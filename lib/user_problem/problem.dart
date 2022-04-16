import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:variable/auth/auth.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/user_problem/image_slider.dart';
import 'package:variable/widget/snackbar.dart';
import 'package:variable/widget/style.dart';
import 'package:variable/widget/textformfield.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({Key? key}) : super(key: key);

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  int importance = 0;
  TextEditingController question = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Uint8List> images = [];
  final issues = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final image = await file.readAsBytes();
      images.add(image);
      setState(() {});
    } else {
      popSnackbar(
        context: context,
        text: 'Something went wrong , pick again',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 75.0,
              leading: IconButton(
                onPressed: () async {
                  await KeepUser.logOutUser();
                  Navigator.of(context).pop();
                },
                color: Colors.black,
                icon: const Icon(
                  Icons.logout,
                ),
              ),
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'Issue',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 1,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {},
                  color: Colors.green,
                  icon: const Icon(
                    Icons.notifications,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    'Add your Question',
                    style: style(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.75,
                  ),
                  Text(
                    'Add Images',
                    style: style(),
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.25,
                  ),
                  images.isNotEmpty
                      ? ImageSlider(images: images)
                      : InkWell(
                          onTap: () async {
                            await pickImage();
                          },
                          child: Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 150,
                                ),
                                Text(
                                  'Add Images',
                                  style: style(),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.75,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                )
                              ],
                            ),
                          ),
                        ),
                  images.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await pickImage();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                              ),
                              child: Text(
                                'Add more',
                                style: style().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    'Question',
                    style: style(),
                    textScaleFactor: 1.25,
                  ),
                  InputField(
                    controller: question,
                  ),
                  Text(
                    'Description',
                    style: style(),
                    textScaleFactor: 1.25,
                  ),
                  InputField(
                    controller: description,
                    textArea: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Importance',
                          style: style(),
                          textScaleFactor: 1.25,
                        ),
                        Text(
                          '$importance %',
                          style: style(),
                          textScaleFactor: 1.25,
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    activeColor: Colors.greenAccent,
                    thumbColor: Colors.greenAccent,
                    inactiveColor: Colors.greenAccent,
                    label: "Importance",
                    value: importance.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        importance = value.toInt();
                      });
                    },
                    min: 0,
                    max: 100,
                  ),
                  isLoading
                      ? Column(
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Please wait ',
                              style: style(),
                              textScaleFactor: 1.25,
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: onPost,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Post', style: style()),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPost() {
    isLoading = !isLoading;
    setState(() {});
    FirebaseDatabaseCollection.createPostDatabase(
      {
        "title": question.text,
        "body": description.text,
        "importance": importance,
        "views": 1,
        "time": DateTime.now(),
        "uid": FirebaseAuthenticationService.user.uid,
        "status": "Running",
        "solutions": [],
      },
      images,
    ).then(
      (value) {
        isLoading = !isLoading;
        question.clear();
        description.clear();
        images.clear();
        importance = 0;
        popSnackbar(context: context, text: 'Post Uploaded Succecfully');
        setState(() {});
      },
    );
  }
}
