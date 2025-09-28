import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/otp/widgets/otp_page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: OtpPage(),
      ),
    );
  }
}
