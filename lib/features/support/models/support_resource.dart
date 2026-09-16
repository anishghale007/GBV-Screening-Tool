import 'package:flutter/material.dart';

/// Represents a verified emergency or support resource in the directory.
class SupportResource {
  const SupportResource({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.displayPhone,
    this.iconAsset,
    this.iconData,
    this.nameNe,
    this.descriptionNe,
  });

  final String id;
  final String name;
  final String description;
  final String phone;
  final String displayPhone;
  final String? iconAsset;
  final IconData? iconData;
  final String? nameNe;
  final String? descriptionNe;

  String localizedName(String languageCode) {
    if (languageCode == 'ne' && nameNe != null && nameNe!.isNotEmpty) {
      return nameNe!;
    }
    return name;
  }

  String localizedDescription(String languageCode) {
    if (languageCode == 'ne' &&
        descriptionNe != null &&
        descriptionNe!.isNotEmpty) {
      return descriptionNe!;
    }
    return description;
  }
}
