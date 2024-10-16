import types from "../types";
import { registerNewUserService, loginUserService } from "../../services/authService";
import { toast } from "react-toastify";

// Register New User
const registerNewUserSuccess = () => {
    return {
        type: types.REGISTER_NEW_USER_SUCCESS,
    };
};

const registerNewUserError = (errorMessage) => {
    return {
        type: types.REGISTER_NEW_USER_ERROR,
    };
};

const registerNewUser = (fullName, password, phoneNumber, email, address) => {
    return async (dispatch) => {
        try {
            const res = await registerNewUserService(fullName, password, phoneNumber, email, address);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(registerNewUserSuccess());
                toast.success(res.data.message);
            } else {
                // Handle case where registration was unsuccessful but no error was thrown
                dispatch(registerNewUserError(res.data.message || "Registration failed."));
                toast.error(res.data.message || "Registration failed.");
            }
        } catch (error) {
            console.log(error);
            // Handle error response if it exists
            const errorMessage = error.response && error.response.data ? error.response.data.message : "An error occurred.";
            dispatch(registerNewUserError(errorMessage));
            toast.error(errorMessage);
        }
    };
};
// Login User phone number
const loginUserSuccess = (userInfo) => {
    return {
        type: types.LOGIN_USER_SUCCESS,
        account: userInfo
    };
};

const loginUserError = () => {
    return {
        type: types.LOGIN_USER_ERROR,

    };
};

const loginUser = (phonenumber, password) => {
    return async (dispatch) => {
        try {
            const res = await loginUserService(phonenumber, password);
            const isSuccess = res && res.data ? res.data.success : false;

            if (isSuccess) {
                dispatch(loginUserSuccess(res.data.data));
                localStorage.setItem("token", res.data.data.token);
                toast.success(res.data.message);
            } else {
                // Hiển thị thông báo lỗi nếu đăng nhập không thành công
                toast.error(res.data.message || "Đăng nhập thất bại.");
                dispatch(loginUserError());
            }
        } catch (error) {
            console.log(error);
            // Xử lý thông báo lỗi nếu có phản hồi từ server
            const errorMessage = error.response && error.response.data
                ? error.response.data.message
                : "Đã xảy ra lỗi khi đăng nhập.";

            // Hiển thị thông báo lỗi
            toast.error(errorMessage);
            dispatch(loginUserError());
        }
    };
};

// update account AUTH
const updateAccountAuthSuccess = (userInfo) => {
    return {
        type: types.AUTH_UPDATE_ACCOUNT,
        accountInfo: userInfo
    };
};
const updateAccountAuth = (phoneNumber, fullName, avatar, email, address) => {
    return (dispatch) => {
        dispatch(updateAccountAuthSuccess({ phoneNumber, fullName, avatar, email, address }));
    };
};


export {
    registerNewUser,
    loginUser,
    updateAccountAuth,

};
