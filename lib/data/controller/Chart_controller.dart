import 'package:android_project/data/repository/Chart_repo.dart';
import 'package:android_project/models/Model/ChartModel.dart';
import 'package:android_project/models/Model/MessageModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/models/Model/UserChatModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartController extends GetxController implements GetxService {
  final ChartRepo chartRepo;
  var isLogin = false.obs;
  ChartController({
    required this.chartRepo,
  });

  bool isLoading = false;

  bool isLoadingMessage = false;

  List<UserChart> listUser = [];

  List<User> listUserSearch = [];

  List<UserMessage> listUserMessage = [];
  String chartName = "Chart time";

  int idReceiver = 0;

  bool isShow = true;

  Future<void> getAll() async {
    isLoading = true;
    Response response = await chartRepo.getChart();
    if (response.statusCode == 200) {
      var data = response.body;
      listUser = [];
      listUser = ChartModel.fromJson(data).listUser ?? [];
    } else {}
    isLoading = false;
    update();
  }

  UserChart? getReceiver(int idReceiver) {
    for (UserChart item in listUser) {
      if (item.id == idReceiver) {
        return item;
      }
    }
    return null;
  }

  bool isLoadingSearch = true;
  Future<void> searchUser(String username) async {
    listUserSearch = [];
    isLoadingSearch = true;
    Response response = await chartRepo.searchUser(username);
    if (response.statusCode == 200) {
      var data = response.body;
      listUserSearch.addAll(UserChatModel.fromJson(data).listUser ?? []);
    } else {}
    isLoadingSearch = false;
    update();
  }

  Future<void> getListMessage(int idReceiver) async {
    isLoadingMessage = true;
    Response response = await chartRepo.getListChart(idReceiver);
    if (response.statusCode == 200) {
      var data = response.body;
      listUserMessage = [];
      listUserMessage.addAll(MessageModel.fromJson(data).listMessage ?? []);
      idReceiver = idReceiver;
    }
    isLoadingMessage = false;
    update();
  }

  Future<void> senImage(int idSender, int idReceiver, String image) async {
    Response response = await chartRepo.sendImage(idSender, idReceiver, image);
    if (response.statusCode == 200) {
    } else {}
  }

  void changeShow() {
    isShow = !isShow;
    update();
  }

  void updateChartName(String newValue) {
    chartName = newValue;
    update();
  }

  Future<String?> autoResponse(String question, int storeId) async {
    Response response = await chartRepo.autoResponse(question, storeId);
    if (response.statusCode == 200) {
      var data = response.body;

      return data as String;
    } else {
      Get.snackbar(
        "Bảo trì",
        "Chức năng này đang bảo trì. Vui lòng thử lại sau",
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
    return null;
  }
}
