import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  // 🔐 Email Sign-Up
  Future<UserModel?> signUp(String email, String pass, String name) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    final user = cred.user!;
    await user.updateDisplayName(name);
    final model = UserModel(
      uid: user.uid,
      email: email,
      displayName: name,
      photoUrl: user.photoURL,
    );
    await _firestore.saveUser(model);
    return model;
  }

  // 🔐 Email Sign-In
  Future<UserModel?> signIn(String email, String pass) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    final user = cred.user!;
    final model = await _firestore.fetchUser(user.uid);
    return model;
  }

  // 🔓 Sign-Out
  Future<void> signOut() => _auth.signOut();

  // 🔄 User Stream
  Stream<UserModel?> get userChanges =>
      _auth.authStateChanges().asyncMap((u) => u == null ? null : _firestore.fetchUser(u.uid));

  // 🔐 Google Sign-In
  Future<UserModel?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    if (googleAuth == null) return null;

    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final userCred = await _auth.signInWithCredential(cred);
    final user = userCred.user!;
    final model = UserModel(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
    await _firestore.saveUser(model);
    return model;
  }

  // 🔐 Apple Sign-In
  Future<UserModel?> signInWithApple() async {
    final rawNonce = _generateNonce(32);
    final nonce = _sha256ofString(rawNonce);

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      rawNonce: rawNonce,
    );

    final userCred = await _auth.signInWithCredential(oauthCredential);
    final user = userCred.user!;
    final model = UserModel(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
    await _firestore.saveUser(model);
    return model;
  }

  // 🔧 Nonce & SHA256 Helpers
  String _generateNonce(int length) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}