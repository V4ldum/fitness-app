import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({Key? key}) : super(key: key);

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (String text) {
        //TODO
        debugPrint(text);
      },
      maxLines: 1,
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        hintText: Strings.sendMessageHint,
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          splashRadius: 25,
          onPressed: () {
            _controller.clear();
            debugPrint("sent"); //TODO implement send message
          },
        ),
      ),
      style: const TextStyle(
        fontFamily: Fonts.primaryMedium,
      ),
    );
  }
}
