import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profile_controller.dart';
import 'widgets/profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: ProfilePage(),
            ),
          ),
        ),
      ),
    );
  }
}