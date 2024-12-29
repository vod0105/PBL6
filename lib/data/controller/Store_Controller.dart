import 'package:android_project/data/repository/Store_repo.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/StoreModel.dart';
import 'package:get/get.dart';

class Storecontroller extends GetxController {
  final StoreRepo storeRepo;
  Storecontroller({
    required this.storeRepo,
  });

  bool isLoading = false;
  StoresItem? storeItem;
  bool loadingCommonStore = false;
  List<StoresItem> storeList = [];
  bool isLoadingItem = false;

  Future<void> getAll() async {
    isLoading = true;
    update();
    Response response = await storeRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      storeList = [];
      storeList.addAll(StoresModel.fromJson(data).listStores ?? []);

      isLoading = false;
      update();
    } else {
      storeList = [];
      isLoading = false;
      update();
    }
  }

  String addressOfStore(int storeId) {
    for (StoresItem item in storeList) {
      if (item.storeId == storeId) {
        return item.location!;
      }
    }
    return "";
  }

  StoresItem? getStoreById(int idStore) {
    for (StoresItem item in storeList) {
      if (item.storeId == idStore) {
        return item;
      }
    }
    return null;
  }

  Future<void> getById(int id) async {
    isLoadingItem = true;
    Response response = await storeRepo.getById(id);
    if (response.statusCode == 200) {
      var data = response.body;
      storeItem = StoresItem.fromJson(data["data"]);
    } else {}
    isLoadingItem = false;
    update();
  }

  Future<String> getNameStoreById(int id) async {
    Response response = await storeRepo.getById(id);
    if (response.statusCode == 200) {
      var data = response.body["data"];
      return data["storeName"];
    } else {
      return "No name";
    }
  }

  List<StoresItem> getCommonStores(List<Productitem> listProduct) {
    loadingCommonStore = true;
    if (listProduct.isEmpty) {
      return [];
    }
    List<StoresItem> initialStores = listProduct[0].stores!;
    Set<String?> commonStoreNames =
        initialStores.map((store) => store.storeName).toSet();
    for (int i = 1; i < listProduct.length; i++) {
      List<StoresItem> currentStores = listProduct[i].stores!;
      Set<String?> currentStoreNames =
          currentStores.map((store) => store.storeName).toSet();
      commonStoreNames = commonStoreNames.intersection(currentStoreNames);
    }
    List<StoresItem> commonStores = [];
    for (var storeName in commonStoreNames) {
      var store =
          initialStores.firstWhere((store) => store.storeName == storeName);
      commonStores.add(store);
    }
    loadingCommonStore = false;
    return commonStores;
  }
}
