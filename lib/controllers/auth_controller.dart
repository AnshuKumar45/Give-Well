import 'package:fundraiser_app/views/navigation_wrapper.dart';
import 'package:fundraiser_app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/firebase_auth_service.dart';
class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  var user = Rxn<User>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    user.value = _authService.getCurrentUser(); // Get current user
  }
  // Gmail Sign-In
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      user.value = await _authService.signInWithGoogle();
      if (user.value != null) {
        showCustomSnackbar(
            title: 'Success', message: 'Google Sign-In successful!');
        Get.offAll(() => NavigationWrapper());
      }
    } catch (e) {
      showCustomSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Email Sign-Up
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      user.value = await _authService.signUpWithEmail(email, password);
      if (user.value != null) {
        showCustomSnackbar(title: 'Success', message: 'Signup successful!!');
        Get.offAll(() => NavigationWrapper());
      }
    } catch (e) {
      showCustomSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Email Sign-In
  Future<void> signInWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      user.value = await _authService.signInWithEmail(email, password);
      if (user.value != null) {
        showCustomSnackbar(title: 'Success', message: 'Login successful');
        Get.offAll(() => NavigationWrapper());
      }
    } catch (e) {
      showCustomSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Sign Out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      user.value = null;
      showCustomSnackbar(title: 'Success', message: 'Signed out successfully');
    } catch (e) {
      showCustomSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
