import axios from "../setup/axios"; // an instance of axios

const fetchProductsBestSaleService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/best-sale`,
    });
}
const fetchProductsByIdCategoryService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/category/${id}`,
    });
}
const fetchAllCombosService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/combo/all`,
    });
}
const fetchAllDrinksService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/category/8`,
    });
}

const fetchProductByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/${id}`,
    });
}
const fetchComboByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/combo/${id}`,
    });
}
const fetchProductsByIdStoreService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/store/${id}`,
    });
}
const fetchRatingProductByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/rate/product/${id}`,
    });
}
const fetchRatingComboByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/rate/combo/${id}`,
    });
}

export {
    fetchProductsBestSaleService,
    fetchProductsByIdCategoryService,
    fetchAllCombosService,
    fetchAllDrinksService,
    fetchProductByIdService,
    fetchComboByIdService,
    fetchProductsByIdStoreService,
    fetchRatingProductByIdService,
    fetchRatingComboByIdService,

}
