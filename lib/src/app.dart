import 'package:dvp_app/src/pages/directions.dart';
import 'package:dvp_app/src/pages/home.dart';
import 'package:dvp_app/src/pages/users.dart';
import 'package:flutter/material.dart';

class DefaultApp extends StatelessWidget {
  const DefaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DVP",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      routes: {
        '/': (context)=> HomePage(),
        '/users': (context)=>UsersPage(),
        '/directions':(context)=>DirectionsPage()
      },
    );
  }
}

