// reducers/authReducer.js
const initialState = {
    listProductsInCart: {}, // fetch từ server
    isBuyNow: false,
    productDetailBuyNow: {}
};

const userReducer = (state = initialState, action) => {
    switch (action.type) {
        case 'UPDATE_PROFILE_SUCCESS':
            return { ...state };
        case 'UPDATE_PROFILE_ERROR':
            return { ...state };
        case 'ADD_TO_CART_SUCCESS':
            return { ...state };
        case 'ADD_TO_CART_ERROR':
            return { ...state };
        case 'FETCH_PRODUCT_CART_SUCCESS':
            return {
                ...state,
                listProductsInCart: action.dataProducts,
            };
        case 'BUY_NOW_OPTION': // Nhấn mua ngay
            return {
                ...state,
                productDetailBuyNow: action.productDetail,
                isBuyNow: true,
            }
        case 'ADD_TO_CART_OPTION': // Nhấn thanh toán trong Cart
            return {
                ...state,
                isBuyNow: false,
            }
        case 'PLACE_ORDER_SUCCESS':
            return {
                ...state,
                listProductsInCart: {},
            }
        case 'PLACE_ORDER_ERROR':
            return {
                ...state,
            }
        case 'RESET_ALL_USER':
            return {
                ...initialState,
            };
        case 'REMOVE_PRODUCT_IN_CART_SUCCESS':
            return {
                ...state
            };
        case 'INCREASE_ONE_QUANTITY_SUCCESS':
            return {
                ...state
            };
        default:
            return state;
    }
};

export default userReducer;
