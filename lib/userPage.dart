import 'dart:io';

import 'package:finalproject/backend/dataUserClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "backend/myProvider.dart";
import 'brain.dart';
import 'drawer/myDrawer.dart';
import 'servicesAndGoods/services.dart';
import 'servicesAndGoods/goods.dart';
import 'add/addGodds.dart';
import 'add/addServices.dart';

class UserPage extends StatefulWidget {
  var id;
  var ind;

  UserPage({required this.id, required this.ind});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int index = 0;

  void currentIndex(int i) {
    setState(() {
      index = i;
    });
  }

  String s = "";
  int radiovALUE = 0;



  Future wait()async{
    var userInfo = Provider.of<MyProvider>(context);
  await  userInfo.fetchFavorite();
  await  userInfo.fetchData();
  await  userInfo.fetchServices();
  await  userInfo.fetchGoods();
  }
  bool waiting=true;


  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<MyProvider>(context);
    wait().then((value){
      setState(() {
        waiting=false;
      });
    });
    return
      waiting==true?
          Scaffold(
            body:
            SafeArea(
              child: Container(
               width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please wait seconds",),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          )

          :
      DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: userInfo.Data[widget.ind].isDarkMode=="true"?ThemeData.dark():ThemeData.light(),

        home: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        height: 180,
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Text("You can post your own product here",style: TextStyle(color:Colors.orange)),
                              title: Text("Add Product",style: TextStyle(color:Colors.teal),),
                              leading: Icon(Icons.add),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return AddGoods(id: widget.id,ind: widget.ind,);
                                }));
                              },
                            ),
                            ListTile(
                              subtitle: Text("You can post your own service here",style: TextStyle(color:Colors.black)),
                              title: Text("ِِAdd service",style: TextStyle(color:Colors.indigo),),
                              leading: Icon(Icons.add),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return AddServices(id: widget.id,ind: widget.ind,);
                                }));
                              },
                            ),
                          ],
                        ),
                      );
                    });
              });
            },
            child: Text("plus"),
          ),
          drawer: MyDrawer(id: widget.id, ind: widget.ind),
          appBar: AppBar(
            title: index==0?Text("I Need A"):Text("I Need A"),
            backgroundColor: index == 0 ? Colors.indigo : Colors.teal,
            actions: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_){
                      return Brain(userId: widget.id,userInd: widget.ind,);
                    })
                  );
                },
                child:Image.asset("assets/images/brain2.png"),

              ),
            ],
          ),
          body: index == 0
              ? ServicesPage(id: widget.id, ind: widget.ind)
              : GoodsPage(id: widget.id, ind: widget.ind),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 6.0,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: kBottomNavigationBarHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.black54,
                  type: BottomNavigationBarType.shifting,
                  currentIndex: index,
                  onTap: currentIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.computer),
                        label: "Services",
                        backgroundColor: Colors.indigo),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sell),
                        label: "Goods",
                        backgroundColor: Colors.teal),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
