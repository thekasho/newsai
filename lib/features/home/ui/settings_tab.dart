import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newsai/core/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/home.dart';


class SettingsTabScreen extends StatefulWidget {
  const SettingsTabScreen({super.key});

  @override
  State<SettingsTabScreen> createState() => _SettingsTabScreenState();
}

class _SettingsTabScreenState extends State<SettingsTabScreen> {
  HomeContImp homeContImp = Get.put(HomeContImp());

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            actionsPadding: const EdgeInsets.all(10),
            buttonPadding: const EdgeInsets.all(5),
            titlePadding: EdgeInsets.symmetric(
              vertical: 1.h,
              horizontal: 20,
            ),
            contentPadding: EdgeInsets.only(
              top: 2.h,
              bottom: 2.h,
              left: 5.w,
            ),
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "Confirm Logout",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            content: Text(
              "Are You Sure?!",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            backgroundColor: white,
            actions: [
              MaterialButton(
                focusElevation: 10,
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  "No",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              SizedBox(width: 1.w),
              MaterialButton(
                focusElevation: 10,
                color: red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  "Yes",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white),
                ),
                onPressed: () {
                  homeContImp.logOut();
                },
              ),
            ],
          ),
    ) ??
    false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 2,
            ),
            SizedBox(height: 1.h,),
            GestureDetector(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 25.sp, color: landingBackground,),
                    const Spacer(flex: 1),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        color: landingBackground
                      ),
                    ),
                    const Spacer(flex: 15),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: darkGrey,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.language, size: 25.sp, color: landingBackground,),
                    const Spacer(flex: 1),
                    Text(
                      "Language",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          color: landingBackground
                      ),
                    ),
                    const Spacer(flex: 15),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: darkGrey,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.light_mode, size: 25.sp, color: landingBackground,),
                    const Spacer(flex: 1),
                    Text(
                      "App Settings",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          color: landingBackground
                      ),
                    ),
                    const Spacer(flex: 15),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: darkGrey,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.policy, size: 25.sp, color: landingBackground,),
                    const Spacer(flex: 1),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          color: landingBackground
                      ),
                    ),
                    const Spacer(flex: 15),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: darkGrey,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.mail_outline, size: 25.sp, color: landingBackground,),
                    const Spacer(flex: 1),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          color: landingBackground
                      ),
                    ),
                    const Spacer(flex: 15),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: darkGrey,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await showExitPopup();
                // cont.logOut();
              },
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 1.h,
                ),
                child: Row(
                  children: [
                    Icon(Icons.login_rounded, size: 25.sp, color: red,),
                    const Spacer(flex: 1),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        color: red,
                      ),
                    ),
                    const Spacer(flex: 15,),
                    Icon(FontAwesomeIcons.chevronRight, size: 20.sp, color: red,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
