import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:memo_night/logic/bindings/AddNote_binding.dart';
import 'package:memo_night/logic/bindings/EditNotes_binding.dart';
import 'package:memo_night/logic/bindings/login_binding.dart';
import 'package:memo_night/logic/bindings/register_binding.dart';
import 'package:memo_night/views/screens/crud/edit_notes.dart';
import 'package:memo_night/views/screens/auth/login.dart';
import 'package:memo_night/views/screens/auth/signup.dart';
import 'package:memo_night/views/screens/splach_screen/splash_screen.dart';
import '../views/screens/contact_us/about_us_page.dart';
import '../views/screens/contact_us/about_us_page.dart';
import '../views/screens/crud/index.dart';
import 'package:memo_night/views/screens/crud/add_note.dart';

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
