import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:site_construct/core/service/storageService.dart';
import 'package:site_construct/firebase_options.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/login/binding/login_binding.dart';
import 'package:site_construct/ui/user/login/login_screen.dart';
import 'package:site_construct/ui/user/navigationMenu/navigation_menu.dart';
import 'package:site_construct/ui/user/profile/controller/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(()=>ProfileController());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

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
      home: LoginScreen(),
      // home: StorageService.isLoggedIn() ? NavigationMenu() : LoginScreen(),
      // initialBinding: _firebaseAuth.currentUser == null ? LoginBinding() : null,
      initialBinding: LoginBinding(),

    );
  }
}
