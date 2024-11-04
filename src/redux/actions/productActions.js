import types from "../types";
import {
    fetchProductsBestSaleService,
    fetchProductsByIdCategoryService,
    fetchAllCombosService,
    fetchProductByIdService,
    fetchComboByIdService,
    fetchProductsByIdStoreService,
    fetchRatingProductByIdService,

} from "../../services/productService";
import { fetchUserDetailByIdService } from "../../services/userService";
import { toast } from "react-toastify";

// Best sale
const fetchProductsBestSaleSuccess = (data) => {
    return {
        type: types.FETCH_PRODUCT_BEST_SALE_SUCCESS,
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
        type: types.FETCH_PRODUCT_BY_ID_CATEGORY_SUCCESS,
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
// fetch all combos
const fetchAllCombosSuccess = (data) => {
    return {
        type: types.FETCH_ALL_COMBO_SUCCESS,
        dataCombos: data
    };
};
const fetchAllCombos = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchAllCombosService();
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchAllCombosSuccess(data)); // // Chạy ở đây (2)
            console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};

// by idProduct => Product Detail
const fetchProductByIdSuccess = (data) => {
    return {
        type: types.FETCH_PRODUCT_BY_ID_SUCCESS,
        productDetail: data
    };
};
const fetchProductById = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchProductByIdService(id);
            const data = res && res.data ? res.data.data[0] : {};
            dispatch(fetchProductByIdSuccess(data)); // // Chạy ở đây (2)
            console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};
// by idCombo => Combo Detail
const fetchComboByIdSuccess = (data) => {
    return {
        type: types.FETCH_COMBO_BY_ID_SUCCESS,
        comboDetail: data
    };
};
const fetchComboById = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchComboByIdService(id);
            const data = res && res.data ? res.data.data[0] : {};
            dispatch(fetchComboByIdSuccess(data)); // // Chạy ở đây (2)
            console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};

// by ID Store
const fetchProductsByIdStoreSuccess = (data) => {
    return {
        type: types.FETCH_PRODUCT_BY_ID_STORE_SUCCESS,
        dataProducts: data
    };
};
const fetchProductsByIdStore = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchProductsByIdStoreService(id);
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchProductsByIdStoreSuccess(data)); // // Chạy ở đây (2)
            // console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};
// rating product by id
const fetchRatingProductByIdSuccess = (data) => {
    return {
        type: types.FETCH_RATING_PRODUCT_BY_ID_SUCCESS,
        dataRatingProduct: data
    };
};
const fetchRatingProductById = (id) => {
    return async (dispatch, getState) => {
        try {
            const resRating = await fetchRatingProductByIdService(id);
            let dataRating = resRating && resRating.data ? resRating.data.data : [];
            // Lấy thêm avatar + fullname User cho từng phần tử trong dataRating
            dataRating = await Promise.all(
                dataRating.map(async (rating) => {
                    const resUser = await fetchUserDetailByIdService(rating.userId);
                    const dataUser = resUser && resUser.data ? resUser.data.data : {};
                    return {
                        ...rating,
                        dataUser: dataUser,
                    };
                })
            );
            dispatch(fetchRatingProductByIdSuccess(dataRating));
            console.log('dataRating: ', dataRating);
        } catch (error) {
            console.log(error);
            toast.error('Không lấy được đánh giá sản phẩm!')
        }
    }
};
export {
    fetchProductsBestSale,
    fetchProductsByIdCategory,
    fetchAllCombos,
    fetchProductById,
    fetchProductsByIdStore,
    fetchRatingProductById,
    fetchComboById,

}