import 'package:basic_flutter/utility/dialog.dart';
import 'package:basic_flutter/utility/my_stye.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  late double screen;
  bool statusRedEye = true;
  late String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screeb = $screen');
    return Scaffold(
        floatingActionButton: bulidRegister(),
        body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment(0, -0.33),
                  radius: 1.0,
                  colors: <Color>[Colors.white, MyStyle().primaryColor])),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLogo(),
                  MyStyle().titleH1('Flower'),
                  bulidUser(),
                  bulidPassword(),
                  buildLogin(),
                ],
              ),
            ),
          ),
        ));
  }

  TextButton bulidRegister() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Text(
          'New Register',
          style: TextStyle(color: Colors.white),
        ),
      );

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().darkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }

  Container bulidUser() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => user = value.trim(),
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'username',
          prefixIcon: Icon(Icons.perm_identity, color: MyStyle().darkColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container bulidPassword() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: statusRedEye
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              }),
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'password',
          prefixIcon: Icon(Icons.lock_outline, color: MyStyle().darkColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screen * 0.4,
      child: MyStyle().showLogo(),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/myService', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}
