import 'package:flutter/src/widgets/editable_text.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<User> register({required Map<String, dynamic> body}) async {
  print("dd {statusCode}");

  final response = await http.post(
    Uri.parse("https://betweener.gsgtt.tech/api/register"),
    body: body,
  );
  print("dd ${response.statusCode}");
  if (response.statusCode == 201) {
    return userFromJson(response.body);
  } else {
    throw Exception("There is an error in register ");
  }
}
