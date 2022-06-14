import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/auth/init_app.dart';
import 'package:variable/bloc/chat/chat_bloc.dart';
import 'package:variable/service/cloud_messages/services.dart';

import 'bloc/messages/messages_bloc.dart';
import 'bloc/post/post_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'firebase_options.dart';
import 'push_notification/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagesService.getToken();
  await FirebaseMessagesService.requestMessageService();
  FirebaseMessagesService.listenFirebaseMessages();
  NotificationService.initState();
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
          fontFamily: "Ubuntu",
        ),
        debugShowCheckedModeBanner: false,
        home: const AppInitScreen(),
      ),
    );
  }
}

// flutterfire configure --project=chat-7d927
// export PATH="$PATH":"$HOME/.pub-cache/bin" 

// Platform  Firebase App Id
// web       1:6746703710:web:ab6b61f56f3ccde65df1cf
// android   1:6746703710:android:3462e9b76bf3d11e5df1cf
// ios       1:6746703710:ios:95086d24ca1914945df1cf
// macos     1:6746703710:ios:95086d24ca1914945df1cf
