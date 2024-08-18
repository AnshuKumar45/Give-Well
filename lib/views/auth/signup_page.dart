import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/change_focus_field.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/widgets/custom_elevated_button.dart';
import 'package:fundraiser_app/widgets/form_field_input.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final nFocus = FocusNode();
  final eFocus = FocusNode();
  final pFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nFocus.dispose();
    eFocus.dispose();
    pFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => navigator!.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.primaryBackgroundW,
            )),
        title: text('Sign Up', Colors.white, 24, fw: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image Placeholder

              SizedBox(height: height * .032),

              // Name Input Field
              buildInputField(
                focusNode: nFocus,
                onFieldSubmitted: (p0) {
                  fieldFocusChange(
                    context: context,
                    currentFocus: nFocus,
                    nextFocus: eFocus,
                  );
                },
                controller: nameController,
                label: 'Name',
                prefixIcon: Icons.person_rounded,
              ),
              const SizedBox(height: 20),
              // Email Input Field
              buildInputField(
                focusNode: eFocus,
                onFieldSubmitted: (p0) {
                  fieldFocusChange(
                    context: context,
                    currentFocus: eFocus,
                    nextFocus: pFocus,
                  );
                },
                controller: emailController,
                label: 'Email',
                prefixIcon: Icons.email_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Password Input Field
              buildInputField(
                focusNode: pFocus,
                onFieldSubmitted: (p0) {
                  pFocus.unfocus();
                },
                controller: passwordController,
                label: 'Password',
                prefixIcon: Icons.lock_rounded,
              ),
              const SizedBox(height: 32),

              // Signup Button
              CustomElevatedButton(
                width: double.infinity,
                borderColor: AppColor.primary,
                buttonColor: AppColor.primary,
                textColor: Colors.white,
                onTap: () {
                  authController.signUpWithEmail(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                innerText: 'Sign Up',
              ),
              const SizedBox(height: 16),

              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text('Already have an account? ', AppColor.textAccentW, 14),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: text('Login', AppColor.primary, 14,
                        fw: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
