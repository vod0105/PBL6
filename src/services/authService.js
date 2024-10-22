import axios from "../setup/axios";

const registerNewUserService = (fullName, password, phoneNumber, email, address) => {
    return axios({ // return response: Object
        method: 'post',
        url: '/api/v1/auth/register-user',
        data: {
            fullName, password, phoneNumber, email, address
        }
    });
}
const loginUserService = (numberPhone, password) => {
    return axios({ // return response: Object
        method: 'post',
        url: '/api/v1/auth/login',
        data: {
            numberPhone, password
        }
    });
}
const logoutUserService = () => {
    return axios({
        method: 'post',
        url: `/api/v1/auth/logout`,
    });
}
const loginGoogleService = (tokenGoogle) => {
    return axios({
        method: 'post',
        url: `/api/v1/auth/login/google`,
        data: {
            token: tokenGoogle
        }
    });
}
const getUserAccountService = () => {  // Lấy account infor => Xử lý khi Refresh Page
    return axios({
        method: 'get',
        url: `/api/v1/user/auth/profile`,
    });
}
// forget password
const sendOTPService = (email) => {
    return axios({
        method: 'post',
        url: `/api/v1/auth/send-otp?email=${email}`,
    });
}
const verifyOTPService = (email, otp, newPassword) => {
    return axios({
        method: 'post',
        url: `/api/v1/auth/confirm-otp?email=${email}&otp=${otp}&newPassword=${newPassword}`,
    });
}

export {
    registerNewUserService,
    loginUserService,
    logoutUserService,
    loginGoogleService,
    getUserAccountService,
    sendOTPService,
    verifyOTPService,


}