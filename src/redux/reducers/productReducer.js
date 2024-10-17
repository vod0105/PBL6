import types from "../types";

const INITIAL_STATE = {
    listProductsBestSale: [],
    listProductsByIdCategory: [],
    productDetail: {},
    listProductsByIdStore: [],
};

const productReducer = (state = INITIAL_STATE, action) => {
    switch (action.type) {
        case types.FETCH_PRODUCT_BEST_SALE_SUCCESS:
            return {
                ...state,
                listProductsBestSale: action.dataProducts,
            };
        case types.FETCH_PRODUCT_BY_ID_CATEGORY_SUCCESS:
            return {
                ...state,
                listProductsByIdCategory: action.dataProducts,
            };
        case types.FETCH_PRODUCT_BY_ID_SUCCESS:
            return {
                ...state,
                productDetail: action.productDetail,

            };
        case types.FETCH_PRODUCT_BY_ID_STORE_SUCCESS:
            return {
                ...state,
                listProductsByIdStore: action.dataProducts,
            };

        default: return state;

    }

};

export default productReducer; 
