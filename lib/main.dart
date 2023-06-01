import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_shop/firebase_options.dart';
import 'package:local_shop/screens/ProductsScreen.dart';
import 'package:local_shop/screens/catergoryScreen.dart';
import 'package:local_shop/screens/mainScreen.dart';
import 'package:local_shop/screens/productDetailsScreen.dart';
import 'package:local_shop/screens/signUpScreen.dart';
import 'package:local_shop/screens/signinScreen.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, db) {
            if (db.connectionState == ConnectionState.done) {
              return MainScreen();
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
      // initialRoute: "/",
      routes: {
        // "/": (context) => MainScreen(),
        "/category": (context) => CategoryScreen(),
        "/signin": (context) => SignInScreen(),
        "/signup": (context) => SignUpScreen(),
        "/products": (context) => ProductScreen(),
        "/product/details": (context) => ProductDetailsScreen(),
      },
    );
  }
}
