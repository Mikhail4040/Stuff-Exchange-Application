import 'package:finalproject/backend/myProvider.dart';
import 'package:finalproject/drawer/myDrawer.dart';
import 'package:finalproject/servicesAndGoods/ProductDetails.dart';
import 'package:flutter/material.dart';
import "/backend/myProvider.dart";
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
class ShowGoods extends StatefulWidget {
  var id;
  var ind;
  var category;

  ShowGoods({required this.id, required this.ind, required this.category});

  @override
  State<ShowGoods> createState() => _ShowGoodsState();
}

class _ShowGoodsState extends State<ShowGoods> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
  //  provider.fetchGoods();
  //  provider.fetchData();
    var goods = provider.ProductGoods.where(
            (element) => element.goodsType == widget.category);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.category),
      ),
      drawer: MyDrawer(id: widget.id, ind: widget.ind),
      body: RefreshIndicator(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: goods
                .map(
                  (e) => Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.teal,
                        Colors.teal.shade300,
                      ]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        e.goodsImage != "null"
                            ? Hero(
                          tag: "1",
                              child: ListTile(
                          onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                //البرميتر التاني يعني عطيه موقع العنصر بلمصفوفة
                                return ProductDetails(userId:widget.id,productId: e.id,productInd:provider.ProductGoods.indexWhere((element) => element.id==e.id),);
                              }));
                          },

                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:CachedNetworkImage(
                                placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                                imageUrl:e.goodsImage,
                                errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),

                              ),
                              // Image.network(
                              //   e.goodsImage, //حط الصورة
                              //   fit: BoxFit.cover,
                              //   height: 70,
                              //   width: 70,
                              // ),
                          ),
                          title: Text(
                              "Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                            )
                            : ListTile(

                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              //البرميتر التاني يعني عطيه موقع العنصر بلمصفوفة
                              return ProductDetails(userId: widget.id,productId: e.id,productInd:provider.ProductGoods.indexWhere((element) => element.id==e.id),);
                            }));
                          },
                          title: Text(
                            "Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("The Name is:"),
                            Expanded(
                              child: Text(
                                provider
                                    .Data[provider.Data.indexWhere(
                                        (element) => element.id == e.userId)]
                                    .firstName,

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            
                            Expanded(
                              child: Text(
                                provider
                                    .Data[provider.Data.indexWhere(
                                        (element) => element.id == e.userId)]
                                    .lastName,

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ), //حط اسم المستخدم
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("The Product is:"),
                            
                            Expanded(
                              child: Text(
                                e.goodsName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("The City is:"),
                            
                            Expanded(
                              child: Text(
                                provider
                                    .Data[provider.Data.indexWhere(
                                        (element) => element.id == e.userId)]
                                    .city,

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ), //حط اسم المستخدم
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
        onRefresh: () async {
        await   provider.fetchGoods();
          print('1');
        //  provider.Data.clear();
         // await provider.fetchData();
         //  setState(() {
         //
         //  });

        },
      ),
    );
  }
}




