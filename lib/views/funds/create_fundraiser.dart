import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/controllers/firebase_storage_controller.dart';
import 'package:fundraiser_app/database/firebase_post_service.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/file_picker_service.dart';
import 'package:fundraiser_app/widgets/form_field_input.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/text_styles.dart';

//
class CreateFundRaserPage extends StatelessWidget {
  CreateFundRaserPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController fundTypeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseStorageController storageController =
      Get.put(FirebaseStorageController());

  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    phoneController.text = _authController.userDetails.value!.phoneNumber!;
    emailController.text = _authController.userDetails.value!.email!;
    List<String> optionList = ['Health', 'Disater', 'General', 'Social', 'NGO'];
    String? selectedValue = optionList[0];
    CustomFormField form = CustomFormField();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundW,
        title: text("Create a Fund", AppColor.textAccentW, 20),
        actions: [
          TextButton(
            onPressed: () async {
              Map<String, String> l = {
                "Name": _authController.userDetails.value!.displayName!,
                "Email": emailController.text,
                "Mobile": phoneController.text,
                "Userid": _authController.userDetails.value!.uid,
                "upi": upiController.text,
              };
              await PostMethods().post(
                amount: amountController.text,
                desc: descController.text,
                endDate: endDateController.text,
                fundType: selectedValue!,
                name: nameController.text,
                photoUrl: storageController.uploadedFileURL.value,
                details: l,
              );
              nameController.clear();
              descController.clear();
              amountController.clear();
              fundTypeController.clear();
              endDateController.clear();
              upiController.clear();
              phoneController.clear();
              storageController.uploadedFileURL.value = '';
              selectedValue = optionList[0];
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
              TextFormField(
                decoration: form.inputDecorationNormal("Fund name", false),
                controller: nameController,
                keyboardType: TextInputType.name,
                style: GoogleFonts.aBeeZee(),
                validator: (name) => (name!.length < 4)
                    ? 'Name Should be atleast 4 charaters'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: form.inputDecorationNormal("Description", false),
                controller: descController,
                keyboardType: TextInputType.name,
                style: GoogleFonts.aBeeZee(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: form.inputDecoration("Amount to be collected",
                    false, const Icon(Icons.currency_rupee_rounded)),
                controller: amountController,
                style: GoogleFonts.aBeeZee(),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    (!value!.isNum) ? 'Enter a valid amount' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: form.inputDecoration(
                    "Enter your upi", false, const Icon(Icons.email_outlined)),
                controller: upiController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.aBeeZee(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: form.inputDecoration(
                    "Mobile No.", false, const Icon(Icons.phone)),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.aBeeZee(),
                validator: (value) => (!value!.isPhoneNumber)
                    ? 'please enter a valid phone number'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: form.inputDecoration(
                    "Email", true, const Icon(Icons.email)),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.aBeeZee(),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: selectedValue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: optionList
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: text(item, Colors.black, 16),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  selectedValue = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: endDateController,
                decoration: form.inputDecoration(
                    "End date", true, const Icon(Icons.calendar_today)),
                style: GoogleFonts.aBeeZee(),
                onTap: () => selectDate(context),
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2050));
    if (picked != null) {
      endDateController.text = picked.toString().split(' ')[0];
    }
  }
}
