
import 'package:flutter/material.dart';
import 'package:provider_mvvm/res/colors.dart';

class RoundButton extends StatelessWidget {
  final String titleText;
  final bool loading;
  final double buttonHeight, buttonWidth;
  final VoidCallback onPressed;

  RoundButton(
      {Key? key,
        required this.titleText,
        this.loading = false,
        this.buttonHeight = 40.0,
        this.buttonWidth = 100.0,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
            color: AppColors.colorDeepPurple,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(color: AppColors.colorWhite,)
              : Text(
                  titleText,
                  style: TextStyle(color: AppColors.colorWhite),
                ),
        ),
      ),
    );
  }
}
