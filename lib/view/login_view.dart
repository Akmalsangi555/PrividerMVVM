
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/res/colors.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/view_model/auth_view_model.dart';
import 'package:provider_mvvm/res/components/round_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final ValueNotifier<bool> obSecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    obSecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final screenHeight = MediaQuery.of(context).size.height * 1;
    final screenWidth = MediaQuery.of(context).size.width * 1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login', style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                    labelText: 'Enter Email',
                  prefixIcon: Icon(Icons.email_outlined)
                ),
                onFieldSubmitted: (value){
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              SizedBox(height: screenHeight* 0.02),
              ValueListenableBuilder(
                valueListenable: obSecurePassword,
                builder: (context, toggleValue, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: obSecurePassword.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock_open_outlined),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            obSecurePassword.value = !obSecurePassword.value;
                          },
                          child: Icon(
                              obSecurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.colorDeepPurple)),
                    ),
                  );
                },
              ),

              SizedBox(height: screenHeight* 0.05),

              RoundButton(
                titleText: "Login",
                buttonHeight: screenHeight* 0.05,
                buttonWidth: screenWidth* 0.5,
                loading: authViewModel.loading,
                onPressed: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter email', context);
                  }
                  else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter password', context);
                  }
                  else if(_passwordController.text.length< 6){
                    Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                  }
                  else {
                     // Map data = {
                     //   'email' : _emailController.text.trim().toString(),
                     //   'password' : _passwordController.text.trim().toString()
                     // };

                     Map data = {
                       'email' : 'eve.holt@reqres.in',
                       'password' : 'cityslicka'
                     };
                     authViewModel.loginApi(data, context);
                    print('login api');
                  }
                },
              ),
              SizedBox(height: screenHeight* 0.02),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: ' Register',
                      style: TextStyle( fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorDeepPurple,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, RoutesName.signUpPage);
                        },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
