import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/Cart_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/MomoModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _cartlist = [];
  List<dynamic> get cartlist => _cartlist;

  double _totalprice = 0;
  double get totalprice => _totalprice;

  List<int> _IDSelectedProduct = [];
  List<int> get IDSelectedProduct => _IDSelectedProduct;

  List<int> _IDSelectedCombo = [];
  List<int> get IDSelectedCombo => _IDSelectedCombo;

  Future<void> getall() async {
    _isLoading = false;
    Response response = await cartRepo.getall();

    if (response.statusCode == 200) {
      print("Lấy dữ liệu danh sách giỏ hàng thành công");
      var data = response.body;
      _cartlist = [];
      var cartData = Cartmodel.fromJson(data).getdata;
      if (cartData != null) {
        _cartlist.addAll(cartData);
      }

      _totalprice = _cartlist
          .where((item) => item.product != null)
          .map((item) => item.product!.totalPrice?.toDouble() ?? 0.0)
          .fold(0.0, (previous, current) => previous + current);
    } else {
      print("Lỗi không lấy được danh sách đơn hàng " +
          response.statusCode.toString());
      _cartlist = [];
      _totalprice = 0;
    }
    _isLoading = true;
    update();
  }

  MomoModels _qrcode = MomoModels();
  MomoModels get qrcode => _qrcode;

  Future<void> orderall(String address, String paymentMethod) async {
    if (!_IDSelectedProduct.isEmpty && _IDSelectedCombo.isEmpty) {
      Response response = await cartRepo.orderproduct(Cartdto(
          cartlist: _IDSelectedProduct,
          deliveryAddress: address,
          paymentMethod: paymentMethod));
      if (response.statusCode == 200) {
        if (paymentMethod == "CASH") {
          Get.snackbar("Thông báo", "Đặt đơn hàng thành công");
          await getall();
        } else {
          var data = response.body;
          _qrcode = (MomoModels.fromJson(data).momo);
          print(_qrcode.payUrl);
        }
      } else {
        print("Đặt đơn hàng sản phẩm thất bại : " +
            response.statusCode.toString());
      }
    } else if (_IDSelectedProduct.isEmpty && !_IDSelectedCombo.isEmpty) {
      Response response = await cartRepo.ordercombo(Cartdto(
          cartlist: _IDSelectedCombo,
          deliveryAddress: address,
          paymentMethod: paymentMethod));
      if (response.statusCode == 200) {
        if (paymentMethod == "CASH") {
          Get.snackbar("Thông báo", "Đặt đơn hàng thành công");
          await getall();
        } else {
          var data = response.body;
          _qrcode = (MomoModels.fromJson(data).momo);
          print(_qrcode.payUrl);
        }
      } else {
        print(
            "Đặt đơn hàng combo thất bại : " + response.statusCode.toString());
      }
    } else if (!_IDSelectedProduct.isEmpty && !_IDSelectedCombo.isEmpty) {
      Response response = await cartRepo.orderproduct(Cartdto(
          cartlist: _IDSelectedProduct,
          deliveryAddress: address,
          paymentMethod: paymentMethod));
      Response responsecombo = await cartRepo.ordercombo(Cartdto(
          cartlist: _IDSelectedCombo,
          deliveryAddress: address,
          paymentMethod: paymentMethod));
      if (response.statusCode == 200) {
        if (paymentMethod == "CASH") {
          Get.snackbar("Thông báo", "Đặt đơn hàng thành công");
          await getall();
        } else {
          var data = response.body;
          _qrcode = (MomoModels.fromJson(data).momo);
          print(_qrcode.payUrl);
        }
      } else {
        print("Lỗi đặt đơn hàng" + response.statusCode.toString());
      }
    } else {
      Get.snackbar("Thông báo", "Vui lòng chọn sản phẩm đặt đơn");
    }
    update();
  }

  void updateTotal(double newtotal) {
    this._totalprice = newtotal;
    update();
  }

  void resetIDSelected() {
    _IDSelectedProduct.clear();
    _IDSelectedCombo.clear();
    update();
  }

  void updateIDSelectedProduct(int id, bool value) {
    if (value) {
      _IDSelectedProduct.add(id);
    } else {
      _IDSelectedProduct.remove(id);
    }
    update();
  }

  void updateIDSelectedCombo(int id, bool value) {
    if (value) {
      _IDSelectedCombo.add(id);
    } else {
      _IDSelectedCombo.remove(id);
    }

    update();
  }

  bool checkInList(int storeId, List<int> listId) {
    for (int item in listId) {
      if (item == storeId) {
        return false;
      }
    }
    return true;
  }

  List<int> listIDStore = [];
  List<int> get getlistIDStore => listIDStore;

  void getDistinctStoreId() async {
    _cartlist.forEach((item) {
      if (checkInList(item.product.storeId, listIDStore)) {
        listIDStore.add(item.product.storeId);
      }
      ;
    });
  }

  List<dynamic> listCartWithStoreId = [];
  List<dynamic> get getlistCartWithStoreId => listCartWithStoreId;
  void getCartWithStoreId(int storeId) {
    _cartlist.forEach((item) {
      if (item.product.storeId == storeId) {
        listCartWithStoreId.add(item.product);
      }
    });
  }
}
