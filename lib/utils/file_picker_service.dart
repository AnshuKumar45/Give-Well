import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/widgets/open_image_source.dart';
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

  Future<File?> chooseImageFile(BuildContext context,FirebaseStorageController storageController) async {
    try {
      return await showModalBottomSheet(
        context: context,
        builder: (builder) => bottomSheet(context,storageController),
      );
    } catch (e) {}
    return null;
  }
}
