import 'package:banquetbookingz/models/selection.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the provider
final selectionModelProvider =
    StateNotifierProvider<SelectionModelNotifier, SelectionModel>((ref) {
  return SelectionModelNotifier();
});

// StateNotifier implementation remains the same as previously defined
class SelectionModelNotifier extends StateNotifier<SelectionModel> {
  SelectionModelNotifier() : super(SelectionModel());

  void toggleCheckBox(bool? checkBoxValue) {
    if (checkBoxValue != null) {
      state = state.copyWith(checkBox: checkBoxValue);
    }
  }

  void updateEnteredemail(String newText) {
    // Assuming your SelectionModel correctly handles the TextEditingController,
    // you might need to recreate the TextEditingController with the new text
    // or find another way to ensure the TextEditingController updates do not conflict.
    state.email.text =
        newText; // Directly updating the TextEditingController's text.

    // IMPORTANT: This direct manipulation won't trigger a state update.
    // Consider creating a new instance of SelectionModel if needed to trigger a rebuild.
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }

  void updateEnteredpassword(String newText) {
    // Assuming your SelectionModel correctly handles the TextEditingController,
    // you might need to recreate the TextEditingController with the new text
    // or find another way to ensure the TextEditingController updates do not conflict.
    state.password.text =
        newText; // Directly updating the TextEditingController's text.

    // IMPORTANT: This direct manipulation won't trigger a state update.
    // Consider creating a new instance of SelectionModel if needed to trigger a rebuild.
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
}
