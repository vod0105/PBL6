// reducers/authReducer.js
const initialState = {
    listProductsInCart: {

    }
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
        default:
            return state;
    }
};

export default userReducer;
