

import 'package:flutter/material.dart';
import 'dart:io';
import "/backend/myProvider.dart";
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toast/toast.dart';
class AddServices extends StatefulWidget {
  var id;
  var ind;

  AddServices({required this.id, required this.ind});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  Color color1=Colors.red;
  Color color2=Colors.red;
  Color color3=Colors.red;
  Color color4=Colors.red;
  Color color5=Colors.red;
  Color color6=Colors.red;
  Color color7=Colors.red;
  Color color8=Colors.red;
  Color color9=Colors.red;

  Color colorExchange1=Colors.red;
  Color colorExchange2=Colors.red;
  Color colorExchange3=Colors.red;
  Color colorExchange4=Colors.red;
  Color colorExchange5=Colors.red;
  Color colorExchange6=Colors.red;
  Color colorExchange7=Colors.red;
  Color colorExchange8=Colors.red;
  Color colorExchange9=Colors.red;
  Color colorExchange10=Colors.red;
  Color colorExchange11=Colors.red;
  Color colorExchange12=Colors.red;
  Color colorExchange13=Colors.red;
  Color colorExchange14=Colors.red;
  var con1=TextEditingController();
  var con2=TextEditingController();
  double val=0.0;
  var showValue=0;
  bool isSelected1=false;
  bool isSelected2=false;
  String type="";
  String preferred="";
  container(String url,String category,Color col,BuildContext con,var id,var ind){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color:col,
          padding: const EdgeInsets.all(7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              child:InkWell(
                onTap: (){},
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      child: Image.asset(
                          url,fit: BoxFit.cover
                      ),
                      width: 100,
                      height: 50,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.withOpacity(0.8),
                      ),
                      child: Text(category,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ],
                ),
              ),
            ),
          ),


        ),
      ),
    );
  }
  text(var text){
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        shadows:[
          Shadow(color:Colors.yellow,offset: Offset(2,2)),
        ],
      ),
    );
  }

  bool ok=false;


  Future check(MyProvider provider)async{
    if(isSelected1==true && isSelected2==true && con1.text!="" && con2.text!=""){
      provider.addServices(
        widget.id,
        provider.Data[widget.ind].email ,
        provider.Data[widget.ind].phoneNumber,
        type,
        con1.text,
        con2.text,
        showValue.toString(),
        preferred ,
        DateTime.now().year,
        "0",
        "null",
      ).then((value) async {
        await provider.fetchServices();
        print("OK1");
        var serviceInd=provider.ProductServices.indexWhere((element) => element.description==con2.text);
        print("$serviceInd");
        print("OK2");
        var serviceId=provider.ProductServices[serviceInd].id;
        print("THE ID IS:$serviceId");
        print("OK3");
           String s=provider.Data[widget.ind].userImage;
          await   provider.updateServicesImage(
              serviceId, s);
        print("OK4");
        Toast.show(
          "Product added successfully",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.black,
        );

      });

      Toast.show(
        "Product added successfully",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.black,
      );
    Navigator.of(context).pop();

    }else
    {
      Toast.show(
        "All fields must be filled out",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.CENTER,
        backgroundColor: Colors.redAccent,
        textColor: Colors.black,
      );
    }

  }

bool wait=false;
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider=Provider.of<MyProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            text("Please select a service category"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    child:container("assets/images/medicalconsultingimg.jpg","Medical Consulting",color1,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        color1=Colors.green;
                        color2=Colors.red;
                        color3=Colors.red;
                        color4=Colors.red;
                        color5=Colors.red;
                        type="Medical Consulting";
                        isSelected1=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/codeimg.jpg","Software Services",color2,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        color1=Colors.red;
                        color2=Colors.green;
                        color3=Colors.red;
                        color4=Colors.red;
                        color5=Colors.red;
                        type="Software Services";
                        isSelected1=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/fooddeliveryimg.jpg","Food Delivery",color3,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        color1=Colors.red;
                        color2=Colors.red;
                        color3=Colors.green;
                        color4=Colors.red;
                        color5=Colors.red;
                        type="Food Delivery";
                        isSelected1=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/homerepairsimg.jpg","Home Repairs",color4,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        color1=Colors.red;
                        color2=Colors.red;
                        color3=Colors.red;
                        color4=Colors.green;
                        color5=Colors.red;
                        type="Home Repairs";
                        isSelected1=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/electricalrepairsimg.jpg","Electrical Repairs",color5,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        color1=Colors.red;
                        color2=Colors.red;
                        color3=Colors.red;
                        color4=Colors.red;
                        color5=Colors.green;

                        type="Electrical Repairs";
                        isSelected1=true;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            text("Please enter the service name"),
            TextField(
              decoration: InputDecoration(
                  hintText: "Product name is..."
              ),
              controller: con1,
            ),

            SizedBox(height: 12,),
            text("Please enter a service description"),
            TextField(
              decoration: InputDecoration(
                  hintText: "Description..."
              ),
              controller: con2,
              keyboardType:TextInputType.text ,
            ),

            SizedBox(height: 12,),
            text("Preferred item to exchange for"),
            Text("-Products",style: TextStyle(fontStyle: FontStyle.italic,backgroundColor: Colors.blue),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    child:container("assets/images/clothesimg.jpg","Clothes",colorExchange1,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.green;
                        preferred="Clothes";
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/shoesimg.jpg","Shoes",colorExchange2,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.green;
                        preferred="Shoes";
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/mobileimg.jpg","Mobile",colorExchange3,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.green;
                        preferred="Mobile";
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/laptobimg.jpg","Laptob",colorExchange4,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.green;
                        preferred="Laptob";
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/carimg.jpg","Cars",colorExchange5,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.green;
                        preferred="Cars";
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/headphoneimg.jpg","Headphone",colorExchange6,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.green;
                        preferred="Headphone";
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/wristwatchimg.jpg","Wristwatch", colorExchange7,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.green;
                        preferred="Wristwatch";
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/housewareimg.jpg","Houseware",colorExchange8,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.green;
                        preferred="Houseware";
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/booksimg.jpg","Books",colorExchange9,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.green;
                        preferred="Books";
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                ],
              ),
            ),

            Text("-Services",style: TextStyle(fontStyle: FontStyle.italic,backgroundColor: Colors.blue)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    child:container("assets/images/medicalconsultingimg.jpg","Medical Consulting",colorExchange10,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.green;
                        preferred="Medical Consulting";
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/codeimg.jpg","Software Services",colorExchange11,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.green;
                        preferred="Software Services";
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/fooddeliveryimg.jpg","Food Delivery",colorExchange12,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.green;
                        preferred="Food Delivery";
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/homerepairsimg.jpg","Home Repairs",colorExchange13,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.green;
                        preferred="Home Repairs";
                        colorExchange14=Colors.red;
                        isSelected2=true;
                      });
                    },
                  ),
                  TextButton(
                    child:container("assets/images/electricalrepairsimg.jpg","Electrical Repairs",colorExchange14,context,widget.id,widget.ind),
                    onPressed: (){
                      setState(() {
                        colorExchange1=Colors.red;
                        colorExchange2=Colors.red;
                        colorExchange3=Colors.red;
                        colorExchange4=Colors.red;
                        colorExchange5=Colors.red;
                        colorExchange6=Colors.red;
                        colorExchange7=Colors.red;
                        colorExchange8=Colors.red;
                        colorExchange9=Colors.red;
                        colorExchange10=Colors.red;
                        colorExchange11=Colors.red;
                        colorExchange12=Colors.red;
                        colorExchange13=Colors.red;
                        colorExchange14=Colors.green;
                        preferred="Electrical Repairs";
                        isSelected2=true;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            text("Please estimate the value of the service hour"),
            Center(child: Text("$showValue \$" ),),
            Slider(
              value: val,
              max: 1000,
              min: 0,
              onChanged: (v){
                setState(() {
                  val=v;
                  showValue=val.toInt();
                });
              },
            ),




            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text("Post Now",style: TextStyle(color: Colors.yellow),),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text("Are you sure about posting?"),
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
                                    onPressed:(){
                                      check(myProvider).then((value){
                                     //   Navigator.of(context).pop();


                                      });
                                    },
                                    child: Text("YES"),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.green),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed:(){
                                      Navigator.of(context).pop();
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
                    // barrierDismissible: false,
                    //هلق اذا منكبس اي كبسة برا dialog ما رح يتسكر
                    barrierColor: Colors.blue.withOpacity(0.2), //جرب بدونا بتعرف ليش
                  );

                },
              ),
            ),

            Center(
              child:
              wait==true?CircularProgressIndicator():
              Container(),
            ),



          ],
        ),
      ),
    );
  }
}
