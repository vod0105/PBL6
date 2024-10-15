import axios from "../setup/axios";

const registerNewUser = (email, phone, username, password) => {
    return axios({ // return response: Object
        method: 'post',
        url: '/api/v1/register',
        data: {
            email, phone, username, password
        }
    });
}
const loginUser = (valueLogin, password) => {
    return axios({ // return response: Object
        method: 'post',
        url: '/api/v1/login',
        data: {
            valueLogin, password
        }
    });
}

export {
    registerNewUser,
    loginUser,
}