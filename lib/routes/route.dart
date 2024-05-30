import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:site_construct/ui/user/homeScreen/home_screen.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/ui/user/login/otp_screen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/homeScreen", page: () => HomeScreen()),
  GetPage(name: "/loginScreen", page: () => LoginScreen()),
  GetPage(name: "/otpScreen", page: () => OtpScreen()),
];
