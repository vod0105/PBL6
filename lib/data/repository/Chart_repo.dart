import 'package:android_project/data/api/ApiClient.dart';
import 'package:android_project/data/api/ApiClientAI.dart';
import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/models/Dto/ChartDto.dart';
import 'package:android_project/models/Dto/ChatAutoDto.dart';
import 'package:get/get.dart';

class ChartRepo {
  final ApiClient apiClient;
  final ApiClientAi apiClientAi;
  ChartRepo({
    required this.apiClient,
    required this.apiClientAi,
  });
  Future<Response> getChart() async {
    return await apiClient.getData(Appconstant.CHART_URL);
  }
  Future<Response> getListChart(int idReceiver) async {
    return await apiClient.getData(Appconstant.GETLISTCHART_URL.replaceFirst("{receiverid}", idReceiver.toString()));
  }
   Future<Response> sendImage(int idSender,int idReceiver,String image) async {
    ChartDto chartDto = ChartDto(sender: idSender, receiver: idReceiver, message: "", imageBase64: image, isRead: true);
    return await apiClient.postData(Appconstant.SAVE_CHART_IMAGE,chartDto.toJson());
  }
    Future<Response> searchUser(String username) async {
    
    return await apiClient.getData(Appconstant.CHART_SEARCH_URL.replaceFirst("{keyname}", username));
  }
  Future<Response> autoResponse(String question, int storeId) async {
    Chatautodto chatDto = Chatautodto(storeId: storeId, question: question);
    return await apiClientAi.postData(Appconstant.AUTO_RESPONSE_URL,chatDto.toJson());
  }
}
