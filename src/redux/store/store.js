// store.js
import { createStore, combineReducers } from 'redux';
import modalReducer from '../reducers/modalReducer';
import authenticationReducer from '../reducers/authenticationReducer';
import categoryReducer from '../reducers/categoryReducer';

const rootReducer = combineReducers({
    modal: modalReducer,
    authentication: authenticationReducer,
    category: categoryReducer
});

const store = createStore(rootReducer);

export default store;
