import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:variable/widget/style.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final int? textArea;
  final Widget? search;
  const InputField(
      {Key? key,
      required this.controller,
      this.textArea,
      this.title,
      this.search})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        maxLines: textArea,
        style: style(),
        focusNode: FocusNode(),
        decoration: InputDecoration(
          filled: true,
          hintText: title,
          hintStyle: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          contentPadding: const EdgeInsets.only(
            left: 15,
            right: 10,
            top: 20,
          ),
          suffixIcon: search,
          fillColor: const Color(0xffF0F0F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class InputFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  const InputFieldNumber({
    Key? key,
    required this.controller,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: style(),
        decoration: InputDecoration(
          filled: true,
          hintText: title,
          hintStyle: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          contentPadding: const EdgeInsets.only(left: 20),
          fillColor: const Color(0xffF0F0F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
