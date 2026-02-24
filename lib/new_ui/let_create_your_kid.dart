import 'dart:io';

import 'package:cooking_champs/constant/app_state.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/dynamic_models/my_child_listing_model.dart';
import 'package:cooking_champs/model/post_model/kids_register_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/widgets/child_profile_created_popup.dart';
import 'package:cooking_champs/widgets/custom_month_picker.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:cooking_champs/widgets/image_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class LetCreateYourKid extends StatefulWidget {
  final bool check;
  final bool? editCheck;
  final Function? onCallBack;
  final Items? myChildModel;
  const LetCreateYourKid(
      {super.key,
      required this.check,
      this.editCheck,
      this.onCallBack,
      this.myChildModel});

  @override
  State<LetCreateYourKid> createState() => _LetCreateYourKidState();
}

class _LetCreateYourKidState extends State<LetCreateYourKid> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Items myChildModel = Items();
  List<XFile> imageFileList = [];
  File? selectedImage;
  dynamic isFocusColor = '';
  dynamic image;
  dynamic selectedAvatar;

  String nameError = "";
  String userNameError = "";
  String gradeError = "";
  String dayError = "";
  String monthError = "";
  String yearError = "";
  String passError = "";
  String selectDate2 = "";
  int? selectedMonth;
  String kidImage = "";

  bool isPassHide = true;
  bool isConPassHide = true;
  bool isValidate = false;
  bool isImage = false;

  String passwordImage = AssetsPath.hideEyeIc;
  String conPasswordImage = AssetsPath.hideEyeIc;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    if (widget.editCheck == true) {
      myChildModel = widget.myChildModel!;
      if (myChildModel.id != null) {
        if (mounted) {
          setState(() {
            nameController.text = myChildModel.name ?? "";
            dayController.text = myChildModel.day.toString() == "null"
                ? ""
                : myChildModel.day.toString();
            monthController.text = myChildModel.month ?? "";
            yearController.text = myChildModel.year ?? "";
            gradeController.text = myChildModel.grade ?? "";
            userNameController.text = myChildModel.username ?? "";
            passController.text = myChildModel.decryptedPassword ?? "";
            kidImage = ApiPath.imageBaseUrl + myChildModel.image.toString();
          });
        }
      }
    }
    final now = DateTime.now();
    selectedMonth = now.month - 1;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.check == true
          ? AppBar(
              leadingWidth: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColor.yellowF6F1E1,
              surfaceTintColor: MyColor.yellowF6F1E1,
              title: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TouchRippleEffect(
                      borderRadius: BorderRadius.circular(30),
                      rippleColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                        isTabExplore = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                        widget.editCheck == true
                            ? Languages.of(context)!.editKidProfile
                            : Languages.of(context)!.addAnotherKid,
                        style: mediumTextStyle(
                            fontSize: 18.0, color: MyColor.black)),
                  ],
                ),
              ),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.check == true
                      ? Container()
                      : SizedBox(
                          height: size.height * 0.06,
                        ),
                  widget.check == true
                      ? Container()
                      : SizedBox(
                          height: size.height * 0.01,
                        ),
                  widget.check == true
                      ? Container()
                      : Text(
                          Languages.of(context)!.letCreateYourKidChampProfile,
                          // textAlign: TextAlign.center,
                          style: semiBoldTextStyle(
                              fontSize: 28.0, color: MyColor.black)),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          AllDialogs.globalBottomSheet(
                            context,
                            ImagePickerKIdsDialog(onCallBack: onCallBack),
                                () {},
                          );
                        },
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (selectedImage != null)
                                ClipOval(
                                  child: Image.file(
                                    selectedImage!,
                                    height: 123,
                                    width: 123,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else if (selectedAvatar != null && selectedAvatar is String)
                                ClipOval(
                                  child: selectedAvatar!.endsWith(".svg")
                                      ? SvgPicture.asset(
                                    selectedAvatar!,
                                    height: 123,
                                    width: 123,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.asset(
                                    selectedAvatar!,
                                    height: 123,
                                    width: 123,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else if (kidImage.isNotEmpty)
                                  Container(
                                    height: 123,
                                    width: 123,
                                    decoration: BoxDecoration(
                                      color: MyColor.liteGray,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: UiUtils.networkProfile(123, 123, kidImage),
                                    ),
                                  )
                                else
                                  CircleAvatar(
                                    radius: 63,
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(
                                      Icons.person,
                                      size: 110,
                                      color: Colors.white,
                                    ),
                                  ),

                              // Circular border
                              Container(
                                height: 146,
                                width: 146,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: MyColor.appTheme,
                                    width: 2,
                                  ),
                                ),
                              ),

                              // Camera icon
                              Positioned(
                                right: 5,
                                bottom: 10,
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColor.appTheme,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )


                    ],
                  ),
                  hsized20,
                  Center(
                    child: TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter Champ Full Name',
                        border: InputBorder.none,
                        hintStyle: regularTextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1.2, color: Colors.grey[300]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      headingText(
                          Languages.of(context)!.dateofbirth.toString()),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                titleText(
                                    Languages.of(context)!.year.toString(),
                                    yearError,
                                    false),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                dropDownTextField(
                                    yearController,
                                    "Year",
                                    // Languages.of(context)!.selectyourcampyear.toString(),
                                    "Year",
                                    yearOnTap),
                              ],
                            ),
                          ),
                          wSized5,
                          Expanded(
                            child: Column(
                              children: [
                                titleText(
                                    Languages.of(context)!.month.toString(),
                                    "",
                                    true),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                dropDownTextField(
                                    monthController,
                                    "Month",
                                    // Languages.of(context)!.selectyourcampmanth.toString(),
                                    "Month",
                                    monthOnTap),
                              ],
                            ),
                          ),
                          wSized5,
                          Expanded(
                            child: Column(
                              children: [
                                titleText(Languages.of(context)!.day.toString(),
                                    "", true),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                dropDownTextField(
                                    dayController,
                                    "Day",

                                    // Languages.of(context)!.selectyourcampbornday.toString(),
                                    "Day",
                                    dayOnTap),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      headingText(Languages.of(context)!
                          .whichclassgradearetheyin
                          .toString()),
                      hsized20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Languages.of(context)!.classgrade.toString(),
                              style: regularNormalTextStyle(
                                  fontSize: 15.0, color: MyColor.color000000)),
                          UiUtils.errorText(gradeError)
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      commonTextField(
                          gradeController,
                          Languages.of(context)!.enterclassgrade.toString(),
                          TextInputAction.next,
                          TextInputType.text,
                          "Class Grade"),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      headingText(Languages.of(context)!
                          .createUsernamePassword
                          .toString()),
                      hsized20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(Languages.of(context)!.username.toString(),
                                  style: regularNormalTextStyle(
                                      fontSize: 15.0,
                                      color: MyColor.color000000)),
                            ],
                          ),
                          UiUtils.errorText(userNameError)
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      commonTextField(
                          userNameController,
                          Languages.of(context)!.enterusername.toString(),
                          TextInputAction.done,
                          TextInputType.text,
                          "UserName"),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Languages.of(context)!.password.toString(),
                              style: regularNormalTextStyle(
                                  fontSize: 15.0, color: MyColor.color000000)),
                          Text(
                            "at least 5 characters",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      commonTextField(
                          passController,
                          Languages.of(context)!.enterpassword.toString(),
                          TextInputAction.done,
                          TextInputType.text,
                          "Password"),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GlobalButton(
                          widget.editCheck == true
                              ? Languages.of(context)!
                                  .updateKidProfile
                                  .toString()
                              : Languages.of(context)!
                                  .createKidProfile
                                  .toString(),
                          MyColor.appTheme,
                          MyColor.appTheme,
                          btnSize55,
                          double.infinity,
                          checkValidation,
                          55,
                          5,
                          0,
                          mediumTextStyle(
                              fontSize: 16.0, color: MyColor.white)),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  headingText(String string) {
    return Center(
      child: Text(string,
          style: regularTextStyle(fontSize: 20.0, color: MyColor.black)),
    );
  }

  Widget titleText(String string, String? error, bool optional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  string,
                  style: regularNormalTextStyle(
                    fontSize: 15.0,
                    color: MyColor.color000000,
                  ),
                ),
                if (!optional)
                  Text(
                    " *",
                    style: regularTextStyle(
                      fontSize: 14.0,
                      color: MyColor.red,
                    ),
                  ),
              ],
            ),
            if (error?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: UiUtils.errorText(error!),
              ),
          ],
        ),
      ],
    );
  }

  /// Password hide show..................
  void hideShowPass() {
    setState(() {
      isPassHide = !isPassHide;
      if (isPassHide) {
        passwordImage = AssetsPath.eyeIc;
      } else {
        passwordImage = AssetsPath.hideEyeIc;
      }
    });
  }

  /// set Suffix icon............
  suffixIconSet(String type) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 7, right: 7),
      child: type == "Password"
          ? GestureDetector(
              onTap: hideShowPass,
              child: SvgPicture.asset(
                passwordImage,
              ))
          : const SizedBox(height: 10, width: 10),
    );
  }

  commonTextField(
    TextEditingController controller,
    String labelText,
    TextInputAction textInputAction,
    TextInputType textInputType,
    String type,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color:
                isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite),
        color: MyColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
      height: 55,
      child: TextField(
        obscureText: type == "Password" ? isPassHide : false,
        textCapitalization: TextCapitalization.sentences,
        onTap: () {
          if (mounted) {
            setState(() {
              isFocusColor = type;
            });
          }
        },
        buildCounter: (BuildContext context,
                {required int currentLength,
                int? maxLength,
                required bool isFocused}) =>
            null,
        controller: controller,
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        textInputAction: textInputAction,
        keyboardType: textInputType,
        style: regularTextStyle(fontSize: 14.0, color: MyColor.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: labelText,
          hintStyle: regularTextStyle(fontSize: 14.0, color: MyColor.grayLite1),
          counter: const Offstage(),
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: 10,
          ),
        ),
        maxLines: 1,
        cursorColor: MyColor.black,
      ),
    );
  }

  dropDownTextField(TextEditingController controller, String labelText,
      String type, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isFocusColor == type
                    ? MyColor.liteOrange
                    : MyColor.grayLite),
            color: MyColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  controller.text.trim().isEmpty ? labelText : controller.text,
                  style: regularTextStyle(
                      fontSize: 12.0,
                      color: controller.text.trim().isEmpty
                          ? MyColor.grayLite1
                          : MyColor.black),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 25,
              ),
            ],
          )),
    );
  }

  onCallBack(dynamic file) {
    if (mounted) {
      setState(() {
        if (file is String && file.startsWith('assets/')) {
          selectedAvatar = file;
          selectedImage = null;
          isImage = true;

        } else if (file is File) {
          selectedImage = file;
          image =file;
          selectedAvatar = null;
          isImage = true;
        }
      });
    }
  }


  checkValidation() {
    if (widget.editCheck == true) {
      kidUpdate();
    } else {
      if (mounted) {
        isValidate = true;
        if (nameController.text.trim().isEmpty) {
          nameError = Languages.of(context)!.enterName;
          isValidate = false;
        } else {
          nameError = '';
        }
        if (nameController.text.trim().isEmpty) {
          nameError = Languages.of(context)!.enterName;
          isValidate = false;
        } else {
          nameError = '';
        }

        if (yearController.text.trim().isEmpty) {
          yearError = Languages.of(context)!.enterYear;
          isValidate = false;
        } else {
          yearError = '';
        }

        if (yearController.text.trim().isEmpty) {
          yearError = Languages.of(context)!.enterYear;
          isValidate = false;
        } else {
          yearError = '';
        }
        if (gradeController.text.trim().isEmpty) {
          gradeError = Languages.of(context)!.enterGrade;
          isValidate = false;
        } else {
          gradeError = '';
        }

        if (userNameController.text.trim().isEmpty) {
          userNameError = Languages.of(context)!.username.toString();
          isValidate = false;
        } else {
          userNameError = '';
        }
        if (passController.text.trim().isEmpty ||
            passController.text.length < 6) {
          passError = Languages.of(context)!.atleast5.toString();
          isValidate = false;
        } else {
          passError = '';
        }

        if (yearController.text.trim().isEmpty) {
          Utility.customToast(context, "Please select year");
          isValidate = false;
        } else if (!isImage) {
          Utility.customToast(context, Languages.of(context)!.pleaseUploadProfile);
          isValidate = false;
        }
        setState(() {});
        print("111111111111");
        if (isValidate) {
          print("mdbckmcksjkcjksxc");
          nameError = "";
          userNameError = "";
          gradeError = "";
          yearError = "";
          passError = "";
          print("1331321321231231323213232$image");
          print("98998989797989789789789978987$selectedAvatar");
          kidRegister();
        }
      }
    }
  }

  kidRegister() async {
    String fcm =
        await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
            "";
    String parentId = await PreferencesServices.getPreferencesData(
            PreferencesServices.parentId) ??
        "";

    KidsRegisterModel kidsRegisterModel = KidsRegisterModel(
        role: RegisterType.roleKids.value,
        parentId: int.parse(parentId),
        name: nameController.text,
        day: dayController.text.isNotEmpty
            ? int.parse(dayController.text)
            : null,
        month: monthController.text.trim().isNotEmpty
            ? Utility.formatDateToMonthDay(selectDate2)
            : "",
        year: yearController.text,
        grade: gradeController.text,
        username: userNameController.text,
        password: passController.text,
        fcmToken: fcm,
        deviceId: AppState.deviceIdStr,
        avatar: selectedAvatar,
        deviceType: AppState.devicetype);

    await ApiServices.kidsRegister(context, kidsRegisterModel, image)
        .then((onValue) {
      if (mounted) {
        if (onValue.status != null && onValue.status != false) {
          AllDialogs.customDialog(
              context,
              ChildProfileCreatedPopup(
                name: nameController.text,
                check: widget.check,
                onCallBack: onUpdate,
                title: Languages.of(context)!.childprofilecreated,
                des:
                    "Great! You’ve successfully created   ${nameController.text} profile. Would you like to add another child?",
              ));
        } else {
          if (onValue.error != null) {
            Utility.customToast(context, onValue.error.toString());
          }
        }
      }
    });
  }

  kidUpdate() async {
    KidsRegisterModel kidsRegisterModel = KidsRegisterModel(
      role: RegisterType.roleKids.value,
      kidId: int.parse(myChildModel.id.toString()),
      name: nameController.text,
      day: int.parse(dayController.text.toString()),
      month: monthController.text.trim().isNotEmpty
          ? selectDate2.isEmpty
              ? monthController.text
              : Utility.formatDateToMonthDay(selectDate2)
          : "",
      year: yearController.text,
      grade: gradeController.text,
      username: userNameController.text,
      password: passController.text,
      avatar: selectedAvatar,
    );
    if (widget.editCheck == true) {
      await ApiServices.updateKidProfile(context, kidsRegisterModel, image)
          .then((onValue) {
        if (mounted) {
          if (onValue.status != null && onValue.status != false) {
            AllDialogs.customDialog(
                context,
                ChildProfileCreatedPopup(
                  name: nameController.text,
                  check: widget.check,
                  onCallBack: onUpdate,
                  title: Languages.of(context)!.childProfileUpdated,
                  des:
                      "Great! You’ve successfully updated   ${nameController.text} profile. Would you like to add another child?",
                ));
          } else {
            if (onValue.error != null) {
              Utility.customToast(context, onValue.error.toString());
            }
          }
        }
      });
    }
  }

  void firstNameOnTap() {
    if (mounted) {
      setState(() {
        isFocusColor = "First Name";
      });
    }
  }

  void lastNameOnTap() {
    if (mounted) {
      setState(() {
        isFocusColor = "Last Name";
      });
    }
  }

  void dayOnTap() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2080),
    );

    if (selectedDate != null) {
      dayController.text = selectedDate.day.toString().padLeft(2, '0');
      monthController.text = DateFormat('MMMM').format(selectedDate);
      yearController.text = selectedDate.year.toString();
      setState(() {});
    }
    isFocusColor = "lastName";
    setState(() {});
  }

  void monthOnTap() async {
    AllDialogs.customDialog(
        context,
        CustomMonthPicker(
          onMonthSelected: (selectedMonth1) {
            setState(() {
              selectedMonth = int.parse(selectedMonth1);
              final now = DateTime.now();
              final formattedDate = "${now.year}-$selectedMonth1-01 00:00:00.000";
              selectDate2 = formattedDate;
              monthController.text =
                  Utility.formatDateToMonthDay(formattedDate);
            });
          },
          currentMonthIndex: selectedMonth!,
        ));
    isFocusColor = "parentEmail";
  }

  void yearOnTap() async {
    AllDialogs.customDialog(
        context,
        SizedBox(
          height: 200,
          child: CustomYearPicker(
            onYearSelected: (selectedYear) {
              setState(() {
                yearController.text = selectedYear.toString();
              });
            },
          ),
        ));

    isFocusColor = "emailstar";
    setState(() {});
  }

  onUpdate() {
    if (widget.check == true) {
      Navigator.pop(context);
      if (widget.onCallBack != null) {
        widget.onCallBack!();
      }
    }
  }
}
