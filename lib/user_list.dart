import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiterabbitmachinetest/database_helper.dart';
import 'package:whiterabbitmachinetest/single_user_profile.dart';
import 'package:whiterabbitmachinetest/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'Colors.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileProvider>().GetUserProfile();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: primaryColor),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchcontroller,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              SizedBox(height: 15),
              Consumer<UserProfileProvider>(builder: (context, value, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: value.responseString.length,
                    itemBuilder: (context, index) {
                      _insert(
                          value.responseString[index]["id"] ?? 0,
                          value.responseString[index]["username"] ?? "username",
                          value.responseString[index]["email"]?? "email",
                          value.responseString[index]["profile_image"]??"image",
                          value.responseString[index]["address"]["street"]??"street",
                          value.responseString[index]["address"]["suite"]??"suite",
                          value.responseString[index]["address"]["city"]??"city",
                          value.responseString[index]["address"]["zipcode"]??"zipcode",
                          value.responseString[index]["address"]["geo"]["lat"]??"lat",
                          value.responseString[index]["address"]["geo"]["lng"]??"lon",
                          value.responseString[index]["phone"]??"phone",
                          value.responseString[index]["website"]??"website");
                      if (searchcontroller.text.isEmpty) {
                        return Container(
                          child: GestureDetector(
                            onTap: ()async{
                              SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                              preferences.setInt("userid", value.responseString[index]["id"]);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleUserProfile()));
                            },
                            child: ListTile(
                              leading: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage((value
                                              .responseString[index]
                                          ["profile_image"] !=
                                              null)
                                              ? value.responseString[index]
                                          ["profile_image"]
                                              : ("https://randomuser.me/api/portraits/men/1.jpg")
                                          )
                                      )
                                  )
                              ),
                              title: Text(
                                  (value.responseString[index]["username"] != null)
                                      ? value.responseString[index]["username"]
                                      : ("")),
                              subtitle: Text(
                                  (value.responseString[index]["company"] != null)
                                      ? value.responseString[index]["company"]
                                  ["name"]
                                      : ("")),
                            ),
                          ),
                        );

                      }else if(value.responseString.contains(searchcontroller.text)){
                        return Container(
                          child: GestureDetector(
                            onTap: ()async{
                              SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                              preferences.setInt("userid", value.responseString[index]["id"]);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleUserProfile()));
                            },
                            child: ListTile(
                              leading: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage((value
                                              .responseString[index]
                                          ["profile_image"] !=
                                              null)
                                              ? value.responseString[index]
                                          ["profile_image"]
                                              : ("https://randomuser.me/api/portraits/men/1.jpg")
                                          )
                                      )
                                  )
                              ),
                              title: Text(
                                  (value.responseString[index]["name"] != null)
                                      ? value.responseString[index]["name"]
                                      : ("")),
                              subtitle: Text(
                                  (value.responseString[index]["company"] != null)
                                      ? value.responseString[index]["company"]
                                  ["name"]
                                      : ("")),
                            ),
                          ),
                        );
                      }else{
                        return Container();
                      }


                    });
              })
            ],
          ),
        ),
      ),
    );
  }

  _insert(
      int columnUserid,
      String columnUsername,
      String columnEmail,
      String columnImage,
      String columnStreet,
      String columnSuit,
      String columnCity,
      String columnZipcode,
      String columnLat,
      String columnLon,
      String columnPhone,
      String columnWebsite) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnUserId: columnUserid,
      DatabaseHelper.columnUsername: columnUsername,
      DatabaseHelper.columnEmail: columnEmail,
      DatabaseHelper.columnImage: columnImage,
      DatabaseHelper.columnStreet: columnStreet,
      DatabaseHelper.columnSuit: columnSuit,
      DatabaseHelper.columnCity: columnCity,
      DatabaseHelper.columnZipcode: columnZipcode,
      DatabaseHelper.columnLat: columnLat,
      DatabaseHelper.columnLon: columnLon,
      DatabaseHelper.columnPhone: columnPhone,
      DatabaseHelper.columnWebsite: columnWebsite
    };
    final id = await dbHelper.insert(row);


  }
}
