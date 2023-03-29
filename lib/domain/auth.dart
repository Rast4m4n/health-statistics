import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/fitness.activity.read',
      'https://www.googleapis.com/auth/fitness.blood_pressure.read',
      'https://www.googleapis.com/auth/fitness.body.read',
      'https://www.googleapis.com/auth/fitness.heart_rate.read',
      'https://www.googleapis.com/auth/fitness.location.read',
    ],
  );

  Future<void> signIn() async {
    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signInSilently();

    if (googleUser == null) {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        print('Ошибка авторизации: $error');
      }
    } else {
      print(
          'Пользователь google ${_googleSignIn.currentUser!.displayName} уже авторизован');
    }
  }
}
