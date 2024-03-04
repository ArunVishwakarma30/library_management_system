import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:library_management_system/controllers/auth_provider.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/views/auth_screens/login_page.dart';
import 'package:library_management_system/views/dashboard/dashboard_home_page.dart';
import 'package:library_management_system/views/menu_screeens/menu_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool("loggedIn") ?? false;

  if (loggedIn) {
    defaultHome = kIsWeb ? const LibraryDashboard() :  const MenuPage();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MenuProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: defaultHome,
    );
  }
}
