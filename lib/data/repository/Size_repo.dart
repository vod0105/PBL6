import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class SizeRepo {
  final ApiClient apiClient;
  SizeRepo({required this.apiClient});
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.SIZE_URL);
  }

  Future<Response> getById(int id) async {
    return await apiClient.getData(
        Appconstant.SIZE_BY_ID_URL.replaceFirst(("{id}"), id.toString()));
  }
}
