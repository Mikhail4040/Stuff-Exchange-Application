import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "backend/myProvider.dart";
import 'userInterface.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var conEmail = TextEditingController();
  var conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var ProviderPage = Provider.of<MyProvider>(context);
    ProviderPage.fetchData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        backgroundColor: Colors.indigo,


      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/images/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red.shade50,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Your Email",
                            icon: Icon(Icons.email)
                          ),
                          controller: conEmail,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Your Password",
                            icon: Icon(Icons.security)
                          ),
                          obscureText: true,
                          controller: conPassword,
                        ),



                        FlatButton(
                          child: Text("LOGIN"),
                          onPressed: () {
                            ProviderPage.logIn(conEmail.text, conPassword.text)
                                .then((value) async{
                              print("Hellooo");
                              int ind = ProviderPage.Data.indexWhere(
                                  (element) => element.email == conEmail.text);
                              print(ind);
                              if (ind >= 0 &&
                                  ProviderPage.Data[ind].password == conPassword.text){
                                SharedPreferences pref=await SharedPreferences.getInstance();
                                setState(() {
                                  pref.setString("id", ProviderPage.Data[ind].id);
                                  pref.setInt("ind",ind);

                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) {
                                  return UserInterface(
                                    id: ProviderPage.Data[ind].id,
                                    ind: ind,
                                  );
                                }));}
                            }).catchError((error) {
                              Toast.show(
                                "${error}",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.black,
                              );
                            });
                          },
                        ),



                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
