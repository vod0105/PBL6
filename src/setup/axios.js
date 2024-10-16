import axios from "axios";

const instance = axios.create({
    baseURL: 'http://localhost:8080',
    // withCredentials: true, // Đảm bảo gửi cookie khi request
});

instance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.getItem("token")}`;

// Add a request interceptor (giữ nguyên nếu cần thay đổi config trước khi gửi request)
instance.interceptors.request.use(function (config) {
    return config;
}, function (error) {
    return Promise.reject(error);
});

// Add a response interceptor (chỉ trả về response từ backend)
instance.interceptors.response.use(function (response) {
    // Trả về dữ liệu response mà không xử lý thêm
    return response;
}, function (error) {
    // Trả về lỗi (không xử lý phức tạp)
    return Promise.reject(error);
});

export default instance;
