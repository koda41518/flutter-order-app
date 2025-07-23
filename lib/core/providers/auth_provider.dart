import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  UserModel? user;

  AuthProvider() {
    _service.userChanges.listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String pass) async {
    final u = await _service.signIn(email, pass);
    if (u != null) user = u;
    notifyListeners();
    return u != null;
  }

  Future<bool> signUp(String email, String pass, String name) async {
    final u = await _service.signUp(email, pass, name);
    if (u != null) user = u;
    notifyListeners();
    return u != null;
  }


  Future<UserModel?> signInWithGoogle() async {
    final u = await _service.signInWithGoogle();
    if (u != null) user = u;
    notifyListeners();
    return user;
  }

  Future<UserModel?> signInWithApple() async {
    final u = await _service.signInWithApple();
    if (u != null) user = u;
    notifyListeners();
    return user;
  }

  Future<void> signOut() async {
    await _service.signOut();
    user = null;
    notifyListeners();
  }
}