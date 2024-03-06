
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return AlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure you want to Logout?', style: TextStyle(fontSize: 16),),
      actions: <Widget>[
        ElevatedButton(
          child: Text('No', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: (Size(100, 35)),
          ),
          onPressed: (){
          Navigator.of(context).pop(false);
        },
        ),
        ElevatedButton(
          child: Text('Yes', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: (Size(100, 35)),
          ),
          onPressed: (){
            userPreferences.removeUser().then((value) {
              Navigator.pushNamed(context, RoutesName.loginPage);
            });
          },
        ),
      ],
    );
  }
}
