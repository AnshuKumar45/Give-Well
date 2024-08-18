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

import '../../utils/contant.dart';
import '../../utils/text_styles.dart';

//
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
  CustomFormField form = CustomFormField();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    phoneController.text = _authController.userDetails.value!.phoneNumber!;
    emailController.text = _authController.userDetails.value!.email!;

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
            child: text("Post", AppColor.textAccentW, 18),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
              15.heightBox,
              DropdownButtonFormField2(
                  iconStyleData: IconStyleData(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    iconSize: 30,
                    iconEnabledColor: const Color(0xFF251E1E).withOpacity(.5),
                    iconDisabledColor: const Color(0xFF251E1E).withOpacity(.5),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    elevation: 1,
                    width: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.textAccentB,
                    ),
                    offset: Offset(width * .72, 0),
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
                  decoration: form.inputDecoration('Select category', false,
                      const Icon(Icons.wysiwyg_rounded)),
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
                  }),
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
