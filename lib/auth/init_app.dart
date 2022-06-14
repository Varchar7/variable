import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:variable/auth/auth.dart';
import 'package:variable/auth/splash.dart';
import 'package:variable/bloc/profile/profile_bloc.dart';
import 'package:variable/widget/style.dart';

import '../manager/manage.dart';
import '../widget/snackbar.dart';

class AppInitScreen extends StatefulWidget {
  const AppInitScreen({Key? key}) : super(key: key);

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        checkIfUserAvailable().then(
          (value) {
            if (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const PageManager()),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Splash()),
                ),
              );
              popSnackbar(context: context, text: 'Welcome');
            }
          },
        );
      },
    );
  }

  Future<bool> checkIfUserAvailable() async {
    await KeepUser.initKeepService();
    return await KeepUser.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/init-animation.json',
              alignment: Alignment.center,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to',
                    style: style().copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' variable',
                    style: style().copyWith(
                      color: const Color.fromARGB(255, 155, 243, 200),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
