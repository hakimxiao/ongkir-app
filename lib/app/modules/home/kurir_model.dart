// To parse this JSON data, do
//
//     final kurir = kurirFromJson(jsonString);

import 'dart:convert';

Kurir kurirFromJson(String str) => Kurir.fromJson(json.decode(str));

String kurirToJson(Kurir data) => json.encode(data.toJson());

class Kurir {
  String name;
  String code;
  String service;
  String description;
  int cost;
  String etd;

  Kurir({
    required this.name,
    required this.code,
    required this.service,
    required this.description,
    required this.cost,
    required this.etd,
  });

  factory Kurir.fromJson(Map<String, dynamic> json) => Kurir(
    name: json["name"],
    code: json["code"],
    service: json["service"],
    description: json["description"],
    cost: json["cost"],
    etd: json["etd"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "service": service,
    "description": description,
    "cost": cost,
    "etd": etd,
  };

  static List<Kurir> fromJsonList(List list) {
    if (list.isEmpty) return List<Kurir>.empty();
    return list.map((item) => Kurir.fromJson(item)).toList();
  }
}
