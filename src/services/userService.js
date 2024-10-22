import axios from "../setup/axios"; // an instance of axios

const updateProfileService = (fullName, avatar, email, address) => {
    const formData = new FormData();
    formData.append('fullName', fullName);
    formData.append('avatar', avatar); // Thêm tệp avatar
    formData.append('email', email);
    formData.append('address', address);

    return axios({
        method: 'put',
        url: '/api/v1/user/auth/profile/update',
        data: formData,
        headers: {
            'Content-Type': 'multipart/form-data' // Đặt header đúng
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
const removeProductInCartService = (cartId) => {
    return axios({
        method: 'delete',
        url: `/api/v1/user/cart/delete/${cartId}`,
    });
}
const increaseOneQuantityService = (cartId) => {
    return axios({
        method: 'put',
        url: `/api/v1/user/cart/update?cartId=${cartId}&quantity=1`,
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
    removeProductInCartService,
    increaseOneQuantityService,

}