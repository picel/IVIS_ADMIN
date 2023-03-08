import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivis_admin/Controller/GetApplication.dart';
import 'package:ivis_admin/Controller/GetInterview.dart';
import 'package:ivis_admin/Model/ApplicationModel.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Map<String, String> userData = {};
  Map schedule = {
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
  List timezone = [
    "12:00",
    "12:15",
    "12:30",
    "12:45",
    "13:00",
    "13:15",
    "13:30",
    "13:45",
    "14:00",
    "14:15",
    "14:30",
    "14:45",
  ];

  @override
  void initState() {
    super.initState();
    _getInterview();
  }

  _getApplication(String sid) async {
    Application app = await GetApplication.getApplication(sid);
    return app;
  }

  _getInterview() async {
    var res = await GetInterviewList.getInterview();
    setState(() {
      schedule = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _showApplication(String sid) {
      _getApplication(sid).then((application) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "지원서 열람",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
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
                              margin: const EdgeInsets.only(top: 5, bottom: 10),
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
                                  for (var language in application.language)
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5E76BF),
                                        borderRadius: BorderRadius.circular(30),
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
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
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
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
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
    }

    return DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => const Color(0xFF5E76BF)),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              '시간',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '토요일',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              '일요일',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        rows: [
          for (var i = 0; i < 12; i++)
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    timezone[i],
                  ),
                ),
                DataCell(
                  TextButton(
                    onPressed: () {
                      if (schedule["sat"][timezone[i]]["sid"] != null) {
                        _showApplication(schedule["sat"][timezone[i]]["sid"]);
                      }
                    },
                    child: Text(
                      schedule["sat"][timezone[i]]["name"] ?? "",
                    ),
                  ),
                ),
                DataCell(
                  TextButton(
                    onPressed: () {
                      if (schedule["sun"][timezone[i]]["sid"] != null) {
                        _showApplication(schedule["sun"][timezone[i]]["sid"]);
                      }
                    },
                    child: Text(
                      schedule["sun"][timezone[i]]["name"] ?? "",
                    ),
                  ),
                ),
              ],
            ),
        ]);
  }
}
