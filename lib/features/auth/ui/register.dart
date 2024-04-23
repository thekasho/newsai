import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newsai/config/config.dart';
import 'package:newsai/features/auth/controllers/register.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/validator.dart';
import '../widget/input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool value = true;

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  @override
  void dispose() {
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterContImp());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<RegisterContImp>(builder: (cont) {
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
                                "Create an Account",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        AuthInput(
                          controller: cont.username,
                          hintText: "Your Username",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(FontAwesomeIcons.solidUser, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            return validInput(val!, 5, 100, "username");
                          },
                          focusNode: f1,
                          onFieldSubmitted: (val) {
                            f1.unfocus();
                            FocusScope.of(context).requestFocus(f2);
                          },
                        ),
                        SizedBox(height: 2.h),
                        AuthInput(
                          controller: cont.email,
                          hintText: "Your Email Address",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(Icons.email, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            return validInput(val!, 5, 100, "email");
                          },
                          focusNode: f2,
                          onFieldSubmitted: (val) {
                            f2.unfocus();
                            FocusScope.of(context).requestFocus(f3);
                          },
                        ),
                        SizedBox(height: 2.h),
                        AuthInput(
                          controller: cont.pass,
                          hintText: "Your Password",
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
                          focusNode: f3,
                          onFieldSubmitted: (val) {
                            f3.unfocus();
                            FocusScope.of(context).requestFocus(f4);
                          },
                        ),
                        SizedBox(height: 2.h),
                        AuthInput(
                          controller: cont.repass,
                          hintText: "Confirm Password",
                          isNumber: false,
                          isPassword: cont.isShowrePassword,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              cont.showrePassword();
                            },
                            child: cont.isShowrePassword ?
                            Icon(Icons.visibility_outlined, size: 20.sp, color: darkGrey,) :
                            Icon(Icons.visibility_off_outlined, size: 20.sp, color: lightRed,),
                          ),
                          valid: (val) {
                            return validInput(val!, 5, 100, "password");
                          },
                          focusNode: f4,
                          onFieldSubmitted: (val) {
                            f4.unfocus();
                            FocusScope.of(context).requestFocus(f5);
                          },
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: ElevatedButton(
                                focusNode: f5,
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
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  f5.unfocus();
                                  FocusScope.of(context).requestFocus(f6);
                                  cont.register();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
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
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: ElevatedButton(
                                focusNode: f6,
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
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(screenLogin);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: value,
                              isError: false,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: 83.w,
                              child: const Text(
                                "By Creating an account, you are agree to our terms and conditions",
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
