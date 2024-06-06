import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../login/login_screen.dart';

class OtpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController pinController = TextEditingController();
  String code = "";

  void verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: LoginScreen.verify,
        smsCode: code,
      );
      await auth.signInWithCredential(credential);
      Get.offNamedUntil(
        '/homeScreen',
        (route) => false,
      );
    } catch (e) {
      print("wrong OTP");
    }
  }
}
