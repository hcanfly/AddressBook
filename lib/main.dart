import 'package:address_book/Screens/list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address Book',
      debugShowCheckedModeBanner: false,
      home: ListPage(),
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.indigo),
    );
  }
}
