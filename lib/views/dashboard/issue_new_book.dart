import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../controllers/menu_provider.dart';
import '../common/app_style.dart';
import '../common/book_container.dart';
import '../menu_screeens/book_details.dart';

class IssueNewBook extends StatefulWidget {
  const IssueNewBook({Key? key}) : super(key: key);

  @override
  State<IssueNewBook> createState() => _IssueNewBookState();
}

class _IssueNewBookState extends State<IssueNewBook> {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    searchController.text = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

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

    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        menuProvider.searchBooks(searchController.text);
        return Scaffold(
          appBar: AppBar(
              title: Center(
            child: Container(
              width: 600,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: blackColor, width: 1)),
              child: Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: searchController,
                      cursorColor: mainColor,
                      style: roundFont(17, blackColor, FontWeight.normal),
                      onChanged: (value) {
                        if (value.isEmpty || value.trim().isEmpty) {
                          menuProvider.searchText = false;
                        } else {
                          menuProvider.searchText = true;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Search for...",
                          hintStyle: roundFont(17, blackColor, FontWeight.bold),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        menuProvider.searchBooks(searchController.text.trim());
                        print(searchController.text);
                      },
                      child: Icon(
                        menuProvider.searchText
                            ? Icons.search
                            : Icons.filter_list,
                        color: mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
          body: FutureBuilder(
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
                            Get.to(
                                () => BookDetails(
                                      bookDetails: snapshot.data![index],
                                    ),
                                arguments: "IssueNewBook");
                          },
                          child: BookContainer(
                              name: bookAtCurrentIndex.bookName,
                              author: bookAtCurrentIndex.authorName,
                              image: bookAtCurrentIndex.coverImage));
                    },
                  );
                }
              }),
        );
      },
    );
  }
}
