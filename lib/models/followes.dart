// To parse this JSON data, do
//
//     final followers = followersFromJson(jsonString);

import 'dart:convert';

Followers followersFromJson(String str) => Followers.fromJson(json.decode(str));

String followersToJson(Followers data) => json.encode(data.toJson());

class Followers {
  int? followingCount;
  int? followersCount;
  List<Follow>? following;
  List<Follow>? followers;

  Followers({
    this.followingCount,
    this.followersCount,
    this.following,
    this.followers,
  });

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        following: json["following"] == null
            ? []
            : List<Follow>.from(
                json["following"]!.map((x) => Follow.fromJson(x))),
        followers: json["followers"] == null
            ? []
            : List<Follow>.from(
                json["followers"]!.map((x) => Follow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x.toJson())),
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
      };
}

class Follow {
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
  List<LinkSec>? linkSec;

  Follow({
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
    this.linkSec,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
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
        linkSec: json["links"] == null
            ? []
            : List<LinkSec>.from(
                json["links"]!.map((x) => LinkSec.fromJson(x))),
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
        "links": linkSec == null
            ? []
            : List<dynamic>.from(linkSec!.map((x) => x.toJson())),
      };
}

class LinkSec {
  int? id;
  String? title;
  String? link;
  String? username;
  int? isActive;
  int? userId;
  String? createdAt;
  String? updatedAt;

  LinkSec({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory LinkSec.fromJson(Map<String, dynamic> json) => LinkSec(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        username: json["username"],
        isActive: json["isActive"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
