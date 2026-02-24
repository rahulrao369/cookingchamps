import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  String btnName;
  Color bgColor;
  Color borderColor;
  double height;
  double bwidth;
  GestureTapCallback onTap;
  double radius;
  double elevation;
  double borderWidth;
  TextStyle style;

  GlobalButton(
      this.btnName,
      this.bgColor,
      this.borderColor,
      this.height,
      this.bwidth,
      this.onTap,
      this.radius,
      this.elevation,
      this.borderWidth,
      this.style, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    final double responsiveHeight = isTablet ? height * 1.3 : height;

    return SizedBox(
      width: double.infinity, // ✅ Always full width
      height: responsiveHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: elevation,
          overlayColor: MyColor.liteOrange,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
        ),
        onPressed: onTap,
        child: Text(btnName, style: style),
      ),
    );
  }
}
