import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:site_construct/firebase_options.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/addNewSite/add_new_site.dart';
import 'package:site_construct/ui/user/addNewSite/binding/add_new_site_binding.dart';
import 'package:site_construct/ui/user/login/binding/login_binding.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/ui/user/navigationMenu/navigation_menu.dart';
import 'package:site_construct/ui/user/onBoarding/on_boarding_screen.dart';
import 'package:site_construct/ui/user/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Site Construction',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: routes,
      home: const AddNewSite(),
      initialRoute: addNewSiteScreen,
      initialBinding: AddNewSiteBinding(),
    );
  }
}
