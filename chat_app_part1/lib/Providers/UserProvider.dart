import 'package:flutter/material.dart';
import '../models/UserInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Question.dart';
class User {
  String id;
  String mobileNum;
  String password;
  String name;
  String gender;
  String age;
  int totMarks = 0;
  Map<String, int> selectedOptions = {};

  //map which directs question id ->option 1,2,3,4
  User({required this.mobileNum,required this.password ,required this.id, required this.age,
    required this.gender, required this.name});


}

class UserProvider with ChangeNotifier {
 // String? authToken;
  User _currentUser=User(name: "",age: "",gender: "",id: "",mobileNum: "",password: "");

//  void setToken(String? token) {
//    if (token == null) {
//      authToken = null;
//      return;
//    }
//    authToken = token;
//    notifyListeners();
//  }

  User get getUser{
    return _currentUser;
  }
  void setUserInfo(UserInfo info){
    _currentUser.mobileNum=info.body
    notifyListeners();
  }
}
