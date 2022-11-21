import 'package:finalproject/backend/myProvider.dart';
import 'package:finalproject/drawer/myDrawer.dart';
import 'package:finalproject/servicesAndGoods/serviceDetails.dart';
import 'package:flutter/material.dart';
import "/backend/myProvider.dart";
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
class ShowService extends StatefulWidget {
  var id;
  var ind;
  var category;

  ShowService({required this.id, required this.ind, required this.category});

  @override
  State<ShowService> createState() => _ShowServiceState();
}

class _ShowServiceState extends State<ShowService> {
  var img;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
   // provider.fetchServices();
    var services = provider.ProductServices.where(
        (element) => element.serviceType == widget.category);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.category),
      ),
      drawer: MyDrawer(id: widget.id, ind: widget.ind),
      body: RefreshIndicator(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: services
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.indigo,
                            Colors.indigo.shade300,
                          ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            e.servicesImage != "null"
                                ? ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child:CachedNetworkImage(
                                        placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                                        imageUrl: e.servicesImage,
                                        errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),

                                      ),
                                      // Image.network(
                                      //   e.servicesImage, //حط الصورة
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
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  //البرميتر التاني يعني عطيه موقع العنصر بلمصفوفة
                                  return ServiceDetails(userId:widget.id,productId: e.id,productInd:provider.ProductServices.indexWhere((element) => element.id==e.id),);
                                }));
                              },
                                  )
                                : ListTile(
                                    title: Text(
                                      "Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  //البرميتر التاني يعني عطيه موقع العنصر بلمصفوفة
                                  return ServiceDetails(userId: widget.id,productId: e.id,productInd:provider.ProductServices.indexWhere((element) => element.id==e.id),);
                                }));
                              },

                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("The Name is:"),
                                Expanded(
                                child:Text(
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
                                Text("The Occupation is:",),
                                Expanded(
                                  child: Text(
                                    e.servicesName,
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
                              ),//حط اسم المستخدم
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
          await provider.fetchServices();
          print("2");
        //  await provider.fetchData();
        },
      ),
    );
  }
}
