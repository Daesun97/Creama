import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creama/features/post/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<UploadTask> uploadPost(List<File> images, String uid) {
    List<UploadTask> uploadTasks = [];
    for (var image in images) {
      final fileRef = _storage.ref().child(
          "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
      uploadTasks.add(fileRef.putFile(image));
    }
    return uploadTasks;
  }

  Future<void> savePost(PostModel data) async {
    await _db.collection("post").add(data.toJson());
  }

  Future<void> deletePost(String doc) async {
    final post = _db.collection("post").doc(doc);
    await post.delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPost(
      {int? lastItemCreatedAt}) {
    final query = _db.collection("post").orderBy("createdAt", descending: true);
    return query.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUserPost(String uid) {
    final query = _db
        .collection("post")
        .where("creatorUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .limit(5);
    return query.get();
  }

  Stream<List<PostModel>> streamAllPosts() {
    return _db
        .collection('post')
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromJson(json: doc.data()))
            .toList());
  }
}

final postRepoProvider = Provider((ref) => PostRepository());
