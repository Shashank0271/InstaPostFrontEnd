// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  String title;
  String body;
  int likes;
  String category;
  String userFirebaseId;
  String userName;
  String imageUrl;
  String id;
  String createdOn;
  Post({
    required this.title,
    required this.body,
    required this.likes,
    required this.category,
    required this.userFirebaseId,
    required this.userName,
    required this.imageUrl,
    required this.id,
    required this.createdOn,
  });
  

  Post copyWith({
    String? title,
    String? body,
    int? likes,
    String? category,
    String? userFirebaseId,
    String? userName,
    String? imageUrl,
    String? id,
    String? createdOn,
  }) {
    return Post(
      title: title ?? this.title,
      body: body ?? this.body,
      likes: likes ?? this.likes,
      category: category ?? this.category,
      userFirebaseId: userFirebaseId ?? this.userFirebaseId,
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'likes': likes,
      'category': category,
      'userFirebaseId': userFirebaseId,
      'userName': userName,
      'imageUrl': imageUrl,
      'id': id,
      'createdOn': createdOn,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] as String,
      body: map['body'] as String,
      likes: map['likes'] as int,
      category: map['category'] as String,
      userFirebaseId: map['userFirebaseId'] as String,
      userName: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
      id: map['_id'] as String,
      createdOn: map['createdOn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(title: $title, body: $body, likes: $likes, category: $category, userFirebaseId: $userFirebaseId, userName: $userName, imageUrl: $imageUrl, id: $id, createdOn: $createdOn)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body &&
      other.likes == likes &&
      other.category == category &&
      other.userFirebaseId == userFirebaseId &&
      other.userName == userName &&
      other.imageUrl == imageUrl &&
      other.id == id &&
      other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      body.hashCode ^
      likes.hashCode ^
      category.hashCode ^
      userFirebaseId.hashCode ^
      userName.hashCode ^
      imageUrl.hashCode ^
      id.hashCode ^
      createdOn.hashCode;
  }
}
