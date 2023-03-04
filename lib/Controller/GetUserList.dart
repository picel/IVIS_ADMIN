import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ivis_admin/Model/UserModel.dart';

class GetUserList {
  // get ivis.dev/api/admin/application, return List<User>
  static Future<List<User>> getUserList() async {
    // get token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    // put token to header with "token" key, and get response
    var response = await http.get(
      Uri.parse('https://ivis.dev/api/admin/users'),
      headers: {
        'Authorization': token,
      },
    );

    // if response is 200, return List<User>
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<User> users = [];
      for (var user in data['result']) {
        // print only name, phone with one line
        // print('${user['name']} : ${user['phone']}');
        users.add(User.fromJson(user));
      }
      return users;
    } else {
      return [];
    }
  }
}
