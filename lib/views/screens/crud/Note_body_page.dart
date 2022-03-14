import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_night/routes/routes.dart';

class Note_body_page extends StatefulWidget {
  final String Note_body;
  final String Note_title;
  final String imageurl;

  const Note_body_page(
      {Key? key,
      required this.Note_body,
      required this.Note_title,
      required this.imageurl})
      : super(key: key);

  @override
  _ProductDetilsState createState() => _ProductDetilsState(
      Note_body: Note_body, Note_title: Note_title, imageurl: imageurl);
}

class _ProductDetilsState extends State<Note_body_page> {
  final String Note_body;
  final String Note_title;
  final String imageurl;

  _ProductDetilsState(
      {required this.Note_body,
      required this.Note_title,
      required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF111631),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xFF7423A8),
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.editnote);
                },
              )
            ],
            title: Title(
                title: 'Title',
                color: Colors.white,
                child: Text(
                  'product details'.tr,
                  style: const TextStyle(
                    color: Color(0xFF7423A8),
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ))),
        body: ListView(children: <Widget>[
          Hero(
            tag: "avatar_" ' $Note_title',
            child: Image.network(imageurl),

          ),
          // 3
          GestureDetector(
              child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                Expanded(
                  // Name and Address are in the same column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Title " ' $Note_title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for address.
                      Text(
                        "body: " ' $Note_body',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon to indicate the phone number.


              ],
            ),
          )),
        ]));
  }
}

// Card(
// margin: const EdgeInsets.all(10),
// shadowColor: Colors.black,
// color: Colors.black12,
// elevation: 10.0,
// child: Column(
// children: [
// Card(
// elevation: 50,
// shadowColor: Colors.black,
// color: Colors.indigo,
// child: SizedBox(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height-150,
// child: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// children: [
// const SizedBox(
// height: 10,
// ), //SizedBox
// Text(
// ' $Note_title',
// style: const TextStyle(
// fontSize: 30,
// color: Colors.black,
// fontWeight: FontWeight.w500,
// ), //Textstyle
// ), //Text
// const SizedBox(
// height: 10,
// ), //SizedBox
// Container(
// alignment: Alignment.topLeft,
// child: Text(
// ' $Note_body',
// style: const TextStyle(
// fontSize: 15,
// color: Colors.black54,
// ), //Textstyle
// ),
// ), //Text
// const SizedBox(
// height: 10,
// ), //SizedBox
// //SizedBox
// ],
// ), //Column
// ), //Padding
// ), //SizedBox
// ),
// ],
// ),
// ),
