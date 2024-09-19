import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/User_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Dto/UserUpdateDto.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _userprofile;
  User? get userprofile => _userprofile;

  Future<void> getuserprofile() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getuserprofile();
    if (response.statusCode == 200) {
      var data = response.body;
      _userprofile = Usermodel.fromJson(data).getuser;
    } else {}
    _isLoading = false;
    update();
  }

  MultipartFile? base64Image;
  void updateAvatar(MultipartFile newimage) {
    base64Image = newimage;
    update();
  }

  Future<void> updateprofile(Userupdatedto updatedto) async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateprofile(updatedto);
    if (response.statusCode == 200) {
      Get.snackbar("Thông báo", "Cập nhật thành công");
    } else {}
    _isLoading = false;
    update();
  }
}
