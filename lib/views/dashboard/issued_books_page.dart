import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:provider/provider.dart';

import '../../models/res_models/all_borrowed_reserver_res.dart';

class IssuedBooksPage extends StatelessWidget {
  IssuedBooksPage({Key? key}) : super(key: key);

  String convertToIST(String utcDateString) {
    // Parse the string into a DateTime object
    DateTime utcDateTime = DateTime.parse(utcDateString);

    // Convert to local time zone (assuming UTC)
    DateTime istDateTime = utcDateTime.toLocal();

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat("dd MMMM yyyy").format(istDateTime);

    return formattedDate;
  }

  
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        menuProvider.getAllBorrowedAndReservedBooks(true);
        return FutureBuilder(
          future: menuProvider.allBorrowedAndReservedBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No books are issued"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else {
              List<AllBorrowedOrReserverdRes> borrowedBooks = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.black), // Add border decoration
                    ),
                    child: SizedBox(
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text(
                            '#',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Student Name',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Student PSID',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Book Name',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Issued Date',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Due Date',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'Action',
                            style: roundFont(18, blackColor, FontWeight.bold),
                          )),
                        ],
                        rows: borrowedBooks
                            .map(
                              (book) => DataRow(

                                cells: <DataCell>[
                                  DataCell(Text(
                                      (borrowedBooks.indexOf(book) + 1)
                                          .toString())),
                                  DataCell(Text(

                                    '${book.userId.firstName} ${book.userId.lastName}',
                                    maxLines: 4,

                                    style: roundFont(
                                        16, blackColor, FontWeight.normal),
                                  )),
                                  DataCell(Text(
                                    book.userId.psid,
                                    style: roundFont(
                                        16, blackColor, FontWeight.normal),
                                  )),
                                  DataCell(Container(
                                    width: 280,
                                    child: Text(
                                      book.bookId.bookName,
                                      maxLines: 5,
                                      style: roundFont(
                                          16, blackColor, FontWeight.normal),
                                    ),
                                  )),
                                  DataCell(Text(
                                    convertToIST(book.borrowedDate.toString()),
                                    style: roundFont(
                                        16, blackColor, FontWeight.normal),
                                  )),
                                  DataCell(Text(
                                    convertToIST(book.dueDate.toString()),
                                    style: roundFont(
                                        16, blackColor, FontWeight.normal),
                                  )),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add action here
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text(
                                        'Returned',
                                        style: roundFont(
                                            18, Colors.white, FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
