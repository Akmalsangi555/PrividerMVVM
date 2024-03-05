
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/home_view_model.dart';
import 'view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> AuthViewModel()),
          ChangeNotifierProvider(create: (_)=> UserViewModel()),
          // ChangeNotifierProvider(create: (_)=> HomeViewModel()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider MVVM',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splashPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
