import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_enter_number.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          LoginScreen.verify = verificationId;
          Get.toNamed('/otpScreen');
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Login",
          style: TextStyle(color: CustomColor.textColor, fontSize: 33),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        const Text(
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
    );
  }
}
