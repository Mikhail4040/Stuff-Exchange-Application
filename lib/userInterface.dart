import 'dart:async';

import 'package:finalproject/backend/dataUserClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'userPage.dart';
import "backend/myProvider.dart";
class UserInterface extends StatefulWidget {
   var id;
   var ind;
   UserInterface({required this.id,required this.ind});
  @override
  _UserInterfaceState createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> with SingleTickerProviderStateMixin{


  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Hi Reflectly',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );

  void onTapDown(TapDownDetails details) {
    controller.forward();
  }

  void onTapUp(TapUpDetails details) {
    controller.reverse();
  }





  final int delayedAmount = 500;
  late double scale;
  late AnimationController controller;
  @override
  void initState() {

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    scale = 1 - controller.value;
    UserData userInfo=Provider.of<MyProvider>(context).Data[widget.ind];
    var provider = Provider.of<MyProvider>(context);
    provider.fetchData();
    var numofUsers=provider.Data.length;

    return Scaffold(
        backgroundColor: Color(0xFF8185E2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Container(
                          child: Image.asset("assets/images/appLogo.png"),
                      ),
                      radius: 50.0,
                    )),
              ),
              DelayedAnimation(
                child: Text(
                  "Hi ${userInfo.firstName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I'm ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    Text(
                      "WithOutMoney",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: Colors.red.withOpacity(0.7)),
                    ),
                  ],
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  "you are one",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "of $numofUsers people",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "who joined us recently",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 70.0,
              ),
              DelayedAnimation(
                child: Container(
                  width: 200,
                  child: ElevatedButton(
                    style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),

                    ) ,
                    child: Text("let's start".toUpperCase(),style: TextStyle(color: Color(0xFF8185E2)),),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return UserPage(id: widget.id,ind: widget.ind,);
                      }));
                    },
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        )



    );
  }
}


class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  DelayedAnimation({required this.child, required this.delay});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animOffset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: controller);
    animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          controller.forward();
        }
      });
    }




  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: animOffset,
        child: widget.child,
      ),
      opacity: controller,
    );
  }
}

