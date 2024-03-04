import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:intl/intl.dart';


class MyBookContainer extends StatelessWidget {
  MyBookContainer({Key? key, required this.bookDetail, required this.onTap, this.dueDateDetails})
      : super(key: key);
  var bookDetail;
  var dueDateDetails;
  final VoidCallback onTap;

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            SizedBox(
              height: 130,
              width: 100,
              child: Image.network(
                bookDetail.coverImage,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookDetail.bookName,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: appStyle(16, kIsWeb ? Colors.black : Colors.white,
                          FontWeight.normal),
                    ),
                    Text(
                      bookDetail.authorName,
                      softWrap: true,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: appStyle(16, mainColor, FontWeight.normal),
                    ),
                    kIsWeb ? SizedBox.shrink() :const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          bookDetail.publisher.toString(),
                          style: roundFont(
                              16,
                              kIsWeb ? Colors.black : Colors.white,
                              FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          color: kIsWeb ? Colors.black : Colors.white,
                          width: 1,
                          height: 13,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          bookDetail.language,
                          style: roundFont(
                              16,
                              kIsWeb ? Colors.black : Colors.white,
                              FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          color: kIsWeb ? Colors.black : Colors.white,
                          width: 1,
                          height: 13,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.picture_as_pdf_outlined,
                          color: kIsWeb ? Colors.black : Colors.white,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          bookDetail.pageCount.toString(),
                          style: roundFont(
                              16,
                              kIsWeb ? Colors.black : Colors.white,
                              FontWeight.normal),
                        ),
                      ],
                    ),

                    kIsWeb ? Row(
                      children: [
                        Text(
                    dueDateDetails.isReturned ?  "Returned Date : " : "Due Date : ",
                          style: roundFont(
                              16,
                              kIsWeb ? Colors.black : Colors.white,
                              FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          dueDateDetails.isReturned? convertToIST(dueDateDetails.returnedDate.toString()) : convertToIST(dueDateDetails.dueDate.toString()),
                          style: roundFont(
                              16,
                              kIsWeb ? Colors.black : Colors.white,
                              FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 8,
                        ),

                      ],
                    ) : SizedBox.shrink()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
