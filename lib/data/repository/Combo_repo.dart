import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/AddComboToCartDto.dart';
import 'package:android_project/models/Dto/OrderComboDto.dart';
import 'package:get/get.dart';

class ComboRepo {
  final ApiClient apiClient;
  ComboRepo({
    required this.apiClient,
  });
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.COMBO_URL);
  }

  Future<Response> getById(int id) async {
    String url =
        Appconstant.COMBO_BY_COMBOID_URL.replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }
  Future<Response> getByStoreId(int storeId) async {
    String url =
        Appconstant.COMBO_BY_STOREID_URL.replaceFirst("{storeid}", storeId.toString());
    return await apiClient.getData(url);
  }
  Future<Response> order(OrderComboDto dto) async {
    return await apiClient.postData(Appconstant.ORDER_COMBO_2_URL,dto.toJson());
  }
   Future<Response> addToCart(ComboToCartDto dto) async {
    return await apiClient.postData(Appconstant.COMBO_TO_CART_URL,dto.toJson());
  }
}
