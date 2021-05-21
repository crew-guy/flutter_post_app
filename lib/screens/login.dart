import 'package:flutter/material.dart';
import 'package:sample_app/screens/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name;
  final controller = TextEditingController();

  void click() {
    this.name = this.controller.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(this.name)));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          controller: this.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            suffixIcon: IconButton(
              icon: Icon(Icons.done),
              splashColor: Colors.blue,
              tooltip: 'Submit',
              onPressed: this.click,
            ),
            labelText: 'Naav kaay tujha ?',
            hintText: 'Enter your name',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
