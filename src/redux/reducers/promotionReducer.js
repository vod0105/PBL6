import types from "../types";

const INITIAL_STATE = {
    listPromotions: [],
};

const promotionReducer = (state = INITIAL_STATE, action) => {
    switch (action.type) {
        case types.FETCH_PROMOTION_SUCCESS:
            return {
                ...state,
                listPromotions: action.dataPromotions,
            };

        default: return state;
        case types.FETCH_PROMOTION_BY_ID_SUCCESS:
            return {
                ...state,
                promotionDetail: action.promotionDetail,
            };
    }

};

export default promotionReducer; 
