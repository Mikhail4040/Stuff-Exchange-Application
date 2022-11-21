import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';

import "backend/myProvider.dart";
import 'userInterface.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var conEmail = TextEditingController();
  var conPassword = TextEditingController();
  var conConfirmPassword = TextEditingController();
  var conFirstName = TextEditingController();
  var conLastName = TextEditingController();
  var conPhoneNumber = TextEditingController();
  var cityName=null;
  int i = 0;
  bool confirmPassCorrect = true;
  bool isShow = false;
  bool isShow2 = false;
  double opacity = 0.0;

  List<String> cityNameList = [
    "Aleppo",
    "Damascus",
    "Daraa",
    "Deir ez-Zor",
    "Hama",
    "Al-Hasakah",
    "Homs",
    "Idlib",
    "Latakia",
    "Quneitra",
    "Al_Raqqah",
    "As_Suwayda",
    "Tartus"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = opacity == 0.0 ? 1.0 : 0.0;
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: size.height,
        color: Colors.red.shade100,
        width: double.infinity,
        // Here i can use size.width but use double.infinity because both work as a same
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Container(
                width: size.width,
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stepper(
                          steps: [
                            Step(
                              title: Text("Step 1"),
                              content: TextField(
                                controller: conEmail,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Inter Your Email Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            Step(
                              title: Text("Step 2"),
                              content: TextField(
                                controller: conPassword,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "Inter Your Password Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.red.shade200),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.password),
                                  suffixIcon: IconButton(
                                      icon: Icon(isShow
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isShow = !isShow;
                                        });
                                      }),
                                ),
                                obscureText: isShow,
                              ),
                            ),
                            Step(
                              title: Text("Step 3"),
                              content: TextField(
                                controller: conConfirmPassword,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  hintText: "Inter Your Password Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.red.shade200),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.password),
                                  suffixIcon: IconButton(
                                      icon: Icon(isShow2
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isShow2 = !isShow2;
                                        });
                                      }),
                                ),
                                obscureText: isShow2,
                              ),
                            ),
                            Step(
                              title: Text("Step 4"),
                              content: TextField(
                                controller: conFirstName,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                  hintText: "Inter Your First Name Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Step(
                              title: Text("Step 5"),
                              content: TextField(
                                controller: conLastName,
                                decoration: InputDecoration(
                                  labelText: "last Name",
                                  hintText: "Inter Your Last Name Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Step(
                              title: Text("Step 6"),
                              content: TextField(
                                controller: conPhoneNumber,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  hintText: "Inter Your Phone Number Please",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  icon: Icon(Icons.phone),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Step(
                              title: Text("Step 7"),
                              content: Row(
                                children: [
                                  Icon(Icons.home),
                                  DropdownButton(
                                    hint: Text("Choose Your City Please"),
                                    value: cityName,
                                    onChanged: (val) {
                                      setState(() {
                                        cityName = val;
                                      });
                                    },
                                    items: cityNameList.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          currentStep: i,
                          onStepContinue: () {
                            setState(() {
                              if (i < 6) {
                                i++;
                              }
                            });
                          },
                          onStepCancel: () {
                            setState(() {
                              if (i > 0) i--;
                            });
                          },
                          onStepTapped: (val) {
                            setState(() {
                              i = val;
                            });
                          }),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        width: size.width * 0.6,
                        child: FlatButton(
                          child: Text("Confirm"),
                          onPressed: () {
                            if (conEmail.text != "" &&
                                conPassword.text != "" &&
                                conConfirmPassword.text != "" &&
                                conFirstName.text != "" &&
                                conLastName.text != "" &&
                                cityName != null &&
                                conPhoneNumber.text != "") {
                              if (conPassword.text == conConfirmPassword.text) {
                                Provider.of<MyProvider>(context, listen: false)
                                    .signUp(conEmail.text, conPassword.text)
                                    .then((value) {
                                  if (conPassword.text ==
                                      conConfirmPassword.text) {
                                    if (conEmail.text != "" &&
                                        conPassword.text != "" &&
                                        conConfirmPassword.text != "" &&
                                        conFirstName.text != "" &&
                                        conLastName.text != "" &&
                                        cityName != "" &&
                                        conPhoneNumber.text != "") {
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .addData(
                                        conEmail.text,
                                        conPassword.text,
                                        conFirstName.text,
                                        conLastName.text,
                                        conPhoneNumber.text,
                                        cityName,
                                        "false",
                                        "null",
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("New account created successfully") ,
                                        behavior: SnackBarBehavior.floating,
                                        // backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ));
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .fetchData();
                                      Navigator.of(context).pop();
                                    } else {
                                      Toast.show(
                                        "All fields must be filled out",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.CENTER,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.black,
                                      );
                                    }
                                  } else {
                                    Toast.show(
                                      "Password does not match",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.black,
                                    );
                                  }
                                }).catchError((res) => Toast.show(
                                          "${res}",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.redAccent,
                                          textColor: Colors.black,
                                        ));
                              }
                              else{
                                Toast.show(
                                  "Password does not match",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.black,
                                );
                              }
                            } else {
                              Toast.show(
                                "All fields must be filled out",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.black,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
