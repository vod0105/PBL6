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

export {
    fetchProductsBestSaleService,
    fetchProductsByIdCategoryService,
    fetchAllCombosService,
    fetchProductByIdService,
    fetchComboByIdService,
    fetchProductsByIdStoreService,
    fetchRatingProductByIdService,

}
