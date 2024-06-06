import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/login/controller/login_controller.dart';
import 'package:site_construct/ui/user/login/widgets/login_page.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  static String verify = "";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginPage(),
            ],
          ),
        ),
      ),
    );
  }
}
