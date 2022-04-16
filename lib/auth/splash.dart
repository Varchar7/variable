import 'package:flutter/material.dart';
import 'package:variable/auth/login.dart';
import 'package:variable/auth/signup.dart';
import 'package:variable/widget/style.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '@variable',
                    style: style().copyWith(
                      color: Colors.white,
                    ),
                    textScaleFactor: 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.greenAccent,
                        Colors.lightBlue,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Discover your solution here',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                    textScaleFactor: 2.9,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Explore all the most exiting solutions roles based on your situation and compability',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                    textScaleFactor: 1.25,
                    textAlign: TextAlign.center,
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.orange,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const Login();
                              }),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.orange,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const SignUp();
                              }),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
