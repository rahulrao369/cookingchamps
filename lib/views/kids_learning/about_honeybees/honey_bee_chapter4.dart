import 'package:cooking_champs/constant/assets_path.dart';
import 'package:flutter/material.dart';

class HoneyBeeChapter4 extends StatefulWidget {
  const HoneyBeeChapter4({super.key});

  @override
  State<HoneyBeeChapter4> createState() => _HoneyBeeChapter4State();
}

class _HoneyBeeChapter4State extends State<HoneyBeeChapter4> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsPath.honeyBeeChapter4,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
