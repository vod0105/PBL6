import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/data/repository/User_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/ResponeModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:get/get.dart';


class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;
  
  User? _userprofile;
  User? get userprofile => _userprofile;

  Future<void> getuserprofile() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getuserprofile();
    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      _userprofile = Usermodel.fromJson(data).getuser;
    } else {
      
    }
    _isLoading = false;
    update();
  }

}