import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:get/get.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  var IsLogin = false.obs;
  AuthController({
    required this.authRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  Future<bool> login(Userdto dto) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(dto);

    if (response.statusCode == 200) {
      var data = response.body["data"];
      String newToken = data["token"];
      authRepo.saveUserToken(newToken);
      Get.find<ApiClient>().updateHeader(newToken);
      IsLogin.value = true;
      update();
      return true;

    } else {
      IsLogin.value = false;
      update();
      return false;
      
    }

}

   Future<bool> register(Userregisterdto dto) async{
      Response response = await authRepo.register(dto);
      if(response.statusCode == 200){
        return true;
        
      }else{
       return false;

      }
  }
}