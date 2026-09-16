import 'package:gbv/core/enums/incident_category.dart';

class IncidentTypeModel {
  const IncidentTypeModel({
    required this.category,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  final IncidentCategory category;
  final String iconPath;
  final String title;
  final String description;

  String get id => category.id;
}
