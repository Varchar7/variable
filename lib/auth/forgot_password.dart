import 'package:flutter/material.dart';
import 'package:variable/widget/textformfield.dart';

import '../widget/buttons.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Forget Password',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Please enter your email address You wil create a link to create a new password via email',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  controller: forgotPassword,
                  title: 'Email',
                ),
                const SizedBox(
                  height: 25,
                ),
                AppsButton(
                  title: 'Send',
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 45,
                  fontSize: 20,
                  borderRadius: 25,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
