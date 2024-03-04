import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/constants/constants.dart';

import '../common/app_style.dart';
import '../common/my_book_container.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({Key? key}) : super(key: key);

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: kIsWeb ? Colors.white :  blackColor,
        body: Column(
          children: [
            Container(
              width: kIsWeb ? width * 0.7 : width,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: mainColor,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Borrowed",
                      style: roundFont(20, kIsWeb ? Colors.black : Colors.white, FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Reserved",
                      style: roundFont(20, kIsWeb ? Colors.black : Colors.white, FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  ListView(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    children: [
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                      // MyBookContainer(),
                    ],
                  ),
                  Center(
                    child: Text("Reserved books details ",
                        style: appStyle(20, Colors.white, FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
