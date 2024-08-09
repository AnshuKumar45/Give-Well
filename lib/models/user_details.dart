import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool? emailVerified;
  final String? phoneNumber;
  final String? providerId;

  UserDetails({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.emailVerified,
    this.phoneNumber,
    this.providerId,
  });

  // Factory constructor to create UserDetails from Firebase User
  factory UserDetails.fromFirebaseUser(User user) {
    return UserDetails(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
      phoneNumber: user.phoneNumber,
      providerId: user.providerData.isNotEmpty ? user.providerData[0].providerId : null,
    );
  }
}
