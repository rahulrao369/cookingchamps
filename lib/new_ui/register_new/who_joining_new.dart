import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/post_model/add_favorite_request.dart';
import 'package:cooking_champs/new_ui/kid_profile_new.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:flutter/material.dart';

class WhoJoiningNew extends StatefulWidget {
  const WhoJoiningNew({super.key});

  @override
  State<WhoJoiningNew> createState() => _WhoJoiningNewState();
}

enum Role { individual, parent }

class _WhoJoiningNewState extends State<WhoJoiningNew> {
  Role selectedRole = Role.parent;
  String roleTipe = "parent";

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      useSafeArea: false,
      body: Stack(
        children: [
          Image.asset(
            AssetsPath.commonBackground,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    hsized30,
                    Text(
                      "Who's joining Cooking Champs?",
                      style: boldTextStyle(
                        fontSize: 28.0,
                        color: MyColor.color000000,
                      ),
                    ),
                    hsized13,
                    Text(
                      "Choose your role to personalize your experience and make the most out of Cooking Champs!",
                      style: regularNormalTextStyleWithoutHeight(
                        fontSize: 13.0,
                        color: MyColor.color000000,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hsized15,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          roleTipe = "parent";
                          selectedRole = Role.parent;
                        });
                      },
                      child: buildCard(
                        isSelected: selectedRole == Role.parent,
                        title: "I'm a Parent",
                        description:
                            "I'm setting up an account for my child to start their cooking.",
                        imagePath: AssetsPath.parent,
                      ),
                    ),
                    hsized15,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          roleTipe = "individual";
                          selectedRole = Role.individual;
                        });
                      },
                      child: buildCard(
                        isSelected: selectedRole == Role.individual,
                        title: "I'm an Individual",
                        description:
                            "I want to explore cooking and learn on my own.",
                        imagePath: AssetsPath.individual,
                      ),
                    ),
                    hsized30,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomButton: Container(
        margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
        child: commonButton(
          text: "Continue",
          onTap: () {
            if (selectedRole != null) {
              updateRole();
            }
          },
          backgroundColor: MyColor.color48335CB2,
          textColor: MyColor.white,
        ),
      ),
    );
  }

  Widget buildCard({
    required bool isSelected,
    required String title,
    required String description,
    required String imagePath,
  }) {
    final bgColor = isSelected ? MyColor.appTheme : MyColor.colorF5F2E6;
    final textColor = isSelected ? MyColor.white : MyColor.black;
    final borderColor = textColor;

    return Container(
      height: 220,
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 1),
              color: Colors.white.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: semiBoldTextStyle(
              fontSize: 19.0,
              color: textColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: regularNormalTextStyle(
              fontSize: 13.0,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateRole() async {
    UpdateRoleRequest updateRoleRequest =
        UpdateRoleRequest(roleType: roleTipe.toString());

    await ApiServices.updateRoleRequest(context, updateRoleRequest, true)
        .then((onValue) {
      if (mounted) {
        setState(() {
          PreferencesServices.setPreferencesData(
              PreferencesServices.whoIsLogin, true);

          if (onValue.status == true) {
            if (roleTipe == "individual") {
              print("individual......");
              PreferencesServices.setPreferencesData(
                  PreferencesServices.loginType, "individual");
              CustomNavigators.pushRemoveUntil(
                  DashBoardView(pageIndex: 0), context);
            } else {
              print("parent......");
              PreferencesServices.setPreferencesData(
                  PreferencesServices.loginType, "parent");
              CustomNavigators.pushNavigate(KidProfileNew(), context);
            }

            // if(onValue.message.toString() == "Recipe removed from favorites successfully!"){
            //   if(widget.pageType == "Favorite") {
            //     recipeList.remove(recipeModel);
            //   }
            //   recipeModel.isFavourite = "No";
            // }else{
            //   recipeModel.isFavourite = "Yes";
            // }
          } 
        });
      }
    });
  }
}
