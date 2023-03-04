import 'package:flutter/material.dart';
import 'package:ivis_admin/View/Desktop/DesktopUI.dart';
import 'package:ivis_admin/View/Mobile/MobileUI.dart';
import 'package:ivis_admin/Controller/TokenProcess.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String userName = '';

  _checkToken() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      var result = await TokenProcess.checkToken();
      if (!result) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        setState(() {
          userName = prefs.getString('id')!;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ScreenTypeLayout(
        mobile: MobileUI(
          username: userName,
        ),
        tablet: DesktopUI(
          username: userName,
        ),
      ),
    );
  }
}
