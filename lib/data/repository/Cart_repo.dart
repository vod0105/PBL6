import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:get/get.dart';

class CartRepo {
  final ApiClient apiClient;
  CartRepo({
    required this.apiClient,
  });
  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.CART_URL);
  }

  Future<Response> getById(int cartId) async {
    return await apiClient.getData(
        Appconstant.CART_BYID_URL.replaceFirst("{cartid}", cartId.toString()));
  }

  Future<Response> orderProductInCart(CartDto cart) async {
    return await apiClient.postData(
        Appconstant.ORDER_PRODUCT_INCART_URL, cart.toJson());
  }

  Future<Response> getAllStoreInCart() async {
    return await apiClient.getData(Appconstant.CART_STORE_URL);
  }

  Future<Response> getListCartByStore(int storeId) async {
    return await apiClient.getData(Appconstant.CART_STORE_LISTPRODUCT_URL
        .replaceFirst("{storeid}", storeId.toString()));
  }

  Future<Response> deleteCart(int cartId) async {
    return await apiClient.deleteData(Appconstant.CART_DELETE_URL
        .replaceFirst("{cartId}", cartId.toString()));
  }

  Future<Response> updateCart(int cartId, int quantity) async {
    return await apiClient.putData(
        Appconstant.CART_UPDATE_URL
            .replaceFirst("{cartId}", cartId.toString())
            .replaceFirst("{quantity}", quantity.toString()),
        null);
  }
}
