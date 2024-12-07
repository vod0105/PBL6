import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> login(UserDto dto) async {
    return await apiClient.postData(Appconstant.LOGIN_URL, dto.toJson());
  }

  Future<Response> logout(String token) async {
    return await apiClient.postData(Appconstant.LOGOUT_URL, token);
  }

  Future<Response> register(UserRegisterDto dto) async {
    return await apiClient.postData(Appconstant.REGISTER_URL, dto.toJson());
  }
  Future<Response> changepassword(String oldPassword,String newPassword) async {
    return await apiClient.postData(Appconstant.CHANGEPASSWORD_URL.replaceFirst("{oldPassword}", oldPassword).replaceFirst("{newpassword}", newPassword), null);
  }

  Future<Response> sendOtp(String email) async {
    return await apiClient
        .postData(Appconstant.SENDOTP_URL.replaceFirst("{email}", email),null);
  }

  Future<Response> verifyOtp(
      String email, String otp, String newPassword) async {
        String url =Appconstant.VERIFYOTP_URL
        .replaceFirst("{email}", email)
        .replaceFirst("{otp}", otp)
        .replaceFirst("{newpassword}", newPassword);
    return await apiClient.postData(url,null);
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(Appconstant.TOKEN, token);
  }
}
