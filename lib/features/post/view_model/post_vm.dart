import 'dart:async';
import 'dart:io';

import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:creama/features/post/model/post_model.dart';
import 'package:creama/features/post/repo/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _postsList = [];

  @override
<<<<<<< HEAD
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepo);
    _postsList = await _fetchPosts(lastItemCreatedAt: null);
    return _postsList;
=======
  FutureOr<void> build() {
    _repository = ref.read(postRepoProvider);
>>>>>>> 33a3afcb8bdd8621ff4a4e17e3d0b90babc362ca
  }

  Future<List<PostModel>> _fetchPosts({int? lastItemCreatedAt}) async {
    final result =
        await _repository.fetchPost(lastItemCreatedAt: lastItemCreatedAt);
    final posts = result.docs
        .map((item) => PostModel.fromJson(json: item.data(), postId: item.id));
    return posts.toList();
  }

  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchPosts(lastItemCreatedAt: _postsList.last.createdAt);
    _postsList = [..._postsList, ...nextPage];
    state = AsyncValue.data(_postsList);
  }

  Future<void> refresh() async {
    final posts = await _fetchPosts(lastItemCreatedAt: null);
    _postsList = posts;
    state = AsyncValue.data(posts);
  }

  Future<void> savePost({
    List<File>? images,
    required String content,
    required BuildContext context,
  }) async {
    final user = ref.read(authRepo).user;
    if (user != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          List<String> imgUrls = images != null
              ? await Future.wait(
                  images.map((image) async {
                    final task = await _repository.uploadPost(image, user.uid);
                    final downloadUrl = await task.ref.getDownloadURL();
                    return downloadUrl;
                  }).toList(),
                )
              : [];

<<<<<<< HEAD
          final newPost = PostModel(
            id: "",
            like: 0,
            creator: 'creator',
            content: content,
            creatorUid: user.uid,
            images: imgUrls,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
          final newPostRef = await _repository.savePost(newPost);

          final updateNewpost = newPost.copyWith(id: newPostRef.id);

          _postsList = [updateNewpost, ..._postsList];
          state = AsyncValue.data(_postsList);
          // context.pop('post');
          return _postsList;
        },
      );
      if (state.hasError) {
        print(state.error);
      }
    }
  }

  Future<void> deletePost(postId) async {
    await _repository.deletePost(postId);
    _postsList.removeWhere((doc) => doc.id == postId);
    state = AsyncValue.data(_postsList);
=======
    if (state.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploading...'),
        ),
      );
    }
    state = await AsyncValue.guard(
      () async {
        List<String> downloadUrls = [];

        if (images.isNotEmpty) {
          final tasks = _repository.uploadPost(images, user!.uid);
          downloadUrls = await Future.wait(
            tasks.map(
              (task) async {
                final snapshot = await task.whenComplete(() => {});
                return await snapshot.ref.getDownloadURL();
              },
            ),
          );
        }
        await _repository.savePost(
          PostModel(
            id: '',
            content: content,
            images: downloadUrls,
            creatorUid: user!.uid,
            creator: user.displayName ?? "Unknown",
            createdAt: DateTime.now().millisecondsSinceEpoch,
            like: 0,
          ),
        );
      },
    );
>>>>>>> 33a3afcb8bdd8621ff4a4e17e3d0b90babc362ca
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, List<PostModel>>(
  () => PostViewModel(),
);
