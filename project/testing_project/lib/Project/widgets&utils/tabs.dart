import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final IconData tabIcon;
  const MyTab({super.key, required this.tabIcon});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(tabIcon),
    );
  }
}
