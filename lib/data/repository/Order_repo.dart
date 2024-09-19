import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });
  Future<Response> getall() async {
    return await apiClient.getData(Appconstant.ORDERT_URL);
  }

  Future<Response> getorderbyordercode(String ordercode) async {
    return await apiClient.getData(Appconstant.ORDER_BY_ORDERCODE_URL
        .replaceFirst("{ordercode}", ordercode));
  }

  Future<Response> getorderbyorderstatus(String status) async {
    return await apiClient.getData(
        Appconstant.ORDER_BY_ORDERSTATUS_URL.replaceFirst("{status}", status));
  }
}
