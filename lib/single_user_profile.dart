// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiterabbitmachinetest/user_list.dart';
import 'Colors.dart';
import 'database_helper.dart';

class SingleUserProfile extends StatefulWidget {
  const SingleUserProfile({Key? key}) : super(key: key);

  @override
  _SingleUserProfileState createState() => _SingleUserProfileState();
}

class _SingleUserProfileState extends State<SingleUserProfile> {
  final dbHelper = DatabaseHelper.instance;
  String? username;
  List userData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getUser());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: primaryColor),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              for (int index = 0; index < userData.length; index++)
                Text(userData[index]["username"],
                    style: TextStyle(color: blackcolor, fontSize: 14)),
              SizedBox(height: 15),
              for (int index = 0; index < userData.length; index++)Text(userData[index]["street"],
          style: TextStyle(color: blackcolor, fontSize: 14)),
              SizedBox(height: 15),
              for (int index = 0; index < userData.length; index++)Text(userData[index]["city"],
                  style: TextStyle(color: blackcolor, fontSize: 14)),
              SizedBox(height: 15),
              for (int index = 0; index < userData.length; index++)Text(userData[index]["phone"],
                  style: TextStyle(color: blackcolor, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Future getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userid = preferences.getInt("userid");
    final allRows = await dbHelper.queryRows(userid);

    allRows.forEach(print);
    userData.add(allRows);
    return userData;
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (newContext) => UserList()));
    return true;
  }
}
