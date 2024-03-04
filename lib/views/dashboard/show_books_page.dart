import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/views/common/book_container.dart';
import 'package:library_management_system/views/menu_screeens/book_details.dart';
import 'package:provider/provider.dart';

class ShowBooksPage extends StatelessWidget {
  int crossAxisCount(double width) {
    if (width > 1496) {
      return 5;
    }
    if (width > 1240) {
      return 4;
    }
    if (width > 1000) {
      return 3;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int axisCount = crossAxisCount(width);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        body: Consumer<MenuProvider>(
          builder: (context, menuProvider, child) {
            menuProvider.getAllBooks();
            return FutureBuilder(
                future: menuProvider.allBooks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No books are available"),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error : ${snapshot.error}"),
                    );
                  } else {
                    return GridView.builder(
                      padding: const EdgeInsets.only(left: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            axisCount, // Number of columns in the grid
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var bookAtCurrentIndex = snapshot.data![index];
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => BookDetails(bookDetails: snapshot.data![index],));
                            },
                            child: BookContainer(
                                name: bookAtCurrentIndex.bookName,
                                author: bookAtCurrentIndex.authorName,
                                image: bookAtCurrentIndex.coverImage));
                      },
                    );
                  }
                });
          },
        ));
  }
}
