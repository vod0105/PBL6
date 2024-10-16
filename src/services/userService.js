import axios from "../setup/axios"; // an instance of axios

const updateProfileService = (phoneNumber, fullName, avatar, email, address) => {
    return axios({
        method: 'put',
        url: '/api/v1/user/auth/profile/update',
        data: {
            phoneNumber, fullName, avatar, email, address
        }
    });
}

// const addProductToCart = (productId, quantity, storeId, size, status)
// Remove Session Storage
// const getUserAccount = () => {
//     return axios({
//         method: 'get',
//         url: `/api/v1/account`,
//     });
// }

const logoutUser = () => {
    return axios({
        method: 'post',
        url: `/api/v1/logout`,
    });
}

export {
    updateProfileService,
    logoutUser,

}