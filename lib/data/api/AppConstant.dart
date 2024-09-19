class Appconstant {
  static const  String APP_NAME = "NhatDepTrai";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://192.168.1.26:8080";

  static const String LOGIN_URL= "/api/v1/auth/login";
  static const String REGISTER_URL= "/api/v1/auth/register-user";

  static const String COMBO_URL = "/api/v1/public/combo/all";
  static const String COMBO_BY_COMBOID_URL = "/api/v1/public/combo/{id}";
  

  static const String STORE_URL = "/api/v1/public/stores/all";
  static const String STORE_BY_ID_URL = "/api/v1/public/stores/{id}";

  static const String CATEGORY_URL = "/api/v1/public/categories/all";

  static const String PRODUCT_URL = "/api/v1/public/products/all";
  static const String PRODUCT_BYID_URL = "/api/v1/public/products/{id}";
  static const String PRODUCT_LIST_BYCATEGORYID_URL = "/api/v1/public/products/category/{id}";
  
  static const String ADD_TOCART_URL = "/api/v1/user/cart/add/product?productId={productid}&quantity={quantity}&storeId={storeid}&size={size}";
  static const String CART_URL = "/api/v1/user/cart/history";

  static const String ORDERT_URL = "/api/v1/user/order/history/all";
  static const String ORDER_PRODUCT_URL = "/api/v1/user/order/create/product";
  static const String ORDER_COMBO_URL = "/api/v1/user/order/create/combo";
  static const String ORDER_PRODUCT_MOMO_URL = "/api/v1/user/order/create";
  static const String ORDER_BY_ORDERCODE_URL = "/api/v1/user/order/history/{ordercode}";
  static const String ORDER_BY_ORDERSTATUS_URL = "/api/v1/user/order/history/status?status={status}";
  
  static const String USER_PROFILE_URL = "/api/v1/user/auth/profile";
  static const String USER_UPDATE_PROFILE_URL = "/api/v1/user/auth/profile/update";
  static const String PRODUCT_LIST_BYNAME_URL = "/api/v1/public/products/search/{productname}";

  static const String SIZE_URL = "/api/v1/public/sizes/all";
  static const String SIZE_BY_ID_URL = "/api/v1/public/sizes/{id}";

  static const String TOKEN = "DBtoken";
}
