import 'package:flutter/material.dart';

@immutable
class SpecialtyEntity {
  final String id;
  final String name;
  final IconData iconReference;

  const SpecialtyEntity({
    required this.id,
    required this.name,
    required this.iconReference,
  });
}
