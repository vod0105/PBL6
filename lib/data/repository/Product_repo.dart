import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:get/get.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({
    required this.apiClient
  });
  // get all product
  Future<Response> getall() async{
    return await apiClient.getData(Appconstant.PRODUCT_URL);
  }

  // get product by id
  Future<Response> getbyid(int id) async{
    String url = Appconstant.PRODUCT_BYID_URL.replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }
  // get product by category id
  Future<Response> getbycategoryid(int id) async{
    String url = Appconstant.PRODUCT_LIST_BYCATEGORYID_URL.replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }
  // add product to cart
  Future<Response> addtocart(int productid,int quantity, int idstore) async {
  String url = Appconstant.ADD_TOCART_URL
    .replaceFirst("{productid}", productid.toString())
    .replaceFirst("{quantity}", quantity.toString())
    .replaceFirst("{storeid}", idstore.toString());
  return await apiClient.postData(url, null); 
  }

  // get product by name
  Future<Response> getbyname(String textsearch) async{
    String url = Appconstant.PRODUCT_LIST_BYNAME_URL.replaceFirst("{productname}", textsearch);
    return await apiClient.getData(url);
  }
}