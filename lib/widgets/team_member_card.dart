// widgets/team_member_card.dart
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String? lattesUrl; // Mantém nullable pois pode não ter Lattes
  final Widget? logo; // Mantém nullable pois pode não ter logo
  final bool showLogo;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.role,
    this.lattesUrl,
    this.logo,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          if (showLogo && logo != null) logo!,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _handleTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: MarkdownGenerator().buildWidgets(
                      '**$name**\n$role',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap() {
    if (lattesUrl != null) {
      launchUrl(Uri.parse(lattesUrl!));
    }
  }
}