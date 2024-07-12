import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creama/features/post/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

<<<<<<< HEAD
  UploadTask uploadPost(File image, String uid) {
    final fileRef = _storage.ref().child(
        "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(image);
  }

  Future<DocumentReference<Map<String, dynamic>>> savePost(
      PostModel data) async {
    return await _db.collection("post").add(data.toJson());
  }

  // Future<void> deletePost(int craatedAt) async {
  //   try {
  //     // createdAt 값이 targetCreatedAt와 일치하는 문서 쿼리
  //     QuerySnapshot<Map<String, dynamic>> snapshot = await _db
  //         .collection('post')
  //         .where('createdAt', isEqualTo: craatedAt)
  //         .limit(1) // 문서 하나만 가져오기 위해 limit 사용
  //         .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       // 문서 삭제
  //       await snapshot.docs.first.reference.delete();
  //       print('Document deleted successfully');
  //     } else {
  //       print('No document found with the specified createdAt');
  //     }
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }

  Future<void> deletePost(postId) async {
    final query = _db.collection("posts").doc(postId);
    final post = await query.get();
    if (!post.exists) {
      print("postID: $postId doesn't exist");
    } else {
      await query.delete();
    }
=======
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
>>>>>>> 33a3afcb8bdd8621ff4a4e17e3d0b90babc362ca
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPost(
      {int? lastItemCreatedAt}) {
<<<<<<< HEAD
    final query =
        _db.collection("post").orderBy("createdAt", descending: true).limit(10);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
=======
    final query = _db.collection("post").orderBy("createdAt", descending: true);
    return query.get();
  }
>>>>>>> 33a3afcb8bdd8621ff4a4e17e3d0b90babc362ca

    // Future<QuerySnapshot<Map<String, dynamic>>> fetchUserPost(String uid) {
    //   final query = _db
    //       .collection("post")
    //       .where("creatorUid", isEqualTo: uid)
    //       .orderBy("createdAt", descending: true)
    //       .limit(5);
    //   return query.get();
    // }

<<<<<<< HEAD
    // Stream<List<PostModel>> streamAllPosts() {
    //   return _db
    //       .collection('post')
    //       .orderBy("createdAt", descending: true)
    //       .snapshots()
    //       .map((snapshot) => snapshot.docs
    //           .map((doc) => PostModel.fromJson(json: doc.data()))
    //           .toList());
    // }
=======
  Stream<List<PostModel>> streamAllPosts() {
    return _db
        .collection('post')
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromJson(json: doc.data()))
            .toList());
>>>>>>> 33a3afcb8bdd8621ff4a4e17e3d0b90babc362ca
  }
}

final postRepoProvider = Provider((ref) => PostRepository());
