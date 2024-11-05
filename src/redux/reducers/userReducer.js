// reducers/authReducer.js
const initialState = {
    listProductsInCart: {}, // fetch từ server
    listCombosInCart: {},
    isBuyNow: false,
    isBuyNowCombo: false,
    productDetailBuyNow: {},
    comboDetailBuyNow: {},
    allOrders: {},
    orderInTransit: {},
    listVouchers: {},
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
                listCombosInCart: action.dataCombos
            };
        case 'BUY_NOW_OPTION': // Nhấn mua ngay PRODUCT
            return {
                ...state,
                productDetailBuyNow: action.productDetail,
                isBuyNow: true,
                isBuyNowCombo: false,
            }
        case 'BUY_NOW_COMBO_OPTION': // Nhấn mua ngay COMBO
            return {
                ...state,
                comboDetailBuyNow: action.comboDetail,
                isBuyNow: false,
                isBuyNowCombo: true,
            }
        case 'ADD_TO_CART_OPTION': // Nhấn thanh toán trong Cart
            return {
                ...state,
                isBuyNow: false,
                isBuyNowCombo: false,
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
                listCombosInCart: {}
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
        case 'FETCH_VOUCHER_SUCCESS':
            return {
                ...state,
                listVouchers: action.dataVouchers
            };
        default:
            return state;
    }
};

export default userReducer;
