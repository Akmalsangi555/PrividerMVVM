
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/res/colors.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/view_model/auth_view_model.dart';
import 'package:provider_mvvm/res/components/round_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

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
          title: Text('SignUp', style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.colorWhite)),
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
                titleText: "SignUp",
                buttonHeight: screenHeight* 0.05,
                buttonWidth: screenWidth* 0.5,
                loading: authViewModel.signUploading,
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
                     Map data = {
                       'email' : _emailController.text.trim().toString(),
                       'password' : _passwordController.text.trim().toString()
                     };
                     authViewModel.signUpApi(data, context);
                    print('signUp api');
                  }
                },
              ),
              SizedBox(height: screenHeight* 0.02),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: ' Login',
                      style: TextStyle( fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorDeepPurple,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, RoutesName.loginPage);
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
