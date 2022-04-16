import 'package:flutter/material.dart';
import 'package:variable/auth/auth.dart';
import 'package:variable/auth/forgot_password.dart';
import 'package:variable/auth/signup.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/widget/snackbar.dart';

import '../manager/manage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loginStatus = false;
  bool passwordValueChange = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    KeepUser.saveUser(
      email: email.text,
      password: password.text,
    );
    loginStatus = await FirebaseAuthenticationService.signIn(
      email: email.text,
      password: KeepUser.encryptPassword(password.text).base64,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome again!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                  textScaleFactor: 2.5,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Welcome back you have been missed !',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                  textScaleFactor: 1.75,
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  style: style(),
                  controller: email,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text('Enter email'),
                    labelStyle: style(),
                    prefixStyle: style().copyWith(
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                TextFormField(
                  style: style(),
                  controller: password,
                  obscureText: passwordValueChange,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text('Enter password'),
                    labelStyle: style(),
                    prefixStyle: style().copyWith(
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordValueChange = !passwordValueChange;
                        });
                      },
                      icon: Icon(passwordValueChange
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const ForgotPassword()),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    fixedSize: const Size(
                      250,
                      50,
                    ),
                  ),
                  onPressed: () async {
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      await login();
                      if (loginStatus) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => const PageManager()),
                          ),
                        );
                      }
                    } else {
                      popSnackbar(
                        context: context,
                        text: 'Incorrect Credential , Something went wrong',
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                const Text(
                  'Or Continue with',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Not a member ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        'Sign up now',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ],
                ),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  TextStyle style() {
    return const TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.black,
    );
  }
}
