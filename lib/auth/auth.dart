import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:variable/service/Firebase/auth.dart';

class KeepUser {
  static SharedPreferences? prefs;
  static final iv = IV.fromLength(16);

  /// [prefs] initialiize First
  static initKeepService() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> checkUser() async {
    final email = prefs!.get('email');
    final password = prefs!.get('password');
    if (email == null || password == null) {
      return false;
    } else {
      return await FirebaseAuthenticationService.signIn(
        email: email.toString(),
        password: password.toString(),
      );
    }
  }

  static Encrypter initEncryption() {
    final key = Key.fromUtf8('              duck              ');
    return Encrypter(AES(key));
  }

  static Encrypted encryptPassword(String password) {
    final encrypted = initEncryption().encrypt(
      password,
      iv: iv,
    );
    return encrypted;
  }

  /* 
  static String decryptPassword(Encrypted ePassword) {
    final decrypt = initEncryption().decrypt(
      ePassword,
      iv: iv,
    );
    return decrypt;
  } 
  */

  static saveUser({required String email, required String password}) {
    prefs!.setString('email', email);
    prefs!.setString('password', encryptPassword(password).base64);
  }

  static logOutUser() {
    prefs!.remove('email');
    prefs!.remove('password');
    FirebaseAuthenticationService.signOut();
  }
}
