import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

Future<Uint8List?> pickImage(ImageSource source) async {
  final picker = ImagePicker();

  final pickedImage = await picker.pickImage(source: source);

  if (pickedImage != null) {
    final file = File(pickedImage.path);
    final bytes = await file.readAsBytes();
    return bytes;
  }

  return null;
}
