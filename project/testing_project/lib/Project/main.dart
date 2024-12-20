import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/Project/database/data.dart';
import 'package:testing_project/Project/model/journal.dart';
import 'package:testing_project/Project/view/screen/welcome_page.dart';
import 'view/screen/home_page.dart';

void main() {
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => JournalService(journals),
        child: HomePage(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: WelcomePage(),
    ),
  ));
}
