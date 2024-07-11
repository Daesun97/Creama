import 'dart:io';

import 'package:creama/features/home/view/home_screen.dart';
import 'package:creama/features/home/view_model/home_vm.dart';
import 'package:creama/features/post/view_model/post_vm.dart';
import 'package:creama/features/post/views/camera_screen.dart';
import 'package:creama/features/post/views/widgets/bottom_sheet.dart';
import 'package:creama/features/post/views/widgets/image_listview.dart';
import 'package:creama/utils/gaps.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WritePostScreen extends ConsumerStatefulWidget {
  const WritePostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WritePostScreenState();
}

class _WritePostScreenState extends ConsumerState<WritePostScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<File> _selectedList = [];
  final FocusNode _focusNode = FocusNode();
  String _text = "";

  void _onDeletePhotoTap(File file) {
    setState(() {
      _selectedList.remove(file);
    });
  }

  void _onPostTap() {
    if (_text == "") return;

    ref
        .read(postProvider.notifier)
        .uploadPost(
          images: _selectedList,
          content: _textController.text,
          context: context,
        )
        .then((value) {
      context.pushReplacement(HomeScreen.routeURL);
      ref.watch(homeTimelineProvider.notifier).refresh();
    });
  }

  Future<void> _onCameraTap() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    ).then(
      (value) {
        if (value != null && mounted) {
          for (var item in value) {
            _selectedList.add(File(item.path));
          }

          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _text = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.size12),
            topRight: Radius.circular(Sizes.size12),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                '오늘의 커피',
              ),
              // 세팅화면
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: const FaIcon(FontAwesomeIcons.gear),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTime.now().toString().split(' ').first,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Gaps.v12,
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: '오늘 마신 커피는 어떤 맛이었나요?',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                        if (_selectedList.isNotEmpty) ...[
                          WritePostImageListView(
                            selectedList: _selectedList,
                            deletePhoto: _onDeletePhotoTap,
                          ),
                          Gaps.v8,
                        ],
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: _onCameraTap,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.size3),
                            child: FaIcon(
                              FontAwesomeIcons.cameraRetro,
                              color: Colors.grey.shade500,
                              size: Sizes.size24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet:
                PostBottomSheetAppBar(text: _text, onpost: _onPostTap)),
      ),
    );
  }
}
