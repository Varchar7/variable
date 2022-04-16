import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<Uint8List> images;
  const ImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: TabController(
          length: widget.images.length,
          vsync: this,
        ),
        children: List.generate(
          widget.images.length,
          (index) => Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.memory(
              widget.images[index],
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
