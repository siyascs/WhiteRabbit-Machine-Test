import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:whiterabbitmachinetest/user_profile_provider.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserProfileProvider>(create: (_) => UserProfileProvider())
];


