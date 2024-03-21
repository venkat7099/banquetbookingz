import 'package:banquetbookingz/providers/imageprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final allFieldsFilledProvider = Provider<bool>((ref) {
  final images = ref.watch(imageProvider);
  final selection = ref.watch(selectionModelProvider);
  // Assuming selectionModelProvider.state has a property 'name' for the full name
  return selection.name.text.isNotEmpty &&
      selection.email.text.isNotEmpty &&
      
      images.profilePic != null;
});