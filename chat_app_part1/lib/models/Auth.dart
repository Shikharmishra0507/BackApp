import 'dart:html';

import 'package:chatapppart1/Providers/UserProvider.dart';

import 'UserException.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './UserInfo.dart';

class Auth {

  String? userId;
  String ? get getUserId{
    if(userId==null)return null;
    return userId;
  }



  UserInfo getUserInfo(var jsonMap){
    return UserInfo.fromJson(jsonMap);
  }
   void loggedId(UserInfo users,String mobileno){

    List<Map> listOfMap=users.body;
    for(int i=0;i<users.body.length;i++){
      if(listOfMap[i].containsKey("mobileno")){
        if(listOfMap[i]["mobileno"]==mobileno) {
          userId=listOfMap[i]["id"];
          break;
        }
      }
    }
    return ;
  }
  Future<void> signUp(String mobileNum, String password) async {


    //print(response.body);
  }

  Future<void> logIn(String mobileNum, String password) async {
    //from all users present in there find the one having this mobile number and password
    final url=Uri.parse("url.json");
    try{
      final response=await http.get(url);
        UserInfo user=getUserInfo(json.decode(response.body));
        loggedId(user,mobileNum);
        if(userId==null){
          throw UserException("Invalid User");
        }
    }
    on UserException {
        throw "Invalid User";
    }
    catch(error){
      rethrow;
    }



  }
}

