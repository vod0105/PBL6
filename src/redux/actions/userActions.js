import types from "../types";
import { updateProfileService } from "../../services/userService";
import { toast } from "react-toastify";

// Register New User
const updateProfileSuccess = () => {
    return {
        type: types.UPDATE_PROFILE_SUCCESS,
    };
};

const updateProfileError = (errorMessage) => {
    return {
        type: types.UPDATE_PROFILE_ERROR,
    };
};

const updateProfile = (phoneNumber, fullName, avatar, email, address) => {
    return async (dispatch) => {
        try {
            const res = await updateProfileService(phoneNumber, fullName, avatar, email, address);
            const isSuccess = res && res.data ? res.data.success : false;
            if (isSuccess) {
                dispatch(updateProfileSuccess());
                toast.success(res.data.message);
            } else {
                // Handle case where registration was unsuccessful but no error was thrown
                dispatch(updateProfileError());
                toast.error(res.data.message || "Update profile failed.");
            }
        } catch (error) {
            console.log(error);
            const errorMessage = error.response && error.response.data ? error.response.data.message : "An error occurred.";
            dispatch(updateProfileError());
            toast.error(errorMessage);
        }
    };
};

export {
    updateProfile,

};
