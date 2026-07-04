import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
    }
    notifyListeners();
  }

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
