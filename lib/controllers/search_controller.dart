import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/founded_users.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<List<FoundedUsers>?> searchUsers(
    {required Map<String, dynamic> body}) async {
  print("hhhhhhhh");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
      Uri.parse("http://www.osamapro.online/api/search"),
      body: body,
      headers: {"Authorization": "Bearer ${user.token}"});
//[{id:44,name:ahmed,age:44},{},{}]

  if (response.statusCode == 200) {
    final users = jsonDecode(response.body)['user'] as List<
        dynamic>; //convert string to Map and then to list  =>[{id:44,name:ahmed,age:44},{},{}]=>list[[ahmed,12,palestine],[bissan,24,palestine]];

    Iterable<FoundedUsers> foundeduser = users
        .map((user) => FoundedUsers.fromJson(user))
        .toList(); //اخد من الليستة الكبيرة كل ليستة واحولها لنوع فاونديد يوزر كلاس واحول المودل هاد للست
    //[
    // FoundedUser(name:Ahmed,14,palestine),
    // FoundedUser(Bisan,17,gAZA),
    // FoundedUser(MOH,17,PALJEKIA),
    // ]
    List<FoundedUsers> filterFoundedUser = foundeduser
        .where((element) =>
            element.name != null && element.name!.contains(body['name']))
        .toList();
    return filterFoundedUser;
  } else {
    return Future.error("There is no persons Found");
  }
}
