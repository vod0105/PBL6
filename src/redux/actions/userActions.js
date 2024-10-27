import types from "../types";
import {
    updateProfileService,
    addProductToCartService,
    fetchProductsInCartService,
    placeOrderBuyNowService,
    placeOrderAddToCartService,
    removeProductInCartService,
    increaseOneQuantityService,
    fetchAllOrdersService,
    cancelOrderService,
    reviewOrderService,

} from "../../services/userService";
import { toast } from "react-toastify";

// Register New User
const updateProfileSuccess = () => {
    return {
        type: types.UPDATE_PROFILE_SUCCESS,
    };
};

const updateProfileError = (errorMessage) => {
    return {
        type: types.UPDATE_PROFILE_ERROR,
    };
};

const updateProfile = (fullName, avatar, email, address) => {
    return async (dispatch) => {
        try {
            const res = await updateProfileService(fullName, avatar, email, address);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(updateProfileSuccess());
                toast.success(res.data.message);
            } else {
                // Handle case where registration was unsuccessful but no error was thrown
                dispatch(updateProfileError());
                toast.error(res.data.message || "Update profile failed.");
            }
        } catch (error) {
            console.log(error);
            const errorMessage = error.response && error.response.data ? error.response.data.message : "An error occurred.";
            dispatch(updateProfileError());
            toast.error(errorMessage);
        }
    };
};

// Add product to cart
const addToCartSuccess = () => {
    return {
        type: types.ADD_TO_CART_SUCCESS,
    };
};
const addToCartError = () => {
    return {
        type: types.ADD_TO_CART_ERROR,
    };
};


const addToCart = (productId, quantity, storeId, size, status) => {
    return async (dispatch) => {
        try {
            const res = await addProductToCartService(productId, quantity, storeId, size, status);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(addToCartSuccess());
                dispatch(fetchProductsInCart());
                toast.success(res.data.message);
            } else {
                dispatch(addToCartError());
                toast.error(res.data.message || "Thêm vào giỏ hàng không thành công!");
            }
        } catch (error) {
            console.log(error);
            const errorMessage = error.response && error.response.data ? error.response.data.message : "An error occurred.";
            dispatch(addToCartError());
            toast.error(errorMessage);
        }
    };
}
// fetch list products in cart
const fetchProductsInCartSuccess = (data) => {
    return {
        type: types.FETCH_PRODUCT_CART_SUCCESS,
        dataProducts: data
    };
};
const fetchProductsInCart = () => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchProductsInCartService();
            const data = res && res.data && res.data.data ? res.data.data : [];
            // Kiểm tra nếu giỏ hàng rỗng
            if (data.length === 0) {
                console.log("Giỏ hàng trống");
                dispatch(fetchProductsInCartSuccess([]));  // Gửi array rỗng đến redux
            }
            else {
                dispatch(fetchProductsInCartSuccess(data));
                console.log('>>> data cart: ', data);
            }
        } catch (error) {
            console.log(error);
            // BE return status 400 when cart is empty -> rơi vô catch error ni -> note: BE xử lý sai
            dispatch(fetchProductsInCartSuccess([]));
        }
    }
};

// Nhấn MUA NGAY trong Modal -> Chuyển đến Check out
const placeOrderUsingBuyNow = (product, quantity, store, size) => {
    return {
        type: types.BUY_NOW_OPTION,
        productDetail: { product, quantity, store, size }
    };
};
// Nhấn THANH TOÁN trong Cart -> Chuyển đến Check out
const placeOrderUsingAddToCart = () => {
    return {
        type: types.ADD_TO_CART_OPTION,
    };
};

// Nhấn ĐẶT HÀNG trong Check out -> Chuyển đến Order Complete
const placeOrderBuyNowSuccess = () => {
    return {
        type: types.PLACE_ORDER_BUY_NOW_SUCCESS,
    };
};
const placeOrderBuyNowError = () => {
    return {
        type: types.PLACE_ORDER_BUY_NOW_ERROR,
    };
};

const placeOrderBuyNow = (paymentMethod, productDetailBuyNow, address, longitude, latitude) => {
    return async (dispatch) => {
        try {
            // dispatch(placeOrderBuyNowSuccess());

            const res = await placeOrderBuyNowService(paymentMethod, productDetailBuyNow, address, longitude, latitude);
            // console.log('>>> res: ', res);
            if (paymentMethod === 'CASH') {
                const isSuccess = res && res.data ? res.data.success : false;
                if (isSuccess) {
                    dispatch(placeOrderBuyNowSuccess());
                    dispatch(fetchAllOrders());
                    toast.success(res.data.message);
                    navigate('/order-complete');
                } else {
                    dispatch(placeOrderBuyNowError());
                    toast.error(res.data.message || "Đặt hàng không thành công!");
                }
            }
            else { // ZALOPAY
                const zalopayUrl = res && res.data ? res.data.data.orderurl : '';
                if (zalopayUrl) {
                    window.location.href = zalopayUrl; // Chuyển hướng sang URL thanh toán của ZaloPay
                } else {
                    toast.error("Không thể thanh toán đơn hàng với ZaloPay!");
                }
            }
        } catch (error) {
            console.log(error);
            dispatch(placeOrderBuyNowError());
            toast.error('Có lỗi ở Server');
        }
    };
}

// Check out = Add to cart
const placeOrderAddToCartSuccess = () => {
    return {
        type: types.PLACE_ORDER_ADD_TO_CART_SUCCESS,
    };
};
const placeOrderAddToCartError = () => {
    return {
        type: types.PLACE_ORDER_ADD_TO_CART_ERROR,
    };
};

const placeOrderAddToCart = (paymentMethod, cartIds, address, longitude, latitude) => {
    return async (dispatch) => {
        try {
            const res = await placeOrderAddToCartService(paymentMethod, cartIds, address, longitude, latitude);
            // console.log('>>> res: ', res);
            if (paymentMethod === 'CASH') {
                const isSuccess = res && res.data ? res.data.success : false;
                if (isSuccess) {
                    dispatch(placeOrderAddToCartSuccess());
                    dispatch(fetchAllOrders());
                    toast.success(res.data.message);
                    navigate('/order-complete');
                } else {
                    dispatch(placeOrderAddToCartError());
                    toast.error(res.data.message || "Đặt hàng không thành công!");
                }
            }
            else {// ZALOPAY
                const zalopayUrl = res && res.data ? res.data.data.orderurl : '';
                if (zalopayUrl) {
                    window.location.href = zalopayUrl; // Chuyển hướng sang URL thanh toán của ZaloPay
                } else {
                    toast.error("Không thể thanh toán đơn hàng với ZaloPay!");
                }
            }
        } catch (error) {
            console.log(error);
            dispatch(placeOrderAddToCartError());
            toast.error('Có lỗi ở Server');
        }
    };
}

//
const resetAllUser = () => {
    return {
        type: types.RESET_ALL_USER,
    };
}
// Xóa sp khỏi giỏ hàng
const removeProductInCartSuccess = () => {
    return {
        type: types.REMOVE_PRODUCT_IN_CART_SUCCESS,
    };
};
const removeProductInCart = (cartId) => {
    return async (dispatch, getState) => {
        try {
            const res = await removeProductInCartService(cartId);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(removeProductInCartSuccess());
                dispatch(fetchProductsInCart());
                toast.success(res.data.message);
            } else {
                toast.error(res.data.message || "Xóa sản phẩm khỏi giỏ hàng không thành công!");
            }
        } catch (error) {
            console.log(error);
            toast.error("Có lỗi ở Server!");
        }
    }
};

// Nhấn + => Tăng 1
const increaseOneQuantitySuccess = () => {
    return {
        type: types.INCREASE_ONE_QUANTITY_SUCCESS,
    };
};
const increaseOneQuantity = (cartId) => {
    return async (dispatch, getState) => {
        try {
            const res = await increaseOneQuantityService(cartId);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(increaseOneQuantitySuccess());
                dispatch(fetchProductsInCart());
                toast.success(res.data.message);
            } else {
                toast.error(res.data.message);
            }
        } catch (error) {
            console.log(error);
            toast.error("Có lỗi ở Server!");
        }
    }
};

// Lấy tất cả orders
const fetchAllOrdersSuccess = (data) => {
    return {
        type: types.FETCH_ALL_ORDERS_SUCCESS,
        dataOrders: data
    };
};
const fetchAllOrders = () => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchAllOrdersService();
            const data = res && res.data && res.data.data ? res.data.data : [];
            dispatch(fetchAllOrdersSuccess(data));
        } catch (error) {
            console.log(error);
            // toast.error('Có lỗi ở Server!');  // BE return status=400 -> Lỗi do BE nên chạy vô catch error ni
        }
    }
};
// Hủy đơn hàng
const cancelOrderSuccess = () => {
    return {
        type: types.CANCEL_ORDER_SUCCESS,
    };
};
const cancelOrder = (orderCode) => {
    return async (dispatch) => {
        try {
            const res = await cancelOrderService(orderCode);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(cancelOrderSuccess());
                dispatch(fetchAllOrders()); // Recall API lấy lại all orders
                toast.success(res.data.message);
            } else {
                toast.error(res.data.message || "Hủy đơn hàng không thành công!");
            }
        } catch (error) {
            console.log(error);
            toast.error("Hủy đơn hàng không thành công!");
        }
    };
};

// đánh giá đơn hàng
const reviewOrderSuccess = () => {
    return {
        type: types.REVIEW_ORDER_SUCCESS,
    };
};
const reviewOrder = (listProductIds, rate, listImageFiles, comment) => {
    return async (dispatch) => {
        try {
            const res = await reviewOrderService(listProductIds, rate, listImageFiles, comment);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(reviewOrderSuccess());
                // dispatch(fetchAllOrders()); // Recall API lấy lại all orders
                toast.success(res.data.message);
            } else {
                toast.error(res.data.message || "Đánh giá đơn hàng không thành công!");
            }
        } catch (error) {
            console.log(error);
            toast.error("Đánh giá đơn hàng không thành công!");
        }
    };
};

export {
    updateProfile,
    addToCart,
    fetchProductsInCart,
    placeOrderUsingBuyNow,
    placeOrderUsingAddToCart,
    placeOrderBuyNow,
    placeOrderAddToCart,
    resetAllUser,
    removeProductInCart,
    increaseOneQuantity,
    fetchAllOrders,
    cancelOrder,
    reviewOrder,


};
