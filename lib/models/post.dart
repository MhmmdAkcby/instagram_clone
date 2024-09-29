import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final like;

  Post({
    required this.description,
    required this.postId,
    required this.uid,
    required this.postUrl,
    required this.username,
    required this.profileImage,
    required this.datePublished,
    required this.like,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "profileImage": profileImage,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "like": like,
        "postId": postId,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        username: snapshot['username'],
        uid: snapshot['uid'],
        description: snapshot['description'],
        postUrl: snapshot['postUrl'],
        profileImage: snapshot['profileImage'],
        datePublished: snapshot['datePublished'],
        postId: snapshot['postId'],
        like: snapshot['like']);
  }
}
