class SubscriptionPlan {
  final int id;
  final String plan;
  final String
      frequency; // Changed to String to handle values like 45a, 46q, 58c
  final int bookings;
  final double pricing;
  final DateTime createdAt;

  SubscriptionPlan({
    required this.id,
    required this.plan,
    required this.frequency,
    required this.bookings,
    required this.pricing,
    required this.createdAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      plan: json['plan'],
      frequency: json['frequency'], // Keep this as a string directly
      bookings: json['bookings'],
      pricing: json['pricing'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'frequency': frequency, // Keep this as a string directly
      'bookings': bookings,
      'pricing': pricing,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
