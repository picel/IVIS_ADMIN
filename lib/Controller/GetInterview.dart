import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ivis_admin/Controller/GetUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetInterviewList {
  // get ivis.dev/api/admin/application, return List<User>
  static Future getInterview() async {
    // get token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    // put token to header with "token" key, and get response
    var response = await http.get(
      Uri.parse('https://ivis.dev/api/admin/interview'),
      headers: {
        'Authorization': token,
      },
    );

    var res = {
      "sat": {
        "12:00": {},
        "12:15": {},
        "12:30": {},
        "12:45": {},
        "13:00": {},
        "13:15": {},
        "13:30": {},
        "13:45": {},
        "14:00": {},
        "14:15": {},
        "14:30": {},
        "14:45": {},
      },
      "sun": {
        "12:00": {},
        "12:15": {},
        "12:30": {},
        "12:45": {},
        "13:00": {},
        "13:15": {},
        "13:30": {},
        "13:45": {},
        "14:00": {},
        "14:15": {},
        "14:30": {},
        "14:45": {},
      },
    };

    // if response is 200, return List<User>
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i in data['result']['sat']) {
        res["sat"]![i['time']] = {
          "sid": i["sid"],
          "name": await GetUser.getUser(i["sid"]),
        };
      }
      for (var i in data['result']['sun']) {
        res["sun"]![i['time']] = {
          "sid": i["sid"],
          "name": await GetUser.getUser(i["sid"]),
        };
      }
      return res;
    } else {
      return res;
    }
  }
}
