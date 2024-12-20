import axios from "axios";

const instance = axios.create({
    baseURL:import.meta.env.VITE_BACKEND_URL,
    // withCredentials: true, // Đảm bảo gửi cookie khi request
});

let isRefreshing = false; // Biến theo dõi nếu đang refresh token
let failedQueue = []; // Danh sách các request bị chờ trong quá trình refresh

// Hàm xử lý queue khi nhận token mới hoặc gặp lỗi
const processQueue = (error, token = null) => {
    failedQueue.forEach(prom => {
        if (error) {
            prom.reject(error);
        } else {
            prom.resolve(token);
        }
    });
    failedQueue = [];
};

// Thêm interceptor cho request
instance.interceptors.request.use(function (config) {
    const token = localStorage.getItem("token"); // Lấy token mới mỗi lần gọi API
    if (token) {
        config.headers.Authorization = `Bearer ${token}`; // Thêm token vào headers
    }
    return config;
}, function (error) {
    return Promise.reject(error);
});

// Interceptor cho response
instance.interceptors.response.use(function (response) {
    return response;
}, async function (error) {
    const originalRequest = error.config;

    // Kiểm tra nếu lỗi là 401 (Unauthorized) và chưa được retry
    if (error.response && error.response.status === 401 && !originalRequest._retry) {
        originalRequest._retry = true; // Đánh dấu request đã retry để tránh loop

        // Kiểm tra nếu đang trong quá trình refresh
        if (isRefreshing) {
            return new Promise((resolve, reject) => {
                failedQueue.push({ resolve, reject });
            }).then(token => {
                originalRequest.headers.Authorization = `Bearer ${token}`;
                return instance(originalRequest);
            }).catch(err => {
                return Promise.reject(err);
            });
        }

        // Bắt đầu refresh token nếu chưa refresh
        isRefreshing = true;
        const refreshToken = localStorage.getItem("token"); // Lấy refresh token từ localStorage -> token cũ
        // localStorage.removeItem('token');

        try {
            let urlBE = import.meta.env.BE_URL || `http://localhost:8080`;
            const response = await axios.post(`${urlBE}/auth/refresh`, { refreshToken });
            const newToken = response?.data?.data ? response.data.data : refreshToken; // Lấy token mới từ response -> note: Lỗi thì giữ nguyên token cũ ko refresh
            localStorage.setItem("token", newToken); // Lưu token mới vào localStorage
            processQueue(null, newToken); // Xử lý lại các request trong queue

            originalRequest.headers.Authorization = `Bearer ${newToken}`; // Cập nhật token cho request ban đầu
            return instance(originalRequest); // Retry lại request ban đầu với token mới
        } catch (refreshError) {
            processQueue(refreshError, null); // Xử lý các request trong queue với lỗi refresh
            return Promise.reject(refreshError); // Trả về lỗi nếu refresh token thất bại
        } finally {
            isRefreshing = false; // Reset trạng thái refresh
        }
    }

    return Promise.reject(error); // Trả về lỗi nếu không phải lỗi 401
});

export default instance;
