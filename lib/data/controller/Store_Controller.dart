
import 'package:android_project/data/repository/Store_repo.dart';
import 'package:android_project/models/Model/StoreModel.dart';
import 'package:get/get.dart';

class Storecontroller extends GetxController {
  final StoreRepo storeRepo;
  Storecontroller({
    required this.storeRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await storeRepo.getall();
    
      if(response.statusCode == 200){
        print("Getting ... store ");
        var data = response.body;
        _productList = [];
        _productList.addAll(StoreModel.fromJson(data).stores);
      }else{
        print("Error"+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }

}