
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemDetailsPage extends StatelessWidget {
  final String? movieName, movieYear, movieImage, storyLine;
  final String? movieRating;

  ItemDetailsPage({ this.storyLine, this.movieName,
    this.movieYear, this.movieImage, this.movieRating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Item Details', style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,)),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("$movieImage",
                height: 300, width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stack){
                  return Center(child: Icon(Icons.error_outline, color: Colors.red, size: 200));
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Name: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Text('${movieName}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Year: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${movieYear}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Ratings: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("$movieRating"),
                      SizedBox(width: 05),
                      RatingBar(
                          initialRating: double.parse("$movieRating"),
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
                    ],
                  ),
                  Text('Description: ', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('${storyLine}',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
