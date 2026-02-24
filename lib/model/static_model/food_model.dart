import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

class FoodModel {
  final String name;
  final String imagePath;
  bool isBitter;
  bool isSour;
  bool isSweet;
  bool isSalty;
  bool isSight;
  bool isSmell;
  bool isTaste;
  bool isTouch;
  bool isHearing;
  bool isCorrect; // New property to track correctness

  FoodModel({
    required this.name,
    required this.imagePath,
    this.isBitter = false,
    this.isSour = false,
    this.isSweet = false,
    this.isSalty = false,
    this.isSight = false,
    this.isSmell = false,
    this.isTaste = false,
    this.isTouch = false,
    this.isHearing = false,
    this.isCorrect = false,
  });

  bool isSelectedTaste(String tasteName) {
    switch (tasteName.toLowerCase()) {
      case 'bitter':
        return isBitter;
      case 'sour':
        return isSour;
      case 'sweet':
        return isSweet;
      case 'salty':
        return isSalty;
      case 'sight':
        return isSight;
      case 'smell':
        return isSmell;
      case 'taste':
        return isTaste;
      case 'touch':
        return isTouch;
      case 'hearing':
        return isHearing;
      default:
        return false;
    }
  }
  void setTaste(String tasteName) {
    isBitter = tasteName == 'isBitter';
    isSour = tasteName == 'isSour';
    isSweet = tasteName == 'isSweet';
    isSalty = tasteName == 'isSalty';
    isSight = tasteName == 'isSight';
    isSmell = tasteName == 'isSmell';
    isTaste = tasteName == 'isTaste';
    isTouch = tasteName == 'isTouch';
    isHearing = tasteName == 'isHearing';
  }
}

class TasteModel {
  String name; // Name of the taste or sense (e.g., "Bitter", "Sour", "Sweet")
  bool isSelected; // Whether this taste or sense is selected for a food item
  Color displayColor; // The color associated with this taste or sense

  TasteModel({
    required this.name,
    this.isSelected = false,
    required this.displayColor,
  });
}
List<TasteModel> tastesList(){
  return [
    TasteModel(name: "Bitter", displayColor: MyColor.sky),
    TasteModel(name: "Sour", displayColor: MyColor.pink),
    TasteModel(name: "Sweet", displayColor: MyColor.purple),
    TasteModel(name: "Salty", displayColor: MyColor.sky),
    TasteModel(name: "Sight", displayColor: MyColor.darkGreen),
    TasteModel(name: "Smell", displayColor: MyColor.darkOrange),
    TasteModel(name: "Taste", displayColor: MyColor.darkSky),
    TasteModel(name: "Touch", displayColor: MyColor.liteGray),
    TasteModel(name: "Hearing", displayColor: MyColor.brownColor),
  ];
}


 List<FoodModel> foodModels(){
  return  [
    FoodModel(name: 'Lemon', imagePath:AssetsPath.lemon),
    FoodModel(name: 'Honey', imagePath:AssetsPath.honey),
    FoodModel(name: 'Orange', imagePath:AssetsPath.orange),
    FoodModel(name: 'Apple', imagePath:AssetsPath.apple),
    FoodModel(name: 'Milk', imagePath:AssetsPath.milk),
    FoodModel(name: 'Banana', imagePath:AssetsPath.banana),
    FoodModel(name: 'Chocolate', imagePath:AssetsPath.chocolate),
  ];
 }