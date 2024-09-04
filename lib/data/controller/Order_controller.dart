import 'package:android_project/data/repository/Order_repo.dart';
import 'package:android_project/models/Model/OrderModel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  List<dynamic> _orderlist = [];
  List<dynamic> get orderlist => _orderlist;

  Future<void> getall() async{  
      _isLoading = false;
      Response response = await orderRepo.getall();
    
      if(response.statusCode == 200){
        print("Getting ... order ");
        var data = response.body;
        _orderlist = [];
        _orderlist.addAll(Ordermodel.fromJson(data).orders);
        print(_orderlist.length);
      }else{
        print("Error"+ response.statusCode.toString());
      }
      _isLoading = true;
      update();
  }

}