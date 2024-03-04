import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/models/req_models/borrow_or_return_req_model.dart';
import 'package:library_management_system/models/res_models/get_all_books_res_model.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:flutter/rendering.dart';
import 'package:library_management_system/views/common/snack_bar.dart';
import 'package:provider/provider.dart';

import '../../models/res_models/search_user_res_model.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({
    Key? key,
    required this.bookDetails,
  }) : super(key: key);
  final GetAllBooksResModel bookDetails;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails>
    with TickerProviderStateMixin {
  late TabController tabController;
  String? args;
  String buttonText = "Reserve";
  String? radioValue;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    args = Get.arguments;
    radioValue = "";
    searchController = TextEditingController();

    // Move the search operation to initState
    if (args == "IssueNewBook") {
      // Only trigger searchUser if it's necessary
      Provider.of<MenuProvider>(context, listen: false).searchUser("!", false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (args == "IssueNewBook") {
      buttonText = "Issue book";
    } else if (kIsWeb) {
      buttonText = "Edit";
    } else if (!kIsWeb && widget.bookDetails.available != 0) {
      buttonText = "Collect from library";
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Container(
            color: mainColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Image.network(
                  widget.bookDetails.coverImage,
                  height: 180,
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  widget.bookDetails.bookName,
                  textAlign: TextAlign.center,
                  style: roundFont(16, Colors.white, FontWeight.normal),
                )),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  widget.bookDetails.authorName,
                  textAlign: TextAlign.center,
                  style: roundFont(16, Colors.grey, FontWeight.normal),
                )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.bookDetails.publishYear.toString(),
                      style: roundFont(16, Colors.white, FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      color: Colors.white,
                      width: 1,
                      height: 13,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.bookDetails.language,
                      style: roundFont(16, Colors.white, FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      color: Colors.white,
                      width: 1,
                      height: 13,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.bookDetails.available > 0
                          ? "Available"
                          : "Not available",
                      style: roundFont(16, Colors.white, FontWeight.normal),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (args == "IssueNewBook") {
                        showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Consumer<MenuProvider>(
                                builder: (context, menuProvider, child) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(

                                    title: const Text('Search Student/Staff'),
                                    content: Container(
                                      width: 650,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 600,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: blackColor,
                                                    width: 1)),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 500,
                                                  child: TextField(
                                                    controller:
                                                        searchController,
                                                    cursorColor: mainColor,
                                                    style: roundFont(
                                                        17,
                                                        blackColor,
                                                        FontWeight.normal),
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter name or PSID",
                                                        hintStyle: roundFont(
                                                            17,
                                                            blackColor,
                                                            FontWeight.bold),
                                                        border:
                                                            InputBorder.none),
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
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (searchController.text
                                                          .trim()
                                                          .isEmpty) {
                                                        ShowSnackbar(
                                                            title: "Failed",
                                                            message:
                                                                "Please enter name or PSID",
                                                            icon: Icons
                                                                .error_outline_outlined);
                                                      } else {
                                                        menuProvider.searchUser(
                                                            searchController
                                                                .text,
                                                            true);
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.search,
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          FutureBuilder<
                                              List<SearchUserResponseModel>>(
                                            future: menuProvider.searchRes,
                                            // Ensure searchRes is not null
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator(); // Show loading indicator while waiting for data
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}'); // Show error message if there's an error
                                              } else {
                                                // Build ListView.builder with search results
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data?.length ??
                                                          0,
                                                  // Access length property from snapshot.data
                                                  itemBuilder:
                                                      (context, index) {
                                                    var userAtCurrentIndex =
                                                        snapshot.data![index];
                                                    return ListTile(
                                                      title: Text(
                                                          "${userAtCurrentIndex.firstName} ${userAtCurrentIndex.lastName}",
                                                          style: roundFont(
                                                              18,
                                                              blackColor,
                                                              FontWeight
                                                                  .normal)),
                                                      subtitle: Text(
                                                          'PSID: ${userAtCurrentIndex.psid}',
                                                          style: roundFont(
                                                              18,
                                                              blackColor,
                                                              FontWeight
                                                                  .normal)),
                                                      trailing: Radio<String>(
                                                        value:
                                                            userAtCurrentIndex
                                                                .id,
                                                        groupValue: radioValue,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            radioValue = value;
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: const Text('Issue'),
                                        onPressed: () {
                                          if (radioValue!.isEmpty) {
                                            ShowSnackbar(
                                                title: "Failed",
                                                message:
                                                    "Please select any staff or student",
                                                icon: Icons.error_outline);
                                          } else {
                                            BorrowOrReturnBookReqModel model = BorrowOrReturnBookReqModel(bookId: widget.bookDetails.id, userId: radioValue!);
                                            menuProvider.borrowBook(model, true);
                                          Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: lightBlue),
                    child: Text(
                      buttonText,
                      style: roundFont(20, Colors.black, FontWeight.bold),
                    )),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          TabBar(
              physics: const NeverScrollableScrollPhysics(),
              isScrollable: kIsWeb,
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: mainColor,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "About",
                    style: roundFont(20, Colors.black, FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Description",
                    style: roundFont(20, Colors.black, FontWeight.bold),
                  ),
                ),
              ]),
          SizedBox(
            height: 300,
            child: TabBarView(controller: tabController, children: [
              DataTable(
                  columnSpacing: 0,
                  headingRowHeight: 0,
                  dividerThickness: 0,
                  columns: const [
                    DataColumn(label: SizedBox.shrink()),
                    DataColumn(label: SizedBox.shrink()),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        "Year",
                        style: roundFont(18, Colors.black45, FontWeight.normal),
                      )),
                      DataCell(Text(
                        widget.bookDetails.publishYear.toString(),
                        style: roundFont(18, Colors.black, FontWeight.normal),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Edition : ",
                        style: roundFont(18, Colors.black45, FontWeight.normal),
                      )),
                      DataCell(Text(
                        widget.bookDetails.edition.toString(),
                        style: roundFont(18, Colors.black, FontWeight.normal),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Publisher : ",
                        style: roundFont(18, Colors.black45, FontWeight.normal),
                      )),
                      DataCell(Text(
                        widget.bookDetails.publisher,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Language : ",
                        style: roundFont(18, Colors.black45, FontWeight.normal),
                      )),
                      DataCell(Text(
                        widget.bookDetails.language,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Page : ",
                        style: roundFont(18, Colors.black45, FontWeight.normal),
                      )),
                      DataCell(Text(
                        widget.bookDetails.pageCount.toString(),
                        style: roundFont(18, Colors.black, FontWeight.normal),
                      )),
                    ]),
                  ]),
              Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 13),
                  child: Text(
                    widget.bookDetails.bookDescription,
                    maxLines: 13,
                    overflow: TextOverflow.ellipsis,
                    style: roundFont(18, Colors.black, FontWeight.normal),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
