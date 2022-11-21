import 'package:flutter/material.dart';

import 'showService.dart';


class ServicesPage extends StatefulWidget {
  var id;
  var ind;
  ServicesPage({required this.id, required this.ind});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  container(String url,String category,BuildContext con,var id,var ind){
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        child:InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_){
              return ShowService(id: widget.id,ind: widget.ind,category: category,);
            }));
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                child: Image.asset(
                    url,fit: BoxFit.cover
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                height: 20,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Text(category,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10,left: 10,right: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 2,
              maxCrossAxisExtent: 200
          ),
          children: [
            container("assets/images/medicalconsultingimg.jpg","Medical Consulting",context,widget.id,widget.ind),
            container("assets/images/codeimg.jpg","Software Services",context,widget.id,widget.ind),
            container("assets/images/fooddeliveryimg.jpg","Food Delivery",context,widget.id,widget.ind),
            container("assets/images/homerepairsimg.jpg","Home Repairs",context,widget.id,widget.ind),
            container("assets/images/electricalrepairsimg.jpg","Electrical Repairs",context,widget.id,widget.ind),

          ],
        ),
      ),
    );
  }
}
