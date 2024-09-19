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
  Future<Response> login(Userdto dto) async {
    return await apiClient.postData(Appconstant.LOGIN_URL, dto.toJson());
  }

  Future<Response> register(Userregisterdto dto) async {
    return await apiClient.postData(Appconstant.REGISTER_URL, dto.toJson());
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(Appconstant.TOKEN, token);
  }
}
