import 'package:flutter/material.dart';
class OptionProvider with ChangeNotifier{
  int? optionId;
  String? optionTitle;
  bool? isSelected;
  int? marks;
  OptionProvider({this.optionId,this.isSelected,this.marks,this.optionTitle});
}