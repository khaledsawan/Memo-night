import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Notes_Controller.dart';
import 'package:memo_night/logic/Controllers/app_language.dart';
import 'package:memo_night/logic/Controllers/Login_Controller.dart';
import 'package:memo_night/routes/routes.dart';
import 'package:memo_night/views/screens/auth/login.dart';
import 'package:memo_night/views/screens/crud/Note_body_page.dart';
import '../../../logic/Controllers/Auth_Controller.dart';

class Notes extends GetView<Notes_Controller> {
  Notes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginController());
    AuthController authService = Get.find();
    String _selectedLang = 'en';

    late final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Notes')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF111631),
          title: Title(
            title: 'Title',
            color: Colors.white,
            child: Text(
              'Product list'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
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
                            dropdownColor: const Color(0xFF0A0E21),
                            underline: const SizedBox(
                              width: 70,
                            ),
                            icon: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.language,
                                color: Colors.white,
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
              /*leading: IconButton(
          icon: Icon(Icons.search_outlined),
          //onPressed:() => Navigator.pop(context, false),
          onPressed: () => Navigator.pop(context),
        ),*/
            ),
          ]),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0A0E21),
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0A0E21),
              ),
              child: Center(
                  child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  color: Color(0xED40066A),
                ),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.vpn_lock_rounded),
              title: Text(
                'Language'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color(0xDAFFFFFF),
                ),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(
                'Contact Us'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color(0xDAFFFFFF),
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.contactus);
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: Text(
                'Log Out'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color(0xDAFFFFFF),
                ),
              ),
              onTap: () async {
                Get.offAll(() => Login());
                await authService.DoLogout();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.blueAccent),
          backgroundColor: Colors.indigo,
          onPressed: () {
            Get.toNamed(AppRoutes.addnote);
          }),
      body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                late Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(data);
                return GestureDetector(
                  onTap: () {
                    Get.to(Note_body_page(
                      Note_body: data['body'],
                      Note_title: data['title'],
                      imageurl: data['imageurl'],
                    ));
                  },
                  child:
                  Card(
                    key: ValueKey(data['title']),
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.white24))),
                            child: Hero(
                                tag: "avatar_" + data['title'],
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(data['imageurl']),
                                )
                            )
                        ),
                        title: Text(
                          data['title'],
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            new Flexible(
                                child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          text: data['body'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        maxLines: 3,
                                        softWrap: true,
                                      )
                                    ]))
                          ],
                        ),
                        trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                        onTap: () {
                          Get.to(Note_body_page(
                            Note_body: data['body'],
                            Note_title: data['title'],
                            imageurl: data['imageurl'],
                          ));
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

/////////
// Container(
// margin: const EdgeInsets.all(3),
// padding: const EdgeInsets.all(3),
// color: const Color(0xFF7423A8),
// child: Column(
// children: [
// Row(
// children: [
// Container(
// margin: const EdgeInsets.all(1),
// padding: const EdgeInsets.all(1),
// alignment: AlignmentDirectional.topStart,
// child: Text(
// data['title'],
// style: const TextStyle(fontSize: 30),
// )),
// ],
// ),
// Container(
// margin: const EdgeInsets.all(1),
// padding: const EdgeInsets.all(1),
// height: 190.0,
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Colors.blue,
// image: DecorationImage(
// image: NetworkImage(data['imageurl']),
// fit: BoxFit.fill)),
// ),
// ],
// ),
// ),