import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:get/get.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({
    required this.apiClient
  });
  Future<Response> getall() async{
    return await apiClient.getData(Appconstant.PRODUCT_URL);
  }
  Future<Response> getbyid(int id) async{
    String url = Appconstant.PRODUCT_BYID_URL.replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }
  Future<Response> addtocart(int productid,int quantity, int idstore) async {
  String url = Appconstant.ADD_TOCART_URL
    .replaceFirst("{productid}", productid.toString())
    .replaceFirst("{quantity}", quantity.toString())
    .replaceFirst("{storeid}", idstore.toString());
  return await apiClient.postData(url, null); 
}
}