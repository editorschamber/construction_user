import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/ui/user/addNewSite/add_new_site.dart';
import 'package:site_construct/ui/user/addNewSite/binding/add_new_site_binding.dart';
import 'package:site_construct/ui/user/details/details_screen.dart';
import 'package:site_construct/ui/user/homeScreen/home_screen.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/labour/labour_screen.dart';
import 'package:site_construct/ui/user/login/binding/login_binding.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/ui/user/login/widgets/login_page.dart';
import 'package:site_construct/ui/user/navigationMenu/navigation_menu.dart';
import 'package:site_construct/ui/user/onBoarding/binding/on_boarding_binding.dart';
import 'package:site_construct/ui/user/onBoarding/on_boarding_screen.dart';
import 'package:site_construct/ui/user/orderPage/binding/order_binding.dart';
import 'package:site_construct/ui/user/orderPage/order_screen.dart';
import 'package:site_construct/ui/user/otp/binding/otp_binding.dart';
import 'package:site_construct/ui/user/otp/otp_screen.dart';
import 'package:site_construct/ui/user/material/material_screen.dart';
import 'package:site_construct/ui/user/otp/widgets/otp_page.dart';
import 'package:site_construct/ui/user/profile/binding/profile_binding.dart';
import 'package:site_construct/ui/user/profile/profile_screen.dart';
import 'package:site_construct/ui/user/siteEmployee/site_employee_list.dart';
import 'package:site_construct/ui/user/splash/binding/splash_binding.dart';
import 'package:site_construct/ui/user/splash/splash_screen.dart';

import '../ui/user/allSitePlan/all_site_plans_screen.dart';

const String homeScreen = "/homeScreen";
const String loginScreen = "/loginScreen";
const String loginPage = "/loginPage";
const String otpScreen = "/otpScreen";
const String otpPage = "/otpPage";
const String detailsScreen = "/detailsScreen";
const String labourScreen = "/labourScreen";
const String materialScreen = "/materialScreen";
const String siteEmployeeList = "/siteEmployeeList";
const String onBoardingScreen = "/onBoardingScreen";
const String profileScreen = "/profileScreen";
const String addNewSiteScreen = "/addNewSiteScreen";
const String allSitePlans = "/allSitePlans";
const String orderScreen = "/orderScreen";
const String splashScreen = "/splashScreen";
const String navigationMenu = "/navigationMenu";

List<GetPage<dynamic>> routes = [
  GetPage(name: homeScreen, page: () => const HomeScreen()),
  GetPage(name: navigationMenu, page: () => const NavigationMenu()),
  GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding()),
  GetPage(name: loginPage, page: () => const LoginPage()),
  GetPage(
      name: otpScreen, page: () => const OtpScreen(), binding: OtpBinding()),
  GetPage(name: otpPage, page: () => const OtpPage()),
  GetPage(
    name: detailsScreen,
    transition: Transition.rightToLeft,
    page: () {
      final Site site = Get.arguments;
      return DetailsScreen(site: site);
    },
  ),
  GetPage(
      name: labourScreen,
      transition: Transition.rightToLeft,
      page: () => const LabourScreen()),
  GetPage(
      name: materialScreen,
      transition: Transition.rightToLeft,
      page: () => const MaterialScreen()),
  GetPage(
      name: siteEmployeeList,
      transition: Transition.rightToLeft,
      page: () => const SiteEmployeeList()),
  GetPage(
      name: siteEmployeeList,
      transition: Transition.rightToLeft,
      page: () => const SiteEmployeeList()),
  GetPage(
      name: siteEmployeeList,
      transition: Transition.rightToLeft,
      page: () => const SiteEmployeeList()),
  GetPage(
    name: onBoardingScreen,
    transition: Transition.rightToLeft,
    page: () => OnBoardingScreen(),
    binding: OnBoardingBinding(),
  ),
  GetPage(
    name: profileScreen,
    transition: Transition.rightToLeft,
    page: () => ProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: addNewSiteScreen,
    transition: Transition.rightToLeft,
    page: () => AddNewSite(),
    binding: AddNewSiteBinding(),
  ),
  GetPage(
    name: orderScreen,
    transition: Transition.rightToLeft,
    page: () => OrderScreen(),
    binding: OrderBinding(),
  ),
  GetPage(
    name: splashScreen,
    transition: Transition.rightToLeft,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  )
];
