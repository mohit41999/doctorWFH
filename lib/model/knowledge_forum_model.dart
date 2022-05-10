// To parse this JSON data, do
//
//     final knowledgeForumModel = knowledgeForumModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KnowledgeForumModel knowledgeForumModelFromJson(String str) =>
    KnowledgeForumModel.fromJson(json.decode(str));

String knowledgeForumModelToJson(KnowledgeForumModel data) =>
    json.encode(data.toJson());

class KnowledgeForumModel {
  KnowledgeForumModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<KnowledgeForumModelData> data;

  factory KnowledgeForumModel.fromJson(Map<String, dynamic> json) =>
      KnowledgeForumModel(
        status: json["status"],
        message: json["message"],
        data: List<KnowledgeForumModelData>.from(
            json["data"].map((x) => KnowledgeForumModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KnowledgeForumModelData {
  KnowledgeForumModelData({
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  factory KnowledgeForumModelData.fromJson(Map<String, dynamic> json) =>
      KnowledgeForumModelData(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
