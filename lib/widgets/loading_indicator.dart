// widgets/loading_indicator.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';

class LoadingIndicator extends StatelessWidget {
  final String message;
  final Color progressColor;
  final bool showMessage;

  const LoadingIndicator({
    super.key,
    this.message = '',
    this.progressColor = kColorMPIGreen,
    this.showMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: kColorMPIWhite,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
          if (showMessage) ...[
            const SizedBox(height: 16),
            Text(message),
          ],
        ],
      ),
    );
  }
}