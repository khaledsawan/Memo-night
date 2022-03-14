import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:memo_night/logic/bindings/AddNote_binding.dart';
import 'package:memo_night/logic/bindings/EditNotes_binding.dart';
import 'package:memo_night/logic/bindings/login_binding.dart';
import 'package:memo_night/logic/bindings/register_binding.dart';
import 'package:memo_night/views/screens/crud/EditNotes.dart';
import 'package:memo_night/views/screens/home_page/Notes.dart';
import 'package:memo_night/views/screens/auth/login.dart';
import 'package:memo_night/views/screens/auth/signup.dart';
import '../views/screens/offline page/ContactUs.dart';
import 'package:memo_night/views/screens/crud/addnote.dart';

class AppRoutes {
  static const addnote = Routes.addnote;
  static const editnote = Routes.editnote;
  static const notes = Routes.notes;
  static const contactus = Routes.contactus;
  static const mainpage = Routes.mainpage;
  static const signup = Routes.signup;
  static const login = Routes.login;
  static const splashscreen = Routes.splashscreen;
  static final routes = [

    GetPage(  name: Routes.contactus,page: () => ContactUs() ),
    GetPage(name: Routes.signup, page: () => Signup(), binding: RegisterBinding()),
    GetPage(name: Routes.login, page: () => Login(), binding: LoginBinding()),
    GetPage(name: Routes.addnote, page: () => AddNote(), binding: AddNote_binding()),
    GetPage(name: Routes.editnote, page: () => EditNotes(), binding: EditNotes_binding()),
    GetPage(name: Routes.notes, page: () => Notes()),
  ];
}

class Routes {
  static const editnote = '/editnote';
  static const notes = '/notes';
  static const addnote = '/addnote';
  static const contactus = '/contactus';
  static const mainpage = '/mainpage';
  static const signup = '/signup';
  static const login = '/login';
  static const splashscreen = '/splashscreen';
}
