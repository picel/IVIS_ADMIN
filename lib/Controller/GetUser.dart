import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetUser {
  // get ivis.dev/api/admin/application, return List<User>
  static Future getUser(String sid) async {
    // get token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    // put token to header with "token" key, and get response
    var response = await http.get(
      Uri.parse('https://ivis.dev/api/admin/user/$sid'),
      headers: {
        'Authorization': token,
      },
    );

    // if response is 200, return List<User>
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['result']['name'];
    } else {
      return "";
    }
  }
}
