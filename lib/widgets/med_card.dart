// widgets/med_card.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/models/med.dart';

class MedCard extends StatelessWidget {
  final Med med;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const MedCard({
    super.key,
    required this.med,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColorMPIGreenOpaque,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
        ),
        title: Text(
          med.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          med.medTypesToString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          color: Colors.white,
          onPressed: onFavoriteTap,
        ),
        onTap: onTap,
      ),
    );
  }
}