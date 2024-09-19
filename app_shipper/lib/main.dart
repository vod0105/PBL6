import 'package:app_shipper/route/app_page.dart';
import 'package:app_shipper/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
      initialRoute: AppRoute.LOGIN_PAGE,
      getPages: AppPage.list,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
    );
  }
}
