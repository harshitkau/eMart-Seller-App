import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_seller_app/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCwoHEeg79MBhaYgVd2WEmlcBGe1ySAjqA",
          appId: "1:1007984899242:android:709a9a171063929c8c0cd3",
          messagingSenderId: "1007984899242",
          projectId: "emart-f9619",
          storageBucket: "emart-f9619.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  var isLoggedIn = false;
  checkUser() async {
    await auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Home() : LoginScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0.0)),
    );
  }
}
