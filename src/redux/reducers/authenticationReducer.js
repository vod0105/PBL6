// reducers/authenticationReducer.js
const initialState = {
    user: {
        isAuthenticated: false
    }

};

const authenticationReducer = (state = initialState, action) => {
    switch (action.type) {
        case 'LOGIN_SUCCESS':
            return { ...state, user: { ...state.user, isAuthenticated: true } };
        case 'LOGIN_ERROR':
            return { ...state, user: { ...state.user, isAuthenticated: false } };
        case 'REGISTER_SUCCESS':
            return { ...state };
        case 'REGISTER_ERROR':
            return { ...state };
        default:
            return state;
    }
};

export default authenticationReducer;
