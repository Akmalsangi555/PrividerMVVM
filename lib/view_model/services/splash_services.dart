
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_mvvm/data/models/user_model.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class SplashServices{

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {

    getUserData().then((value) async {
      print("tokenValue ${value.token.toString()}");
      if(value.token.toString() == 'null' || value.token.toString() == '' ) {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.loginPage);
      }
      else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.homePage);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}