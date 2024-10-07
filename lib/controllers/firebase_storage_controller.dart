import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fundraiser_app/database/firebase_storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/file_picker_service.dart';

class FirebaseStorageController extends GetxController {
  RxString uploadedFileURL = ''.obs;
  Rx<File?> selectedImageFile = Rx<File?>(null);
  final FirebaseStorageService _storageService = FirebaseStorageService();

  Future<void> selectFile(FileSourceType type) async {
    try {
      File? file = await pickFile(type);
      if (file != null) {
        selectedImageFile.value = file;
      }
    } catch (e) {
      debugPrint('File selection failed: $e');
    }
  }

  Future<bool> uploadFile() async {
    if (selectedImageFile.value == null) return false;
    try {
      String fileUrl = await _storageService
          .uploadFileFromFile(selectedImageFile.value!); // Adjust as needed
      if (fileUrl.isNotEmpty) {
        uploadedFileURL.value = fileUrl;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('File upload failed: $e');
      return false;
    }
  }

  void clearSelectedImage() {
    selectedImageFile.value = null;
  }

  void downloadFile() {
    _storageService.downloadFile();
  }

  Future<File?> pickFile(FileSourceType sourceType) async {
    try {
      FilePickerResult? result;

      if (sourceType == FileSourceType.gallery) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
      } else if (sourceType == FileSourceType.camera) {
        // For camera functionality, you'd typically use the `image_picker` package
        XFile? pickedFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        return pickedFile != null ? File(pickedFile.path) : null;
      }

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('File picking failed: $e');
      return null;
    }
  }
}
