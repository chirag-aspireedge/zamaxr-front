class SubscriptionPlanModel {
  final String id;
  final String name;
  final String monthlyPrice;
  final String yearlyPrice;
  final String billingPeriod;
  final bool isRecommended;
  final String? subheader;
  final List<String> features;
  final String ctaText;
  final bool isPrimaryGradient;

  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.yearlyPrice,
    this.billingPeriod = '/ Month',
    this.isRecommended = false,
    this.subheader,
    required this.features,
    required this.ctaText,
    this.isPrimaryGradient = false,
  });
}

class FeatureComparisonItem {
  final String featureName;
  final bool standardAvailable;
  final String? standardText;
  final bool premiumAvailable;
  final String? premiumText;

  const FeatureComparisonItem({
    required this.featureName,
    this.standardAvailable = true,
    this.standardText,
    this.premiumAvailable = true,
    this.premiumText,
  });
}
