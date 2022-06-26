// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_logging_app/providers/db_helper.dart';
import 'package:book_logging_app/services/book_database.dart';
import 'package:book_logging_app/utils/add_bookshelf.dart';
import 'package:book_logging_app/widgets/ourcard.dart';
import 'package:book_logging_app/widgets/ourdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/cloudbuild/v1.dart';
import 'package:provider/provider.dart';

import '../../states/current_user.dart';

// class OurBooks extends StatefulWidget {
//   const OurBooks({Key? key}) : super(key: key);
//   @override
//   _OurBooks createState() => _OurBooks();
// }

// class _OurBooks extends State<OurBooks> {
//   late List<BookLists> _bookList;
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> getBookList() async {
//     _bookList = (await Books.callBookshelf());
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             Text(_currentUser.getCurrentUser.userName.toString() + "'s Books"),
//       ),
//       body: Container(
//         child: FutureBuilder<List<BookLists>>(
//           future: Books.listBook(''),
//           builder: (context, snapshot) {
//             var data = snapshot.data;
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: ListView.builder(
//                     itemCount: data?.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         clipBehavior: Clip.antiAlias,
//                         color: Colors.grey,
//                         child: ListTile(
//                           leading: Image.network('${data?[index].imageLinks}',
//                               fit: BoxFit.fill),
//                           title: AutoSizeText(
//                             '${data?[index].title}',
//                             textAlign: TextAlign.center,
//                             maxFontSize: 16,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Theme.of(context).canvasColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Roboto'),
//                           ),
//                           subtitle: AutoSizeText(
//                             '${data?[index].authors}',
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Theme.of(context).canvasColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Roboto'),
//                           ),
//                           trailing: AutoSizeText(
//                             '${data?[index].language}',
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Theme.of(context).canvasColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Roboto'),
//                           ),
//                           onTap: () {
//                             showModalBottomSheet(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return OurCardBook(
//                                     title: '${data?[index].title}',
//                                     author: '${data?[index].authors}',
//                                     imageUrl: '${data?[index].imageLinks}',
//                                     description: '${data?[index].description}',
//                                     averageRating:
//                                         '${data?[index].averageRating}',
//                                     pageCount: 5,
//                                     publishedDate: '', isbn: '${data?[index].isbn}',
//                                   );
//                                 });
//                           },
//                         ),
//                       );
//                     }),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
class OurBooks extends StatefulWidget {
  const OurBooks({Key? key}) : super(key: key);
  @override
  _OurBooks createState() => _OurBooks();
}

class _OurBooks extends State<OurBooks> {
  BookAdd _getBook = BookAdd();
  @override
  void initState() {
    super.initState();
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var uid = _currentUser.getCurrentUser.uid.toString();

    return Scaffold(
      appBar: AppBar(
        title:
            Text(_currentUser.getCurrentUser.userName.toString() + "'s Books"),
      ),
      body: StreamBuilder(
        stream: db
            .collection('users')
            .doc(uid)
            .collection('bookshelves')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.grey,
                    child: ListTile(
                      leading: Image.network('${documentSnapshot['imageUrl']}',
                          fit: BoxFit.fill),
                      title: AutoSizeText(
                        '${documentSnapshot['title']}',
                        textAlign: TextAlign.center,
                        maxFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto'),
                      ),
                      subtitle: AutoSizeText(
                        '${documentSnapshot['authors']}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto'),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return OurCardBestSeller(
                                title: '${documentSnapshot['title']}',
                                author: '${documentSnapshot['authors']}',
                                imageUrl: '${documentSnapshot['imageUrl']}',
                                description: '',
                              );
                            });
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
