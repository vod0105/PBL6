import 'package:android_project/data/repository/Category_repo.dart';
import 'package:android_project/models/Model/CategoryModel.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  final CategoryRepo categoryRepo;
  CategoryController({
    required this.categoryRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _categoryList = [];
  List<dynamic> get categoryList => _categoryList;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await categoryRepo.getall();
    
      if(response.statusCode == 200){
        print("Getting ... category");
        var data = response.body;
        _categoryList = [];
        _categoryList.addAll(Categorymodel.fromJson(data).categories);
      }else{
        print("Error"+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }

}