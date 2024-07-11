import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';

class PostBottomSheetAppBar extends StatelessWidget {
  final String text;
  final Function onpost;
  const PostBottomSheetAppBar(
      {super.key, required this.text, required this.onpost});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "오늘 커피도 맛나다",
            style: TextStyle(color: Colors.blueGrey),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onpost(),
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueGrey.withOpacity(text != "" ? 1 : 0.5),
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
