import 'package:fundraiser_app/database/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../utils/file_picker_service.dart';

class FirebaseStorageController extends GetxController {
  RxString uploadedFileURL = ''.obs;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  void uploadFile(FileSourceType type) {
    _storageService.uploadFile(type, uploadedFileURL.value);
  }

  void downloadFile() {
    _storageService.downloadFile();
  }
}
