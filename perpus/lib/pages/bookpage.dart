import 'dart:async';
import 'package:flutter/material.dart';
import 'package:perpus/controller/bookcontroller.dart';
import 'package:perpus/models/book.dart';
import 'package:perpus/pages/bookdetail.dart';

import 'package:perpus/widgets/add.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  State<Bookpage> createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> {
  Bookcontroller bookController = Bookcontroller();
  List<BookModel>? books;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  void getBooks() {
    setState(() {
      books = bookController.book;
    });
  }

  void _addBook(BookModel newBook) {
    setState(() {
      books!.add(newBook);
    });
  }

  void _deleteBook(int index) {
    setState(() {
      books!.removeAt(index);
    });
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBookDialog(onAdd: _addBook, books: books);
      },
    );
  }

  void _navigateToBookDetail(BookModel book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            "BOOKS",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header Banner
              SizedBox(
                height: 100,
                child: PageView.builder(
                  itemCount: books!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _navigateToBookDetail(books![index]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(books![index].imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          books![index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              // Section Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Horizontal Scrollable List of Books with Delete Button
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _navigateToBookDetail(books![index]),
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    books![index].imagePath,
                                    height: 245,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    books![index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    books![index].author,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteBook(index);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Recently Updated Section Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Top Favorite',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Grid View for Recently Updated Books with Delete Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: books!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _navigateToBookDetail(books![index]),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    books![index].imagePath,
                                    height: 245,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteBook(index);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
