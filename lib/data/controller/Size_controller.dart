import 'package:android_project/data/repository/Size_repo.dart';
import 'package:android_project/models/Model/SizeModel.dart';
import 'package:get/get.dart';

class SizeController extends GetxController {
  final SizeRepo sizeRepo;
  SizeController({
    required this.sizeRepo,
  });
  bool isLoading = false;

  List<Size> sizeList = [];

  Future<void> getAll() async {
    isLoading = true;
    Response response = await sizeRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      sizeList = [];
      sizeList.addAll(SizeModel.fromJson(data).listSize ?? []);
    } else {}
    isLoading = false;
    update();
  }

  int? getByName(String name) {
    for (Size item in sizeList) {
      if (item.name == name) {
        return item.id!;
      }
    }
    return null;
  }

  String sizeName = "";
  Future<void> getById(int id) async {
    isLoading = true;
    Response response = await sizeRepo.getById(id);
    if (response.statusCode == 200) {
      var data = response.body["data"];
      sizeName = data["name"];
    } else {}
    isLoading = false;
    update();
  }
}
