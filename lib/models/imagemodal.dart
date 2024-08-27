
import 'package:image_picker/image_picker.dart';

class ImageModal {
  final XFile? profilePic;
  ImageModal(
      {this.profilePic,
      });
  ImageModal copyWith(
      {XFile? profilePic,
      }) {
    return ImageModal(
        profilePic: profilePic ?? this.profilePic,
        );
  }
}
