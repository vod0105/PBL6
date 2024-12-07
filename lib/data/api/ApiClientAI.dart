// ignore_for_file: file_names

import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class ApiClientAi extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClientAi({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = Appconstant.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  void updateHeader(String token) {
    this.token = token;
    _mainHeaders = {
      'Content-type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postDataPublic(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      Response response = await put(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri) async {
    try {
      Response response = await delete(uri, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
