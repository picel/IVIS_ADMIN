import 'package:flutter/material.dart';
import 'package:ivis_admin/Controller/GetUserList.dart';
import 'package:ivis_admin/Model/UserModel.dart';
import 'package:ivis_admin/Widgets/Indicator.dart';

class InfoBoard extends StatefulWidget {
  final double boxW;
  final double boxH;
  final bool isMobile;
  const InfoBoard(
      {super.key,
      required this.boxW,
      required this.boxH,
      required this.isMobile});

  @override
  State<InfoBoard> createState() => _InfoBoardState();
}

class _InfoBoardState extends State<InfoBoard> {
  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    List<User> users = await GetUserList.getUserList();
    int apps = 0;
    for (var user in users) {
      if (user.applied) {
        apps++;
      }
    }
    setState(() {
      userCount = users.length;
      applied = apps;
    });
  }

  int userCount = 0;
  int applied = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          Indicator(
            width: widget.boxW,
            height: widget.boxH,
            title: "가입자 수",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Color(0xFF5E76BF)),
                const SizedBox(width: 10),
                Text(
                  userCount.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF5E76BF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  " 명",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5E76BF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Indicator(
            width: widget.boxW,
            height: widget.boxH,
            title: "신청자 수",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Color(0xFF5E76BF)),
                const SizedBox(width: 10),
                Text(
                  applied.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF5E76BF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  " 명",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5E76BF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
