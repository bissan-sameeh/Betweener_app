import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import '../constants.dart';
import '../models/link.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  ///return the user in the system and convert it to user model

  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  /// when required to add new link must authorized previously so we use header

  // print(jsonDecode(response.body)['links']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    /// if the token wrong or the session ended
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
