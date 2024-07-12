import 'dart:async';

import 'package:creama/features/post/model/post_model.dart';
import 'package:creama/features/post/repo/post_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTimelineViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _postsList = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepo);
    _postsList = await _fetchPosts(lastItemCreatedAt: null);
    return _postsList;
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
}

final homeTimelineProvider =
    AsyncNotifierProvider<HomeTimelineViewModel, List<PostModel>>(
  HomeTimelineViewModel.new,
);
