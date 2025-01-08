import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final List<String> contentList;
  final bool isNumbered;
  final IconData? iconData;
  final Color? iconColor;

  const ResultCard({
    required this.title,
    required this.contentList,
    this.isNumbered = false,
    this.iconData,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final contentWidgets = contentList.asMap().entries.map((entry) {
      int index = entry.key + 1;
      String content = entry.value;
      return ListTile(
        leading: isNumbered
            ? Text(
                '$index.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              )
            : Icon(iconData, color: iconColor),
        title: Text(content, textAlign: TextAlign.justify),
        titleTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }).toList();

    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        initiallyExpanded: true,
        collapsedBackgroundColor: kColorMPIWhite,
        title: Text(
          this.title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        children: contentWidgets,
      ),
    );
  }
}
