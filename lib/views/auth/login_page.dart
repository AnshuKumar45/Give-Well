import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/change_focus_field.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/views/auth/signup_page.dart';
import 'package:fundraiser_app/widgets/custom_elevated_button.dart';
import 'package:fundraiser_app/widgets/form_field_input.dart';
import 'package:fundraiser_app/widgets/tagline_widget.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/auth_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final nFocus = FocusNode();
  final eFocus = FocusNode();
  final pFocus = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nFocus.dispose();
    pFocus.dispose();
    eFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:
            text('Login to continue,', AppColor.grey, 35, fw: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .075,
              ),
              Container(
                padding: const EdgeInsets.all(
                    16.0), // Add padding around the container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      12.0), // Border radius for rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent
                          .withOpacity(0.2), // Purple accent shadow
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TaglineWidget(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .085,
                    ),
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
                      prefixIcon: Icons.person_2_rounded,
                    ),
                    25.heightBox, // Spacing between fields
                    // Email Input Field
                    buildInputField(
                      keyboardType: TextInputType.emailAddress,
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
                    ),
                    const SizedBox(height: 25), // Spacing between fields
                    // Password Input Field
                    buildInputField(
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: pFocus,
                      onFieldSubmitted: (p0) {
                        pFocus.unfocus();
                      },
                      controller: passwordController,
                      label: 'Password',
                      prefixIcon: Icons.password_rounded,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .10),
              // Login Button
              CustomElevatedButton(
                  borderColor: AppColor.primary,
                  buttonColor: AppColor.primaryBackgroundW,
                  textColor: AppColor.primary,
                  onTap: () {
                    authController.signInWithEmail(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    // Get.offAll(() => NavigationWrapper());
                  },
                  innerText: 'Login'),
              const SizedBox(height: 12),
              // Google Sign-In Button
              CustomElevatedButton(
                  onTap: () {
                    authController.signInWithGoogle();
                  },
                  innerText: 'Sign in with Google'),
              const SizedBox(height: 10),
              // Signup Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text('Don\'t have an account? ', AppColor.textAccentW, 12),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpPage());
                    },
                    child: text('Sign Up', AppColor.primary, 12,
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
