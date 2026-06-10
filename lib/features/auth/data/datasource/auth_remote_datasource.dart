import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/exceptions/firebase_exception_mapper.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSource(
    this._firebaseAuth,
  );

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _firebaseAuth
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(
        credential.user!,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseExceptionMapper.map(e),
      );
    } catch (_) {
      throw AppException(
        'Unable to login',
      );
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _firebaseAuth
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromFirebaseUser(
        credential.user!,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseExceptionMapper.map(e),
      );
    } catch (_) {
      throw AppException(
        'Unable to register',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } 
    on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseExceptionMapper.map(e),
      );
    }
    catch (_) {
      throw AppException(
        'Unable to logout',
      );
    }
  }

  UserModel? currentUser() {
    final user =
        _firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel.fromFirebaseUser(
      user,
    );
  }
}