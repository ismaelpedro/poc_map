// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class POI {
  int? id;
  String title;
  String description;
  String category;
  double latitude;
  double longitude;

  POI({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory POI.fromMap(Map<String, dynamic> map) {
    return POI(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory POI.fromJson(String source) => POI.fromMap(json.decode(source) as Map<String, dynamic>);
}
