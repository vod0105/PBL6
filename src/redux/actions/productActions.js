import types from "../types";
import {
    fetchProductsBestSaleService,
    fetchProductsByIdCategoryService,
    fetchAllCombosService,
    fetchProductByIdService,
    fetchComboByIdService,
    fetchProductsByIdStoreService,
    fetchRatingProductByIdService,
    fetchAllDrinksService,

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
            // console.log(data);
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
const fetchAllCombos = () => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchAllCombosService();
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchAllCombosSuccess(data)); // // Chạy ở đây (2)
            // console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};

// fetch all combos
const fetchAllDrinksSuccess = (data) => {
    return {
        type: types.FETCH_ALL_DRINK_SUCCESS,
        dataDrinks: data
    };
};
const fetchAllDrinks = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchAllDrinksService();
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchAllDrinksSuccess(data)); // // Chạy ở đây (2)
            // console.log(data);
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
            // console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};

// Product Detail -> list similar products
const fetchSimilarProductsSuccess = (data) => {
    return {
        type: types.FETCH_SIMILAR_PRODUCT_SUCCESS,
        dataProducts: data
    };
};
const fetchSimilarProducts = (idProduct) => {
    return async (dispatch, getState) => {
        try {
            const resPro = await fetchProductByIdService(+idProduct); // Lấy thông tin chi tiết sp
            const dataPro = resPro && resPro.data ? resPro.data.data[0] : {};

            const resCate = await fetchProductsByIdCategoryService(+dataPro.category.categoryId); // Tìm danh sách sản phẩm cùng danh mục với sản phẩm này
            const dataCate = resCate && resCate.data ? resCate.data.data : [];
            // Lọc các sản phẩm có productId khác idProduct truyền vào
            let filteredData = dataCate.filter(product => +product.productId !== +idProduct);
            // Lấy 4 sản phẩm đầu tiên
            let dataSimilarProducts = filteredData.slice(0, 5);
            // Update listSimilarProducts trong product reducer
            dispatch(fetchSimilarProductsSuccess(dataSimilarProducts));
        } catch (error) {
            console.log(error);
        }
    }
};

// Product Detail -> list similar products
const fetchSimilarCombosSuccess = (data) => {
    return {
        type: types.FETCH_SIMILAR_COMBO_SUCCESS,
        dataCombos: data
    };
};
const fetchSimilarCombos = (idCombo) => {
    return async (dispatch, getState) => {
        try {
            const resCombo = await fetchAllCombosService(); // Tìm all combo
            const dataCombo = resCombo?.data?.data ? resCombo.data.data : [];
            console.log('dataCombo: ', dataCombo);
            // Lọc các combo có comboId khác idCombo truyền vào
            let filteredData = dataCombo.filter(combo => +combo.comboId !== +idCombo);
            // Lấy 5 combo đầu tiên
            let dataSimilarCombos = filteredData.slice(0, 5);
            dispatch(fetchSimilarCombosSuccess(dataSimilarCombos));
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
            // console.log(data);
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
            // console.log('dataRating: ', dataRating);
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
    fetchAllDrinks,
    fetchProductById,
    fetchProductsByIdStore,
    fetchRatingProductById,
    fetchComboById,
    fetchSimilarProducts,
    fetchSimilarCombos,
}