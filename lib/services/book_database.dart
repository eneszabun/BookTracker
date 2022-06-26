//*null dönen api verilerini başlangıç olarak boş alıp değer gelirse gelen veriyi kullandırıp boş alan kalmadan devam etmesini sağlamalıyız.

class BookLists {
  final String? title;
  final String? authors;
  String? imageLinks;
  final num? averageRating;
  final String? language;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final String? isbn;
  final String? industryIdentifiers;

  BookLists(
      {this.title,
      this.authors,
      this.imageLinks,
      this.averageRating,
      this.language,
      this.publishedDate,
      this.description,
      this.pageCount,
      this.isbn,
      this.industryIdentifiers});

  factory BookLists.fromJson(dynamic json) {
    return BookLists(
      title: json['title'] as String?,
      authors: json['authors'].toString(),
      imageLinks: json['imageLinks']?['smallThumbnail'] ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Book_red%3B_question_marks.svg/2000px-Book_red%3B_question_marks.svg.png',
      averageRating: json['averageRating'] ?? 0.0,
      language: json['language'] as String?,
      publishedDate: json['publishedDate'] ?? 'Cant find published date!',
      description: json['description'] ?? 'No description. Sorry!',
      pageCount: json['pageCount'] as int?,
      isbn: json['industryIdentifiers']?[0]['identifier'] as String?,
    );
  }
  static List<BookLists> bookListsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return BookLists.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Books{title: $title,authors:$authors,imageLinks:$imageLinks,averageRating:$averageRating,language:$language,publishedDate:$publishedDate,description:$description,pageCount:$pageCount}';
  }
}

class BestSellerBooks {
  final String? title;
  final String? author;
  String? imageLinks;
  final String? description;

  BestSellerBooks({this.title, this.author, this.imageLinks, this.description});

  factory BestSellerBooks.fromJson(dynamic json) {
    return BestSellerBooks(
      title: json['title'] as String?,
      author: json['author'].toString(),
      imageLinks: json['book_image'] ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Book_red%3B_question_marks.svg/2000px-Book_red%3B_question_marks.svg.png',
      description: json['description'] as String,
    );
  }
  static List<BestSellerBooks> bookListsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return BestSellerBooks.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Books{title: $title,authors:$author,imageLinks:$imageLinks,description: $description}';
  }
}
