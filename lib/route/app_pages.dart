import 'package:android_project/page/cart_page/cart_page.dart';
import 'package:android_project/page/category_page/category_detail_page/category_detail_page.dart';
import 'package:android_project/page/category_page/category_page.dart';
import 'package:android_project/page/forget_password_page/forget_password_page.dart';
import 'package:android_project/page/home_page/detail_page/banner/banner_detail.dart';
import 'package:android_project/page/home_page/home_page.dart';
import 'package:android_project/page/login_page/login_page.dart';
import 'package:android_project/page/order_page/order_page.dart';
import 'package:android_project/page/product_page/product_page.dart';
import 'package:android_project/page/profile_page/profile_page.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/page/search_page/camera_page.dart';
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

    GetPage(name: AppRoute.COMBO_DETAIL, 
             page: () {
                var pageId = Get.parameters['pageId'];
                int pageIdInt = int.tryParse(pageId ?? '0') ?? 0;
                return BannerDetail(pageId: pageIdInt);
              },
            transition: Transition.fadeIn ),
    GetPage(name:AppRoute.PRODUCT_DETAIL,page:() {
        var productId = Get.parameters['productId'];
        int productIdInt = int.tryParse(productId ?? '0') ?? 0;
                return ProductPage(productId: productIdInt);
    }),
    GetPage(name:AppRoute.CATEGORY_DETAIL_PAGE,page:() {
      var categoryid = Get.parameters['categoryid'];
      int categoryidInt = int.tryParse(categoryid ?? '0') ?? 0;
      return CategoryDetailPage(categoryid: categoryidInt);
    }),
  ];
}