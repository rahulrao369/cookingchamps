import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

class MatchingModel{
  String rule;
  String answer;
  MatchingModel(this.rule, this.answer);
}

class MatchTheFollowingModel{
  String title;
  String img;
  String answer;
  String? name;
  Color color;

  MatchTheFollowingModel(this.title, this.img, this.answer, this.color,{this.name});
}

List<MatchTheFollowingModel> items (){
  return [
    MatchTheFollowingModel("Sight", AssetsPath.lookImg4,"Taste",MyColor.red1),
    MatchTheFollowingModel("Smell", AssetsPath.lookImg5,"Hearing",MyColor.red1),
    MatchTheFollowingModel("Hearing", AssetsPath.lookImg1,"Sight",MyColor.red1),
    MatchTheFollowingModel("Taste", AssetsPath.lookImg2,"Smell",MyColor.red1),
    MatchTheFollowingModel("Touch", AssetsPath.lookImg3,"Touch",MyColor.red1),
  ];
}

List<MatchTheFollowingModel> nuts (){
  return [
    MatchTheFollowingModel('Walnut',AssetsPath.cashewImg,'Cashew',MyColor.copperRed),
    MatchTheFollowingModel('Almond',AssetsPath.walnutImg,'Walnut',MyColor.copperRed),
    MatchTheFollowingModel('Pine nut',AssetsPath.pistachioImg,'Pistachio',MyColor.copperRed),
    MatchTheFollowingModel('Pistachio',AssetsPath.almondImg,"Almond",MyColor.copperRed),
    MatchTheFollowingModel('Cashew',AssetsPath.hazelNut,'Hazelnut',MyColor.copperRed),
    MatchTheFollowingModel( 'Hazelnut',AssetsPath.pineNutImg,'Pine nut',MyColor.copperRed),
  ];
}