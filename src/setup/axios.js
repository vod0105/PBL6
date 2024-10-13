import axios from "axios";
import { toast } from 'react-toastify';

const instance = axios.create({
    baseURL: 'http://localhost:8080',
    // baseURL: process.env.REACT_APP_BACKEND_URL
    // timeout: 1000,
    // headers: { 'X-Custom-Header': 'foobar' }
});
instance.defaults.withCredentials = true;

// Alter defaults after instance has been created
instance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.getItem("jwt")}`;

// Add a request interceptor
instance.interceptors.request.use(function (config) {
    return config;
}, function (error) {
    return Promise.reject(error);
});

// Add a response interceptor
instance.interceptors.response.use(function (response) {
    // Any status code that lie within the range of 2xx cause this function to trigger
    // Do something with response data
    return response;
}, function (err) {
    // Any status codes that falls outside the range of 2xx cause this function to trigger
    // Do something with response error

    const status = err.response.status || 500;
    // we can handle global errors here
    switch (status) {
        // authentication (token related issues)
        case 401: {
            if (window.location.pathname !== '/'
                && window.location.pathname !== '/login'
                && window.location.pathname !== '/register'
            ) {
                toast.error("Unauthorized the user Please login ... ")
            }
            return err.response.data;
        }

        case 403: {
            toast.error("You don't have the permission to access this link")
            return err.response.data;
        }

        // // bad request
        // case 400: {
        //     return Promise.reject(err);
        // }

        // // not found
        // case 404: {
        //     return Promise.reject(err);
        // }

        // // conflict
        // case 409: {
        //     return Promise.reject(err);
        // }

        // // unprocessable
        // case 422: {
        //     return Promise.reject(err);
        // }

        // // generic api error (server related) unexpected
        // default: {
        //     return Promise.reject(err);
        // }
    }
});

export default instance;