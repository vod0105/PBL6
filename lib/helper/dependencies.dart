import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Category_controller.dart';
import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/Cart_repo.dart';
import 'package:android_project/data/repository/Category_repo.dart';
import 'package:android_project/data/repository/Chart_repo.dart';
import 'package:android_project/data/repository/Combo_repo.dart';
import 'package:android_project/data/repository/Order_repo.dart';
import 'package:android_project/data/repository/Product_repo.dart';
import 'package:android_project/data/repository/Size_repo.dart';
import 'package:android_project/data/repository/Store_repo.dart';
import 'package:android_project/data/repository/User_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: Appconstant.BASE_URL));

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  Get.lazyPut(() => ComboRepo(apiClient: Get.find()));
  Get.lazyPut(() => ComboController(comboRepo: Get.find()));

  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));

  Get.lazyPut(() => StoreRepo(apiClient: Get.find()));
  Get.lazyPut(() => Storecontroller(storeRepo: Get.find()));

  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));

  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  Get.lazyPut(() => SizeRepo(apiClient: Get.find()));
  Get.lazyPut(() => SizeController(sizeRepo: Get.find()));

  Get.lazyPut(() => ChartRepo(apiClient: Get.find()));
  Get.lazyPut(() => ChartController(chartRepo: Get.find()));

  Get.put(CartRepo(apiClient: Get.find()));
  Get.put(CartController(cartRepo: Get.find()));
}
