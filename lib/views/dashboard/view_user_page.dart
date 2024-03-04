import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/views/dashboard/user_history.dart';
import 'package:library_management_system/views/menu_screeens/my_books_page.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../controllers/menu_provider.dart';
import '../common/app_style.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
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

    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        menuProvider.searchUser(searchController.text, false);
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
                          hintText: "Enter name or PSID",
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
                        menuProvider.searchUser(
                            searchController.text.trim(), false);
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
              future: menuProvider.searchRes,
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
                        ListTile(
                          onTap: (){
                            Get.to(()=>UserHistory(userDetail: snapshot.data![index],));
                          },
                          title: Text(
                              "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                              style:
                                  roundFont(18, blackColor, FontWeight.normal)),
                          subtitle: Text('PSID: ${snapshot.data![index].psid}',
                              style:
                                  roundFont(18, blackColor, FontWeight.normal)),
                          trailing: Text(
                              'Borrowed Books: ${snapshot.data![index].totalBooks}',
                              style:
                                  roundFont(18, blackColor, FontWeight.normal)),
                        ),
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
