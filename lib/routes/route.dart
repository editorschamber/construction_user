import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:site_construct/ui/user/homeScreen/homeScreen.dart';
import 'package:site_construct/ui/user/login/otpPage.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/homeScreen", page: () => HomeScreen()),
  GetPage(name: "/otpPage", page: () => OtpPage()),
];
