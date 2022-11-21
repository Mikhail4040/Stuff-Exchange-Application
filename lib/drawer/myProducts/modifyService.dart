import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import "/backend/myProvider.dart";

import 'package:toast/toast.dart';

class ModifyService extends StatefulWidget {
  var serviceId;
  ModifyService({required this.serviceId});

  @override
  State<ModifyService> createState() => _ModifyServiceState();
}

class _ModifyServiceState extends State<ModifyService> {
  var conServicesName=TextEditingController();
  var conDescription=TextEditingController();
  bool ok=false;

  @override
  Widget build(BuildContext context) {
    var serviceInfo=Provider.of<MyProvider>(context);
     int ind=serviceInfo.ProductServices.indexWhere((element) => element.id==widget.serviceId);
    // serviceInfo.fetchServices();
     var servicesName=serviceInfo.ProductServices[ind].servicesName;
     var description=serviceInfo.ProductServices[ind].description;
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Information Edait "),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: ()async{
                print('1');
                setState(() {
                  ok=true;
                });
                if(conServicesName.text!="") {
                  // print("First");
                  print('2');
                  await serviceInfo.updateNameServices(
                      widget.serviceId,conServicesName.text);
                  print('3');
                }
                if(conDescription.text!="") {
                  print('4');
                  //   print("Last");
                  await serviceInfo.updateServiceDescription(
                      widget.serviceId, conDescription.text);
                  print('5');
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
                      Text("Enter the new service name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: servicesName,
                            hintStyle: TextStyle(color: Colors.white)
                        ),
                        controller: conServicesName,
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
