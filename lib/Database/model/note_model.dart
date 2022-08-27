import 'dart:io';

class NoteModel {
  late String id;
  late String title;
  late String body;
  late String imageUrl;
  late String time;

  NoteModel({required this.id,
      required this.body,
      required this.title,
      required this.time,
      required this.imageUrl});
}
