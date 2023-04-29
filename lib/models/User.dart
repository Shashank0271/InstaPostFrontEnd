// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  String firebaseUid;
  String registrationToken;
  final int postCount;
  final List<String> followersTokens;
  final List<String> followers;
  final List<String> following;
  final List<String> likedPosts;
  UserModel({
    required this.username,
    required this.email,
    required this.firebaseUid,
    required this.registrationToken,
    required this.postCount,
    required this.followersTokens,
    required this.followers,
    required this.following,
    required this.likedPosts,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? firebaseUid,
    String? registrationToken,
    int? postCount,
    List<String>? followersTokens,
    List<String>? followers,
    List<String>? following,
    List<String>? likedPosts,
  }) {
    return UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        firebaseUid: firebaseUid ?? this.firebaseUid,
        registrationToken: registrationToken ?? this.registrationToken,
        postCount: postCount ?? this.postCount,
        followersTokens: followersTokens ?? this.followersTokens,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        likedPosts: likedPosts ?? this.likedPosts);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'firebaseUid': firebaseUid,
      'registrationToken': registrationToken,
      'postCount': postCount,
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
      postCount: map['postCount'],
      followersTokens:
          (map['followersTokens'] as List).map((e) => e as String).toList(),
      following: (map['following'] as List).map((e) => e as String).toList(),
      followers: (map['followers'] as List).map((e) => e as String).toList(),
      likedPosts: (map['likedPosts'] as List).map((e) => e as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, firebaseUid: $firebaseUid, registrationToken: $registrationToken, postCount: $postCount, followersTokens: $followersTokens, followers: $followers, following: $following , likedPosts: $likedPosts)';
  }
}
