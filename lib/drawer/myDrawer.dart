import 'dart:io';

import 'package:finalproject/drawer/ContactUs.dart';
import 'package:finalproject/drawer/myProducts/myProducts.dart';
import 'package:finalproject/drawer/setting/settings.dart';
import 'package:finalproject/drawer/xo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import "/backend/myProvider.dart";
import 'aboutUs.dart';
import 'myAccount.dart';
import 'myFavorite Products.dart';
import 'myFavoriteServices.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MyDrawer extends StatefulWidget {
  var id;
  var ind;
  MyDrawer({required this.id, required this.ind});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late File image;
  bool show = false;
  bool ok=false;
  var url="null";
  ImagePicker imagepicker = ImagePicker();

  Future uploadImage(ImageSource img,var uI) async {
    var pickImage = await imagepicker.pickImage(source: img,maxWidth: 100,maxHeight: 100);
    if (pickImage != null) {
      print("Okkkkkkk");
      setState(() async{
        image = File(pickImage.path);
        show = true;
        if(image!=null){
         await uploadToFireBase(uI);
        }
      });
    }
  }
  uploadToFireBase(var userI)async{
    ok=true;
    setState(() {
    });
    var ref=await FirebaseStorage.instance.ref().child("user+image").child(userI.Data[widget.ind].id+'.jpg');
    await ref.putFile(image);
    var u=await ref.getDownloadURL();
    ok=false;
    setState(() {
    });
    url=u;
  }
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<MyProvider>(context);
   // userInfo.Data.clear();
    userInfo.fetchData();
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 120,
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      IconButton(
                          icon: Icon(Icons.camera),
                          tooltip: "Photo shoot",
                          onPressed: () async{

                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Text("Adding a personal photo for you allows all users to see your photo only when publishing a service Do you agree?"),
                                  content: Container(
                                    height: 90,
                                    child: Column(
                                      children: [
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed:()async{
                                                Navigator.of(ctx).pop();
                                                await uploadImage(ImageSource.camera,userInfo).then((value)async{
                                                  if(url!="null") {
                                                    await userInfo.updateImage(
                                                        widget.id, url.toString());
                                                    var services=userInfo.ProductServices.where((element) => element.userId==widget.id);
                                                    services.forEach((element) async{
                                                      await    userInfo.updateServicesImage(element.id, url.toString());
                                                    });
                                                  }
                                                //  Navigator.of(ctx).pop();
                                                  setState(() {
                                                  });
                                                });

                                              },
                                              child: Text("YES"),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed:(){
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text("NO"),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              barrierColor: Colors.blue.withOpacity(0.2), //جرب بدونا بتعرف ليش
                            );


                           // await uploadImage(ImageSource.camera,userInfo).then((value)async{
                           //    if(url!="null") {
                           //      await userInfo.updateImage(
                           //          widget.id, url.toString());
                           //      var services=userInfo.ProductServices.where((element) => element.userId==widget.id);
                           //      services.forEach((element) async{
                           //    await    userInfo.updateServicesImage(element.id, url.toString());
                           //      });
                           //    }
                           //    setState(() {
                           //    });
                           //  });
                          }
                          ),



                      (userInfo.Data[widget.ind].userImage=="null")
                          ? CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.blue.shade900,
                          child: Icon(Icons.add))
                          : ClipRRect(
                        child: CachedNetworkImage(
                          placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                          imageUrl:userInfo.Data[widget.ind].userImage,
                          errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),
                          width: 70,
                          height: 70,
                        ),

                        // Image.network(userInfo.Data[widget.ind].userImage,
                        //   fit: BoxFit.cover,
                        //   height: 70,
                        //   width: 70,
                        // ),
                        borderRadius: BorderRadius.circular(30),
                      ),


                      IconButton(
                          icon: Icon(Icons.add_photo_alternate_rounded),
                          tooltip: "Choose a picture",
                          onPressed: () {
                            setState(() async {

                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Text("Adding a personal photo for you allows all users to see your photo only when publishing a service Do you agree?"),
                                    content: Container(
                                      height: 90,
                                      child: Column(
                                        children: [
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 7),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed:()async{
                                                  Navigator.of(ctx).pop();
                                                  await uploadImage(ImageSource.gallery,userInfo).then((value) async {
                                                    if(url!="null") {
                                                      await userInfo.updateImage(
                                                          widget.id, url.toString());
                                                      var services=userInfo.ProductServices.where((element) => element.userId==widget.id);
                                                      services.forEach((element) async{
                                                        await userInfo.updateServicesImage(element.id, url.toString());
                                                      });
                                                    }

                                                    setState(() {
                                                    });
                                                  });

                                                },
                                                child: Text("YES"),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.green),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed:(){
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text("NO"),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                barrierColor: Colors.blue.withOpacity(0.2), //جرب بدونا بتعرف ليش
                              );







                             // await uploadImage(ImageSource.gallery,userInfo).then((value) async {
                             //    if(url!="null") {
                             //      await userInfo.updateImage(
                             //          widget.id, url.toString());
                             //      var services=userInfo.ProductServices.where((element) => element.userId==widget.id);
                             //    services.forEach((element) async{
                             //  await userInfo.updateServicesImage(element.id, url.toString());
                             //      });
                             //    }
                             //    setState(() {
                             //    });
                             //  });
                            });
                          }),
                    ],
                  ),

                  Text(
                    " ${userInfo.Data[widget.ind].firstName} ${userInfo.Data[widget.ind].lastName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35,
                        wordSpacing: 10,
                        overflow: TextOverflow.fade),
                  ),
                  Text(
                    " ${userInfo.Data[widget.ind].phoneNumber}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        wordSpacing: 10,
                        overflow: TextOverflow.fade),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("My Account",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.person,color: Colors.blue),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return MyAccount(userId: widget.id,userInd: widget.ind,);
                          })
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Settings",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.build_outlined,color: Colors.blue),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return Settings(userId: widget.id,userInd: widget.ind,);
                          })
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Favorite Products",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.add_shopping_cart_rounded,color: Colors.blue,),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return MYFavoriteProducts(userId: widget.id,userInd: widget.ind,);
                        })
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Favorite Services",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.home_repair_service,color: Colors.blue,),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return MyFavoriteServices(userId: widget.id,userInd: widget.ind,);
                          })
                      );
                    },
                  ),
                  ListTile(
                    title: Text("My Products",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.article_outlined,color: Colors.blue),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return MyProductsPage(userId: widget.id,userInd: widget.ind,);
                          })
                      );
                    },
                  ),

                  Divider(
                    height: 3,
                    thickness: 1,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    title: Text("About Us",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.auto_fix_normal_outlined,color: Colors.green),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return AboutUs();
                          })
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Connect ًWith Us",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.groups_sharp,color: Colors.green),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return ContactUss();
                          })
                      );
                    },
                  ),
                  Divider(
                    height: 3,
                    thickness: 1,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    title: Text("Xo Game",style: TextStyle(fontSize: 18,color: Colors.black54),),
                    leading: Icon(Icons.videogame_asset,color: Colors.amber),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return xo();
                          })
                      );
                    },
                  ),
                  (ok==false)?
                  Container():
                  CircularProgressIndicator(color: Colors.blue),
                ],
              ),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
