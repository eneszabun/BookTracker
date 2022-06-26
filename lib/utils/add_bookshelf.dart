import 'package:book_logging_app/models/saved_book.dart';
import 'package:book_logging_app/models/saved_book.dart';
import 'package:book_logging_app/states/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookAdd {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //* kitap ekleme fonksiyonu

  Future<SavedBook> addUsersBook(String uid, String isbn, String title,
      String authors, String imageUrl) async {
    var ref = _firestore.collection("users").doc(uid).collection("bookshelves");
    var documentRef = await ref.add({
      'isbn': isbn,
      'title': title,
      'authors': authors,
      'imageUrl': imageUrl
    });
    return SavedBook(
        id: documentRef.id,
        isbn: isbn,
        title: title,
        authors: authors,
        imageUrl: imageUrl);
  }

  // *kitap gösterme fonksiyonu
  Stream<QuerySnapshot> getBook() {
    var ref = _firestore.collection("bookshelf").snapshots();
    return ref;
  }

  // * kitap silme fonksiyonu
  Future<void> removeBook(String docId) {
    var ref = _firestore.collection("bookshelf").doc(docId).delete();
    return ref;
  }
}
