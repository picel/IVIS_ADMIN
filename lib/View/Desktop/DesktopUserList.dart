import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivis_admin/Model/ApplicationModel.dart';
import 'package:ivis_admin/Controller/GetApplication.dart';
import 'package:ivis_admin/Controller/GetUserList.dart';
import 'package:ivis_admin/Model/UserModel.dart';

class DesktopUserList extends StatefulWidget {
  const DesktopUserList({super.key});

  @override
  State<DesktopUserList> createState() => _DesktopUserListState();
}

class _DesktopUserListState extends State<DesktopUserList> {
  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    List<User> users = await GetUserList.getUserList();
    setState(() {
      userData = users;
    });
  }

  _getApplication(String sid) async {
    Application app = await GetApplication.getApplication(sid);
    return app;
  }

  List<User> userData = [];

  @override
  Widget build(BuildContext context) {
    return DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => const Color(0xFF5E76BF)),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '이름',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '학번',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '전화번호',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '지원여부',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        rows: [
          for (var i = 0; i < userData.length; i++)
            DataRow(
              cells: <DataCell>[
                DataCell(Text("${i + 1}")),
                DataCell(Text(userData[i].name)),
                DataCell(Text(userData[i].sid)),
                DataCell(
                  TextButton(
                    onPressed: () {
                      // copy to clipboard
                      Clipboard.setData(ClipboardData(text: userData[i].phone));
                    },
                    child: Text(userData[i].phone),
                  ),
                ),
                DataCell(
                  Text(userData[i].applied ? "O" : "X"),
                  onTap: () {
                    if (userData[i].applied) {
                      _getApplication(userData[i].sid).then((application) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("${userData[i].name} 지원서"),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "자기소개",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      padding: const EdgeInsets.all(15),
                                      width: 700,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF021373),
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(application.intro),
                                    ),
                                    const Text(
                                      "사용 가능한 언어",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 10),
                                        padding: const EdgeInsets.all(5),
                                        width: 700,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFF021373),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            for (var language
                                                in application.language)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF5E76BF),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  language,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )),
                                    const Text(
                                      "프로젝트 경험",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      padding: const EdgeInsets.all(15),
                                      width: 700,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF021373),
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(application.project),
                                    ),
                                    const Text(
                                      "프로젝트 계획",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      padding: const EdgeInsets.all(15),
                                      width: 700,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF021373),
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(application.etc),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("닫기"),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("아직 지원하지 않았습니다."),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
        ]);
  }
}
