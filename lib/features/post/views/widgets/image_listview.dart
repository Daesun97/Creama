import 'dart:io';

import 'package:creama/utils/gaps.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WritePostImageListView extends StatelessWidget {
  final List<File> selectedList;
  final Function deletePhoto;
  const WritePostImageListView({
    super.key,
    required this.selectedList,
    required this.deletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //일단 높이 고정
      height: 150,
      child: ListView.separated(
        itemCount: selectedList.length,
        separatorBuilder: (context, index) => Gaps.h10,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.size20),
                ),
                child: Image.file(
                  File(selectedList[index].path),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: () => deletePhoto(selectedList[index]),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(Sizes.size7),
                    //나중에 색 넣기
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.black,
                      size: Sizes.size16,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
