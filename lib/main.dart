import 'package:flutter/material.dart';

import './Home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calendar App',
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
