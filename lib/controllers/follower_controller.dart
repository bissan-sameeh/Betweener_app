import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/followes.dart';
import '../models/user.dart';

Future<Followers> viewFollower() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'});
  print("jjj ${response.statusCode}");

  if (response.statusCode == 200) {
    print("jjj ${response.statusCode}");
    return followersFromJson(response.body);
  } else {
    return Future.error("There is an error in get Followers");
  }
}
