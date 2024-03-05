
import 'package:provider_mvvm/res/app_url.dart';
import 'package:provider_mvvm/data/network/BaseApiServices.dart';
import 'package:provider_mvvm/data/network/NetworkApiServices.dart';

class AuthRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginApiUrl, data);
      print("response $response");
      return response;
    } catch (e){
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiUrl, data);
      print("response $response");
      return response;
    } catch (e){
      throw e;
    }
  }

}