import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable Common Scaffold
class CommonScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomButton;
  final Color? backgroundColor;
  final bool useSafeArea;

  const CommonScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomButton,
    this.backgroundColor,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar,
      body: useSafeArea ? SafeArea(child: body) : body,
      bottomNavigationBar: bottomButton != null ? bottomButton : null,
    );
  }
}

/// Common App Bar
PreferredSizeWidget commonAppBar({
  required BuildContext context,
  required String title,
  bool showBack = true,
  bool centerTitle = true,
  Color backgroundColor = MyColor.yellowF6F1E1,
  Color iconColor = MyColor.black,
  Color titleColor = MyColor.black,
  double? titleSize,
  double? fontSize,
}) {
  final bool isIpad = MediaQuery.of(context).size.width > 600;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: backgroundColor,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: showBack
        ? IconButton(
      onPressed: () => Navigator.of(context).pop(true),
      icon: Icon(
        CupertinoIcons.back,
        color: iconColor,
        size: isIpad ? 32 : 24,
      ),
      iconSize: isIpad ? 32 : 24,
    )
        : null,
    title: Text(
      title,
      style: mediumTextStyle(
        fontSize: titleSize ?? (isIpad ? 28.0 : 18.0),
        color: titleColor,
      ),
    ),
    centerTitle: centerTitle,
    toolbarHeight: isIpad ? 80 : 56,
    titleSpacing: isIpad ? 20 : 0,
  );
}


/// Common TextField with password toggle support
Widget commonButton({
  required String text,
  required VoidCallback onTap,
  Color backgroundColor = Colors.blue, // default color
  Color textColor = Colors.white,
  double fontSize = 16.0,
  double height = 50,
  double borderRadius = 34,
  bool isTablet = false, // ✅ New parameter for iPad
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: isTablet ? height * 1.3 : height, // ✅ iPad ke liye bada
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          isTablet ? borderRadius * 1.2 : borderRadius, // ✅ iPad ke liye bada border radius
        ),
      ),
      child: Text(
        text,
        style: mediumTextStyle(
          fontSize: isTablet ? fontSize * 1.25 : fontSize, // ✅ iPad ke liye bada font
          color: textColor,
        ),
      ),
    ),
  );
}

Widget commonTextField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  Widget? prefixWidget, // ✅ new
  int? lenght, // ✅ new
  required TextInputAction textInputAction,
  required TextInputType textInputType,
  bool obscureText = false,
  Widget? suffixIcon,
  String? rightLabelText,
  String? errorText,
  void Function(String)? onFieldSubmitted,
  bool readOnly = false,
  void Function()? onTap,
  List<TextInputFormatter>? inputFormatters,
  FocusNode? focusNode,
  bool isTablet = false, // ✅ New parameter for iPad
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: regularTextStyle(
                    fontSize: isTablet ? 18.0 : 15.0,
                    color: MyColor.black),
                children: [
                  TextSpan(text: labelText.replaceAll('*', '')),
                  if (labelText.contains('*'))
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: isTablet ? 18.0 : 15.0),
                    ),
                ],
              ),
            ),
          ),
          if (rightLabelText != null)
            Text(
              rightLabelText,
              style: TextStyle(
                color: Colors.red,
                fontSize: isTablet ? 16.0 : 13.0,
              ),
            ),
        ],
      ),
      SizedBox(height: isTablet ? 5 : 3),
      TextFormField(
        maxLength: lenght,
        buildCounter: (_, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        style: regularTextStyle(
            fontSize: isTablet ? 18.0 : 14.0,
            color: MyColor.black),
        cursorColor: MyColor.black,
        cursorHeight: isTablet ? 22 : 18,
        readOnly: readOnly,
        onTap: onTap,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: regularTextStyle(
              fontSize: isTablet ? 18.0 : 14.0,
              color: MyColor.liteGray),
          // ✅ FIX: Use isTablet check for contentPadding
          contentPadding: EdgeInsets.fromLTRB(
            prefixWidget != null ? (isTablet ? 25 : 20) : (isTablet ? 20 : 15), // Left padding based on prefixWidget
            isTablet ? 20 : 16, // Top padding
            isTablet ? 20 : 15, // Right padding
            isTablet ? 20 : 16, // Bottom padding
          ),
          // ✅ FIX: Conditionally set prefixIcon
          prefixIcon: prefixWidget != null
              ? Padding(
            padding: EdgeInsets.only(
              left: isTablet ? 10 : 8,
              right: isTablet ? 15 : 10,
            ),
            child: prefixWidget,
          )
              : null, // ✅ NULL set karo, not SizedBox()
          prefixIconConstraints: prefixWidget != null
              ? BoxConstraints(
              minWidth: isTablet ? 50 : 40,
              minHeight: 0)
              : null, // ✅ NULL when no prefixWidget
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
            borderSide: BorderSide(
                color: Color(0xFFDCD8E0),
                width: isTablet ? 1.2 : 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
            borderSide: BorderSide(
                color: Color(0xFFDCD8E0),
                width: isTablet ? 1.2 : 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
            borderSide: BorderSide(
                color: MyColor.liteOrange,
                width: isTablet ? 2.0 : 1.5),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    ],
  );
}