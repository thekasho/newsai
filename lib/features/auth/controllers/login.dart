import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class LoginCont extends GetxController {
  checkNetwork();
  login();
}
class LoginContImp extends LoginCont {
  Requests requests = Requests(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController pass;

  RequestStatus requestStatus = RequestStatus.none;

  bool isShowPassword = true;
  bool isConnected = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  login() async {
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
          'email': email.text,
          'pass': pass.text,
        };
        var auth = await requests.postData(data, AppLinks.login);

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
        } else if(auth['message'] == "password_wrong"){
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
              "Password Incorrect !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "not_exsist"){
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
              "Email Not Registered !!",
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
        } else if(auth['message'] == "success"){
          if(auth['result']['status'] == 0){
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
                "Account Not Active !!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                ),
              ),
            );
            requestStatus = RequestStatus.failure;
            update();
          } else {
            Map loginData = {
              'id': auth['result']['id'],
              'email': email.text,
              'username': auth['result']['username'],
              'avatar': auth['result']['avatar'] ?? "",
              'type': auth['result']['type'],
              'created_at': auth['result']['created_at'],
            };
            var saveLogin = await LocaleApi.saveLoginData(loginData);
            if(saveLogin){
              Get.offAllNamed(screenHome);
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
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.success;
    email = TextEditingController();
    pass = TextEditingController();
    checkNetwork();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

}