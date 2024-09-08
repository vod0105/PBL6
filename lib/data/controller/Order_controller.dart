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

  List<OrderItem> _orderlist = [];
  List<OrderItem> get orderlist => _orderlist;

Future<void> getall() async {
  _isLoading = true;
  Response response = await orderRepo.getall();
  if (response.statusCode == 200) {
    print("Lấy thành công danh sách đơn hàng");
    var data = response.body;
    _orderlist = Ordermodel.fromJson(data).getorderitem ?? [];
  } else {
    print("Lỗi không lấy được danh sách đơn hàng: " + response.statusCode.toString());
    _orderlist = [];
  }
  _isLoading = false;
  update();
}



}