import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/constrant/customColor.dart';
import 'package:site_construct/utils/common/common_widgets/customButton.dart';
import 'package:site_construct/utils/common/common_widgets/customEnterNumber.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String verify = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  void _verifyPhoneNumber() async {
    String phoneNumber = countryCode.text + numberController.text.trim();
    if (phoneNumber.length < 10) {
      Get.defaultDialog();
      return;
    }

    try {
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
        codeSent: (String verificationId, int? resendToken) {
          LoginPage.verify = verificationId;
          Get.toNamed('/otpPage');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("Failed to verify phone number. Please try again.", "");
    }
  }

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
              Text(
                "Login",
                style: TextStyle(color: CustomColor.textColor, fontSize: 33),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
                style: TextStyle(color: CustomColor.lightGrey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.10,
              ),
              CustomEnterNumber(
                countryCode: countryCode,
                numberController: numberController,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomButton(
                buttonColor: CustomColor.buttonColor,
                buttonText: "Send OTP",
                onTap: () {
                  _verifyPhoneNumber();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
