import { combineReducers } from 'redux';
import modalReducer from '../reducers/modalReducer';
import authenticationReducer from '../reducers/authenticationReducer';
import categoryReducer from '../reducers/categoryReducer';
import productReducer from '../reducers/productReducer';

const rootReducer = combineReducers({
    modal: modalReducer,
    authentication: authenticationReducer,
    category: categoryReducer,
    product: productReducer,

});
export default rootReducer;
