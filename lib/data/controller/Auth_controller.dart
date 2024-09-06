import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/ResponeModel.dart';
import 'package:get/get.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  var IsLogin = false.obs;
  AuthController({
    required this.authRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;

  Future<Responemodel> login(Userdto dto) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(dto);
    late Responemodel responseModel;

    if (response.statusCode == 200) {
      var data = response.body["data"];
      String newToken = data["token"];
      authRepo.saveUserToken(newToken);
      Get.find<ApiClient>().updateHeader(newToken);

      responseModel = Responemodel(true, "OKE");
      IsLogin.value = true;
    } else {
      responseModel = Responemodel(false, response.statusText!);
      IsLogin.value = false;
    }

    _isLoading = false;
    update();

    return responseModel;
}

   Future<Responemodel> register(Userregisterdto dto) async{
      _isLoading = false;
      Response response = await authRepo.register(dto);
      late Responemodel responeModel;
      if(response.statusCode == 200){
        responeModel = Responemodel(true,"OKE");
        
      }else{
        responeModel = Responemodel(false,response.statusText!);

      }
      print(response.body);
      _isLoading = true;
      update();
      return responeModel;
  }
}