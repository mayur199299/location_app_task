import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();

  factory LocalStorage() {
    return instance;
  }

  LocalStorage._internal();

  SharedPreferences? _preferencesInstance;
  final String _verificationToken = "verificationToken";
  final String _firstName = "firstName";
  final String _lastName = "lastName";
  final String _email = "email";
  final String _phone = "phone";
  final String _userRole = 'userRole';
  final String _productName = 'productName';
  final String _productCount = 'productCount';
  final String _productPrice = 'productPrice';
  final String _productBrand = 'productBrand';
  final String _productDesc = 'productDesc';
  final String _productMedia = 'productMedia';
  final String _productId = 'productId';
  final String _orderId = 'orderId';
  final String _orderItemId = 'orderItemId';

  SharedPreferences get prefs {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  //VerificationToken
  Future<bool> setVerificationToken(String? s) async {
    return prefs.setString(_verificationToken, s ?? "");
  }

  String getVerificationToken() {
    String stringValue = prefs.getString(_verificationToken) ?? "";
    return stringValue;
  }
  String getProductName() {
    String stringValue = prefs.getString(_productName) ?? "";
    return stringValue;
  }
  String getProductCount() {
    String stringValue = prefs.getString(_productCount) ?? "";
    return stringValue;
  }
  String getProductPrice() {
    String stringValue = prefs.getString(_productPrice) ?? "";
    return stringValue;
  }
  String getProductBrand() {
    String stringValue = prefs.getString(_productBrand) ?? "";
    return stringValue;
  }
  String getProductDesc() {
    String stringValue = prefs.getString(_productDesc) ?? "";
    return stringValue;
  }
  String getProductId() {
    String stringValue = prefs.getString(_productId) ?? "";
    return stringValue;
  }
  List<String> getProductMedia() {
    String jsonString = prefs.getString(_productMedia) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.cast<String>();
  }
  // void updateProductMedia(List<String> updatedImageUrls) {
  //   prefs.setStringList('productMedia', updatedImageUrls);
  // }
  String getUserFirstName() {
    String stringValue = prefs.getString(_firstName) ?? "";
    return stringValue;
  }
  String getUserLastName() {
    String stringValue = prefs.getString(_lastName) ?? "";
    return stringValue;
  }
  String getUserEmail() {
    String stringValue = prefs.getString(_email) ?? "";
    return stringValue;
  }
  String getUserPhone() {
    String stringValue = prefs.getString(_phone) ?? "";
    return stringValue;
  }
  String getOrderId() {
    String stringValue = prefs.getString(_orderId) ?? "";
    return stringValue;
  }
  String getOrderItemId() {
    String stringValue = prefs.getString(_orderItemId) ?? "";
    return stringValue;
  }


  Future<bool> setUserFirstName(String? s) async {
    return prefs.setString(_firstName, s ?? "");
  }
  Future<bool> setUserLastName(String? s) async {
    return prefs.setString(_lastName, s ?? "");
  }
  Future<bool> setUserEmail(String? s) async {
    return prefs.setString(_email, s ?? "");
  }
  Future<bool> setUserPhone(String? s) async {
    return prefs.setString(_phone, s ?? "");
  }
  Future<bool> setProductName(String? s) async {
    return prefs.setString(_productName, s ?? "");
  }
  Future<bool> setProductCount(String? s) async {
    return prefs.setString(_productCount, s ?? "");
  }
  Future<bool> setProductPrice(String? s) async {
    return prefs.setString(_productPrice, s ?? "");
  }
  Future<bool> setProductBrand(String? s) async {
    return prefs.setString(_productBrand, s ?? "");
  }
  Future<bool> setProductDesc(String? s) async {
    return prefs.setString(_productDesc, s ?? "");
  }
  Future<bool> setProductId(String? s) async {
    return prefs.setString(_productId, s ?? "");
  }
  Future<bool> setOrderId(String? s) async {
    return prefs.setString(_orderId, s ?? "");
  }
  Future<bool> setOrderItemId(String? s) async {
    return prefs.setString(_orderItemId, s ?? "");
  }
  Future<bool> setProductMedia(List<String> images) async {
    String jsonString = jsonEncode(images);
    return prefs.setString(_productMedia, jsonString);
  }

  Future<bool> setUserRole(int? role) async {
    if (role == null || (role != 1 && role != 2)) {
      throw ArgumentError('User role must be 1 or 2');
    }
    return prefs.setInt(_userRole, role);
  }


  int? getUserRole() {
    int? role = prefs.getInt(_userRole);
    return role == 1 || role == 2 ? role : null;
  }

  clearData() async {
    return prefs.clear();
  }
}
