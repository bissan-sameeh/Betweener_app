// To parse this JSON data, do
//
//     final foundedUsers = foundedUsersFromJson(jsonString);

import 'dart:convert';

List<FoundedUsers> foundedUsersFromJson(String str) => List<FoundedUsers>.from(
    json.decode(str).map((x) => FoundedUsers.fromJson(x)));

String foundedUsersToJson(List<FoundedUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoundedUsers {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  dynamic country;
  dynamic ip;
  double? long;
  double? lat;
  List<dynamic>? links;

  FoundedUsers({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
    this.links,
  });

  factory FoundedUsers.fromJson(Map<String, dynamic> json) => FoundedUsers(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isActive: json["isActive"],
        country: json["country"],
        ip: json["ip"],
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        links: json["links"] == null
            ? []
            : List<dynamic>.from(json["links"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "isActive": isActive,
        "country": country,
        "ip": ip,
        "long": long,
        "lat": lat,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
      };
}
