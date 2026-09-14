// widgets/styled_button.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isFullWidth;
  final double? width; // Adicionado para flexibilidade

  const StyledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = kColorMPIGreen,
    this.foregroundColor = kColorMPIWhite,
    this.isFullWidth = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
      ),
    );
  }
}