import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/route.dart';
import '../login_screen.dart';

class LoginController extends GetxController {
  TextEditingController countryCode = TextEditingController(text: '+91');
  TextEditingController numberController = TextEditingController();
  final GetStorage storage = GetStorage();

  void verifyPhoneNumber() async {
    String phoneNumber = countryCode.text + numberController.text.trim();
    if (phoneNumber.length < 10) {
      Get.defaultDialog(
        title: 'Invalid Phone Number',
        content: const Text('Please enter a valid phone number.'),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-sign in the user (optional)
        },
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
          Get.snackbar('Error', errorMessage);
        },
        codeSent: (String verificationId, int? resendToken) async {
          storage.write('phoneNumber', phoneNumber); // Store phone number in GetStorage
          LoginScreen.verify = verificationId;
          Get.toNamed(otpScreen);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          LoginScreen.verify = verificationId;
        },
      );
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'Failed to verify phone number. Please try again.');
    }
  }
}
