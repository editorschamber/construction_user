import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data/database_helper.dart';
import '../../../../core/data/user_model.dart';
import '../../../../routes/route.dart';
import '../login_screen.dart';

class LoginController extends GetxController {
  TextEditingController countryCode = TextEditingController(text: '+91');
  TextEditingController numberController = TextEditingController();

  void verifyPhoneNumber() async {
    String phoneNumber = countryCode.text + numberController.text.trim();
    if (phoneNumber.length < 10) {
      Get.defaultDialog();
      return;
    }

    try {
      UserModel? existingUser =
          await DatabaseHelper.instance.getUserByPhoneNumber(phoneNumber);
      if (existingUser != null) {
        Get.offNamed(homeScreen);
        return;
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage;
          switch (e.code) {
            case 'invalid-phone-number':
              errorMessage = 'The provided phone number is not valid.';
              break;
            case 'too-many-requests':
              errorMessage =
                  'We have blocked all requests from this device due to unusual activity. Try again later.';
              break;
            default:
              errorMessage = 'Phone verification failed. Please try again.';
          }
          Get.snackbar(errorMessage, "");
        },
        codeSent: (String verificationId, int? resendToken) async {
          LoginScreen.verify = verificationId;
          Get.toNamed(otpScreen);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("Failed to verify phone number. Please try again.", "");
    }
  }
}
