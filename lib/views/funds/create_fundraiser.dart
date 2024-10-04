import 'package:dropdown_button2/dropdown_button2.dart';
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

import '../../utils/constant.dart';

class CreateFundRaserPage extends StatefulWidget {
  const CreateFundRaserPage({super.key});
  @override
  State<CreateFundRaserPage> createState() => _CreateFundRaserPageState();
}

class _CreateFundRaserPageState extends State<CreateFundRaserPage> {
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
  List<String> optionList = ['Health', 'Disaster', 'General', 'Social', 'NGO'];
  String? selectedValue = Utils.fundCategories[0];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    phoneController.text =
        _authController.userDetails.value!.phoneNumber?.isNotEmpty == true
            ? _authController.userDetails.value!.phoneNumber!
            : '';
    emailController.text = _authController.userDetails.value!.email!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Create a Fund",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: AppColor.textAccentB,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Map<String, String> details = {
                "Name": _authController.userDetails.value!.displayName!,
                "Email": emailController.text,
                "Mobile": phoneController.text,
                "Userid": _authController.userDetails.value!.uid,
                "UPI": upiController.text,
              };
              await PostMethods().post(
                amount: amountController.text,
                desc: descController.text,
                endDate: endDateController.text,
                fundType: selectedValue!,
                name: nameController.text,
                photoUrl: storageController.uploadedFileURL.value,
                details: details,
              );
              // Clear input fields after posting
              nameController.clear();
              descController.clear();
              amountController.clear();
              upiController.clear();
              phoneController.clear();
              endDateController.clear();
              storageController.uploadedFileURL.value = '';
              selectedValue = Utils.fundCategories[0];
            },
            child: Text(
              "Post",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColor.textAccentB,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload Section
              Obx(() => Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColor.grey.withOpacity(0.2),
                        ),
                        child: (storageController
                                .uploadedFileURL.value.isEmptyOrNull)
                            ? Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 100,
                                  color: AppColor.grey,
                                ).onTap(() {
                                  storageController
                                      .uploadFile(FileSourceType.gallery);
                                }),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  storageController.uploadedFileURL.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              // Fund Name Input
              buildInputField(
                controller: nameController,
                label: "Fund Name",
                prefixIcon: Icons.title,
                validator: (name) => name!.length < 4
                    ? 'Name should be at least 4 characters long'
                    : null,
              ),
              const SizedBox(height: 10),
              // Description Input
              buildInputField(
                controller: descController,
                label: "Description",
                prefixIcon: Icons.description,
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              // Amount Input
              buildInputField(
                controller: amountController,
                label: "Amount to be Collected",
                prefixIcon: Icons.currency_rupee_rounded,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    !value!.isNum ? 'Enter a valid amount' : null,
              ),
              const SizedBox(height: 10),
              // UPI Input
              buildInputField(
                controller: upiController,
                label: "UPI ID",
                prefixIcon: Icons.account_balance_wallet_outlined,
              ),
              const SizedBox(height: 10),
              // Phone Input
              buildInputField(
                controller: phoneController,
                label: "Mobile Number",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    !value!.isPhoneNumber ? 'Enter a valid phone number' : null,
              ),
              const SizedBox(height: 10),
              // Email Input
              buildInputField(
                controller: emailController,
                label: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
              ),
              const SizedBox(height: 15),
              // End Date Picker
              buildInputField(
                controller: endDateController,
                label: "End Date",
                prefixIcon: Icons.calendar_today,
                readOnly: true,
                onTap: () => selectDate(context),
              ),
              const SizedBox(height: 20),
              // Fund Category Dropdown
              fundCategory(width),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField2<String> fundCategory(double width) {
    return DropdownButtonFormField2(
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 29,
          iconEnabledColor: const Color(0xFF251E1E).withOpacity(.5),
          iconDisabledColor: const Color(0xFF251E1E).withOpacity(.5),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 175,
          elevation: 1,
          width: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.textAccentB,
          ),
          offset: Offset(width * .69, 0),
          scrollbarTheme: const ScrollbarThemeData(
            radius: Radius.circular(10),
          ),
        ),
        isExpanded: false,
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 15, right: 14),
        ),
        hint: Text(
          'Fund category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF323232).withOpacity(0.7),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        decoration: InputDecoration(
          labelText: 'Select Category',
          prefixIcon: const Icon(Icons.wysiwyg_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
        ),
        items: Utils.fundCategories
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        onChanged: (String? value) {
          selectedValue = value;
        });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2050));
    if (picked != null) {
      endDateController.text = picked.toString().split(' ')[0];
    }
  }
}
