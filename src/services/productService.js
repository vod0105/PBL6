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
const fetchProductByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/${id}`,
    });
}
const fetchProductsByIdStoreService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/products/store/${id}`,
    });
}

export {
    fetchProductsBestSaleService,
    fetchProductsByIdCategoryService,
    fetchProductByIdService,
    fetchProductsByIdStoreService,

}
