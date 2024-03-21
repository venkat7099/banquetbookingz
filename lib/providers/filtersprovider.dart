import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterOptionsState {
  final Map<String, List<String>> options;

  FilterOptionsState({required this.options});
}

class FilterOptionsNotifier extends StateNotifier<FilterOptionsState> {
  FilterOptionsNotifier() : super(FilterOptionsState(options: {
    'Subscription Type': ['Pro', 'Expert', 'Pro Plus'],
    'Billing Type': ['Monthly', 'Quaterly', 'Anually'],
    'Payment Type': ['Credit', 'Debit', 'UPI'],
    'Subscription tags':["Value For Money","Best Seller","Limitted Time Offer"]
  }));

  void removeOption(String category, String option) {
    final categoryOptions = state.options[category]?.toList() ?? [];
    categoryOptions.remove(option);
    state = FilterOptionsState(options: {
      ...state.options,
      category: categoryOptions,
    });
  }
}
final filterOptionsProvider = StateNotifierProvider<FilterOptionsNotifier, FilterOptionsState>((ref) {
  return FilterOptionsNotifier();
});