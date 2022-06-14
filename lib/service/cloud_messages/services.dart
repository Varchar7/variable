import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagesService {
  static final firebaseMessagingInstance = FirebaseMessaging.instance;

  static Future<String?> getToken() async {
    return await firebaseMessagingInstance.getToken();
  }

  static Future<NotificationSettings> requestMessageService() async {
    return await firebaseMessagingInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static listenFirebaseMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(
          "listen : ${event.data} ${event.category} ${event.from} ${event.messageType} ${event.notification!.body} ${event.notification!.title}");
    });
  }

/*   static sucessLoginNotify(String username) async {
    String? token = await getToken();
    http.Response responseSaveinfo = await http.post(
      Uri.parse('http://192.168.43.167:3000/saveinfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "userid": username,
          "deviceid": token!,
        },
      ),
    );
    if (responseSaveinfo.statusCode == 201) {
      print(responseSaveinfo.body);
    } else {
      print(responseSaveinfo.statusCode);
    }
    http.Response responsePostInfo = await http.post(
      Uri.parse('http://192.168.43.167:3000/push'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "userid": username,
        },
      ),
    );
    if (responsePostInfo.statusCode == 201) {
      print(responsePostInfo.body);
    } else {
      print(responsePostInfo.statusCode);
    }
  }
 */
}
