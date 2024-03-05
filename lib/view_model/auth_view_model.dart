
import 'user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/data/models/user_model.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _signUploading = false;
  bool get signUploading => _signUploading;
  setSignUpLoading(bool value){
    _signUploading = value;
    notifyListeners();
  }

  UserViewModel userPreferences = UserViewModel();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
          UserModel(
            token: value ['token'].toString(),
          )
      );
      Utils.flushBarSuccessMessage('Login successfully...!', context);
      Navigator.pushNamed(context, RoutesName.homePage);
      if(kDebugMode){
        print('loginApiResponse ${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print('${error.toString()}');
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarSuccessMessage('SignUp successfully...!', context);
      Navigator.pushNamed(context, RoutesName.homePage);
      if(kDebugMode){
        print('SignUpApiResponse ${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print('${error.toString()}');
      }
    });
  }

}
