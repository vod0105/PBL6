import 'package:android_project/data/api/ApiClient.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../api/AppConstant.dart';

class StoreRepo {
  final ApiClient apiClient;
  StoreRepo({required this.apiClient});
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.STORE_URL);
  }

  Future<Response> getById(int id) async {
    return await apiClient.getData(
        Appconstant.STORE_BY_ID_URL.replaceFirst("{id}", id.toString()));
  }
}
