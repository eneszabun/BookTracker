// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutablesimport 'package:book_logging_app/providers/db_helper.dart';, use_key_in_widget_constructors
import 'package:book_logging_app/providers/db_helper.dart';
import 'package:book_logging_app/screens/search/search.dart';
import 'package:book_logging_app/services/book_database.dart';
import 'package:book_logging_app/widgets/ourcard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/ourdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _OurHomeScreen createState() => _OurHomeScreen();
}

class _OurHomeScreen extends State<HomeScreen> {
  late List<BestSellerBooks> _bestSellerList;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getBookList() async {
    _bestSellerList = (await Books.callBestSellerBooks());
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("The New York Times Best Sellers",
            style: GoogleFonts.roboto(fontSize: 16)),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: OurSearch());
            },
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 16))
        ],
      ),
      body: Container(
        child: FutureBuilder<List<BestSellerBooks>>(
          future: Books.callBestSellerBooks(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).secondaryHeaderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(8)),
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
                          '${data?[index].author}',
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
                                  title: '${data?[index].title}',
                                  author: '${data?[index].author}',
                                  imageUrl: '${data?[index].imageLinks}',
                                  description: '${data?[index].description}',
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
      ),
    );
  }
}
