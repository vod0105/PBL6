import axios from "../setup/axios"; // an instance of axios

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
const fetchAllUser = (page, limit) => {
    return axios({
        method: 'get',
        url: `/api/v1/user/read?page=${page}&limit=${limit}`,
    });
}

const deleteUser = (user) => {
    return axios({
        method: 'delete',
        url: '/api/v1/user/delete',
        data: {
            id: user.id
        }
    });
}
const fetchGroup = () => {
    return axios({
        method: 'get',
        url: `/api/v1/group/read`,
    });
}
// modal create user
const createNewUser = (userData) => {
    return axios({
        method: 'post',
        url: '/api/v1/user/create',
        data: {
            ...userData // Ko được truyền nguyên object mà phải theo từng key:value
        }
    });
}
const updateCurrentUser = (userData) => {
    return axios({
        method: 'put',
        url: '/api/v1/user/update',
        data: {
            ...userData
        }
    });
}
// Remove Session Storage
const getUserAccount = () => {
    return axios({
        method: 'get',
        url: `/api/v1/account`,
    });
}

const logoutUser = () => {
    return axios({
        method: 'post',
        url: `/api/v1/logout`,
    });
}

export {
    registerNewUser,
    loginUser,
    fetchAllUser,
    deleteUser,
    fetchGroup,
    createNewUser,
    updateCurrentUser,
    getUserAccount,
    logoutUser,

}