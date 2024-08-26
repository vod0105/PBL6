import 'package:android_project/data/repository/Auth_repo.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/models/Model/ResponeModel.dart';
import 'package:get/get.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });
  bool _isLoading= false;
  bool get isLoading =>_isLoading;
  Future<Responemodel> login(Userdto dto) async{
      _isLoading = true;
      Response response = await authRepo.login(dto);
      late Responemodel responeModel;
      if(response.statusCode == 200){
        var data = response.body["data"];
        authRepo.saveUserToken(data["token"]);
        responeModel = Responemodel(true,"OKE");
        
      }else{
        responeModel = Responemodel(false,response.statusText!);

      }
      _isLoading = false;
      update();
      return responeModel;
  }
   Future<Responemodel> register(Userregisterdto dto) async{
      _isLoading = true;
      Response response = await authRepo.register(dto);
      late Responemodel responeModel;
      if(response.statusCode == 200){
        responeModel = Responemodel(true,"OKE");
        
      }else{
        responeModel = Responemodel(false,response.statusText!);

      }
      _isLoading = false;
      update();
      return responeModel;
  }
}