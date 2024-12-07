import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Category_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/service/AnnounceCheckService.dart';
import 'package:android_project/route/app_pages.dart';
import 'package:android_project/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:android_project/helper/dependencies.dart' as dep;
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await initNotifications();

  bool isLocationEnabled = await checkLocationPermission();
  if (!isLocationEnabled) {
    runApp(const LocationErrorApp());
  } else {
    runApp(const MyApp());
  }
}

Future<bool> checkLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      if (authController.isLogin.value) {
        Get.putAsync(() => AnnounceCheckService().initService());
        Get.find<CartController>().getAll();
        Get.find<UserController>().getUserProfile();
        Get.find<UserController>().getAnnounce();
        Get.find<SizeController>().getAll();
        Get.find<ComboController>().getAll();
        Get.find<ProductController>().getAll();
        Get.find<ProductController>().getRecommendProduct();
        Get.find<Storecontroller>().getAll();
        Get.find<CategoryController>().getAll();
        Get.find<PromotionController>().getAll();
      }

      return GetMaterialApp(
        initialRoute: AppRoute.LOGIN_PAGE,
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
      );
    });
  }
}

class LocationErrorApp extends StatelessWidget {
  const LocationErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Please enable location services to proceed.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
