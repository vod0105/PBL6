import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/repository/Product_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/ProductModel.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({
    required this.productRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await productRepo.getall();
    
      if(response.statusCode == 200){
        print("Getting ... product ");
        var data = response.body;
        _productList = [];
        _productList.addAll(ProductModel.fromJson(data).products);
      }else{
        print("Error"+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }

    List<dynamic> _productListDetail = [];
    List<dynamic> get productListDetail => _productListDetail;

    Future<void> getProductById(int id) async {
      _isLoading = false;
      
      Response response = await productRepo.getbyid(id);
      
      if (response.statusCode == 200) {
        print("Getting product by id ..."+id.toString());
        var data = response.body;
        _productListDetail = [];
        _productListDetail.addAll(ProductModel.fromJson(data).products);
      } else {
        print("Error" + response.statusCode.toString());
      }
      
      _isLoading = true;
      update(); 
    }

    Future<void> addtocart(int productid,int quantity,int idstore) async {
      _isLoading = false;
      
      Response response = await productRepo.addtocart(productid,quantity,idstore);
      
      if (response.statusCode == 200) {
        Get.snackbar("Announce", "Add to cart success");
      } else {
        print("Error" + response.statusCode.toString());
      }
      
      _isLoading = true;
      update(); 
    }
  
  

}