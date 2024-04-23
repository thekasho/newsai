import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsai/core/constants/app_links.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class NewsCont extends GetxController {
  checkNetwork();
  getNews();
  getCategories();
}
class NewsContImp extends NewsCont {
  Requests requests = Requests(Get.find());
  RequestStatus requestStatus = RequestStatus.none;
  bool isConnected = false;
  List allNews = [];
  List allCategory = [];
  String username = '';
  int userid = 0;

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  getNews() async {
    try {
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
        username = loginData['username'];
        userid = loginData['id'];
      }

      Map newsData = {
        'user_id': userid.toString(),
      };
      var getNews = await requests.postData(newsData, AppLinks.news);

      if(getNews['status'] == "success" && getNews['result'].length >= 1){
        allNews = [];
        allNews.addAll(getNews['result']);
      }
      requestStatus = RequestStatus.success;
      update();

    } catch (e) {
      print("Error $e");
    }
  }

  @override
  getCategories() async {
    try {
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

      Map newsData = {
        'user_id': userid.toString(),
      };
      var getCats = await requests.postData(newsData, AppLinks.category);

      if(getCats['status'] == "success" && getCats['result'].length >= 1){
        allCategory = [];
        allCategory.addAll(getCats['result']);
      }
      requestStatus = RequestStatus.success;
      update();

    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await checkNetwork();
    await getNews();
    update();
  }
}