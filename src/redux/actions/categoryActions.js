import types from "../types";
import { fetchAllCategoriesService } from "../../services/categoryService";

// Thunk: fetching data
export const fetchCategoriesRequest = () => {
    return {
        type: types.FETCH_CATEGORY_REQUEST,
    };

};

export const fetchCategoriesSuccess = (data) => {
    return {
        type: types.FETCH_CATEGORY_SUCCESS,
        dataCategories: data
    };
};

export const fetchCategoriesError = () => {
    return {
        type: types.FETCH_CATEGORY_ERROR,
    };
};
const fetchAllCategories = () => {
    return async (dispatch, getState) => {
        dispatch(fetchCategoriesRequest()); // Chạy ở đây (1)
        try {
            const res = await fetchAllCategoriesService();
            const data = res && res.data ? res.data.data : [];
            // console.log(data);
            dispatch(fetchCategoriesSuccess(data)); // // Chạy ở đây (2)
        } catch (error) {
            console.log(error);
            dispatch(fetchCategoriesError());
        }
    }
};
export {
    fetchAllCategories,

}