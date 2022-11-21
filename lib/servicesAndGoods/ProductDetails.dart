import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "/backend/myProvider.dart";
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

import 'package:cached_network_image/cached_network_image.dart';
class ProductDetails extends StatefulWidget {
  var userId;
  var productId;
  var productInd; //موقع العنصر في المصفوفة
  ProductDetails(
      {required this.userId,
      required this.productId,
      required this.productInd});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double like = 0.0;
  var colorButton = Colors.black;
  var icon = Icons.favorite_outline_sharp;
  bool ok = true;
  int favoriteInd = -1;
  bool isWait=false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Dialog(){
    var provider = Provider.of<MyProvider>(context,listen: false);
    int numOfLikes=like.toInt();
    int numOfContacted= (numOfLikes/2).toInt();
    double numOfSold=double.parse((numOfLikes*100/provider.Data.length).toStringAsFixed(1));
    double numOfBuy=100-numOfSold;
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          //title: Text("All values are estimated"),
          content: Container(
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Image.asset("assets/images/focus.jpg",fit: BoxFit.fitWidth),
                Text("All values are estimated",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
                SizedBox(height: 50,),
                // Row(
                //   children: [
                //     Text("_"),
                //     Text("The number of people who like this "),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text("    product is exactly "),
                //     Text("$numOfLikes",style: TextStyle(
                //       color: Colors.red,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20
                //     ),),
                //   ],
                // ),


                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("_"),
                    Text("The number of people who are likely"),
                  ],
                ),
                Row(
                  children: [
                    Text("    to contact the owner of the"),
                  ],
                ),
                Row(
                  children: [
                    Text("    product "),
                    Text("$numOfContacted",style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  ],
                ),



                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("_"),
                    Text("Percentage of the product being"),
                  ],
                ),
                Row(
                  children: [
                    Text("    sold is "),
                    Text("$numOfSold%",style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  ],
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left:0.0),
                    child: Row(
                      children: [
                        Text("Your chances are ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        Text("$numOfBuy%",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Ok"),
                )








              ],
            ),
          ),
        );
      },
      // barrierDismissible: false,
      //هلق اذا منكبس اي كبسة برا dialog ما رح يتسكر
      barrierColor: Colors.blue.withOpacity(0.2), //جرب بدونا بتعرف ليش
    );
  }




  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    String categoryName = provider.ProductGoods[widget.productInd].goodsType;
    String imgLowerCase = categoryName.toLowerCase() + "img";
    var img = "assets/images/$imgLowerCase.jpg";
   // provider.fetchFavorite();
    favoriteInd = provider.favorite.indexWhere((element) =>
    element.userId == widget.userId &&
        element.productId == widget.productId);
    if (favoriteInd >= 0) {
      icon = provider.favorite[favoriteInd].isLike == "no"
          ? icon = Icons.favorite_outline_sharp
          : icon = Icons.favorite;
      colorButton = provider.favorite[favoriteInd].isLike == "no"
          ? colorButton = Colors.black
          : Colors.red;
    }
    var products = provider.favorite.where((element) =>
    element.productId == widget.productId &&
        element.isLike == "yes");
    int num = products.length;
    setState(() {
      like = num.toDouble();
    });
    return Scaffold(
       key: scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchFavorite().catchError((e) async{
            setState(() {
              ok = false;
            });
            provider.favorite.clear();
            await provider.fetchFavorite();

          });
        //  await provider.fetchFavorite();
          if (ok == true) {
            print('iam here');
            favoriteInd = provider.favorite.indexWhere((element) =>
                element.userId == widget.userId &&
                element.productId == widget.productId);
            if (favoriteInd >= 0) {
              icon = provider.favorite[favoriteInd].isLike == "no"
                  ? icon = Icons.favorite_outline_sharp
                  : icon = Icons.favorite;
              colorButton = provider.favorite[favoriteInd].isLike == "no"
                  ? colorButton = Colors.black
                  : Colors.red;
            }

            var products = provider.favorite.where((element) =>
                element.productId == widget.productId &&
                element.isLike == "yes");
            int num = products.length;
            print(
                "the Number isssssssssssssssssssssssssssssssssssssssssssssssss:$num");
            setState(() {
              like = num.toDouble();
            });
            print("okkkkkkkkkkkkkkkkkk");
          }
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              color: Colors.blue,
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                img,
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              height: 630,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              provider
                                  .ProductGoods[widget.productInd].goodsName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Icon(Icons.check, color: Colors.green, size: 30),
                            isWait==true?CircularProgressIndicator(color: Colors.red,):Container(),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            icon,
                            color: colorButton,
                          ),
                          onPressed: () async {
                            setState(() {
                              isWait=true;
                            });
                            await provider.fetchFavorite().catchError((e) {
                              setState(() {
                                ok = false;
                                provider.favorite.clear();
                              });
                            });
                            if (ok == true) {
                              print('iam here');
                              favoriteInd = provider.favorite.indexWhere(
                                  (element) =>
                                      element.userId == widget.userId &&
                                      element.productId == widget.productId);
                            }
                            print("First $favoriteInd");
                            if (favoriteInd < 0) { //اذا كان مانو موجود
                              print("inter");
                              ok = false;
                              await provider.addFavorite(
                                  widget.userId, widget.productId, "no").then((value)async{
                                    await provider.fetchFavorite();
                              });
                            }
                            //await provider.fetchFavorite();
                            favoriteInd = provider.favorite.indexWhere(
                                (element) =>
                                    element.userId == widget.userId &&
                                    element.productId == widget.productId);
                            print("Second $favoriteInd");
                            icon = provider.favorite[favoriteInd].isLike == "no"
                                ? icon = Icons.favorite_outline_sharp
                                : icon = Icons.favorite;
                            colorButton =
                                provider.favorite[favoriteInd].isLike == "no"
                                    ? colorButton = Colors.black
                                    : Colors.red;
                            var isLike = provider.favorite[favoriteInd].isLike;
                            var favoriteId = provider.favorite[favoriteInd].id;
                            print(favoriteId);

                          //  setState(() async {
                              if (isLike == "no") {
                                print("no");
                                icon = Icons.favorite;
                                colorButton = Colors.red;
                                await provider.updateFavorite(
                                    favoriteId, "yes").then((value){
                                      setState(() {
                                        isWait=false;
                                      });
                                });
                              } else if (isLike == "yes") {
                                print("yes");
                                icon = Icons.favorite_outline_sharp;
                                colorButton = Colors.black;
                                await provider.updateFavorite(favoriteId, "no").then((value){
                                  setState(() {
                                    isWait=false;
                                  });
                                });
                              }

                         //   }

                        //    );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Card(
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:CachedNetworkImage(
                                placeholder:(context, url) =>  Expanded(child: Image.asset("assets/images/load2.gif")),
                                imageUrl: provider.ProductGoods[widget.productInd].goodsImage,
                                errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: (){

                                    return  Dialog();


                                    },
                                    icon: Icon(Icons.align_vertical_bottom),
                                  iconSize: 30,
                                  color: Colors.red,
                                  tooltip: "More Information",
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text("More Information",style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                            CircularPercentIndicator(
                              backgroundColor: Colors.grey,
                              //  arcBackgroundColor: Colors.yellowAccent,
                              percent: like / 100,
                              animation: true,
                              animationDuration: 900,
                              center: Icon(Icons.people_outline_rounded),
                              header: Text("Rating"),
                              lineWidth: 7,
                              radius: 40.0,
                              footer: Text("$like "),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Publisher Name:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              Text(
                                provider
                                    .Data[provider.Data.indexWhere((element) =>
                                        element.id ==
                                        provider.ProductGoods[widget.productInd]
                                            .userId)]
                                    .firstName,
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                  .Data[provider.Data.indexWhere((element) =>
                                      element.id ==
                                      provider.ProductGoods[widget.productInd]
                                          .userId)]
                                  .lastName),
                            ],
                          ), //Publicher Name

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "City:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                  .Data[provider.Data.indexWhere((element) =>
                                      element.id ==
                                      provider.ProductGoods[widget.productInd]
                                          .userId)]
                                  .city),
                            ],
                          ), // City

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Phone Number:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                  .ProductGoods[widget.productInd].phoneNumber),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Preferred to replace:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                  .ProductGoods[widget.productInd].switchTo),
                            ],
                          ), // Preferred to replace

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Estimated value:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                      .ProductGoods[widget.productInd].price +
                                  "\$"),
                            ],
                          ), //Estimated value

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Posted In:",
                                style: TextStyle(color: Colors.black38),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(provider
                                  .ProductGoods[widget.productInd].goodsHistory
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      provider.ProductGoods[widget.productInd].description,
                      style: TextStyle(color: Colors.black38),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Contact him",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            var whatsapp = provider
                                .ProductGoods[widget.productInd].phoneNumber;
                            await launch("whatsapp://send?phone=" +
                                whatsapp +
                                "&text=hello").then((value){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please delete the product Or tell the owner of the post when the procedures are completed by going to: "
                                    "Drawer->My Products->Delete") ,
                                behavior: SnackBarBehavior.floating,
                                // backgroundColor: Colors.red,
                                action: SnackBarAction(
                                    label:"Ok",
                                    onPressed: (){
                                      scaffoldKey.currentState?.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                                    }
                                ),
                                duration: Duration(minutes: 10),
                              ));
                            });
                          },
                          child: Text("WhatApp"),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 40, right: 40)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String u = "mailto:";
                            u += provider.ProductGoods[widget.productInd].email;
                            u += ".org?subject=Greetings&body=Hello%20World";
                            await launch(u).then((value){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please delete the product Or tell the owner of the post when the procedures are completed by going to: "
                                    "Drawer->My Products->Delete") ,
                                behavior: SnackBarBehavior.floating,
                                // backgroundColor: Colors.red,
                                action: SnackBarAction(
                                    label:"Ok",
                                    onPressed: (){
                                      scaffoldKey.currentState?.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                                    }
                                ),
                                duration: Duration(minutes: 10),
                              ));
                            });
                          },
                          child: Text("Gmail"),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 50, right: 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                         onPressed: () async {
                            String u = "tel:";
                            u += provider
                                .ProductGoods[widget.productInd].phoneNumber;
                            await launch(u).then((value){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please delete the product Or tell the owner of the post when the procedures are completed by going to: "
                                      "Drawer->My Products->Delete") ,
                                behavior: SnackBarBehavior.floating,
                               // backgroundColor: Colors.red,
                              action: SnackBarAction(
                                  label:"Ok",
                                  onPressed: (){
                                    scaffoldKey.currentState?.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                                  }
                                  ),
                                duration: Duration(minutes: 10),
                              ));
                            });
                          },
                          child: Text("Call"),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 55, right: 55)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String u = "sms:";
                            u += provider
                                .ProductGoods[widget.productInd].phoneNumber;
                            await launch(u).whenComplete((){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please delete the product Or tell the owner of the post when the procedures are completed by going to: "
                                      "Drawer->My Products->Delete") ,
                                  behavior: SnackBarBehavior.floating,
                                  // backgroundColor: Colors.red,
                                  action: SnackBarAction(
                                      label:"Ok",
                                      onPressed: (){
                                        scaffoldKey.currentState?.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                                      }
                                  ),

                                  duration: Duration(minutes:10),
                                ));




                            });
                          },
                          child: Text("SMS"),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 55, right: 55)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                          ),
                        ),
                      ],
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
