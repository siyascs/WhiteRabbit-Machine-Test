import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'database_helper.dart';

class UserProfileProvider extends ChangeNotifier{

  List<dynamic> _responseString = [];
  bool _error = false;
  String _errorMessage = "";

  List<dynamic> get responseString => _responseString;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> GetUserProfile() async {
    final response = await get(
      Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      try{

        _responseString = json.decode(response.body);
        _error = true;
        _errorMessage = "Success";

      }catch(e){
        _error = false;
        _errorMessage = e.toString();
      }

    }else{
      _error = false;
      _errorMessage = "Something went wrong , please try again later";
    }
    notifyListeners();
    print(_error);
    print(_errorMessage);
  }
}