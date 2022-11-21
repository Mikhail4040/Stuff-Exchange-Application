class UserData{
  var id;
  var email;
  var password;
  var firstName;
  var lastName;
  var phoneNumber;
  var city;
  var isDarkMode;
  var userImage;

   UserData({
    this.id, this.email,this.password,this.firstName,this.lastName,this.phoneNumber,this.city,this.isDarkMode,this.userImage
});

}


class Goods{
  var id;
  var userId;
  var phoneNumber;
  var email;
  var fans;
  var goodsName;
  var goodsType;
  var description;
  var switchTo;
  var price;
  var goodsImage;
  var goodsHistory;
  Goods({
        required this.id,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.goodsType,
    required this.goodsName,
    required this.description,
    required this.price,
    required this.switchTo,
    required this.goodsHistory,
    required this.fans,
    required this.goodsImage,

  });
}


class Services{
  var id;
  var userId;
  var phoneNumber;
  var email;
  var fans;
  var serviceType;
  var servicesName;
  var description;
  var switchTo;
  var price;
  var servicesImage;
  var servicesHistory;
  Services({
    required this.id,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.serviceType,
    required this.servicesName,
    required this.description,
    required this.price,
    required this.switchTo,
    required this.servicesHistory,
    required this.fans,
    required this.servicesImage,

  });
}

class Favorite{
 var id;
 var userId;
 var productId;
 var isLike;
 Favorite({required this.id,required this.userId,required this.productId,required this.isLike});
}











