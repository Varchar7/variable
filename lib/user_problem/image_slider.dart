import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final Uint8List images;
  const ImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer ,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.memory(
          widget.images,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
