import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });
  Future<Response> getall() async{
      return await apiClient.getData(Appconstant.ORDERT_URL);
  }
}