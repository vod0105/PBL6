// reducers/authReducer.js
const initialState = {
    isAuthenticated: false, // Đã đăng nhập chưa em
    registerNewUserSuccess: false,
    account: {}, // Thông tin account

};

const authReducer = (state = initialState, action) => {
    switch (action.type) {
        case 'LOGIN_USER_SUCCESS':
            return { ...state, isAuthenticated: true, account: action.account };
        case 'LOGIN_USER_ERROR':
            return { ...state, isAuthenticated: false };
        case 'REGISTER_NEW_USER_SUCCESS':
            return { ...state, registerNewUserSuccess: true };
        case 'REGISTER_NEW_USER_ERROR':
            return { ...state, registerNewUserSuccess: false };
        case 'AUTH_UPDATE_ACCOUNT':
            let phoneNumber = action.accountInfo.phoneNumber;
            let fullName = action.accountInfo.fullName;
            let avatar = action.accountInfo.avatar;
            let email = action.accountInfo.email;
            let address = action.accountInfo.address;
            return { ...state, account: { ...account, phoneNumber, fullName, avatar, email, address } };
        default:
            return state;
    }
};

export default authReducer;
