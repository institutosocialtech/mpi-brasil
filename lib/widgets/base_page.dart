// widgets/base_page.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/widgets/app_header.dart';
import 'package:mpibrasil/widgets/content_container.dart';
import 'package:mpibrasil/constants.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer; // Mantém nullable pois é opcional
  final Widget? floatingActionButton; 
  final List<Widget> actions;
  final Widget? leading;

  const BasePage({
    super.key,
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.actions = const [],
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,
      appBar: AppHeader(
        title: title,
        leading: leading,
        actions: actions,
      ),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      body: ContentContainer(child: body),
    );
  }
}