import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/auth/init_app.dart';
import 'package:variable/bloc/chat/chat_bloc.dart';

import 'bloc/messages/messages_bloc.dart';
import 'bloc/post/post_bloc.dart';
import 'bloc/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => PostBloc(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => MessageSizeBloc(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        debugShowCheckedModeBanner: false,
        home: const AppInitScreen(),
      ),
    );
  }
}
