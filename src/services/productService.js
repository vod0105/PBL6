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
const fetchAllDrinksService = (drinkId) => {
    console.log('>>> drink id: ', drinkId);
    return axios({
        method: 'get',
        url: `/api/v1/public/products/category/${drinkId}`,
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

// Tất cả sp -> Page: All Products
const fetchAllProductsService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/all`,
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
    fetchAllProductsService,
}
