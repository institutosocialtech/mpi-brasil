import 'package:flutter/material.dart';

extension DateTimeX on DateTime {
  String get formattedDate => '${this.day}/${this.month}/${this.year}';
}
