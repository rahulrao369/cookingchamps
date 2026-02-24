import 'package:flutter/material.dart';

lightTextStyle(
    {required fontSize, required color, latterSpace, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      letterSpacing: 0.2,
      height: 1.5,
      overflow: overflow,
      fontWeight: FontWeight.w300,
      fontFamily: 'bevitamin');
}

regularNormalTextStyle(
    {required fontSize, required color, latterSpace, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      letterSpacing: 0.4,
      height: 1.5,
      fontWeight: FontWeight.w300,
      fontFamily:'bevitamin');
}

regularNormalTextStyleWithoutHeight(
    {required fontSize, required color, latterSpace, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w300,
      fontFamily: 'bevitamin');
}

regularTextStyle({required fontSize, required color, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      letterSpacing: 0.2,
      height: 1.4,
      fontWeight: FontWeight.w400,
      fontFamily: 'bevitamin');
}

mediumTextStyle({required fontSize,  color, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      height: 1.5,
      fontFamily: 'bevitamin');
}

semiBoldTextStyle({required fontSize, required color, height, overflow}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
      height: 1.5,
      fontFamily: 'bevitamin');
}

boldTextStyle(
    {required fontSize, required color, height, latterSpace, overflow}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
    fontWeight: FontWeight.w700,
    fontFamily: 'bevitamin',
    letterSpacing: 0.2,
    height: 1.5,
    //   letterSpacing: latterSpace,
  );
}

boldMaxLiseTextStyle(
    {required fontSize, required color, height, latterSpace, var overflow}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
    fontWeight: FontWeight.w700,
    fontFamily:'bevitamin',
    letterSpacing: 0.2,
    height: 1.5,
    // letterSpacing: latterSpace
  );
}

appBarTextStyle({fontSize, required color, height}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
      height: height,
      fontFamily: 'bevitamin');
}

///...........
class DefaultText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const DefaultText({
    super.key,
    required this.title,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
      ),
    );
  }
}
