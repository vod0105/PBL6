import { combineReducers } from 'redux';
import modalReducer from '../reducers/modalReducer';
import authenticationReducer from '../reducers/authenticationReducer';
import categoryReducer from '../reducers/categoryReducer';
import productReducer from '../reducers/productReducer';
import storeReducer from '../reducers/storeReducer';

const rootReducer = combineReducers({
    modal: modalReducer,
    authentication: authenticationReducer,
    category: categoryReducer,
    product: productReducer,
    store: storeReducer,

});
export default rootReducer;
