import 'package:ivis_admin/Model/ApplicationModel.dart';

class User {
  final String name;
  final String sid;
  final String phone;
  final bool applied;
  final bool approved;

  User({
    required this.name,
    required this.sid,
    required this.phone,
    required this.applied,
    required this.approved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        sid: json['sid'],
        phone: json['phone'],
        applied: json['applied'],
        approved: json['approved']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sid': sid,
      'phone': phone,
      'applied': applied,
      'approved': approved,
    };
  }
}
