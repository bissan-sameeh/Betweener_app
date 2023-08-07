// To parse this JSON data, do
//
//     final followers = followersFromJson(jsonString);

import 'dart:convert';

Followers followersFromJson(String str) => Followers.fromJson(json.decode(str));

String followersToJson(Followers data) => json.encode(data.toJson());

class Followers {
  int? followingCount;
  int? followersCount;
  List<dynamic>? following;
  List<Follower>? followers;

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
            : List<dynamic>.from(json["following"]!.map((x) => x)),
        followers: json["followers"] == null
            ? []
            : List<Follower>.from(
                json["followers"]!.map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x)),
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
      };
}

class Follower {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;
  List<Link>? linksSec;
  List<Link>? links;

  Follower({
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
    this.linksSec,
    this.links,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isActive: json["isActive"],
        country: json["country"],
        ip: json["ip"],
        long: json["long"],
        lat: json["lat"],
        linksSec: json["linksSec"] == null
            ? []
            : List<Link>.from(json["linksSec"]!.map((x) => Link.fromJson(x))),
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
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
        "linksSec": linksSec == null
            ? []
            : List<dynamic>.from(linksSec!.map((x) => x.toJson())),
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Link {
  int? id;
  String? title;
  String? link;
  String? username;
  int? isActive;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Link({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
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
