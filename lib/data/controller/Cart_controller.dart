import 'package:android_project/data/repository/Cart_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/MomoModel.dart';
import 'package:android_project/models/Model/NewCartModel.dart';
import 'package:android_project/models/Model/ZaloModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_project/data/controller/Store_Controller.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });

  bool isLoading = false;

  MoMoModels qrcode = MoMoModels();

  ZaloData _qrcodeZalo = ZaloData();
  ZaloData get qrcodeZalo => _qrcodeZalo;

  List<CartData> cartList = [];

  int totalPrice = 0;

  final List<int> idSelectedItem = [];

  final List<int> idSelectedStore = [];

  final List<int> idSelectedCombo = [];

  List<int> listIDStore = [];

  List<ProductInCart> listCartWithStoreId = [];

  List<NewCartModel> listCart = [];

  List<NewCartModel> listCartInOrder = [];

  Storecontroller storecontroller = Get.find<Storecontroller>();

  Future<void> getAll() async {
    isLoading = true;
    Response response = await cartRepo.getAll();

    if (response.statusCode == 200) {
      var data = response.body;
      cartList = [];
      var cartData = CartModel.fromJson(data).data;
      if (cartData != null) {
        cartList.addAll(cartData);
      }
    } else {
      cartList = [];
      totalPrice = 0;
    }

    isLoading = false;
    update();
  }

  bool? ordering = false;

  Future<void> orderAll(String address, String paymentMethod, double latitude,
      double longitude, String discountCode) async {
    ordering = true;

    if (listCartInOrder.isNotEmpty) {
      List<int> listIdCartItem = [];
      for (NewCartModel cartModel in listCartInOrder) {
        for (CartData cart in cartModel.cartData!) {
          listIdCartItem.add(cart.cartId!);
        }
      }
      Response response;
      if (discountCode != "") {
        response = await cartRepo.orderProductInCart(CartDto(
            cartList: listIdCartItem,
            deliveryAddress: address,
            paymentMethod: paymentMethod,
            latitude: latitude,
            longitude: longitude,
            discountCode: discountCode));
      } else {
        response = await cartRepo.orderProductInCart(CartDto(
            cartList: listIdCartItem,
            deliveryAddress: address,
            paymentMethod: paymentMethod,
            latitude: latitude,
            longitude: longitude));
      }

      if (response.statusCode == 200) {
        var data = response.body;
        if (paymentMethod == "CASH") {
          Get.snackbar(
            "Thông báo",
            "Đặt đơn hàng thành công",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
            icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            isDismissible: true,
          );
          await getListCartV2();
        } else if (paymentMethod == "MOMO") {
          qrcode = (MoMoModels.fromJson(data).moMo);
        } else {
          _qrcodeZalo = ZaloModels.fromJson(data).zaloData!;
        }
      } else {}
    } else {
      Get.snackbar(
        "Thông báo",
        "Vui lòng chọn sản phẩm đặt đơn",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.warning, color: Colors.red),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    }
    ordering = false;
    update();
  }

  void updateTotal(int newTotal, bool key) {
    if (key) {
      totalPrice = totalPrice + newTotal.toInt();
    } else {
      totalPrice = totalPrice - newTotal.toInt();
    }
    update();
  }

  void resetIDSelected() {
    idSelectedItem.clear();
    idSelectedCombo.clear();
    idSelectedStore.clear();
    update();
  }

  void updateIDSelectedStore(int id, bool value) {
    if (value) {
      idSelectedStore.add(id);
    } else {
      idSelectedStore.remove(id);
    }
    update();
  }

  void updateIDSelectedItem(int id, bool value) {
    if (value) {
      idSelectedItem.add(id);
    } else {
      idSelectedItem.remove(id);
    }
    update();
  }

  void updateIDSelectedCombo(int id, bool value) {
    if (value) {
      idSelectedCombo.add(id);
    } else {
      idSelectedCombo.remove(id);
    }
    update();
  }

  Future<void> deleteCart(int cartId) async {
    Response response = await cartRepo.deleteCart(cartId);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Xóa  giỏ hàng thành công",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    } else {}
  }

  Future<void> updateCart(int cartId, int quantity) async {
    Response response = await cartRepo.updateCart(cartId, quantity);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Cập nhật giỏ hàng thành công",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    } else {}
  }

  bool checkInList(int storeId, List<int> listId) {
    for (int item in listId) {
      if (item == storeId) {
        return false;
      }
    }
    return true;
  }

  void getDistinctStoreId() async {
    for (var item in cartList) {
      if (item.type == "product") {
        if (checkInList(item.product!.storeId!, listIDStore)) {
          listIDStore.add(item.product!.storeId!);
        }
      } else {
        if (checkInList(item.combo!.storeId!, listIDStore)) {
          listIDStore.add(item.combo!.storeId!);
        }
      }
    }
  }

  void getCartWithStoreId(int storeId) {
    for (var item in cartList) {
      if (item.product!.storeId == storeId) {
        listCartWithStoreId.add(item.product!);
      }
    }
  }

  Future<void> getListCartV2() async {
    listCart = [];
    List<int> listStoreId = [];
    Response response = await cartRepo.getAllStoreInCart();
    if (response.statusCode == 200) {
      try {
        var data = response.body;
        if (data["data"] is List) {
          listStoreId.addAll(List<int>.from(data["data"]));
        } else {
          listStoreId = [];
          listCart = [];
          update();
        }
      } catch (e) {
        listStoreId = [];
        listCart = [];
      }

      for (int storeId in listStoreId) {
        await storecontroller.getById(storeId);
        StoresItem item = storecontroller.storeItem!;

        List<CartData> cartModelList = [];
        Response responseV2 = await cartRepo.getListCartByStore(storeId);
        if (responseV2.statusCode == 200) {
          var dataProduct = responseV2.body;
          cartModelList.addAll(CartModel.fromJson(dataProduct).data ?? []);
        } else {
          listCart = [];
          return;
        }
        NewCartModel newCartModel =
            NewCartModel(storeItem: item, cartData: cartModelList);
        listCart.add(newCartModel);

        update();
      }
    } else {}
  }

  Future<void> getListCartOrder() async {
    listCartInOrder.clear();
    if (idSelectedStore.isNotEmpty) {
      for (int storeId in idSelectedStore) {
        await storecontroller.getById(storeId);
        StoresItem item = storecontroller.storeItem!;

        Response responseV2 = await cartRepo.getListCartByStore(storeId);
        if (responseV2.statusCode == 200) {
          var dataProduct = responseV2.body;
          List<CartData> cartModelList =
              CartModel.fromJson(dataProduct).data ?? [];

          NewCartModel newCartModel =
              NewCartModel(storeItem: item, cartData: cartModelList);
          listCartInOrder.add(newCartModel);

          for (var idCart in cartModelList) {
            idSelectedItem.remove(idCart.cartId);
          }
        } else {
          return;
        }
        update();
      }
    }

    if (idSelectedItem.isNotEmpty) {
      for (int cartId in idSelectedItem) {
        Response response = await cartRepo.getById(cartId);
        if (response.statusCode == 200) {
          var data = response.body;
          CartData cartData = CartData.fromJson(data["data"][0]);
          bool newItem = true;
          for (NewCartModel cart in listCartInOrder) {
            if (cart.storeItem!.storeId == cartData.product!.storeId) {
              Set<int> cartIdSet = cart.cartData!.map((e) => e.cartId!).toSet();
              if (!cartIdSet.contains(cartData.cartId)) {
                cart.cartData!.add(cartData);
                newItem = false;
                update();
              } else {
                newItem = false;
              }
            }
          }
          if (newItem) {
            await storecontroller.getById(cartData.product!.storeId!);
            StoresItem storeItem = storecontroller.storeItem!;

            NewCartModel newCartModel =
                NewCartModel(storeItem: storeItem, cartData: [cartData]);
            listCartInOrder.add(newCartModel);
            update();
          }
        }
      }
    }
    if (idSelectedCombo.isNotEmpty) {
      for (int cartId in idSelectedCombo) {
        Response response = await cartRepo.getById(cartId);
        if (response.statusCode == 200) {
          var data = response.body;
          CartData cartData = CartData.fromJson(data["data"][0]);
          bool newItem = true;
          for (NewCartModel cart in listCartInOrder) {
            if (cart.storeItem!.storeId == cartData.combo!.storeId) {
              Set<int> cartIdSet = cart.cartData!.map((e) => e.cartId!).toSet();
              if (!cartIdSet.contains(cartData.cartId)) {
                cart.cartData!.add(cartData);
                newItem = false;
                update();
              } else {
                newItem = false;
              }
            }
          }
          if (newItem) {
            await storecontroller.getById(cartData.combo!.storeId!);
            StoresItem storeItem = storecontroller.storeItem!;

            NewCartModel newCartModel =
                NewCartModel(storeItem: storeItem, cartData: [cartData]);
            listCartInOrder.add(newCartModel);
            update();
          }
        }
      }
    }
  }
}
