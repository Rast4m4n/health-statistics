import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/fitness.activity.read',
      'https://www.googleapis.com/auth/fitness.location.read',
      'https://www.googleapis.com/auth/fitness.blood_glucose.read',
      'https://www.googleapis.com/auth/fitness.blood_pressure.read',
      'https://www.googleapis.com/auth/fitness.body.read',
      'https://www.googleapis.com/auth/fitness.heart_rate.read',
      'https://www.googleapis.com/auth/fitness.nutrition.read',
    ],
  );

  Future<void> signIn() async {
    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signInSilently();

    if (googleUser == null) {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  Future<String?> getEmail() async {
    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signInSilently();

    if (googleUser != null) {
      return googleUser.email;
    }
    return null;
  }
}
