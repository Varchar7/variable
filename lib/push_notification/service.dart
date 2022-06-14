import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static List<NotificationChannel> channels = [
    NotificationChannel(
      channelKey: "simpleNotification",
      channelDescription: '',
      channelName: 'simpleNotificationService',
    )
  ];
  static void initState() {
    AwesomeNotifications().initialize(
      null,
      channels,
    );
  }

  static pushSimple() {
    AwesomeNotifications().createNotificationFromJsonData(
      {
        "data": {
          "content": {
            "id": 100,
            "channelKey": "simpleNotification",
            "title": "Huston!\nThe eagle has landed!",
            "body":
                "A small step for a man, but a giant leap to Flutter's community!",
            "notificationLayout": "Messaging",
            "largeIcon":
                "https://media.fstatic.com/kdNpUx4VBicwDuRBnhBrNmVsaKU=/full-fit-in/290x478/media/artists/avatar/2013/08/neil-i-armstrong_a39978.jpeg",
            "bigPicture": "https://www.dw.com/image/49519617_303.jpg",
            "showWhen": true,
            "autoDismissible": true,
            "privacy": "Private"
          },
          "actionButtons": [
            {
              "key": "REPLY",
              "label": "Reply",
              "autoDismissible": true,
              "buttonType": "InputField"
            },
            {
              "key": "ARCHIVE",
              "label": "Archive",
              "autoDismissible": true,
              "isDangerousOption": true
            }
          ]
        }
      },
    );
    /*   AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: "simpleNotification",
        title: "Notification Title",
        body: "The Notification Body",
        notificationLayout: NotificationLayout.Messaging,
        category: NotificationCategory.Message,
        backgroundColor: Colors.lightBlue,
        summary: "Thats my summary",
        color: Colors.blue,
      ),
    );
   */
  }
}
