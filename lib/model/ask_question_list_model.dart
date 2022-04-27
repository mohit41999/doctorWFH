// To parse this JSON data, do
//
//     final askQuestionModel = askQuestionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AskQuestionModel askQuestionModelFromJson(String str) =>
    AskQuestionModel.fromJson(json.decode(str));

String askQuestionModelToJson(AskQuestionModel data) =>
    json.encode(data.toJson());

class AskQuestionModel {
  AskQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory AskQuestionModel.fromJson(Map<String, dynamic> json) =>
      AskQuestionModel(
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
    required this.questionId,
    required this.question,
    required this.description,
    required this.createdDate,
  });

  final String questionId;
  final String question;
  final String description;
  final DateTime createdDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        questionId: json["question_id"],
        question: json["question"],
        description: json["description"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "description": description,
        "created_date": createdDate.toIso8601String(),
      };
}
