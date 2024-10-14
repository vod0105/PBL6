import types from "../types";

const INITIAL_STATE = {
    listProductsBestSale: [],
    listProductsByIdCategory: [],

};

const productReducer = (state = INITIAL_STATE, action) => {
    switch (action.type) {
        case types.FETCH_PRODUCTS_BEST_SALE_SUCCESS:
            return {
                ...state,
                listProductsBestSale: action.dataProducts,
            };
        case types.FETCH_PRODUCTS_BY_ID_CATEGORY_SUCCESS:
            return {
                ...state,
                listProductsByIdCategory: action.dataProducts,
            };

        default: return state;

    }

};

export default productReducer; 
