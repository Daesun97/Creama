import 'package:creama/features/home/view_model/home_vm.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return ref.watch(homeTimelineProvider.notifier).refresh();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(homeTimelineProvider).when(
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
                      ),
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
                                  title: Text(post.content),
                                  subtitle: Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            post.createdAt)
                                        .toString(),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade500,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
