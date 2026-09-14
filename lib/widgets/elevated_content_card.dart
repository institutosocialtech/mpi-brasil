// widgets/elevated_content_card.dart
import 'package:flutter/material.dart';

class ElevatedContentCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const ElevatedContentCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.elevation = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Card(
        elevation: elevation,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}