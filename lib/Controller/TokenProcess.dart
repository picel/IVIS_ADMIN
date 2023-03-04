import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:ivis_admin/globals.dart' as global;

class TokenProcess {
  static Future<bool> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      return false;
    } else {
      try {
        var response = await http.post(
          Uri.parse('${global.backEndURL}/remote_token_verify/'),
          body: {
            'token': prefs.getString('token'),
          },
        );
        if (response.statusCode == 200) {
          prefs.setString('id', response.body);
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
  }
}
