class InterestItem {
  final String entityId;
  final String entityType; // 'doctor' or 'clinic'
  final DateTime addedAt;

  const InterestItem({
    required this.entityId,
    required this.entityType,
    required this.addedAt,
  });
}
