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

const addProductToCartService = (productId, quantity, storeId, size, status) => {
    console.log(productId, quantity, storeId, size, status);
    return axios({
        method: 'post',
        url: '/api/v1/user/cart/add/product',
        data: {
            productId, quantity, storeId, size, status
        }
    });
}
const fetchProductsInCartService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/user/cart/history`,
    });
}

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
    addProductToCartService,
    fetchProductsInCartService,
    logoutUser,
}