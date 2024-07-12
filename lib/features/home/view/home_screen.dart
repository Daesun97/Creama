import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:creama/features/authentication/views/login_screen.dart';
import 'package:creama/features/home/view/widgets/images.dart';
import 'package:creama/features/home/view_model/home_vm.dart';
import 'package:creama/features/post/repo/post_repo.dart';
import 'package:creama/features/post/view_model/post_vm.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "home";
  static const routeURL = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _onRefresh() {
    return ref.watch(postProvider.notifier).refresh();
  }

  Future<void> _signOut() {
    context.pushReplacement(LogInScreen.routeURL);
    return ref.watch(authRepo).signOut();
  }

  // Future<void> _usersonRefresh() {
  //   return ref
  //       .watch(homeTimelineProvider.notifier)
  //       .usersrefresh(uid: ref.read(authRepo).user!.uid);
  // }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeInOut);
  }

  // Future<void> _deletePost({required int craatedAt}) {
  //   return ref.watch(homeTimelineProvider.notifier).deletePost(craatedAt);
  // }

  void _onDelete(String postId) {
    print("delete: $postId");
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("이 향기를 잊습니다"),
        message: const Text("정말로 잊습니다?"),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              ref.read(postProvider.notifier).deletePost(postId);
              Navigator.of(context).pop();
            },
            child: const Text("삭제"),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("취소"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postProvider).when(
          error: (error, stackTrace) => Center(
            child: Text('$error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (posts) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  displacement: 50,
                  edgeOffset: 50,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                          floating: true,
                          snap: true,
                          title: GestureDetector(
                            onTap: _scrollToTop,
                            child: const FaIcon(
                              FontAwesomeIcons.mugSaucer,
                              size: Sizes.size28,
                            ),
                          ),
                          centerTitle: true,
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: Sizes.size28),
                              child: GestureDetector(
                                onTap: () => _signOut(),
                                child: const FaIcon(
                                  FontAwesomeIcons.powerOff,
                                  color: Colors.white,
                                  size: Sizes.size28,
                                ),
                              ),
                            ),
                          ]),
                      posts.isEmpty
                          ? SliverToBoxAdapter(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: const Center(
                                  child: Text(
                                    softWrap: true,
                                    "마신 커피의 향을 기억해 봐요",
                                    style: TextStyle(
                                      fontSize: Sizes.size20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SliverList.separated(
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                return ListTile(
                                  title: Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            post.createdAt)
                                        .toString()
                                        .split(' ')
                                        .first,
                                  ),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.content,
                                        style: const TextStyle(
                                            fontSize: Sizes.size20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (post.images.isNotEmpty)
                                        ImagesSlider(
                                          imgs: post.images,
                                        )
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () => _onDelete(post.id),
                                    child:
                                        const FaIcon(FontAwesomeIcons.trashCan),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade500,
                                );
                              },
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
