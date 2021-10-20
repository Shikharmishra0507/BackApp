// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

//UserInfo welcomeFromJson(String str) =>UserInfo.fromJson(json.decode(str));
//
//String welcomeToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    required this.statusCode,
    required this.body,
  });

  int statusCode;
  List<Map<String,dynamic>> body;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    statusCode: json["statusCode"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body,
  };
}
