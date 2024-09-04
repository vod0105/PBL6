import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({
    required this.apiClient,
  });
  Future<Response> getall() async{
      return await apiClient.getData(Appconstant.CATEGORY_URL);
  }
}