import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/file_picker_service.dart';

class FirebaseStorageService {
  static String community = "community/";
  static String personal = "personal/";
  static String storageBaseUrl = 'gs://communityfundraiserapp.appspot.com/';
  final FilePickerService filePickerService = FilePickerService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///------------------------uploading-----------------------------------
  Future<void> uploadFile(
      FileSourceType sourceType, String uploadedFileUrl) async {
    try {
      File? file = await filePickerService.pickFile(sourceType);

      if (file != null) {
        // Create a reference to the file in Firebase Storage
        Reference storageRef = _storage
            .refFromURL('$storageBaseUrl$personal${file.path.split('/').last}');
        // Upload the file
        await storageRef.putFile(file);
        // Get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        uploadedFileUrl = downloadURL;
        // Show a success message
        Get.snackbar('Success', 'File uploaded successfully!');
      } else {
        Get.snackbar('Error', 'No file selected');
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Failed to upload file: $e');
    }
  }

  ////------------------------------------downloading incomplete code-----------------------------------
  Future<void> downloadFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File('${appDocDir.path}/downloaded_file');

      // Create a reference to the file in Firebase Storage
      Reference storageRef = _storage.refFromURL(
          '${storageBaseUrl}logo.png'); // Replace with the file you want to download

      // Download the file
      await storageRef.writeToFile(downloadToFile);

      // Show a success message
      debugPrint(downloadToFile.path);
      Get.snackbar('Success', 'File downloaded to ${downloadToFile.path}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download file: $e');
    }
  }
}
