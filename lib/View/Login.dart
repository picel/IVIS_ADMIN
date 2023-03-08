import 'dart:ui';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:ivis_admin/Controller/TokenProcess.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ivis_admin/Controller/LoginProcess.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _checked = false;
  Map<String, String> _alertText = {
    'title': "잠깐만요!",
    'content': "이 페이지는 관리자 전용 페이지입니다.\n제대로 알고 찾아오신게 맞나요?",
  };
  bool isMobile = false;

  _checkMobile() {
    if (html.window.navigator.userAgent.contains("Mobile")) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    var prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      if (value.getString('token') != null) {
        TokenProcess.checkToken().then((value) => {
              if (value)
                {
                  Navigator.pushReplacementNamed(context, '/DashBoard'),
                }
            });
      }
    });
    isMobile = _checkMobile();
  }

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      color: const Color(0xFF0A21A6),
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 50,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF021373),
              ),
              width: isMobile ? width * 0.9 : width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "IVIS ADMIN LOGIN",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextField(
                      controller: idController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hoverColor: Colors.transparent,
                        hintText: 'ID',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextField(
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) async {
                        await LoginProcess.login(
                          idController.text,
                          pwController.text,
                        ).then((value) {
                          if (!value) {
                            setState(() {
                              _checked = false;
                              _alertText['title'] = "로그인 실패!";
                              _alertText['content'] = "진짜 길잃은 사용자 아니죠?";
                            });
                          } else {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/DashBoard', (route) => false);
                          }
                        });
                      },
                      controller: pwController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hoverColor: Colors.transparent,
                        hintText: 'PW',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await LoginProcess.login(
                          idController.text,
                          pwController.text,
                        ).then((value) {
                          if (!value) {
                            setState(() {
                              _checked = false;
                              _alertText['title'] = "로그인 실패!";
                              _alertText['content'] = "진짜 길잃은 사용자 아니죠?";
                            });
                          } else {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/DashBoard', (route) => false);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFF2F2F2),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF021373),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _checked
              ? const SizedBox()
              : Positioned(
                  child: Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2).withOpacity(0.8),
                          ),
                          width: isMobile ? width * 0.9 : width * 0.3,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 50,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _alertText['title']!,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                _alertText['content']!,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _checked = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Color(0xFF021373),
                                    ),
                                    child: const Text("저 관리자 맞아요",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      // show js alert dialog, then redirect to ivis.dev
                                      html.window.alert("다시는 길 잃지 마세요!");
                                      html.window
                                          .open('https://ivis.dev', "_self");
                                    },
                                    style: OutlinedButton.styleFrom(
                                      elevation: 0,
                                      side: BorderSide(
                                        color: Color(0xFF021373),
                                      ),
                                    ),
                                    child: const Text(
                                      "길을 잃었어요",
                                      style: TextStyle(
                                        color: Color(0xFF021373),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
