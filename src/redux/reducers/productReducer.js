import types from "../types";

const INITIAL_STATE = {
    listProductsBestSale: [],
    listProductsByIdCategory: [],
    allCombos: [],
    allProductss: [],
    productDetail: {},  // product đang nhấn để coi chi tiết hiện tại
    comboDetail: {},
    listProductsByIdStore: [],
    ratingProduct: [], // tất cả bài đánh giá product
    ratingCombo: [], // tất cả bài đánh giá combo
    allDrinks: [],
    listSimilarProducts: [], // Danh sách sản phẩm cùng Category với product detail hiện tại
    listSimilarCombos: [], // Danh sách combo với combo detail hiện tại
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
        case types.FETCH_ALL_COMBO_SUCCESS:
            return {
                ...state,
                allCombos: action.dataCombos,
            };
        case types.FETCH_ALL_DRINK_SUCCESS:
            return {
                ...state,
                allDrinks: action.dataDrinks,
            };
        case types.FETCH_PRODUCT_BY_ID_SUCCESS:
            return {
                ...state,
                productDetail: action.productDetail,
            };
        case types.FETCH_COMBO_BY_ID_SUCCESS:
            return {
                ...state,
                comboDetail: action.comboDetail,
            };
        case types.FETCH_PRODUCT_BY_ID_STORE_SUCCESS:
            return {
                ...state,
                listProductsByIdStore: action.dataProducts,
            };
        case types.FETCH_RATING_PRODUCT_BY_ID_SUCCESS:
            return {
                ...state,
                ratingProduct: action.dataRatingProduct,
            };
        case types.FETCH_RATING_COMBO_BY_ID_SUCCESS:
            return {
                ...state,
                ratingCombo: action.dataRatingCombo,
            };
        case types.FETCH_SIMILAR_PRODUCT_SUCCESS:
            return {
                ...state,
                listSimilarProducts: action.dataProducts,
            };
        case types.FETCH_SIMILAR_COMBO_SUCCESS:
            return {
                ...state,
                listSimilarCombos: action.dataCombos,
            };
        case types.FETCH_ALL_PRODUCT_SUCCESS:
            return {
                ...state,
                allProducts: action.dataProducts,
            };
        default: return state;

    }

};

export default productReducer; 
