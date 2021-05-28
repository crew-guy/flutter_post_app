## Like Feature

1. In the class model itself, create a function that adds the id of the user who like to a given Set of user ids who liked

    ```jsx
    import 'package:firebase_auth/firebase_auth.dart';
    import 'package:firebase_database/firebase_database.dart';
    import 'package:sample_app/services/database.dart';

    class Post {
      String body;
      String author;
      Set usersLiked = {};
      DatabaseReference _id;

      Post(this.body, this.author);

      void likePost(FirebaseUser user) {
        if (this.usersLiked.contains(user.uid)) {
          this.usersLiked.remove(user.uid);
        } else {
          this.usersLiked.add(user.uid);
        }
        this.update();
      }

      void update() {
        updatePost(this, this._id);
      }

      void setId(DatabaseReference id) {
        this._id = id;
      }

      Map<String, dynamic> toJson() {
        return {
          'author': this.author,
          'usersLiked': this.usersLiked.toList(),
          'body': this.body,
        };
      }
    }

    Post createPost(record) {
      Map<String, dynamic> attributes = {
        'author': "",
        'text': "",
        'usersLiked': [],
      };
      record.forEach((key, value) => {attributes[key] = value});

      Post post = new Post(attributes['body'], attributes['author']);
      post.usersLiked = new Set.from(attributes['usersLiked']);
      return post;
    }
    ```

2. Call a function on UI side that takes the user and depending on whether user has liked or not, updated the usersLiked Set for this post.
**NOTE :** For an app like this, where a lot of things are dependent on who the user is, get user into the app level state (not widget level state) and scream it down to all children

    ```jsx
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
              var post = this.widget.listItems[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: Text(post.body),
                        subtitle: Text(post.author),
                      ),
                    ),
                    Row(children: <Widget>[
                      Container(
                          child: Text(
                            post.usersLiked.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () =>
                            this.like(() => post.likePost(widget.user)),
                        color: post.usersLiked.contains(widget.user.uid)
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ]),
                  ],
                ),
              );
            });
      }
    }
    ```
    
  ## Firebase realtime database integration
  
  ```jsx
import 'package:firebase_database/firebase_database.dart';
import 'package:sample_app/models/post.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  id.set(post.toJson());
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Post post = createPost(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }
  return posts;
}
```

## Post input 

- More detailed Text input

    ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c830fde2-cd39-46d0-a69e-5bcb971f42ff/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c830fde2-cd39-46d0-a69e-5bcb971f42ff/Untitled.png)

    ```dart
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
    ```
    
