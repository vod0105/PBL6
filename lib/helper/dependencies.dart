
import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance(); 
  Get.lazyPut(() => sharedPreferences); 
  // api client
 Get.lazyPut(() => ApiClient(appBaseUrl: Appconstant.BASE_URL));
 Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
 Get.lazyPut(() => AuthController(authRepo: Get.find()));
}