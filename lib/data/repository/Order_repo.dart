import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.ORDERT_URL);
  }

  Future<Response> getOrderByOrderCode(String orderCode) async {
    return await apiClient.getData(Appconstant.ORDER_BY_ORDERCODE_URL
        .replaceFirst('{ordercode}', orderCode));
  }

  Future<Response> getOrderByOrderStatus(String status) async {
    return await apiClient.getData(
        Appconstant.ORDER_BY_ORDERSTATUS_URL.replaceFirst("{status}", status));
  }
   Future<Response> updateFeedback(int orderId) async {
    return await apiClient.postData(
        Appconstant.ORDER_UPDATE_FEEDBACK_URL.replaceFirst("{orderid}", orderId.toString()),null);
  }
  Future<Response> cancelOrder(String orderCode) async {
    return await apiClient.postData(
        Appconstant.ORDERT_CANCEL_URL.replaceFirst("{ordercode}",orderCode),null);
  }
}
