import 'dart:io';

class Note {
  int? id;
  String? title;
  String? body;
  File? ImageUrl;

  Note(
      {required this.id,
      required this.body,
      required this.title,
      this.ImageUrl});
}
