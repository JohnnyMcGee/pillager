import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.userChanges();
  }

  User? get currentUser => _auth.currentUser;

  String? get currentEmail {
    final _currentUser = currentUser;
    if (_currentUser is User) {
      return _currentUser.email;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateEmail(
      {required String password, required String newEmail}) async {
    final _currentEmail = currentEmail;
    if (_currentEmail is String) {
      final user = await signIn(_currentEmail, password);
      if (user != null) {
        try {
          user.updateEmail(newEmail);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  Future<User?> userUpdateDisplayName(
      User? user, String firstName, String lastName) async {
    String displayName = "$firstName $lastName";
    await user?.updateDisplayName(displayName);
    User? currentUser = _auth.currentUser;
    return currentUser;
  }

  // register wwith email & password
  Future registerWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userUpdateDisplayName(result.user, firstName, lastName);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
