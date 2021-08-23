import 'package:flutter_app_login_bloc/model/user.dart';

import 'authentication.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User?> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (email.toLowerCase() != 'tanhy@gmail.com' || password != '123456') {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    return User(name: 'TanHy User', email: email);
  }

  @override
  Future<User?> signOut() async {
    return null;
  }
}
