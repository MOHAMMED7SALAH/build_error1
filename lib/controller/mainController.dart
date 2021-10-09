import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:saffi/model/categorisModel.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/model/rateModel.dart';
import 'package:saffi/model/subCategoryModel.dart';
import 'package:saffi/repo/NetworkUtlis.dart';
import 'package:saffi/ui/widget/custom_alert.dart';

class MainController extends ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  List<CategoriesModel> categoriesList = [];
  List<CategoriesModel> sliderList = [];
  List<ProductDatum> productsList = [];
  List<ProductDatum> productsPointList = [];
  List<ProductDatum> featuredProducts = [];
  List<ProductDatum> searchList = [];
  List<ProductDatum> similerProducts = [];

  CustomAlert _alert = CustomAlert();
  bool loading = false;

  // start applecation
  init(BuildContext context) async {
    loading = true;
    await getCategories(context);
    await getSliders(context);
    await getProductsByPoints(context);
    await getFeaturedProducts(context);
    loading = false;
    notifyListeners();
  }

  //get categoris
  getCategories(BuildContext context) async {
    loading = true;
    Response response = await _util.get("get_categories.php");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
    } else {
      print("getCategoriesSucsses");
      categoriesList = List<CategoriesModel>.from(
          json.decode(response.data).map((x) => CategoriesModel.fromJson(x)));
      notifyListeners();
    }
  }

  // get Sliders
  getSliders(BuildContext context) async {
    loading = true;
    Response response = await _util.get("get_banners.php");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
    } else {
      print("getCategoriesSucsses");
      sliderList = List<CategoriesModel>.from(
          json.decode(response.data).map((x) => CategoriesModel.fromJson(x)));
      notifyListeners();
    }
  }

  List<SubCategoryModel> subCategory = [];
  // get subCategory
  bool loadingSubCat = false;
  Future<List<SubCategoryModel>> getSubCategory(
      BuildContext context, String id) async {
    loadingSubCat = true;
    // notifyListeners();
    Response response =
        await _util.get("get_sub_categories.php?category_id=$id");

    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loadingSubCat = false;
      notifyListeners();
      return null;
    } else {
      // if (json.decode(response.data).runtimeType != List) {
      //   print(
      //       "msg ============ >>>>> ${json.decode(response.data).runtimeType}");
      //   return null;
      // }
      print("getCategoriesSucsses");
      subCategory = subCategoryModelFromJson(response.data);
      loadingSubCat = false;
      notifyListeners();
      return subCategory;
    }
  }

  // get products
  Future<ProductsModel> getProducts(
      BuildContext context, String categoryId) async {
    productsList = [];
    // if (categoryId == "58") {
    //   categoryId = "37";
    // } else {
    //   categoryId = "40";
    // }
    // loading = true;
    Response response = await _util
        .get("get_products_by_sub_category.php?sub_category=$categoryId");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      // loading = false;
      return null;
    } else {
      print("get products Succ");
      ProductsModel _model = ProductsModel.fromJson(json.decode(response.data));
      if (_model.data != null) {
        productsList = _model.data;
      } else {
        productsList = [];
      }

      // try {
      //   productsList = List<ProductsModel>.from(
      //       json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
      // } catch (e) {
      //   return null;
      // }

      // productsList.forEach((element) {
      //   print(Provider.of<UserController>(context, listen: false)
      //       .userCart
      //       .indexWhere((e) => e.name == element.name));

      // });
      // loading = false;
      return _model;
    }
  }

  //  searchOutput
  searchOutput(BuildContext context, {String search}) async {
    searchList = [];
    notifyListeners();
    FormData _formData = FormData.fromMap({
      "search": search,
    });
    loading = true;
    notifyListeners();
    Response response =
        await _util.post("search_products.php", body: _formData);
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loading = false;
      notifyListeners();
    } else {
      ProductsModel _model = ProductsModel.fromJson(json.decode(response.data));
      if (_model.data != null) {
        searchList = _model.data;
      } else {
        searchList = [];
      }
      print("get products Succ");
      // try {
      //   searchList = List<ProductsModel>.from(
      //       json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
      // } catch (e) {
      //   searchList = [];
      // }

      loading = false;
      notifyListeners();
    }
  }

  // products by points
  getProductsByPoints(BuildContext context) async {
    Response response = await _util.get("get_points_products.php");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loading = false;
      notifyListeners();
    } else {
      // try {
      //   print("get products point Succ");
      //   productsPointList = List<ProductsModel>.from(
      //       json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
      // } catch (e) {
      //   productsPointList.isEmpty;
      // }
      ProductsModel _model = ProductsModel.fromJson(json.decode(response.data));
      if (_model.data != null) {
        productsPointList = _model.data;
      } else {
        productsPointList = [];
      }

      loading = false;
      notifyListeners();
    }
  }

  // get featured products

  getFeaturedProducts(BuildContext context) async {
    Response response = await _util.get("get_featured_products.php");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loading = false;
      notifyListeners();
    } else {
      // try {
      //   print("get products point Succ");
      //   featuredProducts = List<ProductsModel>.from(
      //       json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
      // } catch (e) {
      //   featuredProducts.isEmpty;
      // }
      ProductsModel _model = ProductsModel.fromJson(json.decode(response.data));
      if (_model.data != null) {
        featuredProducts = _model.data;
      } else {
        featuredProducts = [];
      }

      loading = false;
      notifyListeners();
    }
  }

  simillerProducts(BuildContext context, String productID) async {
    loading = true;
    Response response = await _util.get("related_products.php?id=$productID");
    if (response == null) {
      print("no conection");
      _alert.networckDialog(context);
      loading = false;
      notifyListeners();
    } else {
      // try {
      //   print("get products point Succ");
      //   similerProducts = List<ProductsModel>.from(
      //       json.decode(response.data).map((x) => ProductsModel.fromJson(x)));
      // } catch (e) {
      //   featuredProducts.isEmpty;
      // }

      ProductsModel _model = ProductsModel.fromJson(json.decode(response.data));
      if (_model.data != null) {
        similerProducts = _model.data;
      } else {
        similerProducts = [];
      }

      loading = false;
      notifyListeners();
    }
  }

  List<RateModel> rate = [];
  getRate(BuildContext context, String productId) async {
    loading = true;
    Response response =
        await _util.post("get_product_comments.php?id=$productId");

    if (response == null) {
      _alert.networckDialog(context);
      notifyListeners();
    } else {
      try {
        rate = List<RateModel>.from(
            json.decode(response.data).map((x) => RateModel.fromJson(x)));
        loading = false;
        notifyListeners();
      } catch (e) {
        print(e);
        _alert.toast(context: context, title: "حدث خطا");
        loading = false;
        notifyListeners();
      }
    }
  }
}
