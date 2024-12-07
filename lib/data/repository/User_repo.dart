import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/models/Dto/AnnoUceDto.dart';
import 'package:android_project/models/Dto/RegisterShipperDto.dart';
import 'package:android_project/models/Dto/UserUpdateDto.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../api/AppConstant.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserProfile() async {
    return await apiClient.getData(Appconstant.USER_PROFILE_URL);
  }

  Future<Response> updateProfile(UserUpdateDto updateDto) async {
    return await apiClient.putData(Appconstant.USER_UPDATE_PROFILE_URL, updateDto.toJson());
  }

  Future<Response> registerShipper(RegisterShipperDto dto) async {
    return await apiClient.postData(Appconstant.REGISTER_SHIPPER_URL, dto.toJson());
  }
  Future<Response> getAnnounce() async{
    return await apiClient.getData(Appconstant.ANNOUNCE_URL);
  }
  Future<Response> addAnnoUce(AnnoUceDto dto) async{
    return await apiClient.postData(Appconstant.ANNOUNCE_ADD_URL,dto.toJson());
  }
   Future<Response> getById(int id) async{
    return await apiClient.getData(Appconstant.USER_GET_ID_URL.replaceFirst("{id}", id.toString()));
  }


  
}
