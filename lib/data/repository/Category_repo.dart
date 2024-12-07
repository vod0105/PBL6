import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({
    required this.apiClient,
  });
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.CATEGORY_URL);
  }
  Future<Response> getByStoreId(int id) async {
    return await apiClient.getData(Appconstant.CATEGORY_BYSTOREID_URL.replaceFirst("{storeid}", id.toString()));
  }
}
