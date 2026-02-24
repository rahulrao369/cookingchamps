import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

class FestivalEventModel {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final Color color;

  FestivalEventModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.color,
  });

  factory FestivalEventModel.fromJson(Map<String, dynamic> json) {
    return FestivalEventModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      color: json['imagePath'] ?? MyColor.purpleNavy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imagePath': imagePath,
    };
  }
}

List<FestivalEventModel> eventsData() {
  return [
    FestivalEventModel(
        title: "INDIA",
        subtitle: "",
        description:
        "Holi is the spring festival, also known as the festival of colours. It is an ancient Hindu religious festival which starts with a Holika bonfire on the night before Holi where people gather, sing and dance.",
        imagePath:AssetsPath.india,
        color:MyColor.purpleNavy
    ),
    FestivalEventModel(
        title: "CHINA",
        subtitle: "Chinese New Year",
        description: "In January Chinese people celebrate Chinese New Year. It is China’s most important day of the year. People celebrate with dragons, fireworks, symbolic clothing, flowers and lanterns.",
        imagePath:AssetsPath.china,
        color:MyColor.purpleNavy
    ),
    FestivalEventModel(
        title: "MEXICO",
        subtitle: "El día de los muertes (The day of the dead)",
        description: "Family and friends get together dress up and paint their faces to pray for and remember people they loved who have died.",
        imagePath:AssetsPath.mexico,
        color:MyColor.color47A7E0
    ),
    FestivalEventModel(
        title: "ITALY",
        subtitle: "Carnival of Venice",
        description: "The tradition of carnival dates back over 900 years. During the carnival, Venice comes alive with masked Venetians and tourists.",
        imagePath:AssetsPath.italy,
        color:MyColor.copperRed
    ),
  FestivalEventModel(
        title: "BRAZIL",
        subtitle: "Rio de Janeiro Carnival",
        description: "The Carnaval in Rio de Janeiro is a world famous festival that began in 1823. Millions of people dress up and dance Samba on the streets for the week before lent.",
        imagePath:AssetsPath.brazil,
        color:MyColor.darkGreen
    ),

    FestivalEventModel(
      title: "NEW YEAR'S EVE",
      subtitle: "",
      description: "All around the Western World at 12 midnight the sky is lit with fireworks to celebrate the arrival of the New Year.",
      imagePath:AssetsPath.newYearEye,
      color:MyColor.black
    ),


    FestivalEventModel(
      title: "BIRTHDAYS",
      subtitle: "",
      description:"To rejoice entering another year, one’s new age is measured in candles that are blown out after we celebrate with the Happy Birthday song.",
      imagePath:AssetsPath.birthday,
        color:MyColor.black
    ),

   FestivalEventModel(
      title: "SPAIN",
      subtitle: "La Tomatina",
      description:"People throw tomatoes at each other just for fun. They say it’s the largest food fight in the world!",
      imagePath:AssetsPath.spain,
        color:MyColor.darkOrange
    ),


    FestivalEventModel(
        title: "JAPAN",
        subtitle: "Children’s Day",
        description:"To celebrate Children’s day Japanese fly hundreds of kites and children dress in traditional costume.",
        imagePath:AssetsPath.japan,
        color:MyColor.color47A7E0
    ),

 FestivalEventModel(
        title: "GERMANY",
        subtitle: "Christmas Markets in Germany",
        description:"On the 25th of December Christians around the world celebrate the birth of Christ with a Christmas tree lit up with festive lights. The Germans introduced the Christmas tree to the world.",
        imagePath:AssetsPath.spain,
        color:MyColor.darkGreen
    ),


    FestivalEventModel(
        title: "RAMADAN",
        subtitle: "",
        description:"Ramadan is the holiest time of year for Muslims around the world. They eat and drink nothing from dawn until sunset. Food and drinks served before dawn is called Suhoor and after sunset is called Iftar.",
        imagePath:AssetsPath.ramadan,
        color:MyColor.color47A7E0
    ),

    FestivalEventModel(
      title: "Jewish Sukkot",
      subtitle: "Christmas Markets in Germany",
      description:
          "Sukkot is celebrated by Jewish people around the world. A Sukkah or temporary house is built by Jewish people for the week of Sukkot. During this celebration all meals are eaten in the temporary house.",
      imagePath:AssetsPath.jewishSukkot,
        color:MyColor.darkGreen
    ),
  ];
}
