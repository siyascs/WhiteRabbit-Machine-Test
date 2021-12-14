import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Colors.dart';
import 'database_helper.dart';
class SingleUserProfile extends StatefulWidget {
  const SingleUserProfile({Key? key}) : super(key: key);

  @override
  _SingleUserProfileState createState() => _SingleUserProfileState();
}

class _SingleUserProfileState extends State<SingleUserProfile> {
  final dbHelper = DatabaseHelper.instance;
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
        child: Column(
          children: [

            Text("Name",style: TextStyle(color: blackcolor,fontSize: 14)),
            SizedBox(height: 15),
            Text("Address",style: TextStyle(color: blackcolor,fontSize: 14)),
            SizedBox(height: 15),
            Text("phone",style: TextStyle(color: blackcolor,fontSize: 14)),
            SizedBox(height: 15),
            Text("email",style: TextStyle(color: blackcolor,fontSize: 14)),
          ],
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
    });

  }
}
