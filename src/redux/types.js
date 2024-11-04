// actionTypes.js
const types = {
  // Category
  FETCH_CATEGORY_REQUEST: 'FETCH_CATEGORY_REQUEST',
  FETCH_CATEGORY_SUCCESS: 'FETCH_CATEGORY_SUCCESS',
  FETCH_CATEGORY_ERROR: 'FETCH_CATEGORY_ERROR',

  CREATE_CATEGORY_REQUEST: 'CREATE_CATEGORY_REQUEST',
  CREATE_CATEGORY_SUCCESS: 'CREATE_CATEGORY_SUCCESS',
  CREATE_CATEGORY_ERROR: 'CREATE_CATEGORY_ERROR',

  DELETE_CATEGORY_SUCCESS: 'DELETE_CATEGORY_SUCCESS',

  // Product
  FETCH_PRODUCT_BEST_SALE_SUCCESS: 'FETCH_PRODUCT_BEST_SALE_SUCCESS',
  FETCH_PRODUCT_BY_ID_CATEGORY_SUCCESS: 'FETCH_PRODUCT_BY_ID_CATEGORY_SUCCESS',
  FETCH_ALL_COMBO_SUCCESS: 'FETCH_ALL_COMBO_SUCCESS',
  FETCH_PRODUCT_BY_ID_SUCCESS: 'FETCH_PRODUCT_BY_ID_SUCCESS',
  FETCH_COMBO_BY_ID_SUCCESS: 'FETCH_COMBO_BY_ID_SUCCESS',
  FETCH_PRODUCT_BY_ID_STORE_SUCCESS: 'FETCH_PRODUCT_BY_ID_STORE_SUCCESS',
  FETCH_RATING_PRODUCT_BY_ID_SUCCESS: 'FETCH_RATING_PRODUCT_BY_ID_SUCCESS',

  // store
  FETCH_STORE_SUCCESS: 'FETCH_STORE_SUCCESS',
  FETCH_STORE_BY_ID_SUCCESS: 'FETCH_STORE_BY_ID_SUCCESS',

  // authentication => Register New User
  REGISTER_NEW_USER_SUCCESS: 'REGISTER_NEW_USER_SUCCESS',
  REGISTER_NEW_USER_ERROR: 'REGISTER_NEW_USER_ERROR',
  // authentication => Login User
  LOGIN_USER_SUCCESS: 'LOGIN_USER_SUCCESS',
  LOGIN_USER_ERROR: 'LOGIN_USER_ERROR',
  // auth => update profile
  AUTH_UPDATE_ACCOUNT: 'AUTH_UPDATE_ACCOUNT',
  LOGOUT_USER: 'LOGOUT_USER',
  // login google
  LOGIN_GOOGLE_SUCCESS: 'LOGIN_GOOGLE_SUCCESS',
  LOGIN_GOOGLE_ERROR: 'LOGIN_GOOGLE_ERROR',
  // get account infor -> refresh page
  FETCH_USER_ACCOUNT_SUCCESS: 'FETCH_USER_ACCOUNT_SUCCESS',
  // send OTP
  SENT_OTP_SUCCESS: 'SENT_OTP_SUCCESS',
  VERIFY_OTP_SUCCESS: 'VERIFY_OTP_SUCCESS',

  // user
  UPDATE_PROFILE_SUCCESS: 'UPDATE_PROFILE_SUCCESS',
  UPDATE_PROFILE_ERROR: 'UPDATE_PROFILE_ERROR',
  ADD_TO_CART_SUCCESS: 'ADD_TO_CART_SUCCESS',
  ADD_TO_CART_ERROR: 'ADD_TO_CART_ERROR',
  FETCH_PRODUCT_CART_SUCCESS: 'FETCH_PRODUCT_CART_SUCCESS',
  BUY_NOW_OPTION: 'BUY_NOW_OPTION',
  ADD_TO_CART_OPTION: 'ADD_TO_CART_OPTION',
  PLACE_ORDER_BUY_NOW_SUCCESS: 'PLACE_ORDER_BUY_NOW_SUCCESS',
  PLACE_ORDER_BUY_NOW_ERROR: 'PLACE_ORDER_BUY_NOW_SUCCESS',
  PLACE_ORDER_ADD_TO_CART_SUCCESS: 'PLACE_ORDER_ADD_TO_CART_SUCCESS',
  PLACE_ORDER_ADD_TO_CART_ERROR: 'PLACE_ORDER_ADD_TO_CART_ERROR',
  RESET_ALL_USER: 'RESET_ALL_USER',
  REMOVE_PRODUCT_IN_CART_SUCCESS: 'REMOVE_PRODUCT_IN_CART_SUCCESS',
  INCREASE_ONE_QUANTITY_SUCCESS: 'INCREASE_ONE_QUANTITY_SUCCESS',
  DECREASE_ONE_QUANTITY_SUCCESS: 'DECREASE_ONE_QUANTITY_SUCCESS',
  FETCH_ALL_ORDERS_SUCCESS: 'FETCH_ALL_ORDERS_SUCCESS',
  CANCEL_ORDER_SUCCESS: 'CANCEL_ORDER_SUCCESS',
  REVIEW_ORDER_SUCCESS: 'REVIEW_ORDER_SUCCESS',
  FETCH_ORDER_IN_TRANSIT_SUCCESS: 'FETCH_ORDER_IN_TRANSIT_SUCCESS',


  // size
  FETCH_SIZE_SUCCESS: 'FETCH_SIZE_SUCCESS',
  // promotion
  FETCH_PROMOTION_SUCCESS: 'FETCH_PROMOTION_SUCCESS',
  FETCH_PROMOTION_BY_ID_SUCCESS: 'FETCH_PROMOTION_BY_ID_SUCCESS',


};

export default types;
