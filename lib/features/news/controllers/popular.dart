import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class PopularNewsCont extends GetxController {
  checkNetwork();
  getNews();
  likePost(int id);
}
class PopularNewsContImp extends PopularNewsCont {
  Requests requests = Requests(Get.find());
  RequestStatus requestStatus = RequestStatus.loading;
  bool isConnected = false;
  List allNews = [];
  int userid = 0;

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  likePost(id) async {
    try {
      if(id >= 1){
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
        Map likeRequest = {
          'user_id': userid.toString(),
          'post_id': id.toString(),
        };
        var likeRes = await requests.postData(likeRequest, AppLinks.likePost);
        if(likeRes['status'] == "success"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Success",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: green,
              fontWeight: FontWeight.bold,
            ),
            content: Text(
              "Saved Success..",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          update();
        }
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  getNews() async {
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
    var loginData  = await LocaleApi.getLoginData();
    if(loginData != null){
      userid = loginData['id'];
    }

    Map newsData = {
      'user_id': userid.toString(),
    };
    var getNews = await requests.postData(newsData, AppLinks.popularNews);

    if(getNews['status'] == "success" && getNews['result'].length >= 1){
      allNews = [];
      allNews.addAll(getNews['result']);
    }
    requestStatus = RequestStatus.success;
    update();
  }

  @override
  void onReady() async {
    super.onReady();
    requestStatus = RequestStatus.loading;
    await checkNetwork();
    await getNews();
    update();
  }

}