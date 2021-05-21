import 'package:flutter/material.dart';

import '../models/post.dart';
import '../widgets/post_list.dart';
import '../widgets/text_input_widget.dart';

class MyHomePage extends StatefulWidget {
  final String name;

  MyHomePage(this.name);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(text) {
    setState(() {
      this.posts.add(new Post(text, widget.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This app'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: PostList(this.posts)),
            TextInputWidget(this.newPost),
          ],
        ),
      ),
    );
  }
}
