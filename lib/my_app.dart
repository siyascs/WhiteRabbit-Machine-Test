import 'package:flutter/material.dart';
import 'package:whiterabbitmachinetest/user_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserList(),
    );
  }
}