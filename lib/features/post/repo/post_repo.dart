import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creama/features/post/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadPost(File image, String uid) {
    final fileRef = _storage.ref().child(
        "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(image);
  }

  Future<DocumentReference<Map<String, dynamic>>> savePost(
      PostModel data) async {
    return await _db.collection("post").add(data.toJson());
  }

  Future<void> deletePost(postId) async {
    final query = _db.collection("post").doc(postId);
    final post = await query.get();
    if (!post.exists) {
      print("postID: $postId doesn't exist");
    } else {
      await query.delete();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPost(
      {int? lastItemCreatedAt}) {
    final query =
        _db.collection("post").orderBy("createdAt", descending: true).limit(10);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> fetchUserPost(String uid) {
  //   final query = _db
  //       .collection("post")
  //       .where("creatorUid", isEqualTo: uid)
  //       .orderBy("createdAt", descending: true)
  //       .limit(5);
  //   return query.get();
  // }

  Stream<List<PostModel>> streamAllPosts() {
    return _db
        .collection('post')
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data(); // JSON 데이터를 가져옴
              return PostModel.fromJson(data).copyWith(id: doc.id);
            }).toList());
  }
}

final postRepoProvider = Provider((ref) => PostRepository());
