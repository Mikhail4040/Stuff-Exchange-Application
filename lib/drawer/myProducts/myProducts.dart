import 'package:finalproject/backend/dataUserClass.dart';
import 'package:finalproject/drawer/myProducts/modifyGoods.dart';
import 'package:finalproject/drawer/myProducts/modifyService.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import "/backend/myProvider.dart";

import 'package:toast/toast.dart';

class MyProductsPage extends StatefulWidget {
  var userId;
  var userInd;
  MyProductsPage({required this.userId,required this.userInd});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  bool wait=false;
  bool waitDelete=false;
  bool waitDeleteGood=false;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
   // var products=provider.ProductGoods.where((element) => element.userId==widget.userId);
    //var services=provider.ProductServices.where((element) => element.userId==widget.userId);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
         actions: [
           IconButton(
         onPressed:()async{
           setState(() {
             wait=true;
           });
           provider.ProductServices.clear();
           provider.ProductGoods.clear();
           provider.ProductGoods.forEach((element) {print(element.goodsName);});
           await provider.fetchGoods();
           await  provider.fetchServices();

           setState(() {
             wait=false;
           });
         },
         icon: Icon(Icons.refresh),
          highlightColor: Colors.green,
    ),
         ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wait==true||waitDelete==true||waitDeleteGood==true?Center(child: CircularProgressIndicator(
              color: wait==true?Colors.blue:waitDelete==true?Colors.indigo:Colors.teal,
            )):SizedBox(height: 20,),
            Text("Products",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.teal,
            ),),
            ...provider.ProductGoods.where((element) => element.userId==widget.userId).map((e){
              return Card(
                color: Colors.teal.shade300,
                elevation: 5,
                child: ListTile(
                  title: Text(e.goodsName,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(e.goodsType),
                  leading: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return ModifyGoods(goodId:e.id);
                      }));
                    },
                    child:Text("Modify"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                  trailing:ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text("Are you sure to delete?"),
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
                                          setState(() {
                                            waitDeleteGood=true;
                                          });
                                          await deleteGood(ctx, e, provider).then((value){
                                            setState(() {
                                              waitDeleteGood=false;
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
                    },
                    child:Text("Delete"),
                  ),
                ),
              );
                  }).toList(),






            SizedBox(height: 30,),
            Text("Services",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.indigo,
            ),),

            ...provider.ProductServices.where((element) => element.userId==widget.userId).map((e){
              return Card(
                color: Colors.indigo.shade300,
                elevation: 5,
                child: ListTile(
                  title: Text(e.servicesName,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(e.serviceType),
                  leading: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return ModifyService(serviceId: e.id);
                      }));
                    },
                    child:Text("Modify"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                  trailing:ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text("Are you sure to delete?"),
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
                                          setState(() {
                                            waitDelete=true;
                                          });
                                            await deleteService(e, provider,ctx).then((value) {setState(() {
                                              waitDelete=false;
                                            });});
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

                    },
                    child:Text("Delete"),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),

    );
  }

  Future<void> deleteGood(BuildContext ctx, Goods e, MyProvider provider) async {
      Navigator.of(ctx).pop();
    var id=e.id;
    await provider.deleteGoods(e.id).then((value){
      var favourites=provider.favorite.where((element) => element.productId==id);
      favourites.forEach((favouriteId) async{
        await provider.deleteFavorite(favouriteId.id);
      });
    });

  }

  Future<void> deleteService(Services e, MyProvider provider,BuildContext ctx) async {
    Navigator.of(ctx).pop();
    var id=e.id;
    await provider.deleteServices(e.id);
    var favourites=provider.favorite.where((element) => element.productId==id);
    favourites.forEach((favouriteId) async{
      await provider.deleteFavorite(favouriteId.id);
    });
  }
}
