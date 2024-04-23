import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsai/config/config.dart';
import 'package:newsai/features/auth/controllers/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/validator.dart';
import '../widget/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.put(LoginContImp());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<LoginContImp>(builder: (cont) {
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
            } else if(cont.requestStatus == RequestStatus.success || cont.requestStatus == RequestStatus.failure){
              return Form(
                key: cont.formstate,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.w,
                              height: 6.h,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Text(
                                "Let`s Sign You In",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        AuthInput(
                          controller: cont.email,
                          hintText: "Email Address",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(Icons.email, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            return validInput(val!, 5, 100, "email");
                          },
                          focusNode: f1,
                          onFieldSubmitted: (val) {
                            f1.unfocus();
                            FocusScope.of(context).requestFocus(f2);
                          },
                        ),
                        SizedBox(height: 2.h),
                        AuthInput(
                          controller: cont.pass,
                          hintText: "Password",
                          isNumber: false,
                          isPassword: cont.isShowPassword,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              cont.showPassword();
                            },
                            child: cont.isShowPassword ?
                            Icon(Icons.visibility_outlined, size: 20.sp, color: darkGrey,) :
                            Icon(Icons.visibility_off_outlined, size: 20.sp, color: lightRed,),
                          ),
                          valid: (val) {
                            return validInput(val!, 5, 100, "password");
                          },
                          focusNode: f2,
                          onFieldSubmitted: (val) {
                            f2.unfocus();
                            FocusScope.of(context).requestFocus(f3);
                          },
                        ),
                        SizedBox(height: 7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: ElevatedButton(
                                // focusNode: f3,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(buttonsColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 1.h
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  cont.login();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5.w),
                            Text(
                              "Or",
                              style: TextStyle(
                                color: landingBackground,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: ElevatedButton(
                                // focusNode: f3,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(darkGrey),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 1.h
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  Get.toNamed(screenRegister);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
          }),
        ),
      ),
    );
  }
}
