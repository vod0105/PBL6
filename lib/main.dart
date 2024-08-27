import 'package:android_project/route/app_pages.dart';
import 'package:android_project/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_project/helper/dependencies.dart' as dep;
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoute.PROFILE_PAGE,
      getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
      
        themeMode: ThemeMode.light,
    );
  }
}
