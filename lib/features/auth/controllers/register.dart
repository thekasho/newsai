import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';

abstract class RegisterCont extends GetxController {
  checkNetwork();
  register();
}
class RegisterContImp extends RegisterCont {
  Requests requests = Requests(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController repass;

  RequestStatus requestStatus = RequestStatus.none;

  bool isShowPassword = true;
  bool isShowrePassword = true;
  bool isConnected = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  showrePassword() {
    isShowrePassword = isShowrePassword == true ? false : true;
    update();
  }

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  register() async {
    try {
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        requestStatus = RequestStatus.loading;
        update();

        if(!isConnected){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "No Internet Connection !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
          return;
        }

        Map data = {
          'username': username.text,
          'email': email.text,
          'pass': pass.text,
        };

        var auth = await requests.postData(data, AppLinks.register);

        if(RequestStatus.serverFailure == auth){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: red,
              fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "email_exsist"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Email Already in use !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "data_null"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "failed"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "success") {
          Get.defaultDialog(
              backgroundColor: white,
              title: "Success",
              titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
              titleStyle: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  color: green,
                  fontWeight: FontWeight.bold
              ),
              content: Text(
                "Account Registered Success",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                ),
              ),
              onWillPop: () async {
                Get.back();
                Get.back();
                Get.toNamed(screenLogin);
                return false;
              }
          );
          requestStatus = RequestStatus.success;
          update();
        } else {
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    repass = TextEditingController();
    checkNetwork();
    requestStatus = RequestStatus.success;
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    pass.dispose();
    repass.dispose();
    super.dispose();
  }

}