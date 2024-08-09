import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _keyName = 'userName';
  static const String _keyEmail = 'userEmail';
  static const String _keyPhotoURL = 'userPhotoURL';
  static const String _phoneNumber = 'phoneNumber';

  // Save user details
  static Future<void> saveUserDetails(
      String name, String email, String photoURL, String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPhotoURL, photoURL);
    await prefs.setString(_phoneNumber, phoneNumber);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Get user photo URL
  static Future<String?> getUserPhotoURL() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhotoURL);
  }

  // Get phone number
  static Future<String?> getUserPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumber);
  }

  // Clear user details
  static Future<void> clearUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPhotoURL);
    await prefs.remove(_phoneNumber);
  }
}
