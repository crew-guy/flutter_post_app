import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/screens/home.dart';
import 'package:sample_app/services/auth.dart';

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
  FirebaseUser user;

  // Lifecycle method that runs every time app is reinitialized i.e. app is started on device
  // Runs as soon as APK is loaded
  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  void click() {
    signInWithGoogle().then((user) => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage(user)))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }

  Widget googleLoginButton() {
    return OutlinedButton(
      onPressed: this.click,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(image: AssetImage('assets/google_logo.png'), height: 35),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
