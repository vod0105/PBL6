import axios from "axios";

const instance = axios.create({
    baseURL: 'http://localhost:8080',
    // withCredentials: true, // Đảm bảo gửi cookie khi request
});

instance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.getItem("token")}`;

instance.interceptors.request.use(function (config) {
    return config;
}, function (error) {
    return Promise.reject(error);
});
instance.interceptors.response.use(function (response) {
    return response;
}, function (error) {
    return Promise.reject(error);
});

export default instance;
