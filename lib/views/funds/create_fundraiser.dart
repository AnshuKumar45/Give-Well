import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/file_picker_service.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/views/resources/fundpost.dart';
import 'package:fundraiser_app/widgets/Text_field.dart';
import 'package:get/get.dart';

class CreateFundRaserPage extends StatelessWidget {
  CreateFundRaserPage({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController upiController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  final TextEditingController fundTypeController = TextEditingController();
  
  final FirebaseStorageController controller =
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
              String res = await PostMethods().post(
                amount: amountController.text,
                desc: descController.text,
                endDate: endDateController.text,
                fundType: fundTypeController.text,
                name: nameController.text,
                upi: upiController.text,
                photoUrl: '',
              );
              nameController.clear();
              descController.clear();
              amountController.clear();
              fundTypeController.clear();
              endDateController.clear();
              upiController.clear();
              print(res);
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
              Stack(
                children: [
                  Container(
                    height: 300,
                    child: Image.network(
                        "https://i.natgeofe.com/k/7d906c71-1105-4048-b32b-a55b1b04e3bc/OG_Floods_KIDS_0922_3x2.jpg"),
                  ),
                  IconButton(
                    onPressed: () => controller.uploadFile(FileSourceType.gallery),
                    icon: Icon(
                      Icons.add_a_photo,
                      color: AppColor.primary,
                    ),
                  ),
                ],
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
