import 'dart:async';

import 'package:creama/features/post/model/post_model.dart';
import 'package:creama/features/post/repo/post_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTimelineViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _postsList = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepoProvider);
    _postsList = await _fetchPosts(lastItemCreatedAt: null);
    return _postsList;
  }

  Future<List<PostModel>> _fetchPosts({int? lastItemCreatedAt}) async {
    final result =
        await _repository.fetchPost(lastItemCreatedAt: lastItemCreatedAt);
    final posts =
        result.docs.map((item) => PostModel.fromJson(json: item.data()));
    return posts.toList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final posts = await _fetchPosts(lastItemCreatedAt: null);
    _postsList = posts;
    state = AsyncValue.data(posts);
  }
}

final homeTimelineProvider =
    AsyncNotifierProvider<HomeTimelineViewModel, List<PostModel>>(
  HomeTimelineViewModel.new,
);
