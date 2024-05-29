import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';
import 'package:site_construct/constrant/customColor.dart';
import 'package:site_construct/ui/user/login/loginPage.dart';
import 'package:site_construct/utils/common/common_widgets/customButton.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController pinController = TextEditingController();
  String code = "";

  void _verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: LoginPage.verify,
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
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "OTP Verify",
                style: TextStyle(color: CustomColor.textColor, fontSize: 33),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Pinput(
                length: 6,
                autofillHints: [AutofillHints.oneTimeCode],
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
