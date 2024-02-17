import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController textController;

  const DialogBox(
      {super.key, required this.nameController, required this.textController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 100),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Name (required)"),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Text"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
