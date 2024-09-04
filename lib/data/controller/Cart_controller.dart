import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/Cart_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/ResponeModel.dart';
import 'package:get/get.dart';


class CartController extends GetxController implements GetxService{
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });
   bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _cartlist = [];
  List<dynamic> get cartlist => _cartlist;

  double _totalprice = 0;
  double get totalprice => _totalprice;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await cartRepo.getall();
    
      if(response.statusCode == 200){
        print("Getting ... cart");
        var data = response.body;
        _cartlist = [];
        _cartlist.addAll(Cartmodel.fromJson(data).carts);

        _totalprice = _cartlist
          .map((item) => item.totalPrice ?? 0.0) 
          .reduce((value, element) => value + element); 

      }else{
        print("Error"+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }
  Future<void> orderall(String address , String paymentMethod) async{

    List<int> listcart = _cartlist.map<int>((item) => item.cartItemId).toList();

    Response response = await cartRepo.orderproduct(Cartdto(cartlist: listcart,deliveryAddress: address,paymentMethod: paymentMethod));
    if(response.statusCode == 200){
        Get.snackbar("Announce", "Order product success");
      }else{
        print("Error"+ response.statusCode.toString());
      }
  }

  void updateTotal(double newtotal) {
    this._totalprice = newtotal;
    update();
  }
}