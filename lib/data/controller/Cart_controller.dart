import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/Cart_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/MomoModel.dart';
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
      var cartData = Cartmodel.fromJson(data).getdata;
      if (cartData != null) {
        _cartlist.addAll(cartData);
      }
      print(_cartlist[0].product.productName);

       _totalprice = _cartlist
      .where((item) => item.product != null) 
      .map((item) => item.product!.totalPrice?.toDouble() ?? 0.0) 
      .fold(0.0, (previous, current) => previous + current); 


      }else{
        print("Error "+ response.statusCode.toString());
         _cartlist = [];
      }
      _isLoading = true;
      update();
  }

  MomoModels _qrcode = MomoModels();
  MomoModels get qrcode => _qrcode;

  Future<void> orderall(String address , String paymentMethod) async{
   
      List<int> listcart = _cartlist.map<int>((item) => item.cartItemId).toList();
      Response response = await cartRepo.orderproduct(Cartdto(cartlist: listcart,deliveryAddress: address,paymentMethod: paymentMethod));
      if(response.statusCode == 200){
          if(paymentMethod == "CASH")
          {
            Get.snackbar("Announce", "Order product success");
            await getall(); 
          }
          else{
            var data = response.body;
            _qrcode = (MomoModels.fromJson(data).momo);
            print(_qrcode.payUrl);
          }
           
      }else{
        print("Error"+ response.statusCode.toString());
      }
    update();

    
  }

  void updateTotal(double newtotal) {
    this._totalprice = newtotal;
    update();
  }
}