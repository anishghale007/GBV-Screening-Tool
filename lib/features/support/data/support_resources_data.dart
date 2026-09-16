import 'package:flutter/material.dart';
import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/features/support/models/support_resource.dart';

/// Predefined list of verified support helplines and emergency centers in
/// Nepal.
const List<SupportResource> defaultSupportResources = [
  SupportResource(
    id: 'nwc_helpline',
    name: 'National Women Helpline',
    nameNe: 'राष्ट्रिय महिला हेल्पलाइन',
    description: '24/7 National Women Commission support',
    descriptionNe: '२४/७ राष्ट्रिय महिला आयोग सहयोग',
    phone: '1145',
    displayPhone: '1145',
    iconAsset: AssetConstants.safeIcon,
    iconData: Icons.shield_outlined,
  ),
  SupportResource(
    id: 'police_women_cell',
    name: 'Nepal Police Women Cell',
    nameNe: 'नेपाल प्रहरी महिला सेल',
    description: 'Direct line to special dispatch cell',
    descriptionNe: 'विशेष प्रेषण सेलको लागि प्रत्यक्ष सम्पर्क',
    phone: '100',
    displayPhone: '100',
    iconAsset: AssetConstants.emergencyLightIcon,
    iconData: Icons.emergency_outlined,
  ),
  SupportResource(
    id: 'sathi_shelter',
    name: 'SATHI Emergency Shelter',
    nameNe: 'साथी आपतकालीन आश्रय',
    description: 'Safe secure shelter and temporary lodging',
    descriptionNe: 'सुरक्षित आश्रय र अस्थायी आवास',
    phone: '01555309',
    displayPhone: '01-555309',
    iconAsset: AssetConstants.homeIcon,
    iconData: Icons.home_outlined,
  ),
];
