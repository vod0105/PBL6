import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class PromotionRepo {
  final ApiClient apiClient;
  PromotionRepo({required this.apiClient});
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.PROMOTION_URL);
  }
  Future<Response> getByStoreId(int storeId) async {
    return await apiClient.getData(Appconstant.PROMOTION_BYSTOREID_URL.replaceFirst("{storeId}", storeId.toString()));
  }
  Future<Response> getByUser() async {
    return await apiClient.getData(Appconstant.USER_PROMOTION_URL);
  }
   Future<Response> savePromotion(int voucherId) async {
    return await apiClient.postData(Appconstant.SAVE_PROMOTION_URL.replaceFirst("{voucherId}", voucherId.toString()),null);
  }


 
}
