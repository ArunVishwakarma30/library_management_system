import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/views/common/my_book_container.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../common/app_style.dart';

class UserHistory extends StatefulWidget {
  UserHistory({Key? key, required this.userDetail}) : super(key: key);
  var userDetail;

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(

      builder: (context, menuProvider, child) {
        menuProvider.userHistory(widget.userDetail.id);
        return Scaffold(
          appBar: AppBar(
            title: Text("${widget.userDetail.firstName}'s History",
                style: roundFont(18, blackColor, FontWeight.normal)),
          ),
          body: FutureBuilder(
              future: menuProvider.booksHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No users are available"),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                       MyBookContainer(bookDetail: snapshot.data![index].bookId, onTap: (){}, dueDateDetails:snapshot.data![index] ),
                        Divider()
                      ],
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
