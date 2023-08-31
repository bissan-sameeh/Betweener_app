import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<bool> editLink(
    {required int userId, required Map<String, dynamic> body}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.put(
      Uri.parse("https://betweener.gsgtt.tech/api/links/$userId"),
      headers: {'Authorization': 'Bearer ${user.token}'},
      body: body);
  if (response.statusCode == 200) {
    return true;
  }
  return Future.error('Something wrong');
}
