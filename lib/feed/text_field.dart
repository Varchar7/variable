import 'package:flutter/material.dart';
import 'package:variable/widget/style.dart';

class TextAreaField extends StatelessWidget {
  final TextEditingController textEditingController;
  const TextAreaField({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      style: style(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        hintText: 'Write Something here ...',
        hintStyle: style(),
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
