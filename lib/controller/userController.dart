import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/model/OrderItemsModel.dart';
import 'package:saffi/model/OredersModel.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/model/resetPasswordModel.dart';
import 'package:saffi/model/userModel.dart';
import 'package:saffi/repo/NetworkUtlis.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:saffi/ui/Pages/intro/splash_screen.dart';
import 'package:saffi/ui/widget/custom_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class UserController extends ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  UserModel userModel;
  CustomAlert _alert = CustomAlert();
  SharedPreferences _prefs;
  List<ProductDatum> userCart = [];
  List<OrderItemsModel> orderItems = [];
  List<ProductDatum> wishList = [];
  List<OrderModel> userOrders = [];
  double totalcart = 0;
  bool loaging = false;
  // login
  Future<bool> login(BuildContext context,
      {String email, String password}) async {
    FormData _formData = FormData.fromMap({
      "email": email,
      "password": password,
      "device_token": firebaseMessaging,
    });
    Response response = await _util.post("login.php", body: _formData);

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      return false;
    } else {
      userModel = UserModel.fromJson(json.decode(response.data));
      notifyListeners();
      if (userModel.message == "login success") {
        print("login success");
        await storeUserData(response.data);
        _alert.toast(context: context, title: "${userModel.message}");
        getUserCart(context);
        return true;
      } else {
        print("error Data");
        _alert.showCustomDialog(
          btnMsg: "اعادة المحاولة",
          context: context,
          msg: "${userModel.message}",
          onClick: () => Navigator.pop(context),
        );
        return false;
      }
    }
  }

  Future<bool> reset(BuildContext context, {String email}) async {
    FormData _formData = FormData.fromMap({
      "email": email,
    });
    Response response =
        await _util.post("forgot_my_password.php", body: _formData);
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      return false;
    } else {
      if (json.decode(response.data)["success"] != null) {
        print("login success");
        _alert.toast(
            context: context,
            title: "${json.decode(response.data)["success"]}");
        notifyListeners();
        return true;
      } else {
        print("error Data");
        _alert.showCustomDialog(
          btnMsg: "اعادة المحاولة",
          context: context,
          msg: "${json.decode(response.data)["errors"][0]}",
          onClick: () => Navigator.pop(context),
        );
        return false;
      }
    }
  }

  // register
  Future<bool> register(BuildContext context,
      {String email, String name, String phone, String password}) async {
    FormData _formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    });
    Response response = await _util.post("register.php", body: _formData);
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      return false;
    } else {
      userModel = UserModel.fromJson(json.decode(response.data));
      notifyListeners();
      if (userModel.message == "succesfully register") {
        print("succesfully register");
        // storeUserData(response.data);
        _alert.toast(context: context, title: "${userModel.message}");
        return true;
      } else {
        print("error Data");
        _alert.showCustomDialog(
          btnMsg: "اعادة المحاولة",
          context: context,
          msg: "${userModel.message}",
          onClick: () => Navigator.pop(context),
        );
        return false;
      }
    }
  }

  // edit user data
  Future<bool> editUserData(BuildContext context,
      {String email, String name, String phone, String password}) async {
    FormData _formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    });
    Map<String, String> headers = {
      "Authorization": userModel.token,
    };
    Response response =
        await _util.post("edit_account.php", body: _formData, headers: headers);
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      return false;
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print(json.decode(response.data)["massage"]);
      userModel.user.email = email;
      userModel.user.phone = phone;
      userModel.user.name = name;
      String data = json.encode(userModel.toJson());
      storeUserData(data);
      _alert.toast(
          context: context, title: "${json.decode(response.data)["message"]}");
      return true;
    }
  }

  Future<bool> editUserPassword(BuildContext context,
      {String newPassword, String confirmPass, String oldPassword}) async {
    loaging = true;
    notifyListeners();
    EditPasswordModel _model;
    FormData _formData = FormData.fromMap({
      "new_pass": newPassword,
      "confirm_new_pass": confirmPass,
      "old_pass": oldPassword,
    });
    Map<String, String> headers = {
      "Authorization": userModel.token,
    };
    Response response = await _util.post("edit_password.php",
        body: _formData, headers: headers);

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loaging = false;
      notifyListeners();
      return false;
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      _model = EditPasswordModel.fromJson(json.decode(response.data));
      if (_model.message != null) {
        _alert.toast(context: context, title: _model.message);
        loaging = false;
        notifyListeners();
        return true;
      } else {
        loaging = false;
        notifyListeners();
        _alert.showCustomDialog(
          btnMsg: "try again",
          context: context,
          msg: _model.errors.first,
          onClick: () => Navigator.pop(context),
        );
        return false;
      }
    }
  }

//
  // add to cart
  Future<bool> addToCart(BuildContext context,
      {ProductDatum item, @required double qtp}) async {
    FormData _formData = FormData.fromMap({
      "product_id": item.id,
      "product_name": item.name,
      "qty": qtp,
      "price": item.dicount ?? item.price,
      "unit": item.unite ?? "",
    });
    print(userModel.token);
    Map<String, String> headers = {
      "Authorization": userModel.token,
    };
    // print(item.name + item.unite);
    Response response = await _util.post("add_to_my_cart.php",
        body: _formData, headers: headers);
    if (response == null) {
      print("chack your conection");
      _alert.networckDialog(context);
      return false;
    } else if (response.statusCode == 401) {
      Timer(Duration(seconds: 3), () {
        logout(context);
      });

      return false;
    } else {
      print(
          "${json.decode(response.data)["message"]} ${json.decode(response.data)["errors"]}");

      if (json.decode(response.data)["message"] != null) {
        if (json.decode(response.data)["message"] ==
            "access denied wrong access token") {
          // _alert.showOptionDialog(
          //     btnMsg: "تسجيل الدخول",
          //     cancel: "متابعة التسوق",
          //     context: context,
          //     msg: "يجب تسجيل الدخول حتي تتمكن من الاضافة للعربة",
          //     onCancel: () => Navigator.pop(context),
          //     onClick: () => push(context, LoginPage()));
          return false;
        } else {
          // Timer(Duration(seconds: 2), () {
          //   _alert.toast(
          //       context: context,
          //       title: "${json.decode(response.data)["message"]}");
          // });

          getUserCart(context);
          return true;
        }
      }
      notifyListeners();
      return false;
    }
  }

//https://safi.fahita.store/api/minus_cart.php?id=238
  //remove from cart
  delFromCart(BuildContext context, {ProductDatum item}) async {
    FormData _formData = FormData.fromMap({
      "id": item.idCart,
    });
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };
    Response response = await _util.post(
        // "del_from_my_cart.php?id=${item.idCart}",
        "minus_cart.php?id=${item.idCart}",
        body: _formData,
        headers: headers);
    if (response == null) {
      print("chack your conection");
      _alert.networckDialog(context);
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print(
          "${json.decode(response.data)["message"]} ${json.decode(response.data)["errors"]}");
      _alert.toast(
          context: context, title: "${json.decode(response.data)["message"]}");
      getUserCart(context);

      notifyListeners();
    }
  }

  //get userCart
  getUserCart(BuildContext context) async {
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };
    print("tokeb =================>  ${userModel.token}");
    Response response = await _util.get(
      "my_cart.php",
      headers: headers,
    );

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print("getCartSucc");

      try {
        // userCart = List<ProductsModel>.from(
        //     json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
        ProductsModel _model =
            ProductsModel.fromJson(json.decode(response.data));
        if (_model.data != null) {
          userCart = _model.data;
        } else {
          userCart = [];
        }
        // totalcart = 0;
        // for (int i = 0; i < userCart.length; i++) {
        //   totalcart = double.parse(userCart[i].total) + totalcart;
        // }
        totalcart = 0;
        for (int i = 0; i < userCart.length; i++) {
          totalcart = (double.parse(userCart[i].price) *
                  double.parse(userCart[i].qtp)) +
              totalcart;
        }
        notifyListeners();
      } catch (e) {
        userCart.clear();
        notifyListeners();
      }
    }
  }

  //get user Order
  getUserOrders(BuildContext context) async {
    loaging = true;
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };

    Response response = await _util.get(
      "my_orders.php",
      headers: headers,
    );

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loaging = false;

      notifyListeners();
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print("get user Order succ");

      try {
        userOrders = List<OrderModel>.from(
            json.decode(response.data).map((x) => OrderModel.fromJson(x)));
        loaging = false;
        notifyListeners();
      } catch (e) {
        userOrders.clear();
        loaging = false;
        notifyListeners();
      }
    }
  }

  double totalOrderItems = 0;
  // get order Items
  getorderItems(BuildContext context, String orderID) async {
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };

    Response response = await _util.get(
      "my_order_items.php?order_id=$orderID",
      headers: headers,
    );

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);

      notifyListeners();
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print("get Order items succ");

      try {
        orderItems = List<OrderItemsModel>.from(
            json.decode(response.data).map((x) => OrderItemsModel.fromJson(x)));

        totalOrderItems = 0;
        for (int i = 0; i < orderItems.length; i++) {
          totalOrderItems = int.parse(orderItems[i].total) + totalOrderItems;
        }
        notifyListeners();
      } catch (e) {
        userOrders.clear();
        notifyListeners();
      }
    }
  }

  // wish List
  wishListController(BuildContext context, ProductDatum item) async {
    _prefs = await SharedPreferences.getInstance();
    if (wishList.any((e) => e.id == item.id) != true) {
      wishList.add(item);
      notifyListeners();
    } else {
      wishList.remove(item);
      notifyListeners();
    }

    List<String> spWishList =
        wishList.map((item) => json.encode(item.toJson())).toList();
    print(spWishList);
    _prefs.setStringList("wishList", spWishList);
    // wishList.clear();
    // notifyListeners();
  }

  // Storge User Data
  storeUserData(String data) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString("userData", data);
  }

  // Get Storge User Date
  Future<bool> getUserData(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String userData = _prefs.getString("userData");
    List wishData = _prefs.getStringList("wishList");

    if (userData != null) {
      userModel = UserModel.fromJson(json.decode(userData));
      print(userData);
      print("wishList : $wishData");
      if (wishData != null) {
        // wishList = List<ProductsModel>.from(
        //     json.decode(wishData).map((x) => ProductsModel.fromJson(x)));
        wishList = wishData
            .map((item) => ProductDatum.fromJson(json.decode(item)))
            .toList();
        notifyListeners();
      }
      getUserCart(context);
      deviceToken();
      notifyListeners();
      return true;
    } else {
      if (wishData != null) {
        // wishList = List<ProductsModel>.from(
        //     json.decode(wishData).map((x) => ProductsModel.fromJson(x)));
        wishList = wishData
            .map((item) => ProductDatum.fromJson(json.decode(item)))
            .toList();
        notifyListeners();
      }
      userModel = null;
      return false;
    }
  }

  //logout
  logout(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove("userData");
    push(context, SplashScreen());
  }

  // increase points
  increasePoints(BuildContext context, {int points}) async {
    Map<String, String> headers = {
      "Authorization": userModel.token,
    };
    Response response = await _util
        .post("increase_user_points.php?points=$points", headers: headers);
    if (response == null) {
      print("chack your conection");
      _alert.networckDialog(context);
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print(
          "${json.decode(response.data)["message"]} ${json.decode(response.data)["errors"]}");
      _alert.toast(
          context: context, title: "${json.decode(response.data)["message"]}");
      if (json.decode(response.data)["message"] ==
          "points increased successfuly") {
        int newPoints = int.parse(userModel.user.points) + points;
        userModel.user.points = newPoints.toString();
        print("user points :" + userModel.user.points);
        notifyListeners();
        String data = json.encode(userModel.toJson());
        storeUserData(data);
      }
      notifyListeners();
    }
  }

  // check out
  Future<bool> checkOut(BuildContext context,
      {String city,
      String zoon,
      String street,
      String build,
      String storey,
      String from,
      String to,
      @required String id,
      @required int type}) async {
    FormData _formData = FormData.fromMap({
      "city": city,
      "zone": zoon,
      "street": street,
      "build": build,
      "storey": storey,
      "time_from": from,
      "time_to": to,
    });
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };
    Response response = await _util.post(
        type == 0 ? "checkout.php" : "checkout_points.php?product_id=$id",
        headers: headers,
        body: _formData);
    if (response == null) {
      print("chack your conection");
      _alert.networckDialog(context);
      return false;
    } else if (response.statusCode == 401) {
      logout(context);
      return false;
    } else {
      print(
          "${json.decode(response.data)["message"]} ${json.decode(response.data)["errors"]}");

      if (json.decode(response.data)["message"] == "تم انشاء الطلب بنجاح") {
        _alert.toast(context: context, title: "order sucssessflly");
        userCart = [];
        notifyListeners();
        return true;
      } else {
        _alert.toast(context: context, title: "Plase tray again liter");

        return false;
      }
    }
  }

  Future<bool> addreat(BuildContext context, String productID, String comment,
      String rate) async {
    loaging = true;
    notifyListeners();
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
    };
    FormData body = FormData.fromMap(
        {"product_id": productID, "comment": comment, "rate": rate});
    Response response = await _util.post("add_comment_on_product.php",
        body: body, headers: headers);
    if (response == null) {
      _alert.networckDialog(context);
      loaging = false;
      return false;
    } else {
      if (response.statusCode == 200) {
        _alert.toast(context: context, title: "تم الاضافة بنجاح");
        Provider.of<MainController>(context, listen: false)
            .getRate(context, productID);
        notifyListeners();
        loaging = false;
        return true;
      } else if (response.statusCode == 401) {
        _alert.showCustomDialog(
          context: context,
          msg: "يجب تسجيل الدخول لتتمكن من اضافة ريت",
          btnMsg: "تسجيل الدخول",
          onClick: () => push(context, pushReplacement(context, LoginPage())),
        );
        notifyListeners();
        loaging = false;
        return false;
      } else {
        _alert.toast(context: context, title: "حدث حطا");
        loaging = false;
        return false;
      }
    }
  }

  deviceToken() async {
    Map<String, String> headers = {
      "Authorization": userModel == null ? null : userModel.token,
      "Accept": "application/json"
    };
    FormData body = FormData.fromMap({"token": firebaseMessaging});
    Response response =
        await _util.post("add_edit_token.php", body: body, headers: headers);

    print("response ========== >>>>> ${response.data}");
  }
}
