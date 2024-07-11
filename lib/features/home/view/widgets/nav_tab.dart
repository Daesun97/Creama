import 'package:creama/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final int selectedIndex;

  final Function onTap;
  const NavTab(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.selectedIcon,
      required this.selectedIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected ? Colors.white : const Color(0xFFE3B964),
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFFE3B964),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
