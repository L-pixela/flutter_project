import 'package:flutter/material.dart';
import 'view/screen/home_page.dart';

void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
    home: HomePage(),
  ));
}
