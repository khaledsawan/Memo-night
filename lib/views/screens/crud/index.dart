import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_night/Databease/model/note_model.dart';
import 'package:memo_night/views/screens/crud/add_note.dart';
import '../../../logic/Controllers/AddNote_Controller.dart';
import '../../../logic/Controllers/Auth_Controller.dart';
import '../../../logic/Controllers/Login_Controller.dart';
import '../../../logic/Controllers/app_language.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import 'note_body_page.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  AuthController authService = Get.find();
  final String _selectedLang = 'en';
  late Map<String, dynamic> data;
  late final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Notes')
      .orderBy('time')
      .snapshots(includeMetadataChanges: true);
  List<Color> colorList = [
    const Color(0xff171B70),
    const Color(0xFF5D1C85),
    const Color(0xff032340),
    const Color(0xff050340),
    const Color(0xff2C0340),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = const Color(0xff092646);
  Color topColor = const Color(0xff410D75);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  String supString(String body) {
    if (body.length > 30) {
      return body.substring(0, 27) + '...';
    } else {
      return body;
    }
  }

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginController());
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = const Color(0xff33267C);
          },
        );
      },
    );
  }

  changeLanguageAlertDialog(
      BuildContext context, double height, double width, String id) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(45.0),
      )),
      backgroundColor: AppColors.mainColor,
      insetPadding: const EdgeInsets.only(left: 70, right: 70),
      content: SizedBox(
          height: height * 0.07,
          child: Center(
              child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  CollectionReference note =
                      FirebaseFirestore.instance.collection('Notes');
                  await note
                      .doc(id)
                      .delete()
                      .then((value) => const GetSnackBar(
                            title: '',
                            message: 'note deleted successfully',
                          ))
                      .catchError((error) => GetSnackBar(
                            title: 'Error',
                            message: error.toString(),
                          ));
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.delete_forever_outlined,
                      size: 40,
                      color: AppColors.red,
                    ),
                    Text(
                      'Delete Note',
                      style: GoogleFonts.marckScript(
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xDA00BBFF),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4, top: 2),
                height: 1,
                color: AppColors.blue,
              ),
            ],
          ))),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: Title(
              title: 'Title',
              color: Colors.white,
              child: Text('Memo Night'.tr,
                  style: GoogleFonts.marckScript(
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue,
                  )),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Directionality(
                  textDirection: _selectedLang == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<AppLanguage>(
                          init: AppLanguage(),
                          builder: (controllers) {
                            return DropdownButton(
                              dropdownColor: AppColors.mainColor,
                              underline: const SizedBox(
                                width: 70,
                              ),
                              icon: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.language,
                                  color: AppColors.iconColor1,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  child: Text("En"),
                                  value: 'en',
                                ),
                                DropdownMenuItem(
                                  child: Text("Ar"),
                                  value: 'ar',
                                ),
                              ],
                              value: controllers.appLocale,
                              onChanged: (dynamic value) {
                                controllers.changeLanguage(value);
                                Get.updateLocale(Locale(value));
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ]),
        drawer: Drawer(
          width: width * 0.6,
          backgroundColor:AppColors.mainColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF0A0E21),
                ),
                child: Center(
                    child: Text('Settings',
                        style: GoogleFonts.marckScript(
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                        ))),
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  color: AppColors.iconColor1,
                  size: 30,
                ),
                title: Text('Contact Us'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    )),
                onTap: () {
                  Get.toNamed(AppRoutes.contactus);
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              const Divider(
                color: AppColors.textColor,
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.logout,
                    color: AppColors.iconColor1, size: 30),
                title: Text('Log Out'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    )),
                onTap: () async {
                  Get.lazyPut(() => LoginController());

                  await authService.doLogout();
                  Get.lazyPut(() => AuthController());
                },
              ),
              const Divider(
                color: AppColors.textColor,
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: AppColors.blue),
            backgroundColor: Colors.indigo,
            onPressed: () {
              Get.lazyPut(() => AddNoteController());
              Get.to(const AddNote());
            }),
        body: AnimatedContainer(
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(
              () {
                index = index + 1;
                bottomColor = colorList[index % colorList.length];
                topColor = colorList[(index + 1) % colorList.length];
              },
            );
          },
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, topColor],
            ),
          ),
          child: StreamBuilder(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.size == 0) {
                  return Center(
                    child: SizedBox(
                      width: width * 0.33,
                      height: height * 0.2,
                      child: Image.asset('images/assets/empty box.png'),
                    ),
                  );
                }
                return AnimationLimiter(
                  child: GestureDetector(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        late Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        Timestamp t = data['time'];
                        DateTime d = t.toDate();

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            verticalOffset: -250,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: GestureDetector(
                                onLongPress: () {

                                  changeLanguageAlertDialog(
                                      context, height, width, document.id);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 8, top: 8),
                                  height: width / 4 + 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue2,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      NoteModel note = NoteModel(
                                          id: document.id,
                                          body: data['body'],
                                          title: data['title'],
                                          time: d.year.toString() +
                                              '/' +
                                              d.month.toString() +
                                              '/' +
                                              d.day.toString() +
                                              ' ' +
                                              d.hour.toString() +
                                              ':' +
                                              d.minute.toString(),
                                          imageUrl: data['imageUrl']);
                                      Get.to(NoteBodyPage(note: note));
                                    },
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 2, top: 2),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          data['imageUrl'],
                                                        ),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                width: width * 0.33,
                                                height: width / 3.3,
                                              ),
                                              SizedBox(
                                                width: width / 20,
                                              ),
                                              Column(
                                                //crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                      supString(data['title']),
                                                      style: const TextStyle(
                                                          color: AppColors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: width / 17,
                                                  ),
                                                  Container(
                                                      alignment: Alignment.bottomRight,
                                                      child: Text(
                                                        supString(data['body']),
                                                        style: const TextStyle(
                                                            color: AppColors.textColor,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.normal),
                                                      )),
                                                  SizedBox(
                                                    height: width / 27,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                      d.year.toString() +
                                                          '/' +
                                                          d.month.toString() +
                                                          '/' +
                                                          d.day.toString() +
                                                          ' ' +
                                                          d.hour.toString() +
                                                          ':' +
                                                          d.minute.toString(),
                                                      style: const TextStyle(
                                                          color: AppColors.grey)))
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
        ));
  }
}
