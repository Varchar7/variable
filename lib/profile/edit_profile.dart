import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:variable/service/Firebase/profile_picture.dart';

import '../widget/snackbar.dart';
import '../widget/style.dart';

Future<void> pickImage(BuildContext context) async {
  ImagePicker imagePicker = ImagePicker();
  final file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    final image = await file.readAsBytes();
    await UserProfilePicture.uploadProfilePicture(image);
  } else {
    popSnackbar(
      context: context,
      text: 'Something went wrong , pick again',
    );
  }
}

Future<void> showMyBottomSheet(BuildContext context, String? url) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'profile',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        url != null && url != '' ? NetworkImage(url) : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await pickImage(context).then(
                          (value) => popSnackbar(
                            context: context,
                            text: 'Image Updated Successfully',
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "Update Image",
                        style: style().copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await UserProfilePicture.deleteProfilePicture().then(
                          (value) => popSnackbar(
                            context: context,
                            text: 'Image Deleted Successfully',
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "Delete Image",
                        style: style().copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
