import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/views/navigation_wrapper.dart';
import 'package:fundraiser_app/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            text: "Enter your gmail",
            inputType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            text: "password",
            inputType: TextInputType.visiblePassword,
            textEditingController: passController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (){ Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationWrapper()));},
            child: text("Login", AppColor.textAccentW, 16),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: text("signUp", AppColor.textAccentW, 16),
          ),
        ],
      ),
    );
  }
}
