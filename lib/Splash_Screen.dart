import 'package:finalproject/userPage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'whoIamI.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:provider/provider.dart';
import "backend/myProvider.dart";
class SplashScreenPage extends StatefulWidget {

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var userId;
  var pos;
  void shared()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      userId=pref.getString("id");
      pos=pref.getInt("ind");
    });

  }

  @override
  void initState() {
    shared();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
            loaderColor: Colors.red.shade100,
            image: Image.asset("assets/images/appLogo.png"),
            navigateAfterSeconds:
                userId!=null?UserPage(id: userId, ind: pos):
            WhoIamIPage(),
            seconds: 3,
            photoSize: 150,
          ),
          Positioned(
            child: Text(
              '''WithOutMoney''',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade200,
                  fontFamily: "Lobster-Regular",
                  fontSize: 25),
            ),
            left: 120,
            top: 190,
          ),
          Positioned(
            child: Text(
              '''    Developed By 
  Doha & Mikhail''',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lobster-Regular",
                  fontSize: 25),
            ),
            left: 110,
            top: 750,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.red.shade100,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.red.shade100,
                height: 100,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

