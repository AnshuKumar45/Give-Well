import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/widgets/custrom_circular_progress.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final FirebaseStorageController controller =
      Get.put(FirebaseStorageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Storage Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomCircularProgress(),
            // ElevatedButton(
            //   onPressed: () => controller.uploadFile(FileSourceType.gallery),
            //   child: const Text('Upload from Gallery'),
            // ),
            // ElevatedButton(
            //   onPressed: () => controller.uploadFile(FileSourceType.camera),
            //   child: const Text('Upload from Camera'),
            // ),
            ElevatedButton(
              onPressed: controller.downloadFile,
              child: const Text('Download File'),
            ),
            Obx(() {
              if (controller.uploadedFileURL.value.isNotEmpty) {
                return Text(
                    'Uploaded file URL: ${controller.uploadedFileURL.value}');
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
