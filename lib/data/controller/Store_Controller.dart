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
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<StoresItem> _storeList = [];
  List<StoresItem> get storeList => _storeList;

  Future<void> getAll() async {
    _isLoading = true;
    Response response = await storeRepo.getAll();

    if (response.statusCode == 200) {
      var data = response.body;
      _storeList = [];
      _storeList.addAll(StoresModel.fromJson(data).listStores ?? []);
    } else {
    }
    _isLoading = false;
    update();
  }

  String addressOfStore(int storeId) {
    for (StoresItem item in _storeList) {
      if (item.storeId == storeId) {
        return item.location!;
      }
    }
    return "";
  }

  StoresItem? getStoreById(int idStore) {
    for (StoresItem item in _storeList) {
      if (item.storeId == idStore) {
        return item;
      }
    }
    return null;
  }

  StoresItem? _storeItem;
  StoresItem? get storeItem => _storeItem;
  bool _isLoadingItem = false;
  bool get isLoadingItem => _isLoadingItem;

  Future<void> getById(int id) async {
    _isLoadingItem = true;
    Response response = await storeRepo.getById(id);
    if (response.statusCode == 200) {
      var data = response.body;
      _storeItem = StoresItem.fromJson(data["data"]);
    } else {
    }
    _isLoadingItem = false;
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
  bool loadingCommonStore = false;

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
