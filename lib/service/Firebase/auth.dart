import 'package:firebase_auth/firebase_auth.dart';

import 'curd_user_database.dart';

class FirebaseAuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static get user => _auth.currentUser;

  // _auth.

  //SIGN UP METHOD
  static Future<bool> signUp({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user!.updateDisplayName(username);
      await user!.reload();
      await FirebaseDatabaseCollection.createUserDatabase();
      await FirebaseDatabaseCollection.createDataOnUserDatabase(
        {
          "username": username,
          "email": email,
          "password": password,
          "mobile": phone,
          "image": "",
          "uid": user!.uid,
          "posts": [],
          "followings": [],
          "followers": [],
          "points": 0,
          "accuracy": 0,
          "favourite": [],
          "solutions": [],
          "saved": [],
        },
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  //SIGN IN METHOD
  static Future<bool> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  //SIGN OUT METHOD
  static Future<bool> signOut() async {
    await _auth.signOut();
    return true;
  }
}
