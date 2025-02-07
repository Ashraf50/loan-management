import 'package:flutter/material.dart';

class MessageTextfield extends StatelessWidget {
  final TextEditingController? controller;

  const MessageTextfield({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Send Message",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () async {},
              icon: Icon(
                Icons.send,
                color: Color(0xff2B475E),
                size: 27,
              ),
            ),
          ),
        ));
  }
}
