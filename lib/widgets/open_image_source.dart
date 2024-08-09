import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/utils/file_picker_service.dart';

Widget bottomSheet(BuildContext context, FirebaseStorageController controller) {
  Future openSource(FileSourceType source) async {
    final file = await FilePickerService().pickFile(source);
    File selected = File(file!.path);
    if (await selected.exists()) {
      Navigator.pop(context, selected);
    } else {
      Navigator.pop(context, File(''));
    }
  }

  var style = const TextStyle(
    fontSize: 12,
    letterSpacing: 0.02,
    fontWeight: FontWeight.w600,
  );
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      children: [
        Text(
          'Choose Image File',
          style: style,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              onTap: () async {
                openSource(FileSourceType.camera);
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 12,
                  ),
                  Text(
                    'Camera',
                    style: style,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
