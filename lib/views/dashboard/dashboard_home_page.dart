import 'package:flutter/material.dart';
import 'package:library_management_system/views/dashboard/add_book_page.dart';
import 'package:library_management_system/views/dashboard/reserver_books_page.dart';
import 'package:library_management_system/views/dashboard/show_books_page.dart';
import 'package:library_management_system/views/dashboard/view_user_page.dart';
import 'package:side_navigation/side_navigation.dart';

import 'issue_new_book.dart';
import 'issued_books_page.dart';

class LibraryDashboard extends StatefulWidget {
  const LibraryDashboard({Key? key}) : super(key: key);

  @override
  _LibraryDashboardState createState() => _LibraryDashboardState();
}

class _LibraryDashboardState extends State<LibraryDashboard> {
  bool expandedState = false;

  /// Views to display
  List<Widget> views = [
    AddBook(),
    ShowBooksPage(),
    IssueNewBook(),
    ViewUsers(),
    ReservedBooksPage(),
    IssuedBooksPage()
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 800) {
      expandedState = false;
    } else {
      expandedState = true;
    }

    return Scaffold(
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            initiallyExpanded: expandedState,
            expandable: expandedState,
            items: const [
              SideNavigationBarItem(
                icon: Icons.menu_book_outlined,
                label: 'Add books',
              ),
              SideNavigationBarItem(
                icon: Icons.menu_book_sharp,
                label: 'show books',
              ),
              SideNavigationBarItem(
                icon: Icons.image_search_sharp,
                label: 'Issue Book',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'View Users',
              ),
              SideNavigationBarItem(
                icon: Icons.notification_add_outlined,
                label: 'Reserved Books',
              ),
              SideNavigationBarItem(
                icon: Icons.image_search_sharp,
                label: 'Issued Books',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
