import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivis_admin/Model/ApplicationModel.dart';
import 'package:ivis_admin/Controller/GetApplication.dart';
import 'package:ivis_admin/Controller/GetUserList.dart';
import 'package:ivis_admin/Model/UserModel.dart';
import 'package:ivis_admin/Widgets/Indicator.dart';

class MobileUserList extends StatefulWidget {
  const MobileUserList({super.key});

  @override
  State<MobileUserList> createState() => _MobileUserListState();
}

class _MobileUserListState extends State<MobileUserList> {
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
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return RawMaterialButton(
          onPressed: () {
            if (userData[index].applied) {
              _getApplication(userData[index].sid).then((application) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        userData[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          width: width * 0.9,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "학번: ${userData[index].sid}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "전화번호: ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text: userData[index].phone),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("전화번호가 복사되었습니다."),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      userData[index].phone,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Column(
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Wrap(
                                        runSpacing: 5,
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
                                                color: const Color(0xFF5E76BF),
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
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "닫기",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("아직 지원하지 않은 사람입니다."),
                ),
              );
            }
          },
          hoverElevation: 0,
          highlightElevation: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            width: width * 0.9,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: userData[index].applied ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userData[index].name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: userData[index].applied
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    userData[index].applied
                        ? Text(
                            "지원 완료",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        : Text(
                            "미지원",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userData[index].sid,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: userData[index].applied
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Text(
                      userData[index].phone,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: userData[index].applied
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
