import 'package:cloud_firestore/cloud_firestore.dart';

class SavedBook {
  final String id;
  final String isbn;
  final String title;
  final String authors;
  final String imageUrl;

  SavedBook(
      {required this.id,
      required this.isbn,
      required this.title,
      required this.authors,
      required this.imageUrl});

  factory SavedBook.fromSnapshot(DocumentSnapshot snapshot) {
    return SavedBook(
      id: snapshot.id,
      isbn: snapshot["isbn"],
      title: snapshot["title"],
      authors: snapshot['authors'],
      imageUrl: snapshot['imageUrl'],
    );
  }
}
