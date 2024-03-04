import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:library_management_system/views/menu_screeens/home_page.dart';
import 'package:library_management_system/views/menu_screeens/my_books_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> pages = <Widget>[
    HomePage(),
    MyBooks(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blackColor,
        title: Row(
          children: [
            SizedBox(
              width: width * 0.2,
            ),
            Text(
              _selectedIndex == 1 ? "My " : "IT ",
              style: roundFont(20, mainColor, FontWeight.bold),
            ),
            Text(
              _selectedIndex == 1 ? "Books" : "Dept Library",
              style: roundFont(20, Colors.white, FontWeight.bold),
            )
          ],
        ),
      ),
      body: Center(
        child: pages[_selectedIndex],
      ),
      drawer: Drawer(
        // Change color here
        surfaceTintColor: Colors.white,

        backgroundColor: blackColor,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? mainColor : Colors.white,
              ),
              title: Text('Home',
                  style: roundFont(
                      18,
                      _selectedIndex == 0 ? mainColor : Colors.white,
                      FontWeight.normal)),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.menu_book_sharp,
                color: _selectedIndex == 1 ? mainColor : Colors.white,
              ),
              title: Text('My Books',
                  style: roundFont(
                      18,
                      _selectedIndex == 1 ? mainColor : Colors.white,
                      FontWeight.normal)),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: _selectedIndex == 2 ? mainColor : Colors.white,
              ),
              title: Text('School',
                  style: roundFont(
                      18,
                      _selectedIndex == 2 ? mainColor : Colors.white,
                      FontWeight.normal)),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
