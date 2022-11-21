import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import "/backend/myProvider.dart";
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:cached_network_image/cached_network_image.dart';
class MyAccount extends StatefulWidget {
  var userId;
  var userInd;
  MyAccount({required this.userId,required this.userInd});
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Product', 0),
      GDPData('Service', 0),
    ];
    return chartData;
  }





  @override
  Widget build(BuildContext context) {
    var userInfo=Provider.of<MyProvider>(context);
    userInfo.fetchFavorite();
    userInfo.fetchServices();
    userInfo.fetchGoods();
    userInfo.fetchData();
    var userImg=userInfo.Data[widget.userInd].userImage;
    var userFirstName=userInfo.Data[widget.userInd].firstName;
    var userLastName=userInfo.Data[widget.userInd].lastName;
    var userEmail=userInfo.Data[widget.userInd].email;
    var userPhoneNumber=userInfo.Data[widget.userInd].phoneNumber;
    var userCity=userInfo.Data[widget.userInd].city;
    var numOfProducts=Provider.of<MyProvider>(context,listen: false).ProductGoods.where((element) => element.userId==widget.userId).length;
    var numOfServices=Provider.of<MyProvider>(context,listen: false).ProductServices.where((element) => element.userId==widget.userId).length;
    var result=numOfServices+numOfProducts;
    var numOfLike=Provider.of<MyProvider>(context,listen: false).favorite.where((element) => element.userId==widget.userId && element.isLike=="yes").length;
    // print(numOfLike);
    var arrayInd1=_chartData.indexWhere((element) => element.continent=="Product");
    _chartData[arrayInd1].gdp=numOfProducts;
    var arrayInd2=_chartData.indexWhere((element) => element.continent=="Service");
    _chartData[arrayInd2].gdp=numOfServices;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.black12,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                      imageUrl:userImg,
                      errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),

                    ),

                   // Image.network(userImg) ,
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userFirstName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        userLastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email,color: Colors.blue),
                      SizedBox(width: 5,),
                      Text(userEmail),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone,color: Colors.blue),
                      SizedBox(width: 5,),
                      Text(userPhoneNumber),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home,color: Colors.blue),
                      SizedBox(width: 5,),
                      Text(userCity),
                    ],
                  ),
                 SizedBox(height: 20,),

                  Divider(
                    thickness: 1,
                    height: 1,
                    indent: 80,
                    endIndent: 80,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10,),
                  Text(
                      "some stats about you:",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/postimg.png',width: 80,height: 80,),
                          SizedBox(height: 10,),
                          Text(
                               '$result',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                              'products posted'
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Image.asset('assets/images/sm.png',width: 60,height: 80,),
                          SizedBox(height: 10,),
                          Text(
                            '$numOfLike',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                              'products you like'
                          ),
                        ],
                      ),
                    ],
                  ),
                    SizedBox(height: 30,),
                  Divider(
                    thickness: 1,
                    height: 1,
                    indent: 80,
                    endIndent: 80,
                    color: Colors.black,
                  ),



              SfCircularChart(

                title:
                ChartTitle(text: 'Products posted by you',borderColor: Colors.blue),
                legend:
                Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  RadialBarSeries<GDPData, String>(
                      dataSource: _chartData,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      maximumValue: 400,
                  ),
                ],
              ),







                  
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                    Column(
                      children:[
                        Text("your account",style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),
                        ),
                        Text("will only be seen by you",style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class GDPData {
  GDPData(this.continent, this.gdp);
   String continent;
   int gdp;
}