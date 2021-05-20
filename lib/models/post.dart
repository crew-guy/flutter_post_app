class Post {
  String text;
  String author;
  int likes = 0;
  bool userLiked = false;

  Post(this.text, this.author);

  void likePost() {
    if (!this.userLiked) {
      this.likes += 1;
      this.userLiked = true;
    } else {
      this.userLiked = false;
      this.likes -= 1;
    }
  }
}
