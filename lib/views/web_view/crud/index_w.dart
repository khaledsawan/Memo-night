import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnv2/views/View/crud/add_note.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/model/note_model.dart';
import '../../../logic/Controllers/AddNote_Controller.dart';
import '../../../logic/Controllers/Auth_Controller.dart';
import '../../../logic/Controllers/Login_Controller.dart';
import '../../../logic/Controllers/app_language.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../View/crud/note_body_page.dart';


class IndexW extends StatefulWidget {
  const IndexW({Key? key}) : super(key: key);

  @override
  _IndexWState createState() => _IndexWState();
}

class _IndexWState extends State<IndexW> with TickerProviderStateMixin {
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

  String supString(String body, double width, double height) {
    if (body.length > 100) {
      return '${body.substring(0, body.length)}...';
    } else {
      return body;
    }
  }

  String supStringTitle(String body) {
    if (body.length > 50) {
      return '${body.substring(0, 37)}...';
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
          height: height * 0.01.h,
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
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
                  //  Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.delete,
                        size: 30,
                        color: AppColors.red,
                      ),
                      Text(
                        'Delete Note',
                        style: GoogleFonts.marckScript(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color:  AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4, top: 4),
                  height: 1,
                  color: AppColors.blue,
                ),
              ],
            )),
          )),
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
              title: '',
              color:  AppColors.white,
              child: Center(
                child: Text('Memo Night'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 43,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    )),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
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
                              underline: SizedBox(
                                width: 70.h,
                              ),
                              icon: const Icon(
                                Icons.language,
                                color: AppColors.iconColor1,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Text(
                                    "En",
                                    style: TextStyle(fontSize: 4.sp),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'ar',
                                  child: Text(
                                    "Ar",
                                    style: TextStyle(fontSize: 4.sp),
                                  ),
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
          width: 225,
          backgroundColor: AppColors.mainColorA,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      child: Image.asset('images/assets/2040510.png'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text('Setting'.tr,
                          style: GoogleFonts.marckScript(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          )),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  color: AppColors.iconColor1,
                  size: 35,
                ),
                title: Text('Contact Us'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
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
                height: 1,
              ),
              ListTile(
                leading: const Icon(Icons.logout,
                    color: AppColors.iconColor1, size: 35),
                title: Text('Log Out'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
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
                height: 1,
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(2.h),
          padding: EdgeInsets.all(2.h),
          child: FloatingActionButton(
              backgroundColor: AppColors.indoo,
              onPressed: () {
                Get.lazyPut(() => AddNoteController());
                Get.to(const AddNote());
              },
              child: const Icon(
                Icons.edit,
                color: AppColors.blue,
                size: 25,
              )),
        ),
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
                  return Center(
                      child: Text(
                    'Something went wrong'.tr,
                    style: TextStyle(fontSize: 14.sp),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.size == 0) {
                  return Center(
                    child: SizedBox(
                      width: width * 0.05.h,
                      height: height * 0.05.h,
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
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      bottom: 1.h,
                                      top: 1.h),
                                  height: height * 0.04.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue2,
                                    borderRadius: BorderRadius.circular(2.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
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
                                          time:
                                              '${d.year}/${d.month}/${d.day} ${d.hour}:${d.minute}',
                                          imageUrl: data['imageUrl']);
                                      Get.to(NoteBodyPage(note: note));
                                    },
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 1.w,
                                                      right: 1.w),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            data['imageUrl'],
                                                          ),
                                                          fit: BoxFit.fill),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h)),
                                                  width: width * 0.18,
                                                  height: height * 0.034.h,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 1.w,
                                                          bottom: 5.h,
                                                          top: 1.h),
                                                      child: Text(
                                                        supStringTitle(
                                                            data['title']),
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                          fontSize: 30,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      child: SizedBox(
                                                        width: width * 0.75,
                                                        height:
                                                            height * 0.020.h,
                                                        child: Text(
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          supString(
                                                              data['body'],
                                                              width,
                                                              height),
                                                          //   style: GoogleFonts.robotoFlex(
                                                          // fontSize: 18,
                                                          //
                                                          // fontStyle: FontStyle.normal,
                                                          // fontWeight: FontWeight.w500,
                                                          // color: AppColors.white,
                                                          //   ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 1.w),
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                    '${d.year}/${d.month}/${d.day} ${d.hour}:${d.minute}',
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.grey))),
                                          ]),
                                    ),
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
