import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/database/firebase_post_service.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/file_picker_service.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fundraiser_app/widgets/custom_textform_field.dart';
import '../../utils/text_styles.dart';

class CreateFundRaserPage extends StatelessWidget {
  CreateFundRaserPage({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController upiController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  final TextEditingController fundTypeController = TextEditingController();

  final FirebaseStorageController storageController =
      Get.put(FirebaseStorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundW,
        title: text("Create a Fund", AppColor.textAccentW, 20),
        actions: [
          TextButton(
            onPressed: () async {
              await PostMethods().post(
                amount: amountController.text,
                desc: descController.text,
                endDate: endDateController.text,
                fundType: fundTypeController.text,
                name: nameController.text,
                upi: upiController.text,
                photoUrl: storageController.uploadedFileURL.value,
              );
              nameController.clear();
              descController.clear();
              amountController.clear();
              fundTypeController.clear();
              endDateController.clear();
              upiController.clear();
            },
            child: text("post", AppColor.textAccentW, 18),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Obx(() => Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: (storageController
                                  .uploadedFileURL.value.isEmptyOrNull)
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 150,
                                  color: AppColor.grey,
                                ).onTap(() {
                                  storageController
                                      .uploadFile(FileSourceType.gallery);
                                })
                              : Image.network(
                                  storageController.uploadedFileURL.value,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                  text: "Fund name",
                  textEditingController: nameController,
                  inputType: TextInputType.name),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  text: "Description",
                  textEditingController: descController,
                  inputType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  text: "Fund Tpye",
                  textEditingController: fundTypeController,
                  inputType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                textEditingController: amountController,
                text: "Amount to be collected",
                inputType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                text: "Enter your upi",
                textEditingController: upiController,
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                text: "Enter end date(dd/mm/yyyy)",
                textEditingController: endDateController,
                inputType: TextInputType.datetime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
