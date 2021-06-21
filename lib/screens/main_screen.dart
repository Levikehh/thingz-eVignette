import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingz_evignette/authentication_service.dart';

class MainScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hello, ${user.email}!",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text(
                "Sign out",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
