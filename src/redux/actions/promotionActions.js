import types from "../types";
import { fetchAllPromotionsService, fetchPromotionByIdService } from "../../services/promotionService";

// Thunk: fetching data
export const fetchPromotionsSuccess = (data) => {
    return {
        type: types.FETCH_PROMOTION_SUCCESS,
        dataPromotions: data
    };
};

const fetchAllPromotions = () => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchAllPromotionsService();
            const data = res && res.data ? res.data.data : [];
            dispatch(fetchPromotionsSuccess(data));
        } catch (error) {
            console.log(error);
        }
    }
};
// by idPromotion => Promotion Detail
const fetchPromotionByIdSuccess = (data) => {
    return {
        type: types.FETCH_PROMOTION_BY_ID_SUCCESS,
        promotionDetail: data
    };
};
const fetchPromotionById = (id) => {
    return async (dispatch, getState) => {
        try {
            const res = await fetchPromotionByIdService(id);
            const data = res && res.data ? res.data.data : {};
            dispatch(fetchPromotionByIdSuccess(data)); // // Chạy ở đây (2)
            console.log(data);
        } catch (error) {
            console.log(error);
        }
    }
};
export {
    fetchAllPromotions,
    fetchPromotionById
}