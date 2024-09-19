class AppRoute {
  static String LOGIN_PAGE = "/login";
  static String HOME_PAGE = "/";
  static String STORE_PAGE = "/store";
  static String ORDER_DETAIL_PAGE = "/order-detail";
  static String CHAR_PAGE = "/char";
  static String ORDER_PAGE = "/order";
  static String ORDER_DETAIL_RECEIVE_PAGE = "/order-detail-receive";
  static String PROFILE_PAGE = "/profile";

  static String get_order_detail_receive(int orderCode) =>
      '$ORDER_DETAIL_RECEIVE_PAGE?orderCode=$orderCode';
  static String get_order_detail(int orderCode) =>
      '$ORDER_DETAIL_PAGE?orderCode=$orderCode';

  static String get_store_detail(int storeId) =>
      '$STORE_PAGE?storeId=$storeId';
}