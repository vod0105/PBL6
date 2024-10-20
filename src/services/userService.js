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
const placeOrderService = () => {
    return axios({
        // method: 'post',
        // url: `/api/v1/user/`,
    });
}

// const getUserAccount = () => {
//     return axios({
//         method: 'get',
//         url: `/api/v1/account`,
//     });
// }

export {
    updateProfileService,
    addProductToCartService,
    fetchProductsInCartService,
    placeOrderService,

}