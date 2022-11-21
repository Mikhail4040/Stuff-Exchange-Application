import 'package:finalproject/signUpPage.dart';
import 'package:finalproject/userPage.dart';
import 'package:finalproject/whoIamI.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend/myProvider.dart';
import 'Splash_Screen.dart';
import 'userInterface.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(
      ChangeNotifierProvider<MyProvider>(
        create: (_) => MyProvider(),
        child:MyApp(),
      ),
    );




}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: SplashScreenPage()

    );
  }
}


