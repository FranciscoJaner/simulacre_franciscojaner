import 'dart:convert';

class ScanModel {
  ScanModel({
    this.id,
    required this.titol,
    required this.quantitat,
  });

  int? id;
  String titol;
  String quantitat;

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        titol: json["titol"],
        quantitat: json["quantitat"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "titol": titol,
        "quantitat": quantitat,
      };
}
