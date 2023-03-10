import 'package:flutter/material.dart';
import 'package:non_cognitive/ui/components/core/color.dart';

enum TextInputCustomType { NORMAL, WITH_ICON }

class TextInputCustom extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputCustomType type;
  final IconData? icon;
  final Function(String)? onChanged;

  const TextInputCustom(
      {super.key,
      required this.controller,
      required this.hint,
      required this.type,
      this.icon,
      this.onChanged,
      });

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInputCustom> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.hint == "Password" ? true : false,
      controller: widget.controller,
      style: const TextStyle(
        fontFamily: "Poppins"
      ),
      cursorColor: gray,
      onChanged: widget.onChanged ?? (value) {},
      decoration: widget.type == TextInputCustomType.WITH_ICON
          ? InputDecoration(
              fillColor: lightGray,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: gray,
                fontFamily: 'Poppins',
              ),
              prefixIcon: Icon(widget.icon))
          : InputDecoration(
              fillColor: lightGray,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: gray,
                fontSize: 13,
                fontFamily: 'Poppins',
              )),
    );
  }
}
