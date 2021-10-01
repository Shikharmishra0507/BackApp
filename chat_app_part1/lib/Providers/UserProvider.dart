import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatapppart1/Modules/user.dart';
class UserProvider with ChangeNotifier{

  String? authToken;
  void setToken(String ?token){
    if(token==null){
      authToken=null;
      return ;
    }
    authToken=token;
    notifyListeners();
  }
  Map<String,User>_users={};
  void setBasicUserInfo({String? userId ,String? name,String? age,String? gender}){
    //find this user id if exist then update
    if(_users.containsKey(userId)){
      _users[userId]?.name=name!;
      _users[userId]?.age=age!;
      _users[userId]?.gender=gender!;
    }
    else{
      _users[userId!]=User(
        id:userId,
        name:name!,
        gender: gender!,
        age: age!
      );
    }
    notifyListeners();
    //else enter the data
  }
  Future<void > setUserInfo (String userId,List<String>selectedOptions )async{
    final url=Uri.parse("https://chat-app-fee60-default-rtdb.firebaseio.com/user.json?auth=$authToken");
    try {
      final response=await http.post(url,body:json.encode({

      }));
    }  catch (e) {
      throw e;
    }
  }

}