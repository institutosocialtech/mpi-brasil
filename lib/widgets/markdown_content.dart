// widgets/markdown_content.dart
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownContent extends StatelessWidget {
  final String data;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;

  const MarkdownContent({
    super.key,
    required this.data,
    this.textAlign = TextAlign.justify,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: MarkdownGenerator().buildWidgets(data),
      ),
    );
  }
}