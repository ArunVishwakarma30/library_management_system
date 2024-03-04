import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:library_management_system/views/common/my_book_container.dart';
import 'package:library_management_system/views/menu_screeens/book_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        menuProvider.getAllBooks();
        return Scaffold(
            appBar: AppBar(
                backgroundColor: blackColor,
                title: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: mainColor, width: 1)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width - 105,
                        child: TextField(
                          cursorColor: mainColor,
                          style: roundFont(17, Colors.grey, FontWeight.normal),
                          onChanged: (value) {
                            if (value.isEmpty || value.trim().isEmpty) {
                              menuProvider.searchText = false;
                            } else {
                              menuProvider.searchText = true;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search for...",
                              hintStyle:
                                  roundFont(17, Colors.grey, FontWeight.bold),
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
                      Icon(
                        menuProvider.searchText
                            ? Icons.search
                            : Icons.filter_list,
                        color: mainColor,
                      )
                    ],
                  ),
                )),
            backgroundColor: blackColor,
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
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MyBookContainer(
                          bookDetail: snapshot.data![index],
                          onTap: () {
                            Get.to(
                                () => BookDetails(
                                      bookDetails: snapshot.data![index],
                                    ),
                                transition: Transition.rightToLeft);
                          },
                        );
                      },
                    );
                  }
                }));
      },
    );
  }
}
