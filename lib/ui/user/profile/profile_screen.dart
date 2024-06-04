import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/ui/user/profile/widgets/profile_page.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

import '../../../utils/common/common_widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:ProfilePage(),
        ),
      ),
    );
  }
}
