import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/repository/Product_repo.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/ProductModel.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({
    required this.productRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // get all product
  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;
  Future<void> getall() async {
    _isLoading = false;
    Response response = await productRepo.getall();
    if (response.statusCode == 200) {
      var data = response.body;
      _productList = [];
      _productList.addAll(Productmodel.fromJson(data).get_listproduct ?? []);
    } else {
      print("Lỗi không lấy được dữ liệu danh sách sản phẩm : " +
          response.statusCode.toString());
    }
    _isLoading = true;
    update();
  }

  // get product by id
  List<dynamic> _productListDetail = [];
  List<dynamic> get productListDetail => _productListDetail;
  Future<void> getProductById(int id) async {
    _isLoading = false;
    Response response = await productRepo.getbyid(id);
    if (response.statusCode == 200) {
      var data = response.body;
      _productListDetail = [];
      _productListDetail
          .addAll(Productmodel.fromJson(data).get_listproduct ?? []);
    } else {
      print("Lỗi không lấy được dữ liệu chi tiết sản phẩm : " +
          response.statusCode.toString());
    }
    _isLoading = true;
    update();
  }

  // add to cart
  Future<void> addtocart(
      int productid, int quantity, int idstore, String sizename) async {
    _isLoading = false;
    Response response =
        await productRepo.addtocart(productid, quantity, idstore, sizename);
    if (response.statusCode == 200) {
      Get.snackbar("Thông báo", "Thêm vào giỏ hàng thành công");
    } else {
      print("Lỗi thêm sản phẩm vào giỏ hàng" + response.statusCode.toString());
    }
    _isLoading = true;
    update();
  }

  // get product by category id
  List<dynamic> _productListBycategory = [];
  List<dynamic> get productListBycategory => _productListBycategory;
  Future<void> getProductByCategoryId(int id) async {
    _isLoading = false;
    Response response = await productRepo.getbycategoryid(id);
    if (response.statusCode == 200) {
      var data = response.body;
      _productListBycategory = [];
      _productListBycategory
          .addAll(Productmodel.fromJson(data).get_listproduct ?? []);
    } else {
      print("Lỗi không lấy được danh sách sản phẩm theo danh mục" +
          response.statusCode.toString());
    }
    _isLoading = true;
    update();
  }

  // get product by name
  String textSearch = "";
  String get gettextSearch => textSearch;

  void updateTextSearch(String text) {
    this.textSearch = text;
    update();
  }

  List<dynamic> _productListSearch = [];
  List<dynamic> get productListSearch => _productListSearch;

  Future<void> search() async {
    try {
      if (textSearch == "") {
        _productListSearch = _productList;
      } else {
        Response response = await productRepo.getbyname(this.textSearch);
        if (response.statusCode == 200) {
          var data = response.body;
          _productListSearch = [];
          _productListSearch
              .addAll(Productmodel.fromJson(data).get_listproduct ?? []);
        } else {
          print("Lỗi không lấy được danh sách sản phẩm theo tên" +
              response.statusCode.toString());
          _productListSearch = [];
        }
      }
    } catch (e) {
      print("Exception: $e");
      _productListSearch = [];
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }
}
