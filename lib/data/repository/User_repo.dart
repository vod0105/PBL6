import 'package:android_project/data/api/ApiClient.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../api/AppConstant.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient
  });
  Future<Response> getuserprofile() async{
    return await apiClient.getData(Appconstant.USER_PROFILE_URL);
  }
}