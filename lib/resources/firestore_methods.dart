import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "some error occurred";

    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('post', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        postId: postId,
        uid: uid,
        postUrl: photoUrl,
        username: username,
        profileImage: profileImage,
        datePublished: DateTime.now(),
        like: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
