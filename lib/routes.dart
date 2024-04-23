import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:newsai/features/auth/ui/register.dart';

import 'config/config.dart';
import 'features/auth/ui/login.dart';
import 'features/home/ui/home.dart';
import 'features/landing/ui/home.dart';
import 'features/news/ui/by_category.dart';

List<GetPage<dynamic>>? routes = [
  // home & landing
  GetPage(name: screenLandingHome, page: () => const LandingHomeScreen()),
  GetPage(name: screenHome, page: () => const HomeScreen()),
  // auth
  GetPage(name: screenRegister, page: () => const RegisterScreen()),
  GetPage(name: screenLogin, page: () => const LoginScreen()),
];
