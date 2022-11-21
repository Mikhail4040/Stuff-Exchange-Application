import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'signUpPage.dart';
import 'logIn.dart';
import "backend/myProvider.dart";


class WhoIamIPage extends StatefulWidget {

  @override
  _WhoIamIPageState createState() => _WhoIamIPageState();
}

class _WhoIamIPageState extends State<WhoIamIPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    setState(() {
      controller =
      AnimationController(vsync: this, duration: Duration(seconds: 5))
        ..repeat();
      animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<MyProvider>(context).fetchData();
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.2,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                    child: Text("WELCOME TO WithOutMoney",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),
                  ),
                    opacity:animation ,
                  ),
                  SizedBox(height: size.height * 0.05),
                  SvgPicture.asset(
                    "assets/images/chat.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple.shade500,
                    ),
                    width: size.width * 0.6,
                    child: FlatButton(
                      child: Text("LOGIN"),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){return LogInPage();}));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple.shade50),
                    width: size.width * 0.6,
                    child: FlatButton(
                      child: Text("SIGN UP"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_){return SignUpPage();}));
                      },
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
