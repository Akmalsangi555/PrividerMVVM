
import 'package:provider_mvvm/view/signup_view.dart';
import 'package:provider_mvvm/view/splash_view.dart';

import 'routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/view/home_screen.dart';
import 'package:provider_mvvm/view/login_view.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RoutesName.splashPage:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      case RoutesName.loginPage:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RoutesName.signUpPage:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpView());
      case RoutesName.homePage:
        return MaterialPageRoute(builder: (BuildContext context) => HomeView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(child: Text('No routes defined.')),
          );
        });
    }
  }
}