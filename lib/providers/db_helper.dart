import 'dart:convert';
import 'package:book_logging_app/services/book_database.dart';
import 'package:http/http.dart' as http;

class Books {
  static Future<List<BookLists>> callBook(String? query) async {
    // var uri = Uri.https('google-books.p.rapidapi.com', 'volumes');
    // final response = await http.get(uri, headers: {
    //   'X-RapidAPI-Key': 'e453c2b1e0msh33497bf8ca02e8dp13e724jsn682ffc87c500',
    //   'X-RapidAPI-Host': 'google-books.p.rapidapi.com'
    // });
    var fetchUri =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=AIzaSyAx6Uv9e5aJ5kSYypF6S5OnF7ONSv4IBfg';
    final response = await http.get(Uri.parse(fetchUri));
    Map data = json.decode(response.body);
    List _temp = [];
    for (var i in data['items']) {
      _temp.add(i['volumeInfo']);
    }
    if (query != null) {
      _temp.where((element) =>
          element.title!.toLowerCase().contains(query.toLowerCase()).toList());
    }
    return BookLists.bookListsFromSnapshot(_temp);
  }

  static Future<List<BestSellerBooks>> callBestSellerBooks() async {
    var fetchUri =
        'https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=j84sw4Ay0dIkikBZfIfJrJHaJBnOMdZg';
    final response = await http.get(Uri.parse(fetchUri));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map['results']['books'] ?? [];
    return BestSellerBooks.bookListsFromSnapshot(data);
  }

  // static Future<List<BookLists>> callBookshelf() async {
  //   const String apiLink =
  //       'https://www.googleapis.com/books/v1/mylibrary/bookshelves/0/volumes?key=AIzaSyAx6Uv9e5aJ5kSYypF6S5OnF7ONSv4IBfg';
  //   const String tokenValue =
  //       '984850102405-cq8hsmln8kfjnu99ip7dfu61seskhj85.apps.googleusercontent.com';
  //   final http.Response response = await http.get(Uri.parse(apiLink),
  //       headers: {"Authorization": 'Bearer:${tokenValue}'});
  //   Map data = json.decode(response.body);
  //   List _temp = [];
  //   for (var i in data['items']) {
  //     _temp.add(i['volumeInfo']);
  //   }
  //   return BookLists.bookListsFromSnapshot(_temp);
  // }

  static Future<List<BookLists>> listBook(query) async {
    var fetchUri =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:$query&key=AIzaSyAx6Uv9e5aJ5kSYypF6S5OnF7ONSv4IBfg';
    final response = await http.get(Uri.parse(fetchUri));
    Map data = json.decode(response.body);
    List _temp = [];
    for (var i in data['items']) {
      _temp.add(i['volumeInfo']);
    }
    if (query != null) {
      _temp.where((element) =>
          element.title!.toLowerCase().contains(query.toLowerCase()).toList());
    }
    return BookLists.bookListsFromSnapshot(_temp);
  }
}
