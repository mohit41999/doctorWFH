// To parse this JSON data, do
//
//     final myKnowledgeForumModel = myKnowledgeForumModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyKnowledgeForumModel myKnowledgeForumModelFromJson(String str) =>
    MyKnowledgeForumModel.fromJson(json.decode(str));

String myKnowledgeForumModelToJson(MyKnowledgeForumModel data) =>
    json.encode(data.toJson());

class MyKnowledgeForumModel {
  MyKnowledgeForumModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory MyKnowledgeForumModel.fromJson(Map<String, dynamic> json) =>
      MyKnowledgeForumModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.doctorId,
    required this.forumId,
    required this.knowledgeTitle,
    required this.date,
  });

  final String doctorId;
  final String forumId;
  final String knowledgeTitle;
  final DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        doctorId: json["doctor_id"],
        forumId: json["forum_id"],
        knowledgeTitle: json["knowledge_title"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "forum_id": forumId,
        "knowledge_title": knowledgeTitle,
        "date": date.toIso8601String(),
      };
}
