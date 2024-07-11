import 'dart:async';
import 'dart:io';

import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:creama/features/post/model/post_model.dart';
import 'package:creama/features/post/repo/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final PostRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(postRepo);
  }

  Future<void> uploadPost({
    required List<File> images,
    required String content,
    required BuildContext context,
  }) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();

    if (state.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('커피 이모티콘'),
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
            like: 0,
            id: '',
            content: content,
            images: downloadUrls,
            creatorUid: user!.uid,
            creator: "미상",
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      },
    );
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);
