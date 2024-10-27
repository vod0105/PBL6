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

// note: Mua ngay -> status = 3: Đơn hàng đã được xác nhận
//       Giỏ hàng -> status = 1: Đơn hàng mới
// => Phân biệt rứa à bay??
const placeOrderBuyNowService = (paymentMethod, productDetailBuyNow, address, longitude, latitude) => {
    return axios({
        method: 'post',
        url: `/api/v1/user/order/create/now`,
        data: {
            paymentMethod,
            productId: productDetailBuyNow.product.productId,
            storeId: productDetailBuyNow.store.storeId,
            quantity: productDetailBuyNow.quantity,
            size: productDetailBuyNow.size,
            deliveryAddress: address,
            longitude,
            latitude
        }
    });
}
const placeOrderAddToCartService = (paymentMethod, cartIds, address, longitude, latitude) => {
    return axios({
        method: 'post',
        url: `/api/v1/user/order/create`,
        data: {
            cartIds,
            deliveryAddress: address,
            longitude,
            latitude,
            paymentMethod
        }
    });
}
const fetchAllOrdersService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/user/order/history`,
    });
}
const cancelOrderService = (orderCode) => {
    return axios({
        method: 'post',
        url: `/api/v1/user/order/cancel/${orderCode}`,
    });
}
const reviewOrderService = (listProductIds, rate, listImageFiles, comment) => {
    const formData = new FormData();
    formData.append('productId', listProductIds);
    formData.append('rate', rate);
    // formData.append('imageFiles', listImageFiles);
    listImageFiles.forEach((file, index) => {
        formData.append('imageFiles', file);  // Thêm từng file ảnh vào FormData
    });
    formData.append('comment', comment);
    // console.log('>>> list id: ', listProductIds);
    // console.log('>>> rate: ', rate);
    // console.log('>>> listImageFiles: ', listImageFiles);
    // console.log('>>> comment: ', comment);

    return axios({
        method: 'post',
        url: `/api/v1/user/product/rating`,
        data: formData,
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    });
}

export {
    updateProfileService,
    addProductToCartService,
    fetchProductsInCartService,
    placeOrderService,
    removeProductInCartService,
    increaseOneQuantityService,
    placeOrderBuyNowService,
    placeOrderAddToCartService,
    fetchAllOrdersService,
    cancelOrderService,
    reviewOrderService,

}