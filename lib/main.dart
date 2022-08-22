import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memo_night/logic/Controllers/Register_Controller.dart';
import 'package:memo_night/logic/bindings/Auth_binding.dart';
import 'package:memo_night/routes/routes.dart';
import 'package:memo_night/utils/langs/translations.dart';
import 'init/init.dart';
import 'logic/Controllers/Login_Controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.lazyPut(() => LoginController());
      Get.lazyPut(() => RegisterController());
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        secondaryHeaderColor: const Color(0xFF0A0E21),
        backgroundColor: const Color(0xFF0A0E21),
        buttonColor: const Color(0xFF550101),
        bottomAppBarColor: const Color(0xFF7423A8),
        cardColor: const Color(0xFF0D1D7F),
      ),
      translations: Translation(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
       getPages: AppRoutes.routes,
       initialRoute:AppRoutes.splashscreen ,
     // home: const Index(),
    );
  }
}
