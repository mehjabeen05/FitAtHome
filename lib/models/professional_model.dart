class Professional {
  final String id;
  final String name;
  final String profession;
  final String qualification;
  final int experienceYears;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final double basePricePerMinute;
  final String bio;
  final bool isVerified;
  final List<String> availableSlots;
  final List<String> serviceCategoryIds;

  const Professional({
    required this.id,
    required this.name,
    required this.profession,
    required this.qualification,
    required this.experienceYears,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.basePricePerMinute,
    required this.bio,
    required this.isVerified,
    required this.availableSlots,
    required this.serviceCategoryIds,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  double priceForDuration(int durationMinutes) => basePricePerMinute * durationMinutes;
}
