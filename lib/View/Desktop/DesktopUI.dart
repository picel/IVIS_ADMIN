import 'package:flutter/material.dart';
import 'package:ivis_admin/View/InfoBoard.dart';
import 'package:ivis_admin/Widgets/Indicator.dart';
import 'package:ivis_admin/View/Desktop/DesktopUserList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopUI extends StatefulWidget {
  final String username;
  const DesktopUI({super.key, required this.username});

  @override
  State<DesktopUI> createState() => _DesktopUIState();
}

class _DesktopUIState extends State<DesktopUI> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NavigationRail(
          extended: true,
          backgroundColor: const Color(0xFF5E76BF),
          selectedLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          useIndicator: true,
          indicatorColor: Colors.white,
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          leading: Column(
            children: const [
              SizedBox(height: 20),
              Text(
                "IVIS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.space_dashboard_outlined),
              selectedIcon: Icon(Icons.space_dashboard),
              label: Text('Dashboard'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: Text('User List'),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.username} 님 환영합니다.",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
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
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('token');
                                    prefs.remove('id');
                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                  },
                                  child: const Text("확인"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(width: 5),
                          Text("로그아웃"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                [
                  SizedBox(
                    width: width,
                    height: height - 200,
                    child: const InfoBoard(
                      boxH: 200,
                      boxW: 300,
                      isMobile: false,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height - 200,
                    child:
                        const SingleChildScrollView(child: DesktopUserList()),
                  ),
                ][_selectedIndex]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
