import 'package:flutter/material.dart';
import 'Pages/Home/HomeView.dart';

void main() async {
  runApp(MaterialApp(
    home: HomeView(),
    theme: ThemeData(
      hintColor: Colors.amber[300],
      primaryColor: Colors.white,
    ),
  ));
}