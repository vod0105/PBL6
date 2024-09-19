import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/Chart_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:get/get.dart';

class ChartController extends GetxController implements GetxService {
  final ChartRepo chartRepo;
  var IsLogin = false.obs;
  ChartController({
    required this.chartRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isShow = true;
  bool get isShow => _isShow;

  void ChangeShow() {
    _isShow = !_isShow;
    update();
  }
}
