import { combineReducers } from 'redux';
import modalReducer from '../reducers/modalReducer';
import authReducer from '../reducers/authReducer';
import categoryReducer from '../reducers/categoryReducer';
import productReducer from '../reducers/productReducer';
import storeReducer from '../reducers/storeReducer';
import userReducer from './userReducer';
import sizeReducer from './sizeReducer';

const rootReducer = combineReducers({
    modal: modalReducer,
    auth: authReducer,
    category: categoryReducer,
    product: productReducer,
    store: storeReducer,
    user: userReducer,
    size: sizeReducer,

});
export default rootReducer;
