
import 'package:flutter/cupertino.dart';
import 'package:provider_mvvm/data/response/api_response.dart';
import 'package:provider_mvvm/repository/home_repository.dart';
import 'package:provider_mvvm/data/models/movies_list_model.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesListModel> moviesListResponse){
    moviesList = moviesListResponse;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi(BuildContext context) async {

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }

}
