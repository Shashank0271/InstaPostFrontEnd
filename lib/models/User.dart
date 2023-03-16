// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String email;
  String firebaseUid;
  final String registrationToken;
  final List<String> postIds;
  final List<String> followersTokens;
  final List<String> followers;
  final List<String> following;
  UserModel({
    required this.username,
    required this.email,
    required this.firebaseUid,
    required this.registrationToken,
    required this.postIds,
    required this.followersTokens,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? firebaseUid,
    String? registrationToken,
    List<String>? postIds,
    List<String>? followersTokens,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      registrationToken: registrationToken ?? this.registrationToken,
      postIds: postIds ?? this.postIds,
      followersTokens: followersTokens ?? this.followersTokens,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'firebaseUid': firebaseUid,
      'registrationToken': registrationToken,
      'postIds': postIds,
      'followersTokens': followersTokens,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      firebaseUid: map['firebaseUid'] as String,
      registrationToken: map['registrationToken'] as String,
      postIds: (map['postIds'] as List).map((e) => e as String).toList(),
      followersTokens:
          (map['followersTokens'] as List).map((e) => e as String).toList(),
      following: (map['following'] as List).map((e) => e as String).toList(),
      followers: (map['followers'] as List).map((e) => e as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, firebaseUid: $firebaseUid, registrationToken: $registrationToken, postIds: $postIds, followersTokens: $followersTokens, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.firebaseUid == firebaseUid &&
        other.registrationToken == registrationToken &&
        listEquals(other.postIds, postIds) &&
        listEquals(other.followersTokens, followersTokens) &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }
}
