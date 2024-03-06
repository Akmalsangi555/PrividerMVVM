
import 'package:flutter/foundation.dart';
import 'package:provider_mvvm/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(UserModel userModel) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', userModel.token.toString());
    print('userToken ${userModel.token.toString()}');
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? userToken = sharedPreferences.getString('token');
    return UserModel(
      token: userToken.toString()
    );
  }

  Future<bool> removeUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    notifyListeners();
    return true;
  }

}
