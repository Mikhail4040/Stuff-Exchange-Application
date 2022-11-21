import 'package:finalproject/servicesAndGoods/ProductDetails.dart';
import 'package:flutter/material.dart';
import "backend/myProvider.dart";
import 'package:provider/provider.dart';

import 'servicesAndGoods/serviceDetails.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:kmeans/kmeans.dart';
class Brain extends StatefulWidget {
  var userId;
  var userInd;

  Brain({required this.userId, required this.userInd});
  @override
  State<Brain> createState() => _BrainState();
}

class _BrainState extends State<Brain> {
  List<String>sum=[];
  List<String>res=[];
  String mostTypeName="";
  int  mostTypeNumber=0;
  bool isGoods=false;




  void K_means(var provider){
   //  final ArffReader reader = ArffReader.fromFile(File('example/letter.arff'));
   // // await reader.parse();
   //
   //  const int labelIndex = 16;
   //  final int trainingSetSize = reader.data.length ~/ 2;
   //
   //  // Train on the first half of the data.
   //  final List<List<double>> trainingData =
   //  reader.data.sublist(0, trainingSetSize);
   //  final KMeans trainingKMeans = KMeans(trainingData, labelDim: labelIndex);
   //  final Clusters trainingClusters = trainingKMeans.bestFit(
   //    minK: 26,
   //    maxK: 26,
   //  );
   //
   //  int trainingErrors = 0;
   //  for (int i = 0; i < trainingClusters.clusterPoints.length; i++) {
   //    // Count the occurrences of each label.
   //    final List<int> counts = List<int>.filled(trainingClusters.k, 0);
   //    for (int j = 0; j < trainingClusters.clusterPoints[i].length; j++) {
   //      counts[trainingClusters.clusterPoints[i][j][labelIndex].toInt()]++;
   //    }
   //
   //    // Find the most frequent label.
   //    int maxIdx = -1;
   //    int maxCount = 0;
   //    for (int j = 0; j < trainingClusters.k; j++) {
   //      if (counts[j] > maxCount) {
   //        maxCount = counts[j];
   //        maxIdx = j;
   //      }
   //    }
   //
   //    // If a point isn't in the most frequent cluster, consider it an error.
   //    for (int j = 0; j < trainingClusters.clusterPoints[i].length; j++) {
   //      if (trainingClusters.clusterPoints[i][j][labelIndex].toInt() != maxIdx) {
   //        trainingErrors++;
   //      }
   //    }
   //  }
   //  // This should be zero.
   //  print('trainingErrors: $trainingErrors');
   //
   //  // A copy of the clustering that ignores the labels.
   //  final Clusters ignoreLabel = Clusters(
   //    trainingClusters.points,
   //    <int>[labelIndex],
   //    trainingClusters.clusters,
   //    trainingClusters.means,
   //  );
   //
   //  // Find the predicted cluster for the other half of the data.
   //  final List<List<double>> data = reader.data.sublist(trainingSetSize);
   //  final List<int> predictions = data.map((List<double> point) {
   //    return ignoreLabel.kNearestNeighbors(point, 5);
   //  }).toList();
   //
   //  // Count the number points where the predicted cluster doesn't match the
   //  // label.
   //  int errors = 0;
   //  for (int i = 0; i < predictions.length; i++) {
   //    final List<double> rep = ignoreLabel.clusterPoints[predictions[i]][0];
   //    final int repClass = rep[labelIndex].toInt();
   //    final int dataClass = data[i][labelIndex].toInt();
   //    if (dataClass != repClass) {
   //      errors++;
   //    }
   //  }
   //
   //  // Hopefully these are small.
   //  final int testSetSize = reader.data.length - trainingSetSize;
   //  final double errorRate = errors.toDouble() / testSetSize.toDouble();
   //  print('classification errors: $errors / $testSetSize');
   //  print('error rate: $errorRate');
   //








   List<String>s=[];
   sum.clear();
   res.clear();
   isGoods=false;
    var fav= provider.favorite.where((element) {
      return
        element.userId==widget.userId && element.isLike=="yes" ;
    });
 //   print("the Fav is:");
   // print(fav.length);
    fav.forEach((fav){
      provider.ProductGoods.forEach((goods) {
        if(fav.productId==goods.id) {
          s.add(fav.productId);
        }
      });
    });
  //  print("THe sum is:");
  //  print(s.length);
    fav.forEach((fav){
      provider.ProductServices.forEach((service) {
        if(fav.productId==service.id) {
          s.add(fav.productId);
        }
      });
    });
   // print("THe sum is:");
   // print(s.length);
    sum=s;
   sum.forEach((element) {
     provider.ProductGoods.forEach((goods) {
       if(goods.id==element)
         res.add(goods.goodsType);
     });
   });
   sum.forEach((element) {
     provider.ProductServices.forEach((service) {
       if(service.id==element)
         res.add(service.serviceType);
     });
   });
   Map counts={};
   res.forEach((element) {
     counts[element] = 0;
   });
   res.forEach((element) {
     counts[element] = counts[element]+1;
   });
 String maxName="";
 int maxNumber=0;

 counts.forEach((key, value) {
   if(value>maxNumber) {
     maxNumber = value;
     maxName = key;
   }
 });
 mostTypeName=maxName;
 mostTypeNumber=maxNumber;

 provider.ProductGoods.forEach((element) {
     if(element.goodsType==mostTypeName)
       isGoods=true;
   });


  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider=Provider.of<MyProvider>(context);
    provider.fetchFavorite();
    provider.fetchServices();
    provider.fetchGoods();
    provider.fetchData();
    K_means(provider);



    return Scaffold(
      appBar: AppBar(
        title: Text("Quick access"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:LinearGradient(
              colors: [
                Colors.teal,
                Colors.indigo
              ]
            )
          ),
        ),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Stack(
                alignment: Alignment.center,
                children:[
                  Positioned(
                      child:Column(
                        children: [
                          Row(children: [
                            Text("wow! It's really amazing "),
                            Text("how"),
                          ],),
                          Row(children: [
                            Text("the app knows"),
                            Text(" that I "),
                            Text("like these items?"),
                          ],),
                          SizedBox(height: 10,),
                          Row(children: [
                            Text("This is "),
                            Text("K-Means" ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                            Text(" algorithm Bro!")
                          ],),
                        ],
                      ),
                    left:70 ,
                   // bottom: 210,

                  ),
                  Image.asset(
                "assets/images/talk.png",
            ),
          ],),
              mostTypeNumber==0?
                  Column(
                    children: [
                      Text(
                        "    K-means did not notice any products that you might like",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15

                        ),
                      ),
                      Image.asset("assets/images/why.png")
                    ],
                  ) :
                  ListTile(
                    title: Text("Items you might like",
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30,
                      fontFamily: "Lobster-Regular",
                      color: Colors.black54
                    ),
                    ),
                    leading: Icon(Icons.star,color: Colors.yellow,),
                    trailing: Icon(Icons.star,color: Colors.yellow,),
                  ),

              isGoods==true?
                   Column(
                     children: provider.ProductGoods.where((element) => element.goodsType==mostTypeName).map((e){
                       return Padding(
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
                                         return ProductDetails(userId:widget.userId,productId: e.id,productInd:provider.ProductGoods.indexWhere((element) => element.id==e.id),);
                                       }));
                                     },
                                     leading: ClipRRect(
                                       borderRadius: BorderRadius.circular(30),
                                       child: CachedNetworkImage(
                                         placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                                         imageUrl: e.goodsImage,
                                         errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),
                                         height: 70,
                                         width: 70,
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
                                       return ProductDetails(userId: widget.userId,productId: e.id,productInd:provider.ProductGoods.indexWhere((element) => element.id==e.id),);
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
                       );

                     }).toList(),
                   ):


                    Column(
                      children:provider.ProductServices.where((element) => element.serviceType==mostTypeName).map((e){
                        return Padding(
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
                                      child: CachedNetworkImage(
                                        placeholder:(context, url) =>  Image.asset("assets/images/load2.gif"),
                                        imageUrl: e.servicesImage,
                                        errorWidget: (context, url, error) => Text("Please try again",style: TextStyle(color: Colors.red),),
                                        height: 70,
                                        width: 70,
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
                                        return ServiceDetails(userId:widget.userId,productId: e.id,productInd:provider.ProductServices.indexWhere((element) => element.id==e.id),);
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
                                        return ServiceDetails(userId: widget.userId,productId: e.id,productInd:provider.ProductServices.indexWhere((element) => element.id==e.id),);
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
                        );

                      }).toList()
                    ),


          ]
          ),
        ),
      ),

    );
  }
}
