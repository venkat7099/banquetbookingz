import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage search text
class SearchTextNotifier extends StateNotifier<String> {
  SearchTextNotifier() : super('');

  void setSearchText(String text) {
    state = text;
  }
}

// Provider for search text state
final searchTextProvider = StateNotifierProvider<SearchTextNotifier, String>(
  (ref) => SearchTextNotifier(),
);
