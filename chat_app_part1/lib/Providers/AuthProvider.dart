import 'dart:html';

import 'package:chatapppart1/models/httpException.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  late String? token;
  DateTime? expiryDate;
  late String userId;

  String ? get getUserId{
    if(!isAuth)return null;
    return userId;
  }
  String? get getToken {
    //print("here");
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != null) return token;
    return null;
  }

  bool get isAuth{
    return getToken != null;
  }

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDR7uLU9yKO2xejmqx0OmH-9WR8TAj12IY');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        //even though some other error are not there it is not executing properly
        print("throwing error");
        throw HttpException(responseData['error']['message']);
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (error) {
      // TODO
      throw error;
    }
    notifyListeners();
    //print(response.body);
  }

  Future<void> logIn(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDR7uLU9yKO2xejmqx0OmH-9WR8TAj12IY');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        //even though some other error are not there it is not executing properly
        throw HttpException(responseData['error']['message']);
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
}
