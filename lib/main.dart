import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/inherited.dart';
import 'package:nosso_primeiro_projeto/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: 
        TaskInherited(child: const HomePage()),
        // const FormScren(),
        );
  }
}
