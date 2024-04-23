import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';
import '../ui/categories_tab.dart';
import '../ui/home_tab.dart';
import '../ui/settings_tab.dart';
import 'news.dart';

abstract class HomeCont extends GetxController {
  checkNetwork();
  checkAuth();
  changePage(int i);
  logOut();
}
class HomeContImp extends HomeCont {
  Requests requests = Requests(Get.find());
  RequestStatus requestStatus = RequestStatus.none;
  bool isConnected = false;
  String username = '';
  int currentPage = 0;

  List<Widget> pagesList = [
    const HomeTabScreen(),
    const CategoriesTabScreen(),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Favourite"),))],),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Notifications"),))],),
    const SettingsTabScreen(),
  ];

  List pagesTitles = [
    "Home",
    "Categories",
    "Favourite",
    "Notifications",
    "Settings",
  ];

  List<IconData> pageIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.layerGroup,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.gears,
  ];

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  changePage(int i) {
    currentPage = i;
    if(i==1){
      NewsContImp newsContImp = Get.put(NewsContImp());
      newsContImp.getCategories();
    }
    update();
  }

  @override
  checkAuth() async {
    var loginData  = await LocaleApi.getLoginData();
    if(loginData != null){
      username = loginData['username'];
      update();
    } else {
      // Get.offAllNamed(screenHome);
    }
  }

  @override
  logOut() async {
    try {
      var loginData  = await LocaleApi.getLoginData();
      if(loginData != null){
        await LocaleApi.removeLoginData();
        Get.offAllNamed(screenLandingHome);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.none;
    checkNetwork();
    checkAuth();
    super.onInit();
  }
}