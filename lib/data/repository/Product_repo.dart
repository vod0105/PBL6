import 'dart:convert';
import 'dart:io';
import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/ApiClientAI.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/AddCartDto.dart';
import 'package:android_project/models/Dto/CommentDto.dart';
import 'package:android_project/models/Dto/OrderProductDto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  final ApiClient apiClient;
  final ApiClientAi apiClientAI;
  ProductRepo({required this.apiClient, required this.apiClientAI});

  Future<Response> getAll() async {
    return await apiClient.getData(Appconstant.PRODUCT_URL);
  }

  Future<Response> getById(int id) async {
    String url =
        Appconstant.PRODUCT_BYID_URL.replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }

  Future<Response> getByCategoryId(int id) async {
    String url = Appconstant.PRODUCT_LIST_BYCATEGORYID_URL
        .replaceFirst("{id}", id.toString());
    return await apiClient.getData(url);
  }

  Future<Response> addToCart(AddCartDto dto) async {
    return await apiClient.postData(Appconstant.ADD_TOCART_URL, dto.toJson());
  }

  Future<Response> getByName(String textSearch) async {
    String url =
        Appconstant.PRODUCT_LIST_BYNAME_URL.replaceFirst("{name}", textSearch);
    return await apiClient.getData(url);
  }

  Future<Response> getByStoreAndCategoryId(int storeId, int categoryId) async {
    return await apiClient.getData(Appconstant
        .PRODUCT_LIST_BYCATEGORYID_STOREID_URL
        .replaceFirst("{storeid}", storeId.toString())
        .replaceFirst("{categoryid}", categoryId.toString()));
  }

  Future<http.StreamedResponse> addComment(CommentDto dto) async {
    var uri =
        Uri.parse(Appconstant.BASE_URL + Appconstant.PRODUCT_ADD_COMMENT_URL);
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer ${apiClient.token}',
    });

    request.fields.addAll(dto.toJson());

    if (dto.imageFiles != null) {
      for (File image in dto.imageFiles!) {
        String fileName = image.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath(
            'imageFiles', image.path,
            filename: fileName));
      }
    }

    return await request.send();
  }

  Future<Response> getComment(int productId) async {
    return await apiClient.getData(Appconstant.PRODUCT_GET_COMMENT_URL
        .replaceFirst("{productid}", productId.toString()));
  }

  Future<Response> order(Orderproductdto dto) async {
    return await apiClient.postData(
        Appconstant.ORDER_COMBO_2_URL, dto.toJson());
  }

  Future<Response> searchByImage(String base64Image) async {
    final body = jsonEncode({
      'image': base64Image,
    });
    return await apiClientAI.postDataPublic(
        Appconstant.SEARCH_BYIMAGE_URL, body);
  }

  Future<Response> getByStoreId(int storeId) async {
    return await apiClient.getData(Appconstant.PRODUCT_BYSTOREID_URL
        .replaceFirst("{id}", storeId.toString()));
  }

  Future<Response> getRecommendProduct(int userId) async {
    return await apiClientAI.getData(Appconstant.RECOMMEND_PRODUCT_URL
        .replaceFirst("{userId}", userId.toString()));
  }

  Future<Response> getListDrinkInCombo(List<int> storeId) async {
    String storeIdString = storeId.join(",");
    String uri = Appconstant.DRINK_URL.replaceFirst("{storeId}", storeIdString);
    return await apiClient.getData(uri);
  }
}
