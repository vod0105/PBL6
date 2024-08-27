import 'package:android_project/page/cart_page/cart_page.dart';
import 'package:android_project/page/forget_password_page/forget_password_page.dart';
import 'package:android_project/page/home_page/home_page.dart';
import 'package:android_project/page/login_page/login_page.dart';
import 'package:android_project/page/product_page/product_page.dart';
import 'package:android_project/page/profile_page/profile_page.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/page/search_page/camera_page.dart';
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
    GetPage(name:AppRoute.PRODUCT_DETAIL,page:() => ProductPage()),
  ];
}