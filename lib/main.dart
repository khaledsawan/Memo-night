import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mnv2/routes/routes.dart';
import 'package:mnv2/utils/colors.dart';
import 'package:mnv2/utils/langs/translations.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'init/init.dart';
import 'logic/Controllers/Login_Controller.dart';
import 'logic/Controllers/Register_Controller.dart';
import 'logic/bindings/Auth_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return Sizer(
      builder: (context, orientation, deviceType) {
           return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AuthBinding(),
          theme: ThemeData.dark().copyWith(
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor:AppColors.backGroundColor,
            secondaryHeaderColor: AppColors.backGroundColor,
            backgroundColor: AppColors.backGroundColor,
            buttonColor: AppColors.red,
            bottomAppBarColor: AppColors.iconColor1,
          ),
          translations: Translation(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          localizationsDelegates: const [
          ],
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.splashscreen,
        );
      },
    );
  }
}
