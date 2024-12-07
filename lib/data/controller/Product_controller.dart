import 'dart:convert';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/repository/Product_repo.dart';
import 'package:android_project/models/Dto/AddCartDto.dart';
import 'package:android_project/models/Dto/CommentDto.dart';
import 'package:android_project/models/Dto/OrderProductDto.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/MomoModel.dart';
import 'package:android_project/models/Model/ProductModel.dart';
import 'package:android_project/models/Model/RateModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/models/Model/ZaloModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  UserController userController = Get.find<UserController>();
  AuthController authController = Get.find<AuthController>();
  ProductController({
    required this.productRepo,
  });
  bool isLoading = false;

  List<Productitem> productList = [];

  Future<void> getAll() async {
    isLoading = true;
    Response response = await productRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      productList = [];
      productList.addAll(ProductModel.fromJson(data).listProduct ?? []);
    } else {}
    isLoading = false;
    update();
  }

  Productitem? getProductById(int id) {
    for (Productitem item in productList) {
      if (item.productId == id) {
        return item;
      }
    }
    return null;
  }

  Future<void> addToCart(
      int productId, int quantity, int idStore, String sizeName) async {
    isLoading = true;
    AddCartDto cart = AddCartDto(
        productId: productId,
        quantity: quantity,
        size: sizeName,
        storeId: idStore);
    Response response = await productRepo.addToCart(cart);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Thêm vào giỏ hàng thành công",
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
    isLoading = false;
    update();
  }

  List<Productitem> productListByCategory = [];

  bool isLoadingProductInCategory = true;
  Future<void> getProductByCategoryId(int id) async {
    isLoadingProductInCategory = true;
    Response response = await productRepo.getByCategoryId(id);
    if (response.statusCode == 200) {
      var data = response.body;
      productListByCategory = [];
      productListByCategory
          .addAll(ProductModel.fromJson(data).listProduct ?? []);
    } else {}
    isLoadingProductInCategory = false;
    update();
  }

  List<Productitem> productListByCategoryStore = [];

  bool isLoadingStoreCategory = false;
  Future<void> getProductByStoreCategoryId(int storeId, int categoryId) async {
    isLoadingStoreCategory = true;
    Response response =
        await productRepo.getByStoreAndCategoryId(storeId, categoryId);
    if (response.statusCode == 200) {
      var data = response.body;
      productListByCategoryStore = [];
      productListByCategoryStore
          .addAll(ProductModel.fromJson(data).listProduct ?? []);
    } else {}
    isLoadingStoreCategory = false;
    update();
  }

  Future<List<Productitem>> getProductByStoreCategoryIdV2(
      int storeId, int categoryId) async {
    List<Productitem> list = [];
    Response response =
        await productRepo.getByStoreAndCategoryId(storeId, categoryId);
    if (response.statusCode == 200) {
      var data = response.body;

      list.addAll(ProductModel.fromJson(data).listProduct ?? []);
    } else {}
    return list;
  }

  String textSearch = "";
  String get gettextSearch => textSearch;

  void updateTextSearch(String text) {
    textSearch = text;
    update();
  }

  List<Productitem> productListSearch = [];

  void search() {
    try {
      productListSearch = [];

      if (textSearch.isEmpty) {
        productListSearch = productList;
      } else {
        for (Productitem item in productList) {
          if (item.productName!
              .toLowerCase()
              .contains(textSearch.toLowerCase())) {
            productListSearch.add(item);
          }
        }
      }
    } catch (e) {
      productListSearch = [];
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }

  void swap(List<Productitem> arr, int i, int j) {
    Productitem temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
  }

  int partition(List<Productitem> arr, int low, int high, type) {
    Productitem pivot = arr[high];
    int i = low - 1;

    for (int j = low; j <= high - 1; j++) {
      if (type == 1) {
        if (arr[j].price! > pivot.price!) {
          i++;
          swap(arr, i, j);
        }
      } else {
        if (arr[j].price! < pivot.price!) {
          i++;
          swap(arr, i, j);
        }
      }
    }

    swap(arr, i + 1, high);
    return i + 1;
  }

  void quickSort(List<Productitem> arr, int low, int high, int type) {
    if (low < high) {
      int pi = partition(arr, low, high, type);
      quickSort(arr, low, pi - 1, type);
      quickSort(arr, pi + 1, high, type);
    }
  }

  void sortDes(int type) {
    try {
      quickSort(productListSearch, 0, productListSearch.length - 1, type);
    } catch (e) {
      productListSearch = [];
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }

  void getAllProductSearch() {
    try {
      productListSearch = productList;
      textSearch = "";
    } catch (e) {
      productListSearch = [];
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }

  void filterProduct(String categoryName, int lowPrice, int highPrice) {
    try {
      productListSearch = [];
      for (Productitem item in productList) {
        if (categoryName == "Tất cả") {
          if (item.price!.toInt() > lowPrice &&
              item.price!.toInt() < highPrice) {
            productListSearch.add(item);
          }
        } else {
          if (item.category!.categoryName == categoryName &&
              item.price!.toInt() > lowPrice &&
              item.price!.toInt() < highPrice) {
            productListSearch.add(item);
          }
        }
      }
    } catch (e) {
      productListSearch = [];
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }

  Future<void> searchByImage(String base64Image) async {
    Response response = await productRepo.searchByImage(base64Image);
    if (response.statusCode == 200) {
      var data = response.body;
      productListSearch = [];
      for (Productitem item in productList) {
        if (item.productName!.toLowerCase().contains(data.toLowerCase())) {
          productListSearch.add(item);
        }
      }
      update();
    } else {
      productListSearch = [];
      update();
    }
  }

  List<Productitem>? getListDrink() {
    List<Productitem> productListDrink = [];
    for (Productitem item in productList) {
      if (item.category!.categoryName == "Nước uống") {
        productListDrink.add(item);
      }
    }
    return productList;
  }

  Future<void> addComment(CommentDto dto) async {
    var response = await productRepo.addComment(dto);

    var responseString = await response.stream.bytesToString();

    try {
      jsonDecode(responseString);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Thông báo",
          "Phản hồi thành công",
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
    // ignore: empty_catches
    } catch (e) {}
  }

  List<DisplayRate> listComment = [];
  bool? loadingComment = false;
  Future<void> getComment(int productId) async {
    loadingComment = true;
    Response response = await productRepo.getComment(productId);
    if (response.statusCode == 200) {
      var data = response.body;
      listComment = [];
      for (RateData item in RateModel.fromJson(data).listRate ?? []) {
        User? user = await userController.getById(item.userId!);
        while (userController.loadReceiver!) {
          await Future.delayed(const Duration(microseconds: 100));
        }
        DisplayRate displayRate = DisplayRate(user: user, rateData: item);
        listComment.add(displayRate);
      }
    } else {}
    loadingComment = false;
    update();
  }

  MoMoModels _qrcode = MoMoModels();
  MoMoModels get qrcode => _qrcode;
  ZaloData _qrcodeZalo = ZaloData();
  ZaloData get qrcodeZalo => _qrcodeZalo;
  bool loadingOrder = false;
  Future<void> order(Orderproductdto dto) async {
    loadingOrder = true;
    Response response = await productRepo.order(dto);
    if (response.statusCode == 200) {
      var data = response.body;
      if (dto.paymentMethod == "CASH") {
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
      } else if (dto.paymentMethod == "MOMO") {
        _qrcode = (MoMoModels.fromJson(data).moMo);
      } else {
        _qrcodeZalo = ZaloModels.fromJson(data).zaloData!;
      }
    } else {}
    loadingOrder = false;
    update();
  }

  Future<List<Productitem>> getByStoreId(int storeId) async {
    List<Productitem> result = [];
    Response response = await productRepo.getByStoreId(storeId);
    if (response.statusCode == 200) {
      var data = response.body;
      result.addAll(ProductModel.fromJson(data).listProduct ?? []);
      return result;
    } else {
      return result;
    }
  }

  bool loadingRecommendProduct = false;
  List<int> listProductId = [];
  Future<void> getRecommendProduct() async {
    loadingRecommendProduct = true;
    Response response =
        await productRepo.getRecommendProduct(authController.idUser);
    if (response.statusCode == 200) {
      listProductId = [];
      if (response.body is List) {
        listProductId = List<int>.from(response.body);
      } else if (response.body is String) {
        listProductId = List<int>.from(jsonDecode(response.body));
      } else {
        throw Exception("response.body không phải là kiểu hợp lệ");
      }
    } else {
      listProductId = [];
    }
    loadingRecommendProduct = false;
    update();
  }

  List<Productitem> listProductRecommend = [];
  void getProductRecommend() async {
    for (Productitem item in productList) {
      if (listProductId.contains(item.productId)) {
        listProductRecommend.add(item);
      }
    }
  }

  bool loadDrinkInCombo = false;
  Future<List<Productitem>?> getListDrinkInCombo(List<int> storeId) async {
    loadDrinkInCombo = true;
    List<Productitem> res = [];
    Response response = await productRepo.getListDrinkInCombo(storeId);
    if (response.statusCode == 200) {
      res = [];
      var data = response.body;
      res.addAll(ProductModel.fromJson(data).listProduct ?? []);
      loadDrinkInCombo = false;
      update();
      return res;
    } else {}
    return null;
  }
}
