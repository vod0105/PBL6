import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:get/get.dart';

class ComboRepo {
  final ApiClient apiClient;
  ComboRepo({
    required this.apiClient,
  });
  Future<Response> getall() async{
      return await apiClient.getData(Appconstant.COMBO_URL);
  }
  
}