import 'package:flutter/material.dart';
import 'package:fundraiser_app/views/auth/signup_page.dart';
import 'package:fundraiser_app/views/navigation_wrapper.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/auth_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  // TextEditingControllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.heightBox,

            // Email TextField
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password TextField
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),

            // Login Button
            ElevatedButton(
              onPressed: () {
                // authController.signInWithEmail(
                //   emailController.text.trim(),
                //   passwordController.text.trim(),
                // );
              Get.offAll(() => NavigationWrapper());
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),

            // Google Sign-In Button
            ElevatedButton(
              onPressed: () {
                authController.signInWithGoogle();
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 16),

            // Signup Button
            TextButton(
              onPressed: () {
                // Navigate to Signup Page
                Get.to(() => SignUpPage());
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
