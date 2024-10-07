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


  ///------------------------Uploading a specific file-----------------------------------
  Future<String> uploadFileFromFile(File file) async {
    String downloadUrl = "";

    try {
      // Create a reference to the file location in Firebase Storage
      Reference storageRef = _storage
          .refFromURL('$storageBaseUrl$personal${file.path.split('/').last}');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(file);

      // Wait until the file upload completes
      await uploadTask;

      // Get the file's download URL after upload
      downloadUrl = await storageRef.getDownloadURL();

      debugPrint("File uploaded successfully. Download URL: $downloadUrl");
    } catch (e) {
      debugPrint('Failed to upload file: $e');
      Get.snackbar('Error', 'Failed to upload file: $e');
    }

    return downloadUrl;
  }

  ///------------------------Downloading a file-----------------------------------
  Future<void> downloadFile() async {
    try {
      // Get the app's document directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File('${appDocDir.path}/downloaded_file');

      // Reference to the file in Firebase Storage
      Reference storageRef = _storage.refFromURL(
          '${storageBaseUrl}logo.png'); // Replace with the actual file you want to download

      // Download the file and write it to the local storage
      await storageRef.writeToFile(downloadToFile);

      // Show a success message
      debugPrint('File downloaded to: ${downloadToFile.path}');
      Get.snackbar('Success', 'File downloaded to ${downloadToFile.path}');
    } catch (e) {
      debugPrint('Failed to download file: $e');
      Get.snackbar('Error', 'Failed to download file: $e');
    }
  }
}
