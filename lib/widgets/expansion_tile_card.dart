// widgets/expansion_tile_card.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/widgets/elevated_content_card.dart';

class ExpansionTileCard extends StatelessWidget {
  final String title;
  final Widget content;
  final TextStyle titleStyle;
  final bool initiallyExpanded;

  const ExpansionTileCard({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: titleStyle,
      ),
      initiallyExpanded: initiallyExpanded,
      children: [
        ElevatedContentCard(
          child: content,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}