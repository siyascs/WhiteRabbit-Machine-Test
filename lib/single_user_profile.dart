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
  @override
  void initState() {
    super.initState();
    getUser();
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

                Text(username!,style: TextStyle(color: blackcolor,fontSize: 14)),
                SizedBox(height: 15),
                Text("Address",style: TextStyle(color: blackcolor,fontSize: 14)),
                SizedBox(height: 15),
                Text("phone",style: TextStyle(color: blackcolor,fontSize: 14)),
                SizedBox(height: 15),
                Text("email",style: TextStyle(color: blackcolor,fontSize: 14)),
              ],
            ),
          ),
    ),
      );

  }
  Future getUser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    int? userid=preferences.getInt("userid");
    final allRows = await dbHelper.queryRows(userid);

    allRows.forEach(print);
    // print(allRow);
    allRows.forEach((element) {
      print(element["username"]);
      username=element["username"];
    });

  }
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (newContext) => UserList()));
    return true;
  }
}
