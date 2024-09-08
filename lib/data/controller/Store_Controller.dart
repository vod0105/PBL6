
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

  List<dynamic> _storeList = [];
  List<dynamic> get storeList => _storeList;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await storeRepo.getall();
    
      if(response.statusCode == 200){
        print("Lấy dữ liệu danh sách cửa hàng thành công");
        var data = response.body;
        _storeList = [];
        _storeList.addAll(StoreModel.fromJson(data).stores);
        print(_storeList);
      }else{
        print("Lỗi không lấy được danh sách cửa hàng : "+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }

}