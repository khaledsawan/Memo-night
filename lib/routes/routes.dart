import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mnv2/views/View/crud/add_note.dart';
import 'package:mnv2/views/View/crud/index.dart';
import '../logic/bindings/AddNote_binding.dart';
import '../logic/bindings/login_binding.dart';
import '../logic/bindings/register_binding.dart';
import '../views/View/auth/login.dart';
import '../views/View/auth/sign_up.dart';
import '../views/mobile_view/contact_us/about_us_page.dart';
import '../views/mobile_view/crud/add_note_m.dart';
import '../views/mobile_view/crud/index_m.dart';
import '../views/mobile_view/splach_screen/splash_screen.dart';


class AppRoutes {
  static const addnote = Routes.add;
  static const editnote = Routes.editnote;
  static const notes = Routes.notes;
  static const contactus = Routes.contactus;
  static const signup = Routes.signup;
  static const login = Routes.login;
  static const splashscreen = Routes.splashscreen;
  static final routes = [
    GetPage(name: Routes.contactus,page: () => const AboutUsPage() ),
    GetPage(name: Routes.splashscreen,page: () =>  splachScreen() ),
    GetPage(name: Routes.signup, page: () => const SignUp(), binding: RegisterBinding()),
    GetPage(name: Routes.login, page: () => const Login(), binding: LoginBinding()),
    GetPage(name: Routes.add, page: () => const AddNote(), binding: AddNoteBinding()),
    GetPage(name: Routes.notes, page: () =>  const Index()),
  ];
}

class Routes {
  static const editnote = '/editnote';
  static const notes = '/';
  static const add = '/add';
  static const contactus = '/contactus';
  static const signup = '/signup';
  static const login = '/login';
  static const splashscreen = '/splashscreen';
}
