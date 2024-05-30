import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/login/widgets/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
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
