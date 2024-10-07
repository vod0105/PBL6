// store.js
import { createStore, combineReducers } from 'redux';
import modalReducer from '../reducers/modalReducer';
import authenticationReducer from '../reducers/authenticationReducer';

const rootReducer = combineReducers({
    modal: modalReducer,
    authentication: authenticationReducer,
    
});

const store = createStore(rootReducer);

export default store;
