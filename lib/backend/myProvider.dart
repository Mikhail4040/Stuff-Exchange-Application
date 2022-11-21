import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dataUserClass.dart';


class MyProvider with ChangeNotifier {
  List<UserData> Data = [];
  List<Goods>ProductGoods=[];
  List<Services>ProductServices=[];
  List<Favorite>favorite=[];



//لالاضافة لقاهدة البيانات
  Future<void> addData(
      var email,
      var password,
      var firstName,
      var lastName,
      var phoneNumber,
      var city,
      var isDarkMode,
      var userImage,

      ) async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users.json";
    try {
      var ref = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "city": city,
            "isDarkMode": isDarkMode,
            "userImage":userImage,

          }));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }


  // To add a new product
  Future<void> addGoods(
  var userId,
  var email,
  var phoneNumber,
  var goodsType,
  var goodsName,
  var description,
  var price,
  var switchTo,
  var goodsHistory,
  var fans,
  var goodsImage

      ) async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods.json";
    try {
      var ref = await http.post(Uri.parse(url),
          body: json.encode({
            "userId":userId,
            "email": email,
            "phoneNumber":phoneNumber,
            "goodsType":goodsType,
            "goodsName": goodsName,
            "description": description,
            "price": price,
            "switchTo": switchTo,
            " goodsHistory": goodsHistory,
            "fans": fans,
            "goodsImage":goodsImage,

          }));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }





  Future<void> addServices(
      var userId,
      var email,
      var phoneNumber,
      var serviceType,
      var servicesName,
      var description,
      var price,
      var switchTo,
      var servicesHistory,
      var fans,
      var servicesImage

      ) async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services.json";
    try {
      var ref = await http.post(Uri.parse(url),
          body: json.encode({
            "userId":userId,
            "email": email,
            "phoneNumber":phoneNumber,
            "serviceType":serviceType,
            "servicesName": servicesName,
            "description": description,
            "price": price,
            "switchTo": switchTo,
            "servicesHistory":servicesHistory,
            "fans": fans,
            "servicesImage":servicesImage,

          }));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }




  Future<void> addFavorite(
      var userId,
      var productId,
      var isLike,
      ) async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/favorite.json";
    try {
      var ref = await http.post(Uri.parse(url),
          body: json.encode({
            "userId":userId,
            "productId": productId,
            "isLike":isLike,

          }));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }














  //    لجلب البيانات من قاعجة البيانات و وضعها في مصفوفة مثلاا
  Future fetchData() async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users.json";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body) as Map<String, dynamic>;
      // print(json.decode(res.body)["name"]);
      Data1.forEach((key, value) {
        var ind = Data.indexWhere((element) => element.id == key);
        if (ind < 0)
          Data.add(
            UserData(
              id: key,
              email: value["email"],
              password: value["password"],
              firstName: value["firstName"],
              lastName: value["lastName"],
              phoneNumber: value["phoneNumber"],
              city: value["city"],
              isDarkMode: value["isDarkMode"],
              userImage: value["userImage"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }



  //    لجلب البيانات من قاعجة البيانات المنتجات و وضعها في مصفوفة مثلاا

  Future fetchGoods() async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods.json";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body) as Map<String, dynamic>;
      Data1.forEach((key, value) {
        var ind = ProductGoods.indexWhere((element) => element.id == key);
        if (ind < 0)
          ProductGoods.add(
            Goods(
              id: key,
              userId: value["userId"],
              email: value["email"],
              phoneNumber: value["phoneNumber"],
              goodsType: value["goodsType"],
              goodsName: value["goodsName"],
             description : value["description"],
              price: value["price"],
              switchTo: value["switchTo"],
              goodsHistory:value[" goodsHistory"],
              fans: value["fans"],
              goodsImage:value["goodsImage"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }


  Future fetchServices() async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services.json";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body) as Map<String, dynamic>;
      Data1.forEach((key, value) {
        var ind = ProductServices.indexWhere((element) => element.id == key);
        if (ind < 0)
          ProductServices.add(
            Services(
              id: key,
              userId: value["userId"],
              email: value["email"],
              phoneNumber: value["phoneNumber"],
              serviceType:value["serviceType"],
              servicesName: value["servicesName"],
              description : value["description"],
              price: value["price"],
              switchTo: value["switchTo"],
              servicesHistory:value["servicesHistory"],
              fans: value["fans"],
              servicesImage:value["servicesImage"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }



  Future fetchFavorite() async {
    String url = "https://finalproject-7a8cf-default-rtdb.firebaseio.com/favorite.json";
    try {
     // favorite.clear();
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body) as Map<String, dynamic>;
      Data1.forEach((key, value) {
        var ind = favorite.indexWhere((element) => element.id == key);
        if (ind < 0)
          favorite.add(
            Favorite(
              id: key,
              userId: value["userId"],
              productId: value["productId"],
              isLike: value["isLike"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }














  Future<void> update(String id, var name, String last) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      Data[indexElement].firstName = name;
      Data[indexElement].lastName = last;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "firstName": name,
            "lastName": last,
          }));
      notifyListeners();
    }
  }


  Future<void> updateUserFirstName(String id, var firstName) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      Data[indexElement].firstName = firstName;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "firstName": firstName,
          }));
      notifyListeners();
    }
  }



  Future<void> updateUserLastName(String id, var lastName) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      Data[indexElement].lastName = lastName;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "lastName": lastName,
          }));
      notifyListeners();
    }
  }


  Future<void> updateUserPhoneNumber(String id, var phoneNumber) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      Data[indexElement].phoneNumber = phoneNumber;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "phoneNumber": phoneNumber,
          }));
      notifyListeners();
    }
  }


  Future<void> updateUserCity(String id, var city) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    try{
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "city": city,
          }));
    }catch(e){
      print("Error is $e");
    }
    if (indexElement >= 0) {
      Data[indexElement].city = city;
    }
    notifyListeners();
  }



  Future<void> updatedarkMode(String id, var isDark) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      Data[indexElement].isDarkMode = isDark;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "isDarkMode": isDark,
          }));
    }
    notifyListeners();
  }













  Future<void> updateGoods(String id, var fans) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods/${id}.json";
    var indexElement = ProductGoods.indexWhere((element) => element.id == id);
    try{
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "fans": fans,
          }));
    }catch(e){
      print("Error is $e");
    }
    if (indexElement >= 0) {
      ProductGoods[indexElement].fans = fans;
    }
    notifyListeners();
  }

  Future<void> updateGoodsName(String id, var name) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods/${id}.json";
    var indexElement = ProductGoods.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      ProductGoods[indexElement].goodsName = name;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "goodsName": name,

          }));
    }
    notifyListeners();
  }

  Future<void> updateGoodsDescription(String id, var description ) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods/${id}.json";
    var indexElement = ProductGoods.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      ProductGoods[indexElement].description = description;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "description": description,

          }));
    }
    notifyListeners();
  }




  Future<void> updateServices(String id, var name, String description) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services/${id}.json";
    var indexElement = ProductServices.indexWhere((element) => element.id == id);
    if (indexElement >= 0) {
      ProductServices[indexElement].servicesName = name;
      ProductServices[indexElement].description = description;
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "servicesName": name,
            "description": description,
          }));
    }
    notifyListeners();
  }

  Future<void> updateNameServices(String id, var nameService) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services/${id}.json";
    var indexElement = ProductServices.indexWhere((element) => element.id == id);
    try{
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "servicesName": nameService,
          }));
    }catch(e){
      print("Error is $e");
    }
    if (indexElement >= 0) {
      ProductServices[indexElement].servicesName = nameService;
    }
    notifyListeners();
  }

  Future<void> updateServiceDescription(String id,String description) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services/${id}.json";
    var indexElement = ProductServices.indexWhere((element) => element.id == id);
    try{
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "description": description,
          }));
    }catch(e){
      print("Error is $e");
    }
    if (indexElement >= 0) {
      ProductServices[indexElement].description = description;
    }
    notifyListeners();
  }



  Future<void> updateFavorite(var id, var isLike) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/favorite/${id}.json";
    var indexElement = favorite.indexWhere((element) => element.id == id);
    try{
      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "isLike": isLike,
          }));
    }catch(e){
      print("Error is $e");
    }
    if (indexElement >= 0) {
      favorite[indexElement].isLike = isLike;
    }
    notifyListeners();
  }














  Future<void> updateImage(String id, var imageUrl) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var indexElement = Data.indexWhere((element) => element.id == id);
    print("THE INDEX IS:$indexElement");
    if (indexElement >= 0) {
      Data[indexElement].userImage =imageUrl;

      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "userImage": imageUrl,
          }));
    }
    notifyListeners();
  }



  Future<void> updateGoodsImage(String id, var imageUrl) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods/${id}.json";
    var indexElement = ProductGoods.indexWhere((element) => element.id == id);
    print("THE INDEX IS:$indexElement");
    if (indexElement >= 0) {
      ProductGoods[indexElement].goodsImage =imageUrl;

      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "goodsImage": imageUrl,
          }));
    }
    notifyListeners();
  }


  Future<void> updateServicesImage(String id, var imageUrl) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services/${id}.json";
    var indexElement = ProductServices.indexWhere((element) => element.id == id);
    print("THE INDEX IS:$indexElement");
    if (indexElement >= 0) {
      ProductServices[indexElement].servicesImage =imageUrl;

      var res =await http.patch(Uri.parse(url),
          body: json.encode({
            "servicesImage": imageUrl,
          }));
    }
    notifyListeners();
  }















// حذف عنصر id
  Future<void> delete(String id) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/users/${id}.json";
    var removeIndex = Data.indexWhere((element) => element.id == id);
    try{
      await http.delete(Uri.parse(url));
    }catch(e){
      print("error is $e");
    }
    if (removeIndex >= 0) {
     await Data.removeAt(removeIndex);
    }
    notifyListeners();
  }


  Future<void> deleteGoods(String id) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/goods/${id}.json";
    var removeIndex = await ProductGoods.indexWhere((element) =>
    element.id == id);
    try{
      await http.delete(Uri.parse(url));
    }catch(e){
      print("error is $e");
    }
    if (removeIndex >= 0) {
      await ProductGoods.removeAt(removeIndex);
    }

    notifyListeners();
  }



  Future<void> deleteServices(String id) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/services/${id}.json";
    var removeIndex = ProductServices.indexWhere((element) => element.id == id);
    try{
      await http.delete(Uri.parse(url));
    }catch(e){
      print("error is $e");
    }
    if (removeIndex >= 0) {
     await ProductServices.removeAt(removeIndex);

    }
    notifyListeners();
  }



  Future<void> deleteFavorite(String id) async {
    String url =
        "https://finalproject-7a8cf-default-rtdb.firebaseio.com/favorite/${id}.json";
    var removeIndex = favorite.indexWhere((element) => element.id == id);
    try{
      await http.delete(Uri.parse(url));
    }catch(e){
      print("error is $e");
    }
    if (removeIndex >= 0) {
    await  favorite.removeAt(removeIndex);
    }
    notifyListeners();
  }















  interUserPage(var email) {
    int index = Data.indexWhere((element) => element.email == email);
    if (index > 0) {
      return index;
    }
    notifyListeners();
  }


  Future<void> authFun(String email, String password, String method) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:${method}?key=AIzaSyAryusM14Lu1w90TU61YNGmKFqd3WwIgXM";
    try {
      var res = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      var resData = json.decode(res.body);
      if (resData["error"] != null) throw "${resData["error"]["message"]}";

      notifyListeners();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> signUp(String e, String p) async {
    return authFun(e, p, "signUp");
    notifyListeners();
  }

  Future<void> logIn(String e, String p) async {
    return authFun(e, p, "signInWithPassword");
    notifyListeners();
  }
}
