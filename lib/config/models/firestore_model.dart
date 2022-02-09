import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String userId;
  final String userEmail;
  // String userPassword;
  final DateTime dateCreated;

  FirebaseUser({required this.userId, required this.userEmail, required this.dateCreated});

  static FirebaseUser fromJson(Map<String, dynamic> json) => FirebaseUser(
    userId: json['userId'],
    userEmail:json['userEmail'],
    dateCreated:  toDateTime(json['dateCreated']),
  );

  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }
}
