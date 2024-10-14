import types from "../types";
import axios from '../../setup/axios'
import { fetchProductsBestSaleService, fetchProductsByIdCategoryService } from "../../services/productService";

// Best sale
const fetchProductsBestSaleSuccess = (data) => {
    return {
        type: types.FETCH_PRODUCTS_BEST_SALE_SUCCESS,
        dataProducts: data
    };
};
const fetchProductsBestSale = () => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchProductsBestSaleService();
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchProductsBestSaleSuccess(data)); // // Chạy ở đây (2)
            // console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};
// by idCategory
const fetchProductsByIdCategorySuccess = (data) => {
    return {
        type: types.FETCH_PRODUCTS_BY_ID_CATEGORY_SUCCESS,
        dataProducts: data
    };
};
const fetchProductsByIdCategory = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchProductsByIdCategoryService(id);
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchProductsByIdCategorySuccess(data)); // // Chạy ở đây (2)
            console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};


export {
    fetchProductsBestSale,
    fetchProductsByIdCategory

}