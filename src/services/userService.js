import instance from "../setup/axios"; // an instance of axios
import axios from "axios";
const updateProfileService = (fullName, avatar, email, address) => {
    const formData = new FormData();
    formData.append('fullName', fullName);
    formData.append('avatar', avatar); // Thêm tệp avatar
    formData.append('email', email);
    formData.append('address', address);

    return instance({
        method: 'put',
        url: '/api/v1/user/auth/profile/update',
        data: formData,
        headers: {
            'Content-Type': 'multipart/form-data' // Đặt header đúng
        }
    });
}

const addProductToCartService = (productId, quantity, storeId, size, status) => {
    return instance({
        method: 'post',
        url: '/api/v1/user/cart/add/product',
        data: {
            productId, quantity, storeId, size, status
        }
    });
}
const fetchProductsInCartService = () => {
    return instance({
        method: 'get',
        url: `/api/v1/user/cart/history`,
    });
}
const placeOrderService = () => {
    return instance({
        // method: 'post',
        // url: `/api/v1/user/`,
    });
}
const removeProductInCartService = (cartId) => {
    return instance({
        method: 'delete',
        url: `/api/v1/user/cart/delete/${cartId}`,
    });
}
const increaseOneQuantityService = (cartId) => {
    return instance({
        method: 'put',
        url: `/api/v1/user/cart/update?cartId=${cartId}&quantity=1`,
    });
}
const decreaseOneQuantityService = (cartId) => {
    return instance({
        method: 'put',
        url: `/api/v1/user/cart/update?cartId=${cartId}&quantity=-1`,
    });
}


// note: Mua ngay -> status = 3: Đơn hàng đã được xác nhận
//       Giỏ hàng -> status = 1: Đơn hàng mới
// => Phân biệt rứa à bay??
const placeOrderBuyNowService = (paymentMethod, productDetailBuyNow, address, longitude, latitude) => {
    if (paymentMethod === 'CASH') {
        return instance({
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
    else { // ZALOPAY
        return axios({
            method: 'post',
            url: `https://pbl6-fastordersystem.onrender.com/api/v1/zalopay/create-order`,
            data: {
                amount: 20000,
                orderId: '3',
                orderInfo: 'Payment for order with id=3',
                lang: 'en',
                extraData: 'additional data'
            }
        });
    }
}
const placeOrderAddToCartService = (paymentMethod, cartIds, address, longitude, latitude) => {
    if (paymentMethod === 'CASH') {
        return instance({
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
    else { // ZALOPAY
        return axios({
            method: 'post',
            url: `https://pbl6-fastordersystem.onrender.com/api/v1/zalopay/create-order`,
            data: {
                amount: 20000,
                orderId: '3',
                orderInfo: 'Payment for order with id=3',
                lang: 'en',
                extraData: 'additional data'
            }
        });
    }
}
const fetchAllOrdersService = () => {
    return instance({
        method: 'get',
        url: `/api/v1/user/order/history`,
    });
}
const cancelOrderService = (orderCode) => {
    return instance({
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
    return instance({
        method: 'post',
        url: `/api/v1/user/product/rating`,
        data: formData,
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    });
}
const fetchOrderInTransitByOrderCodeService = (orderCode) => {
    return instance({
        method: 'get',
        url: `/api/v1/user/order/history/${orderCode}`,
    });
}
const fetchShipperDetailByIdService = (id) => {
    return instance({
        method: 'get',
        url: `/api/v1/public/user/${id}`,
    });
}

const fetchUserDetailByIdService = (id) => {
    return instance({
        method: 'get',
        url: `/api/v1/public/user/${id}`,
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
    fetchOrderInTransitByOrderCodeService,
    fetchShipperDetailByIdService,
    fetchUserDetailByIdService,
    decreaseOneQuantityService,

}