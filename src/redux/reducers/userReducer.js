// reducers/authReducer.js
const initialState = {

};



const userReducer = (state = initialState, action) => {
    switch (action.type) {
        case 'UPDATE_PROFILE_SUCCESS':
            return { ...state };
        case 'UPDATE_PROFILE_ERROR':
            return { ...state };
        default:
            return state;
    }
};

export default userReducer;
