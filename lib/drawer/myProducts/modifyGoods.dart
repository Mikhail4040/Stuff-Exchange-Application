import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import "/backend/myProvider.dart";

import 'package:toast/toast.dart';

class ModifyGoods extends StatefulWidget {
  var goodId;
  ModifyGoods({required this.goodId});

  @override
  State<ModifyGoods> createState() => _ModifyGoodsState();
}

class _ModifyGoodsState extends State<ModifyGoods> {
  var conGoodName=TextEditingController();
  var conDescription=TextEditingController();
  bool ok=false;

  @override
  Widget build(BuildContext context) {
    var goodsInfo=Provider.of<MyProvider>(context);
    int ind=goodsInfo.ProductGoods.indexWhere((element) => element.id==widget.goodId);
   // goodsInfo.fetchServices();
    var servicesName=goodsInfo.ProductGoods[ind].goodsName;
    var description=goodsInfo.ProductGoods[ind].description;
    return Scaffold(
      appBar: AppBar(
        title: Text("Goods Information Edait "),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: ()async{
                setState(() {
                  ok=true;
                });
                if(conGoodName.text!="") {
                  await goodsInfo.updateGoodsName(
                      widget.goodId,conGoodName.text);
                }
                if(conDescription.text!="") {
                  await goodsInfo.updateGoodsDescription(
                      widget.goodId, conDescription.text);
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
                      Text("Enter the new services name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: servicesName,
                            hintStyle: TextStyle(color: Colors.white)
                        ),
                        controller: conGoodName,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter the new description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: description,
                            hintStyle: TextStyle(color: Colors.white)
                        ),
                        controller: conDescription,
                      ),
                    ],
                  ),
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
