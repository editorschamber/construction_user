import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/login/controller/login_controller.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_enter_number.dart';
import 'package:site_construct/utils/common/common_widgets/common_textfield.dart';

import 'common_textfield.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();
  final authController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Obx(() {
            return authController.isLoading.value
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildLogo(),
                    SizedBox(height: 48),
                    _buildWelcomeText(),
                    SizedBox(height: 48),
                    _buildInputFields(),
                    SizedBox(height: 24),
                    _buildLoginButton(),
                    SizedBox(height: 16),
                    // _buildSignUpRow(),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF1565C0),
          ],
        ),
      ),
      child: CustomPaint(
        painter: BackgroundPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildLogo() {
    return Hero(
      tag: 'logo',
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          Icons.lock,
          size: 60,
          color: Color(0xFF1565C0),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          "Welcome",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Sign in to continue",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mobile Number",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        CustomEnterNumber(
          countryCode: controller.countryCode,
          numberController: authController.numberController,
          prefixIcon: Icon(Icons.phone, color: Colors.white70),
        ),
        SizedBox(height: 24),
        Text(
          "Password",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        CustomTextfield(
          password: authController.passwordController,
          prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
        ),
        SizedBox(height: 8),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: TextButton(
        //     onPressed: () {
        //       // TODO: Implement forgot password functionality
        //     },
        //     child: Text(
        //       "Forgot Password?",
        //       style: TextStyle(color: Colors.white70, fontSize: 14),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      buttonColor: Colors.white,
      buttonText: "Login",
      textColor: Color(0xFF1565C0),
      onTap: () {
        authController.verifyPhoneNumber();
      },
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to sign up page
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.7,
        size.width * 0.5,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.9,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

