
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Category_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/route/app_pages.dart';
import 'package:android_project/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_project/helper/dependencies.dart' as dep;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {

    final authController = Get.find<AuthController>();

    authController.IsLogin.listen((loggedIn) {
      if (loggedIn) {
       
        Get.find<ComboController>().getall();
        Get.find<ProductController>().getall();
        Get.find<Storecontroller>().getall();
        Get.find<CategoryController>().getall();
        Get.find<UserController>().getuserprofile();
      }
    });
   
    
    return GetMaterialApp(
      initialRoute: AppRoute.LOGIN_PAGE,
      getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
      
        themeMode: ThemeMode.light,
    );
  }
}
