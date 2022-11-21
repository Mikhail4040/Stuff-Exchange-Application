import 'dart:math';

import 'package:finalproject/servicesAndGoods/serviceDetails.dart';
import 'package:flutter/material.dart';
import "/backend/myProvider.dart";
import 'package:provider/provider.dart';
import 'package:finalproject/servicesAndGoods/ProductDetails.dart';
class MyFavoriteServices extends StatefulWidget {
  var userId;
  var userInd;
  MyFavoriteServices({required this.userId,required this.userInd});

  @override
  State<MyFavoriteServices> createState() => _MyFavoriteServicesState();
}

class _MyFavoriteServicesState extends State<MyFavoriteServices> {
  List<Color>color=[Colors.black,Colors.blue,Colors.grey,Colors.green,Colors.teal,Colors.cyan];
  var range=Random();
  bool ok=false;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    // provider.fetchFavorite();
    // provider.fetchServices();
    var i=provider.favorite.where((element) => element.userId==widget.userId && element.isLike=="yes");
    var ii=i.forEach((e) {
      if(provider.ProductServices.indexWhere((element) => element.id==e.productId)>=0)
        ok=true;
    });
    setState(() {
      ok;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Services'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          ok=false;
        //  provider.favorite.clear();
         // provider.ProductServices.clear();
         // await provider.fetchFavorite();
          await provider.fetchServices();
       var i=provider.favorite.where((element) => element.userId==widget.userId && element.isLike=="yes");
       var ii=i.forEach((e) {
         if(provider.ProductServices.indexWhere((element) => element.id==e.productId)>=0)
           ok=true;
       });
       setState(() {
         ok;
       });
          print("$ok");
        },
        child:
         ok==true?
        ListView(
          scrollDirection: Axis.vertical,
          children:
          provider.favorite.where((element) => element.userId==widget.userId && element.isLike=="yes").map((e){
            return provider.ProductServices.indexWhere((element) => element.id==e.productId)>=0?
              CurvedListItem(
              productName:provider.ProductServices[provider.ProductServices.indexWhere((element) => element.id==e.productId)].servicesName ,
              description:provider.ProductServices[provider.ProductServices.indexWhere((element) => element.id==e.productId)].description ,
              color: color[range.nextInt(5)],
              userId:widget.userId,
              productId: provider.ProductServices[provider.ProductServices.indexWhere((element) => element.id==e.productId)].id,
              productInd:provider.ProductServices.indexWhere((element) => element.id==e.productId),
            ):Container();
          }).toList(),
        ):
            ListView(
              children: [
                Image.asset("assets/images/folder.png",width: 300,height: 300,),
                Text("There are no items to display!",style: TextStyle(
                  color: Colors.blue,
                  fontSize: 29
                ),),
              ],
            ),
      ),
    );
  }
}


// Image.asset("assets/images/folder.png",width: 200,height: 300,),
// Text("There is nothing you like!",style: TextStyle(
//   color: Colors.blue,
//   fontSize: 30
// ),),






class CurvedListItem extends StatelessWidget {
  String productName;
  String description;
  Color color;
  var userId;
  var productId;
  var productInd;

  CurvedListItem({required this.productName, required this.description,required this.color,required this.userId,required this.productId,required this.productInd});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedRectangleClipper(),
      child: Container(
        color:color,
        padding: EdgeInsets.only(
          left: 32,
          top: 100,
          bottom: 50,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                productName,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                description,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_){
                            return ServiceDetails(
                              userId:userId ,
                              productId: productId,
                              productInd: productInd,
                            );
                          }),
                        );
                      },
                      child: Text("Open")),
                ],
              ),
            ]),
      ),
    );
  }
}
class CurvedRectangleClipper extends CustomClipper<Path> {
  final double offset = 80;
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height - offset);
    var firstEndpoint = Offset(offset, size.height);
    path.arcToPoint(firstEndpoint, radius: Radius.circular(-offset),clockwise: false);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, offset);
    path.lineTo(offset, offset);

    var secondEndPoint = Offset(0,0);

    path.arcToPoint(secondEndPoint, radius: Radius.circular(-offset),clockwise: true);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}