import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/ui/user/details/details_screen.dart';
import 'package:site_construct/ui/user/homeScreen/home_screen.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/labour/labour_screen.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/ui/user/login/otp_screen.dart';

const String homeScreen = "/homeScreen";
const String loginScreen = "/loginScreen";
const String otpScreen = "/otpScreen";
const String detailsScreen = "/detailsScreen";
const String labourScreen = "/labourScreen";

List<GetPage<dynamic>> routes = [
  GetPage(name: homeScreen, page: () => const HomeScreen()),
  GetPage(name: "/loginScreen", page: () => const LoginScreen()),
  GetPage(name: "/otpScreen", page: () => const OtpScreen()),
  GetPage(
      name: "/detailsScreen",
      page: () {
        final Site site = Get.arguments;
        return DetailsScreen(site: site);
      }),
  GetPage(name: labourScreen, page: () => const LabourScreen()),
];
