import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import "/backend/myProvider.dart";

import 'package:toast/toast.dart';

class ModifyUserInfo extends StatefulWidget {
  var userId;
  var userInd;
  ModifyUserInfo({required this.userId, required this.userInd});

  @override
  State<ModifyUserInfo> createState() => _ModifyUserInfoState();
}

class _ModifyUserInfoState extends State<ModifyUserInfo> {
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
  var cityName;
  var conFirstName=TextEditingController();
  var conLastName=TextEditingController();
  var conPhoneNumber=TextEditingController();
  bool ok=false;
  bool wait=false;

  @override
  Widget build(BuildContext context) {
    var userInfo=Provider.of<MyProvider>(context);
  //userInfo.fetchData();
  var userImg=userInfo.Data[widget.userInd].userImage;
  var userFirstName=userInfo.Data[widget.userInd].firstName;
  var userLastName=userInfo.Data[widget.userInd].lastName;
  var userPhoneNumber=userInfo.Data[widget.userInd].phoneNumber;
  var userCity=userInfo.Data[widget.userInd].city;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information Edait "),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: ()async{
                print("1");
                setState(() {
                  ok=true;
                  wait=true;
                });
                if(conFirstName.text!="") {
                 // print("First");
                  await userInfo.updateUserFirstName(
                      widget.userId, conFirstName.text).then((value){
                    setState(() {
                      print("1");
                      wait=false;
                    });
                  });
                }
                if(conLastName.text!="") {
               //   print("Last");
                  await userInfo.updateUserLastName(
                      widget.userId, conLastName.text).then((value){
                    setState(() {
                      wait=false;
                    });
                  });
                }
                if(conPhoneNumber.text!="") {
                //  print("phone");
                  await userInfo.updateUserPhoneNumber(
                      widget.userId, conPhoneNumber.text).then((value){
                    setState(() {
                      wait=false;
                    });
                  });
                }
                if(cityName!="" && cityName!=null) {
              //    print("The City Name is:$cityName");
                  await userInfo.updateUserCity(widget.userId, cityName.toString()).then((value){
                    setState(() {
                      wait=false;
                    });
                  });
                }
                Toast.show(
                  "Updated successfully",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: Colors.green,
                  textColor: Colors.black,
                );
                setState(() async{
                  ok=false;
                });
                print("2");
              },
              icon: Icon(Icons.save_sharp,color: Colors.green,)),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade600,
        padding: EdgeInsets.only(top: 70),
        child:SafeArea(
          child: Center(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter the new first name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: userFirstName,
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                        controller: conFirstName,
                    ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter the new last name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: userLastName,
                            hintStyle: TextStyle(color: Colors.white)
                        ),
                        controller: conLastName,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter the new phone number",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: userPhoneNumber,
                            hintStyle: TextStyle(color: Colors.white),
                        ),
                        keyboardType:TextInputType.number ,
                        controller: conPhoneNumber,
                      ),
                    ],
                  ),
                ),

                DropdownButton(
                  hint: Text("Choose Your City",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
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
                (ok==true)?
                    CircularProgressIndicator(color: Colors.red,):
                    Container(),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}
