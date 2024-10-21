import axios from "../setup/axios";

const fetchAllPromotionsService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/promotions/all`,
    });
}
const fetchPromotionByIdService = (id) => {
    return axios({
        method: 'get',
        url: `/api/v1/public/promotions/${id}`,
    });
}

export {
    fetchAllPromotionsService,
    fetchPromotionByIdService,

}
