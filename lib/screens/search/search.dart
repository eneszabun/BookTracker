// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_logging_app/providers/db_helper.dart';
import 'package:book_logging_app/services/book_database.dart';
import 'package:book_logging_app/widgets/ourcard.dart';
import 'package:flutter/material.dart';

class OurSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.grey,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: FutureBuilder<List<BookLists>>(
        future: Books.callBook(query),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.grey,
                      child: ListTile(
                        leading: Image.network('${data?[index].imageLinks}',
                            fit: BoxFit.fill),
                        title: AutoSizeText(
                          '${data?[index].title}',
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
                          '${data?[index].authors}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto'),
                        ),
                        trailing: AutoSizeText(
                          '${data?[index].language}',
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
                                return OurCardBook(
                                  title: '${data?[index].title}',
                                  author: '${data?[index].authors}',
                                  imageUrl: '${data?[index].imageLinks}',
                                  description: '${data?[index].description}',
                                  averageRating:
                                      '${data?[index].averageRating}',
                                  pageCount: 5,
                                  publishedDate: '',
                                  isbn: '${data?[index].isbn}',
                                );
                              });
                        },
                      ),
                    );
                  }),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text('Search Books'),
      ),
    );
  }
}
