import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function callback;

  // Initiate widget with this callback as a value
  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  void click() {
    FocusScope.of(context).unfocus();
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
            hintText: 'Hi newbie',
            prefixIcon: Icon(Icons.message),
            labelText: "Type a message",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue[900],
              tooltip: "Post message",
              onPressed: this.click,
            )),
      ),
    ]);
  }
}
