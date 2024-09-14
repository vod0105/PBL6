import 'package:android_project/page/cart_page/cart_page.dart';
import 'package:android_project/page/category_page/category_detail_page/category_detail_page.dart';
import 'package:android_project/page/category_page/category_page.dart';
import 'package:android_project/page/chat_page/chart_page.dart';
import 'package:android_project/page/forget_password_page/forget_password_page.dart';
import 'package:android_project/page/home_page/detail_page/banner/banner_detail.dart';
import 'package:android_project/page/home_page/detail_page/combo/combo_detail.dart';
import 'package:android_project/page/home_page/home_page.dart';
import 'package:android_project/page/login_page/login_page.dart';
import 'package:android_project/page/order_page/order_detail_page.dart';
import 'package:android_project/page/order_page/order_page.dart';
import 'package:android_project/page/product_page/product_all.dart';
import 'package:android_project/page/product_page/product_page.dart';
import 'package:android_project/page/profile_page/profile_page.dart';
import 'package:android_project/page/profile_page/profile_setting_page/profile_camera.dart';
import 'package:android_project/page/profile_page/profile_setting_page/profile_setting_page.dart';
import 'package:android_project/page/profile_page/profile_setup_page/profile_setup_page.dart';
import 'package:android_project/page/promotion_page/promotion_page.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/page/search_page/camera_page.dart';
import 'package:android_project/page/search_page/search_page.dart';
import 'package:android_project/page/store_page/store_page.dart';
import 'package:android_project/route/app_route.dart';
import 'package:get/get.dart';
class AppPages {
  static var list = [
    GetPage(name:AppRoute.LOGIN_PAGE,page:() => LoginPage()),
    GetPage(name:AppRoute.REGISTER_PAGE,page:() => RegisterPage()),
    GetPage(name:AppRoute.FORGET_PASSWORD_PAGE,page:() => ForgetPasswordPage()),
    GetPage(name:AppRoute.HOME_PAGE,page:() => HomePage()),
    GetPage(name:AppRoute.PROFILE_PAGE,page:() => ProfilePage()),
    GetPage(name:AppRoute.CAMERA_PAGE,page:() => CameraPage()),
    GetPage(name:AppRoute.CART_PAGE,page:() => CartPage()),
    GetPage(name:AppRoute.STORE_PAGE,page:() => StorePage()),
    GetPage(name:AppRoute.CATEGORY_PAGE,page:() => CategoryPage()),
    GetPage(name:AppRoute.ORDER_PAGE,page:() => OrderPage()),
    GetPage(name:AppRoute.PRODUCT_ALL_PAGE,page:() => ProductAll()),
    GetPage(name:AppRoute.PRODUCT_ALL_PAGE,page:() => ProductAll()),
    GetPage(name:AppRoute.SEARCH_PAGE,page:() => SearchPage()),
    GetPage(name:AppRoute.PROFILE_SETTING_PAGE,page:() => ProfileSettingPage()),
    GetPage(name:AppRoute.PROFILE_CAMERA_PAGE,page:() => ProfileCamera()),
    GetPage(name:AppRoute.PROFILE_SETUP_PAGE,page:() => ProfileSetupPage()),
    GetPage(name:AppRoute.PROMOTION_PAGE,page:() => PromotionPage()),
    GetPage(name:AppRoute.CHART_PAGE,page:() => ChartPage()),

    GetPage(name:AppRoute.ORDER_DETAIL_PAGE,
      page:() {
        String orderCode = Get.parameters['orderCode']!;
        return OrderDetailPage(orderCode : orderCode);
      }
    ),

    GetPage(name: AppRoute.COMBO_DETAIL, 
      page: () {
        var comboId = Get.parameters['comboId'];
        int comboIdInt = int.tryParse(comboId ?? '0') ?? 0;
        return ComboDetail(comboId: comboIdInt);
      },
    transition: Transition.fadeIn ),

    GetPage(name:AppRoute.PRODUCT_DETAIL,
      page:() {
        var productId = Get.parameters['productId'];
        int productIdInt = int.tryParse(productId ?? '0') ?? 0;
                return ProductPage(productId: productIdInt);
      }
    ),

    GetPage(name:AppRoute.CATEGORY_DETAIL_PAGE,
      page:() {
        var categoryid = Get.parameters['categoryid'];
        var categoryname = Get.parameters['categoryname'];
        int categoryidInt = int.tryParse(categoryid ?? '0') ?? 0;
        return CategoryDetailPage(categoryid: categoryidInt,categoryname:categoryname!);
      }
    ),
  ];
}