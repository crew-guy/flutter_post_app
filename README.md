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
    
    
