
import 'package:provider_mvvm/res/app_url.dart';
import 'package:provider_mvvm/data/network/BaseApiServices.dart';
import 'package:provider_mvvm/data/models/movies_list_model.dart';
import 'package:provider_mvvm/data/network/NetworkApiServices.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviesListModel> fetchMoviesList() async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListApiUrl);
      print("getApiResponse $response");
      return response = MoviesListModel.fromJson(response);
    } catch (e){
      throw e;
    }
  }

}
