import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

enum FileSourceType {
  gallery,
  camera,
}

class FilePickerService {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickFile(FileSourceType sourceType) async {
    if (sourceType == FileSourceType.gallery) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } else if (sourceType == FileSourceType.camera) {
      XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return File(photo.path);
      }
    }
    return null;
  }
}
