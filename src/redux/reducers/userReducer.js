// reducers/authReducer.js
const initialState = {
    listProductsInCart: {}, // fetch từ server
    isBuyNow: false,
    productDetailBuyNow: {},
    allOrders: {},
    orderInTransit: {}
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
        case 'PLACE_ORDER_BUY_NOW_SUCCESS':
            return {
                ...state,
                productDetailBuyNow: {},
            }
        case 'PLACE_ORDER_BUY_NOW_ERROR':
            return {
                ...state,
            }
        case 'PLACE_ORDER_ADD_TO_CART_SUCCESS':
            return {
                ...state,
                listProductsInCart: {},
            }
        case 'PLACE_ORDER_ADD_TO_CART_ERROR':
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
        case 'FETCH_ALL_ORDERS_SUCCESS':
            return {
                ...state,
                allOrders: action.dataOrders,
            };
        case 'CANCEL_ORDER_SUCCESS':
            return {
                ...state,
            };
        case 'REVIEW_ORDER_SUCCESS':
            return {
                ...state,
            };
        case 'FETCH_ORDER_IN_TRANSIT_SUCCESS':
            return {
                ...state,
                orderInTransit: action.dataOrderDetail
            };
        default:
            return state;
    }
};

export default userReducer;
