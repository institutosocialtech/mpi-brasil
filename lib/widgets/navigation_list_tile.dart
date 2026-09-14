// widgets/navigation_list_tile.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';

class NavigationListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData trailingIcon;
  final bool showDivider;

  const NavigationListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.trailingIcon = Icons.keyboard_arrow_right,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(trailingIcon),
            color: Colors.grey,
            onPressed: onTap,
          ),
          onTap: onTap,
        ),
        if (showDivider) const Divider(color: kColorMPIDividerGray),
      ],
    );
  }
}