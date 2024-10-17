import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final ApiClient apiClient;
  CartRepo({
    required this.apiClient,
  });
  Future<Response> getall() async {
    return await apiClient.getData(Appconstant.CART_URL);
  }
  Future<Response> getbyid(int cartid) async {
    return await apiClient.getData(Appconstant.CART_BYID_URL.replaceFirst("{cartid}", cartid.toString()));
  }


  Future<Response> orderproductintcart(Cartdto cart) async {
    return await apiClient.postData(
        Appconstant.ORDER_PRODUCT_INCART_URL, cart.toJson());
  }
  Future<Response> getallstoreincart() async {
    return await apiClient.getData(
        Appconstant.CART_STORE_URL);
  }
  Future<Response> getlistcartbystore(int storeid) async {
    return await apiClient.getData(
        Appconstant.CART_STORE_LISTPRODUCT_URL.replaceFirst("{storeid}", storeid.toString()));
  }
}
