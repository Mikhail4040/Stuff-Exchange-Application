import 'package:finalproject/servicesAndGoods/showGoods.dart';
import 'package:flutter/material.dart';

class GoodsPage extends StatefulWidget {
  var id;
  var ind;
  GoodsPage({required this.id, required this.ind});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  container(String url,String category,BuildContext con,var id,var ind){
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        child:InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_){
              return ShowGoods(id: widget.id, ind: widget.ind, category: category);
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
                  color: Colors.orange.withOpacity(0.8),
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
    return Scaffold(
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
            container("assets/images/clothesimg.jpg","Clothes",context,widget.id,widget.ind),
            container("assets/images/shoesimg.jpg","Shoes",context,widget.id,widget.ind),
            container("assets/images/mobileimg.jpg","Mobile",context,widget.id,widget.ind),
            container("assets/images/laptobimg.jpg","Laptob",context,widget.id,widget.ind),
            container("assets/images/carimg.jpg","Cars",context,widget.id,widget.ind),
            container("assets/images/headphoneimg.jpg","Headphone",context,widget.id,widget.ind),
            container("assets/images/wristwatchimg.jpg","Wristwatch",context,widget.id,widget.ind),
            container("assets/images/housewareimg.jpg","Houseware",context,widget.id,widget.ind),
            container("assets/images/booksimg.jpg","Books",context,widget.id,widget.ind),

          ],
        ),
      ),
    );
  }
}
