import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/service/AnnounceCheckService.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  var isLogin = false.obs;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isLoadingSendOtp = false;

  int idUser = 0;

  String validateLogin = "";

  String validateRegister = "";

  String validateSendotp = "";

  ApiClient apiClient = Get.find<ApiClient>();

  Future<bool> login(UserDto dto) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(dto);
    if (response.statusCode == 200) {
      var data = response.body["data"];
      idUser = data["id"];

      String newToken = data["token"];
      authRepo.saveUserToken(newToken);
      apiClient.updateHeader(newToken);

      isLogin.value = true;

      update();
      return true;
    } else {
      isLogin.value = false;
      validateLogin = response.body["message"];

      update();
      return false;
    }
  }

  Future<bool> register(UserRegisterDto dto) async {
    Response response = await authRepo.register(dto);

    if (response.statusCode == 200) {
      return true;
    } else {
      validateRegister = response.body["message"];

      update();
      return false;
    }
  }

  Future<bool> logout() async {
    String token = apiClient.token;
    Response response = await authRepo.logout(token);

    if (response.statusCode == 200) {
      isLogin.value = false;
      final announceService = Get.find<AnnounceCheckService>();
      announceService.onClose();
      Get.toNamed(AppRoute.LOGIN_PAGE);
      update();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendotp(String email) async {
    isLoadingSendOtp = true;
    Response response = await authRepo.sendOtp(email);
    if (response.statusCode == 200) {
      isLoadingSendOtp = false;
      update();
      return true;
    } else {
      validateSendotp = response.body["message"];
      isLoadingSendOtp = false;
      update();
      return false;
    }
  }

  Future<bool> verifyotp(String email, String otp, String password) async {
    Response response = await authRepo.verifyOtp(email, otp, password);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> changepassword(String oldPassword, String newPassword) async {
    Response response = await authRepo.changepassword(oldPassword, newPassword);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Đổi mật khẩu thành công",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.warning_rounded, color: Colors.green),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    } else {
      Get.snackbar(
        "Thông báo",
        "Đổi mật khẩu thất bại ${response.body['message']}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.warning_rounded, color: Colors.red),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    }
  }
}
