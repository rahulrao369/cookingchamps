import 'dart:async';

import 'package:cooking_champs/my_orders/my_orders_new.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/new_ui/kid_profile_new.dart';
import 'package:cooking_champs/new_ui/register_new/who_joining_new.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:flutter/material.dart';

import 'login_new_view.dart';
import 'register_new/register_new_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), checkLogin);
  }

  checkLogin() async {
    var isLogin = await PreferencesServices.getPreferencesData(PreferencesServices.isLogin);
    var whoisLogin = await PreferencesServices.getPreferencesData(PreferencesServices.whoIsLogin) ?? false;
print("sdkbfdskjfsdjfhbkdskfsdfbjkds${PreferencesServices.getPreferencesData(PreferencesServices.whoIsLogin)}");
    if (isLogin == true) {
      if (mounted) {
        if (whoisLogin == false) {
          CustomNavigators.pushRemoveUntil(WelcomeCookingChampsView(), context);
        } else {
          CustomNavigators.pushRemoveUntil(DashBoardView(pageIndex: 0), context);
          // CustomNavigators.pushRemoveUntil(MyOrdersNew(), context);
        }
      }
    } else {
      Timer(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeCookingChampsView(),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.appTheme,
      body: Center(
        child: Image.asset(width: size.width * 0.50, height: 111, AssetsPath.logo),
      ),
    );
  }
}
