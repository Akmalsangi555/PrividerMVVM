
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/data/response/status.dart';
import 'package:provider_mvvm/res/colors.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/view_model/home_view_model.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchMoviesListApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    // Provider.of<HomeViewModel>(context, listen: false).userListApi(context);
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home Page', style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //     onTap: (){
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.colorWhite)),
        actions: [
          GestureDetector(
              onTap: (){
                userPreferences.removeUser().then((value) {
                  Navigator.pushNamed(context, RoutesName.loginPage);
                });
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Icon(
                      Icons.logout_outlined, color: AppColors.colorWhite,
                    ),
                ),
              )),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _){
              switch(value.moviesList.status){
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(child: Text(value.moviesList.message.toString()));
                    default:
                    return ListView.builder(
                        itemCount: value.moviesList.data!.movies!.length,
                        itemBuilder: (context, index){
                          var movieData = value.moviesList.data!.movies![index];
                          // print('moviesTitle ${movieData.title}');
                          return Card(
                            child: ListTile(
                              leading: Image.network(movieData.posterUrl.toString(),
                              height: 40, width: 40, fit: BoxFit.cover,
                              errorBuilder: (context, error, stack){
                                return Icon(Icons.error_outline, color: Colors.red);
                              }),
                              title: Text("${movieData.title}"),
                              subtitle: Text("${movieData.year}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Utils.averageRating(movieData.ratings!).toStringAsFixed(1)),

                                  RatingBar(
                                      initialRating: double.parse(Utils.averageRating(movieData.ratings!).toStringAsFixed(1)),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 1,
                                      minRating: 0,
                                      maxRating: 10,
                                      itemSize: 18.0,
                                      ignoreGestures: true,
                                      ratingWidget: RatingWidget(
                                          full: Icon(Icons.star, color: Colors.amber),
                                          half: Icon(
                                            Icons.star_half,
                                            color: Colors.amber,
                                          ),
                                          empty: Icon(
                                            Icons.star_outline,
                                            color: Colors.amber,
                                          )),
                                      onRatingUpdate: (value) {

                                      }),
                                  // showRatingStars(Utils.averageRating(movieData.ratings!).toStringAsFixed(1))
                              ]
                              ),
                            ),
                          );
                    });
              }
            },
          ),

      ),
    );
  }
  Widget showRatingStars(ratingValue){
    return RatingBar(
        initialRating: ratingValue,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        minRating: 0,
        itemSize: 18.0,
        ignoreGestures: true,
        ratingWidget: RatingWidget(
            full: Icon(Icons.star, color: Colors.amber),
            half: Icon(
              Icons.star_half,
              color: Colors.amber,
            ),
            empty: Icon(
              Icons.star_outline,
              color: Colors.amber,
            )),

        onRatingUpdate: (value) {
          // setState(() {
          // photoPreviousObject.data![index].carsDetails!.rating = "$value";
          // print("ratingValue ${photoPreviousObject.data![index].carsDetails!.rating}");
          // });
        });
  }
}
