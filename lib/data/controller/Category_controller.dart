import 'package:android_project/data/repository/Category_repo.dart';
import 'package:android_project/models/Model/CategoryModel.dart';
import 'package:android_project/models/Model/Item/CategoryItem.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryRepo categoryRepo;
  CategoryController({
    required this.categoryRepo,
  });

  bool? isLoading;

  bool isLoadingStore = false;

  List<CategoryItem> categoryList = [];

  List<CategoryItem> categoryListStoreId = [];

  Future<void> getAll() async {
    isLoading = true;
    Response response = await categoryRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      categoryList = [];
      categoryList.addAll(CategoryModel.fromJson(data).listCategory ?? []);
    } else {
      categoryList = [];
    }
    isLoading = false;
    update();
  }

  Future<void> getByStoreId(int id) async {
    isLoadingStore = true;
    Response response = await categoryRepo.getByStoreId(id);

    if (response.statusCode == 200) {
      var data = response.body;
      categoryListStoreId = [];
      categoryListStoreId
          .addAll(CategoryModel.fromJson(data).listCategory ?? []);
    } else {
      categoryListStoreId = [];
    }
    isLoadingStore = false;
    update();
  }
}
