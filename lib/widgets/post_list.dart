import 'package:flutter/material.dart';
import 'package:sample_app/models/post.dart';

class PostList extends StatefulWidget {
  List<Post> listItems;
  PostList(this.listItems);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback) {
    this.setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.listItems.length,
        itemBuilder: (context, index) {
          Post post = this.widget.listItems[index];
          return Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(post.text),
                    subtitle: Text(post.author),
                  ),
                ),
                Row(children: <Widget>[
                  Container(
                      child: Text(
                        post.likes.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 10)),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () => this.like(post.likePost),
                    color: post.userLiked ? Colors.blue : Colors.black,
                  ),
                ]),
              ],
            ),
          );
        });
  }
}
