import 'package:flutter/material.dart';
import 'package:ivis_admin/View/InfoBoard.dart';
import 'package:ivis_admin/View/Desktop/DesktopUserList.dart';
import 'package:ivis_admin/View/Mobile/MobileUserList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileUI extends StatefulWidget {
  final String username;
  const MobileUI({super.key, required this.username});

  @override
  State<MobileUI> createState() => _MobileUIState();
}

class _MobileUIState extends State<MobileUI> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IVIS ADMIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("로그아웃"),
                    content: const Text("로그아웃 하시겠습니까?"),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("취소"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.remove('token');
                          prefs.remove('id');
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: const Text("확인"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _selectedIndex = value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            activeIcon: Icon(Icons.space_dashboard),
            label: 'DashBoard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'User List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF5E76BF),
      ),
      body: Column(
        children: [
          Text(
            "${widget.username} 님 환영합니다.",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          [
            InfoBoard(
              boxH: height * 0.2,
              boxW: width * 0.8,
              isMobile: true,
            ),
            SizedBox(
              width: width,
              height: height - 200,
              child: const MobileUserList(),
            ),
          ][_selectedIndex]
        ],
      ),
    );
  }
}
