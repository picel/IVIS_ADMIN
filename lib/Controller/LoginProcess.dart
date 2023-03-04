import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ivis_admin/globals.dart' as global;

class LoginProcess {
  static setToken(String token) async {
    print(token);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<bool> login(String id, String password) async {
    try {
      var response = await http.post(
        Uri.parse('${global.backEndURL}/remote_login/'),
        body: {
          'id': id,
          'pw': password,
        },
      );
      if (response.statusCode == 200) {
        setToken(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
