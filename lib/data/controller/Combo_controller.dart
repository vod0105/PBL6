import 'package:android_project/data/repository/Combo_repo.dart';
import 'package:android_project/models/Model/ComboModel.dart';
import 'package:get/get.dart';

class ComboController extends GetxController{
  final ComboRepo comboRepo;
  ComboController({
    required this.comboRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _comboList = [];
  List<dynamic> get comboList => _comboList;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await comboRepo.getall();
    
      if(response.statusCode == 200){
        print("Lấy dữ liệu danh sách combo thành công");
        var data = response.body;
        _comboList = [];
        _comboList.addAll(Combomodel.fromJson(data).get_listcombo ?? []);
      }else{
        print("Lỗi không lấy được danh sách com bo : "+ response.statusCode.toString());
        _comboList = [];
      }
      _isLoading = true;
      update();
  }

  List<dynamic> _comboDetail = [];
  List<dynamic> get comboDetail => _comboDetail;

  Future<void> getbyid(int id) async{  
      _isLoading = false;
      Response response = await comboRepo.getbyid(id);
      if(response.statusCode == 200){
        print("Lấy dữ liệu chi tiết combo thành công");
        var data = response.body;
        _comboDetail = [];
        _comboDetail.addAll(Combomodel.fromJson(data).get_listcombo ?? []);
        update();
      }else{
        print("Lỗi không lấy được danh sách com bo : "+ response.statusCode.toString());
         _comboDetail = [];
      }
      _isLoading = true;
      update();
  }


}