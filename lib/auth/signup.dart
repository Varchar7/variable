import 'package:flutter/material.dart';
import 'package:variable/auth/login.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/widget/snackbar.dart';

import '../manager/manage.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordValueChange = false;
  bool signUpStatus = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    KeepUser.saveUser(
      email: email.text,
      password: password.text,
    );
    signUpStatus = await FirebaseAuthenticationService.signUp(
      email: email.text,
      password: KeepUser.encryptPassword(password.text).base64,
      phone: mobile.text,
      username: username.text,
    );
    popSnackbar(
      context: context,
      text: "Account Created Successfully",
    );
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign up',
                    textScaleFactor: 2.5,
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const Text(
                    'Let\'s start new journey with us and explore new things.',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.75,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: style(),
                          controller: username,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                            ),
                            filled: true,
                            hintText: 'Enter username',
                            errorStyle: style().copyWith(
                              color: Colors.white,
                            ),
                            hintStyle: style().copyWith(color: Colors.black),
                            helperStyle: style(),
                            prefixStyle: style(),
                            suffixStyle: style(),
                            counterStyle: style(),
                            floatingLabelStyle: style(),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        TextFormField(
                          style: style(),
                          controller: email,
                          validator: (email) {
                            if (email != null && email.isNotEmpty) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                              return emailValid ? null : 'Type valid email';
                            } else {
                              return 'Email field can\'t be empty';
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                            ),
                            filled: true,
                            errorStyle: style().copyWith(
                              color: Colors.white,
                            ),
                            hintStyle: style().copyWith(color: Colors.black),
                            helperStyle: style(),
                            prefixStyle: style(),
                            suffixStyle: style(),
                            counterStyle: style(),
                            floatingLabelStyle: style(),
                            hintText: 'Enter Email',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        TextFormField(
                          style: style(),
                          controller: mobile,
                          validator: (mobile) {
                            if (mobile != null || mobile!.isNotEmpty) {
                              return mobile.length == 10
                                  ? null
                                  : 'Phone no must be 10 Digit';
                            } else {
                              return 'Phone no can\'t be empty';
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                            ),
                            filled: true,
                            hintText: 'Enter Mobile Number',
                            errorStyle: style().copyWith(
                              color: Colors.white,
                            ),
                            hintStyle: style().copyWith(color: Colors.black),
                            helperStyle: style(),
                            prefixStyle: style(),
                            suffixStyle: style(),
                            counterStyle: style(),
                            floatingLabelStyle: style(),
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
                          validator: (pass) {
                            if (pass != null || pass!.isNotEmpty) {
                              return pass.length >= 8
                                  ? null
                                  : 'Password minimum 8 Digit';
                            } else {
                              return 'Password can\'t be empty';
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                            ),
                            filled: true,
                            hintText: 'Enter password',
                            errorStyle: style().copyWith(
                              color: Colors.white,
                            ),
                            hintStyle: style().copyWith(color: Colors.black),
                            helperStyle: style(),
                            prefixStyle: style(),
                            suffixStyle: style(),
                            counterStyle: style(),
                            floatingLabelStyle: style(),
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
                      ],
                    ),
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
                      if (formKey.currentState!.validate()) {
                        await signUp();
                        if (signUpStatus) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((context) => const PageManager()),
                            ),
                          );
                        } else {
                          popSnackbar(
                              context: context, text: 'Something went wrong');
                        }
                      }
                    },
                    child: const Text(
                      'Signup',
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
                        'I\'m a member ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Login()));
                        },
                        child: const Text(
                          'Log In now',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  TextStyle style() {
    return const TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.black,
    );
  }
}
