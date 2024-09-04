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
   Future<Response> getall() async{
      return await apiClient.getData(Appconstant.CART_URL);
   }
   Future<Response> orderproduct(Cartdto cart) async{
      return await apiClient.postData(Appconstant.ORDER_PRODUCT_URL,cart.toJson());
   }
   
}