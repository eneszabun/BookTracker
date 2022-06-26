import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_logging_app/states/current_user.dart';
import 'package:book_logging_app/utils/add_bookshelf.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OurCardBook extends StatefulWidget {
  // final Widget child;
  final String title;
  final String author;
  final String imageUrl;
  final String averageRating;
  final String publishedDate;
  final String description;
  final int pageCount;
  final String isbn;

  const OurCardBook({
    Key? key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.averageRating,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.isbn,
  }) : super(key: key);

  @override
  State<OurCardBook> createState() => _OurCardBookState();
}

class _OurCardBookState extends State<OurCardBook> {
  @override
  Widget build(BuildContext context) {
    BookAdd _bookadd = BookAdd();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var uid = _currentUser.getCurrentUser.uid.toString();
    bool click = true;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      color: Colors.grey,
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      Image.network(widget.imageUrl.toString()).image,
                ),
                IconButton(
                  onPressed: () {
                    _bookadd.addUsersBook(uid, widget.isbn, widget.title,
                        widget.author, widget.imageUrl);
                    setState(() {
                      click = !click;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.bookmark,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                AutoSizeText('Rating:${widget.averageRating}',
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    minFontSize: 18,
                    maxFontSize: 24,
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Flex(
              clipBehavior: Clip.antiAlias,
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AutoSizeText(
                      widget.author,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      widget.description,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 18,
                      maxFontSize: 24,
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      // 'Publish Date:$publishedDate',
                      widget.isbn,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      minFontSize: 18,
                      maxFontSize: 24,
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OurCardBestSeller extends StatelessWidget {
  // final Widget child;
  final String title;
  final String author;
  final String imageUrl;
  final String description;

  const OurCardBestSeller({
    Key? key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookAdd _bookadd = BookAdd();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var uid = _currentUser.getCurrentUser.uid.toString();
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      color: Colors.grey,
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: Image.network(imageUrl.toString()).image,
                ),
                IconButton(
                  onPressed: () {
                    _bookadd.addUsersBook(uid, '0', title, author, imageUrl);
                  },
                  icon: Icon(
                    FontAwesomeIcons.bookmark,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
            Flex(
              clipBehavior: Clip.antiAlias,
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AutoSizeText(
                      author,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //* card widget'ına gerekli olan bilgileri ekleyip son halini oluşturmamız lazım.
                    AutoSizeText(description,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        minFontSize: 18,
                        maxFontSize: 24,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
