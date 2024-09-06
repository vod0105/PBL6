class AppRoute {
  static String LOGIN_PAGE = "/login";
  static String HOME_PAGE = "/";
  static String REGISTER_PAGE = "/register";
  static String FORGET_PASSWORD_PAGE = "/forget_password";
  static String PROFILE_PAGE = "/profile";
  static String CAMERA_PAGE = "/camera";
  static String CART_PAGE = "/cart";
  static String PRODUCT_DETAIL = "/product_detail";
  static String COMBO_DETAIL = "/combo_detail";
  static String STORE_PAGE = "/store";
  static String CATEGORY_PAGE = "/category";
  static String CATEGORY_DETAIL_PAGE = "/category_detail";
  static String ORDER_PAGE = "/order";
  static String PRODUCT_ALL_PAGE = "/product_all";

  static String get_combo_detail(int pageId) => '$COMBO_DETAIL?pageId=$pageId';
  static String get_product_detail(int productId) => '$PRODUCT_DETAIL?productId=$productId';
  static String get_product_bycategoryid_detail(int categoryid,String categoryname) => '$CATEGORY_DETAIL_PAGE?categoryid=$categoryid&categoryname=$categoryname';
}