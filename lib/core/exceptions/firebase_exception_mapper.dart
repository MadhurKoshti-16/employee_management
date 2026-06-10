import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionMapper {
  static String map(FirebaseAuthException e) {

    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address';

      case 'invalid-credential':
        return 'Invalid email or password';

      case 'user-disabled':
        return 'This account has been disabled';

      case 'email-already-in-use':
        return 'Email already registered';

      case 'weak-password':
        return 'Password must be at least 6 characters';

      case 'network-request-failed':
        return 'No internet connection';

      case 'too-many-requests':
        return 'Too many attempts. Try again later';


      default:
        return e.message ?? 'Something went wrong';
    }
  }
}
