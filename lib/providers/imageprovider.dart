import 'package:banquetbookingz/models/imagemodal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageStateNotifier extends StateNotifier<ImageModal> {
  ImageStateNotifier() : super(ImageModal());

  final ImagePicker _picker = ImagePicker();

 void setProfilePic(XFile newProfilePic) {
    state = state.copyWith(profilePic: newProfilePic);
  }

  Future<void> pickImage(BuildContext context, source, String imageType) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final fileSize = await pickedFile.length();
      final allowedExtensions = ['jpg', 'pdf', 'png'];
      final extension = pickedFile.path.split('.').last.toLowerCase();
      if (fileSize > 2 * 1024 * 1024 ||
          !allowedExtensions.contains(extension)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(fileSize > 2 * 1024 * 1024
                  ? 'The file is too large. Please choose a file smaller than 2MB.'
                  : "Invalid file type. Only jpg, jpeg, pdf, and png files are allowed."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
        // File is larger than 2MB
        // Handle the error, possibly by showing an error message
        return;
      } else {
        switch (imageType) {
          case 'profilePic':
            state = state.copyWith(profilePic: pickedFile);
            break;
         

          default:
            // Handle unknown image type if necessary
            break;
        }
        return;
      }

      // Check the file extension
    }
  }
}

final imageProvider =
    StateNotifierProvider<ImageStateNotifier, ImageModal>((ref) {
  return ImageStateNotifier();
});

enum DateRange { fifteenDays, month, custom }

class DateRangeNotifier extends StateNotifier<DateRange> {
  DateRangeNotifier() : super(DateRange.fifteenDays);

  void setDateRange(DateRange range) {
    state = range;
  }
}

final dateRangeProvider =
    StateNotifierProvider<DateRangeNotifier, DateRange>((ref) {
  return DateRangeNotifier();
});
