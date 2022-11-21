import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final _overviewTitle = "Overview".toUpperCase();
  String text1=
"Providing communication between individuals wishing to meet their life needs without paying money andThe application allows people who join the application to view what they have of the things they want to barter with, and to order what they lackThings they want to barter on and Our app allows barter not only for goods, but also for services";
String text2=
    "The application allows the user to join the application and create his own account, by entering the name, phone number, and cityWithin Syria (this application targets the Syrian community only in its current version), and the email addressown, and a strong password and The application allows the user who has created an account to manage this account, including adding an imagePersonal, set in general, add favourites (things the user wants to refer back to later fromNot doing a lengthy search.";

String text3="The user can add the goods and services he owns and would like to display in our application to barter on them where his task isJust fill in the fields that we show it, and once it is finished, we will display it within the categories of goods and services on the interfaceAttractive.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/aboutus.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                height: 300.0,
              ),
              constraints: BoxConstraints.expand(height: 300.0),
            ),
            Container(
              margin: new EdgeInsets.only(top: 190.0),
              height: 110.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    new Color(0x00736AB7),
                    new Color(0xFF736AB7)
                  ],
                  stops: [0.0, 0.9],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                ),
              ),
            ),

            Container(
              height: double.infinity,
              width: double.infinity,
              padding: new EdgeInsets.only(top: 280, left:0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(_overviewTitle,style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text("1",style: TextStyle(color: Colors.white,fontSize: 20),),
                          Card(
                            color: Colors.teal,
                            elevation: 15,
                            child:  Text(text1,style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text("2",style: TextStyle(color: Colors.white,fontSize: 20),),
                          Card(
                            color: Colors.teal,
                            elevation: 10,
                            child: SingleChildScrollView(
                              child: Text(text2,style: TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text("3",style: TextStyle(color: Colors.white,fontSize: 20),),
                          Card(
                            color: Colors.teal,
                            elevation: 5,
                            child: SingleChildScrollView(
                              child: Text(text3,style: TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
