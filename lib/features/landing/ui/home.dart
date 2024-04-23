import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:newsai/config/config.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../controllers/landing.dart';

class LandingHomeScreen extends StatefulWidget {
  const LandingHomeScreen({super.key});

  @override
  State<LandingHomeScreen> createState() => _LandingHomeScreenState();
}

class _LandingHomeScreenState extends State<LandingHomeScreen> {

  @override
  Widget build(BuildContext context) {
    Get.put(LandingContImp());
    return GetBuilder<LandingContImp>(builder: (cont) {
      if(cont.requestStatus == RequestStatus.loading){
        return SizedBox(
          height: 85.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const CircularProgressIndicator(
                color: black,
              ),
            ],
          ),
        );
      } else if(cont.requestStatus == RequestStatus.success){
        return OnBoardingSlider(
          finishButtonText: 'Join Us',
          onFinish: () {
            Get.offAllNamed(screenRegister);
          },
          finishButtonStyle: const FinishButtonStyle(
            backgroundColor: buttonsColor,
          ),
          skipIcon: Icon(Icons.navigate_next_outlined, size: 25.sp,),
          skipTextButton: Text(
            'Skip',
            style: TextStyle(
              fontSize: 18.sp,
              color: white,
              fontWeight: FontWeight.w600,
            ),
          ),
          skipFunctionOverride: () {
            Get.offAllNamed(screenLogin);
          },
          trailing: Text(
            'Login',
            style: TextStyle(
              fontSize: 18.sp,
              color: white,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingFunction: () {
            Get.offAllNamed(screenLogin);
          },
          controllerColor: white,
          totalPage: 3,
          imageVerticalOffset: 5.h,
          imageHorizontalOffset: 3.w,
          headerBackgroundColor: landingBackground,
          pageBackgroundColor: landingBackground,
          background: [
            Image.asset(
              'assets/images/landing_1.png',
              width: 95.w,
            ),
            Image.asset(
              'assets/images/landing_2.png',
              width: 95.w,
            ),
            Image.asset(
              'assets/images/landing_3.png',
              width: 95.w,
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 40,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.h,),
                  Text(
                    'Always Up-to-Date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 25.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Receive notifications for the most recent news updates and many more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 40,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 53.h,),
                  Text(
                    'Bookmark & Share',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 25.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Save and easily share news with freinds using our intuitive news app features.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 40,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.h,),
                  Text(
                    'New Categories',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 25.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Enjoy expertly tailored news, crafted exclusively for your interests.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      return SizedBox(
        height: 85.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const CircularProgressIndicator(
              color: black,
            ),
          ],
        ),
      );
    });
  }
}
