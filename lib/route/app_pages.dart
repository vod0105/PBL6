import 'package:android_project/page/cart_page/cart_order/cart_order.dart';
import 'package:android_project/page/cart_page/cart_page.dart';
import 'package:android_project/page/category_page/category_detail_page/category_detail_page.dart';
import 'package:android_project/page/category_page/category_page.dart';
import 'package:android_project/page/chat_page/chart_page.dart';
import 'package:android_project/page/chat_page/home_chart/home_chat_detail.dart';
import 'package:android_project/page/chat_page/search_chart/search_chat.dart';
import 'package:android_project/page/chat_page/store_chat/store_chat.dart';
import 'package:android_project/page/chat_page/store_chat/store_chat_detail.dart';
import 'package:android_project/page/forget_password_page/forget_password_page.dart';
import 'package:android_project/page/home_page/detail_page/combo/combo_detail.dart';
import 'package:android_project/page/home_page/detail_page/combo/payment_combo.dart';
import 'package:android_project/page/home_page/home_page.dart';
import 'package:android_project/page/login_page/login_page.dart';
import 'package:android_project/page/order_page/order_detail_page.dart';
import 'package:android_project/page/order_page/order_page.dart';
import 'package:android_project/page/product_page/product_all.dart';
import 'package:android_project/page/product_page/product_order.dart';
import 'package:android_project/page/product_page/product_page.dart';
import 'package:android_project/page/profile_page/notification/notification.dart';
import 'package:android_project/page/profile_page/profile_page.dart';
import 'package:android_project/page/profile_page/profile_setting_page/profile_camera.dart';
import 'package:android_project/page/profile_page/profile_setting_page/profile_setting_page.dart';
import 'package:android_project/page/profile_page/profile_setup_page/profile_setup_page.dart';
import 'package:android_project/page/profile_page/profile_setup_page/shipper_register/shipper_register_page.dart';
import 'package:android_project/page/profile_page/transFerPoint/transfer_point_page.dart';
import 'package:android_project/page/profile_page/promotion_page/promotion_page.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/page/search_page/camera_page.dart';
import 'package:android_project/page/search_page/search_page.dart';
import 'package:android_project/page/store_page/store_detail/store_detail_page.dart';
import 'package:android_project/page/store_page/store_page.dart';
import 'package:android_project/route/app_route.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoute.LOGIN_PAGE,
        page: () => const LoginPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.REGISTER_PAGE,
        page: () => const RegisterPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.FORGET_PASSWORD_PAGE,
        page: () => const ForgetPasswordPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.HOME_PAGE,
        page: () => const HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PROFILE_PAGE,
        page: () => const ProfilePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.CAMERA_PAGE,
        page: () => const CameraPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.CART_PAGE,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.STORE_PAGE,
        page: () => const StorePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.CATEGORY_PAGE,
        page: () => const CategoryPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.ORDER_PAGE,
        page: () => const OrderPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PRODUCT_ALL_PAGE,
        page: () => const ProductAll(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PRODUCT_ALL_PAGE,
        page: () => const ProductAll(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.SEARCH_PAGE,
        page: () => const SearchPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PROFILE_SETTING_PAGE,
        page: () => const ProfileSettingPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PROFILE_CAMERA_PAGE,
        page: () => const ProfileCamera(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PROFILE_SETUP_PAGE,
        page: () => const ProfileSetupPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PROMOTION_PAGE,
        page: () => const PromotionPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.CHART_PAGE,
        page: () => const ChartPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.REGISTER_SHIP_PAGE,
        page: () => const ShipperRegisterPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.ORDER_CART_PAGE,
        page: () => const CartOrder(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.NOTIFICATION_PAGE,
        page: () => const Notification(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.TRANSFER_POINT_PAGE,
        page: () => const TransferPointPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.SEARCH_CHAT_PAGE,
        page: () => const SearchChat(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.STORE_CHAT_PAGE,
        page: () => const StoreChat(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.ORDER_DETAIL_PAGE,
        page: () {
          String orderCode = Get.parameters['orderCode']!;
          return OrderDetailPage(orderCode: orderCode);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.COMBO_DETAIL,
        page: () {
          var comboId = Get.parameters['comboId'];
          int comboIdInt = int.tryParse(comboId ?? '0') ?? 0;
          return ComboDetail(comboId: comboIdInt);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.STORE_CHAT_DETAIL_PAGE,
        page: () {
          var storeId = Get.parameters['storeId'];
          int storeIdInt = int.tryParse(storeId ?? '0') ?? 0;
          return StoreChatDetail(storeId: storeIdInt);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.PRODUCT_DETAIL,
        page: () {
          var productId = Get.parameters['productId'];
          int productIdInt = int.tryParse(productId ?? '0') ?? 0;
          return ProductPage(productId: productIdInt);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.CATEGORY_DETAIL_PAGE,
        page: () {
          var categoryId = Get.parameters['categoryId'];
          var categoryName = Get.parameters['categoryName'];
          int categoryIdInt = int.tryParse(categoryId ?? '0') ?? 0;
          return CategoryDetailPage(
              categoryId: categoryIdInt, categoryName: categoryName!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.STORE_DETAIL_PAGE,
        page: () {
          var storeId = Get.parameters['storeId'];
          int storeIdInt = int.tryParse(storeId ?? '0') ?? 0;
          return StoreDetailPage(storeId: storeIdInt);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoute.USER_CHAT_DETAIL_PAGE,
        page: () {
          var idReceiver = Get.parameters['idReceiver'];
          int idReCeiVeRdInt = int.tryParse(idReceiver ?? '0') ?? 0;
          return HomeChatDetail(idReceiver: idReCeiVeRdInt);
        },
        transition: Transition.fadeIn),
    GetPage(
      name: AppRoute.ORDER_COMBO_PAGE,
      page: () {
        var comboId = Get.parameters['comboid'];
        var drinkId = Get.parameters['drinkId'];
        var quantity = Get.parameters['quantity'];
        int quantityInt = int.tryParse(quantity ?? '1') ?? 1;

        int comboIdInt = int.tryParse(comboId ?? '0') ?? 0;
        List<int> drinkIds =
            drinkId?.split(',').map((id) => int.tryParse(id) ?? 0).toList() ??
                [];
        return PaymentCombo(idCombo: comboIdInt, idDrink: drinkIds,quantity: quantityInt,);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: AppRoute.ORDER_PRODUCT_PAGE,
        page: () {
          var product = Get.parameters['product'];
          var size = Get.parameters['size'];
          var quantity = Get.parameters['quantity'];

          int productInt = int.tryParse(product ?? '0') ?? 0;
          int quantityInt = int.tryParse(quantity ?? '0') ?? 0;
          return ProductOrder(
            idProduct: productInt,
            quantity: quantityInt,
            size: size!,
          );
        },
        transition: Transition.fadeIn),
  ];
}
