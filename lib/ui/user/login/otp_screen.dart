import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController pinController = TextEditingController();
  String code = "";

  void _verifyOtp() async {
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "OTP Verify",
                style: TextStyle(color: CustomColor.textColor, fontSize: 33),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Pinput(
                length: 6,
                autofillHints: const [AutofillHints.oneTimeCode],
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: pinController,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomButton(
                buttonColor: CustomColor.buttonColor,
                buttonText: "Submit",
                onTap: () => _verifyOtp(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
