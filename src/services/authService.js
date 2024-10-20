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

export {
    registerNewUserService,
    loginUserService,
    logoutUserService,
    loginGoogleService
}