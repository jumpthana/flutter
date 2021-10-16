import 'package:basic_flutter/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late String initalRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initalRoute = '/myService';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: initalRoute,
    );
  }
}
