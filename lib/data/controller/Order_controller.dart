import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/repository/Order_repo.dart';
import 'package:android_project/models/Model/OrderModel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });
  bool isLoading = false;



  List<OrderItem> orderList = [];

  Future<void> getAll() async {
    isLoading = true;
    Response response = await orderRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      orderList = OrderModel.fromJson(data).orderItem ?? [];
    } else {
      orderList = [];
    }
    isLoading = false;
    update();
  }

  OrderItem? orderDetail;

  Future<void> getOrderByOrderCode(String orderCode) async {
    isLoading = true;
    Response response = await orderRepo.getOrderByOrderCode(orderCode);
    if (response.statusCode == 200) {
      var data = response.body;

      orderDetail = OrderItem.fromJson(data["data"]);
    } else {
    }
    isLoading = false;
    update();
  }

  Future<void> getOrderWithStatus(String status) async {
    isLoading = true;
    Response response = await orderRepo.getOrderByOrderStatus(status);
    if (response.statusCode == 200) {
      var data = response.body;
      orderList = OrderModel.fromJson(data).orderItem ?? [];
    } else {
      orderList = [];
    }
    isLoading = false;
    update();
  }
  Future<void> updateFeedback(int orderid)async{
    Response response = await orderRepo.updateFeedback(orderid);
    if(response.statusCode != 200){
    }
  }
  Future<void> cancelOrder(String orderCode,String status)async{
    Response response = await orderRepo.cancelOrder(orderCode);
    if(response.statusCode != 200){
    }
    else{
      Get.find<UserController>().addAnnoUce("Thông báo đơn hàng", "Bạn vừa đặt hủy thành công một đơn hàng !"); 
     await getOrderWithStatus(status);
      
    }
  }
}
