import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

Future<bool?> addFollow({required Map<String, dynamic> body}) async {
  print("jjjj");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
      Uri.parse("https://betweener.gsgtt.tech/api/follow"),
      body: body,
      headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    print(" rrrr ${response.statusCode}");

    return true;
  }
  if (response.statusCode == 500) {
    throw Exception('Failed to add');
  }
  Future.error("Something error");
}
