import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

class DayModel {
  String day;
  Color color;
  bool isMorningSelected;
  bool isNightSelected;

  DayModel({
    required this.day,
    required this.color,
    required this.isMorningSelected,
    required this.isNightSelected,
  });
}

List<DayModel> days = [
  DayModel(day: 'Sunday', color:MyColor.red2, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Monday', color: MyColor.olive, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Tuesday', color: MyColor.pastel, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Wednesday', color:MyColor.deepPurple, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Thursday', color: MyColor.magenta, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Friday', color: MyColor.goldenOrange, isMorningSelected: false, isNightSelected:false),
  DayModel(day: 'Saturday', color:MyColor.aquamarine, isMorningSelected: false, isNightSelected:false),
];