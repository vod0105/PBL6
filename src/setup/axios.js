import axios from "axios";

const instance = axios.create({
    baseURL: 'http://localhost:8080',
    // withCredentials: true, // Đảm bảo gửi cookie khi request
});

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
}, function (error) {
    return Promise.reject(error);
});

export default instance;
