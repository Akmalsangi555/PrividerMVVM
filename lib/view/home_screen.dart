
import 'logout_dialog.dart';
import 'home_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/res/colors.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/data/response/status.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider_mvvm/view_model/home_view_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home Page', style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog(); // Show the dialog
                  },
                );

                // userPreferences.removeUser().then((value) {
                //   Navigator.pushNamed(context, RoutesName.loginPage);
                // });
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
                          final movieData = value.moviesList.data!.movies![index];
                          // print('moviesTitle ${movieData.title}');
                          return Card(
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ItemDetailsPage(
                                        movieName: movieData.title,
                                        movieYear: movieData.year,
                                        movieImage: movieData.posterUrl,
                                        storyLine: movieData.storyline,
                                        movieRating: Utils.averageRating(movieData.ratings!).toStringAsFixed(1)
                                    )));
                              },
                              leading: Image.network(movieData.posterUrl.toString(),
                                  height: 50, width: 50, fit: BoxFit.fill,
                                  errorBuilder: (context, error, stack){
                                return Icon(Icons.error_outline, color: Colors.red);
                              }),
                              title: Text("${movieData.title}"),
                              subtitle: Text("${movieData.year}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Utils.averageRating(movieData.ratings!).toStringAsFixed(1)),
                                  SizedBox(width: 05),
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
                                          half: Icon(Icons.star_half, color: Colors.amber),
                                          empty: Icon(Icons.star_outline, color: Colors.amber),
                                      ),
                                      onRatingUpdate: (value) {}
                                  ),
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

}
