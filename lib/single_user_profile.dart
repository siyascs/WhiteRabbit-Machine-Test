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
  List? _UserData;

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
        alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: _UserData!.length,
              itemBuilder: (_,int position){
              return Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      _UserData![position]["image"],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(_UserData![position]["username"],
                      style: TextStyle(color: blackcolor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(_UserData![position]["street"],
                      style: TextStyle(color: blackcolor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(_UserData![position]["city"],
                      style: TextStyle(color: blackcolor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(_UserData![position]["phone"],
                      style: TextStyle(color: blackcolor, fontSize: 14)),
                ],
              );
              })
        ),
      ),
    );
  }

  Future getUser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    int? userid=preferences.getInt("userid");
    _UserData=await dbHelper.queryRows(userid);
    print(_UserData?[0]["username"]);
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (newContext) => UserList()));
    return true;
  }
}
