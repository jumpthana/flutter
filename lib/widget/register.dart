import 'package:basic_flutter/utility/dialog.dart';
import 'package:basic_flutter/utility/my_stye.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late double screen;
  late String name, user, password;

  Container bulidName() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'username',
          prefixIcon: Icon(Icons.fingerprint, color: MyStyle().darkColor),
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
          hintText: 'name',
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
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: bulidFloatingActionButton(),
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('New Register'),
      ),
      body: Center(
        child: Column(
          children: [
            bulidName(),
            bulidUser(),
            bulidPassword(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton bulidFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: MyStyle().darkColor,
      onPressed: () {
        print('name = $name, user = $user, password = $password');
        if ((name?.isEmpty ?? true) ||
            (user?.isEmpty ?? true) ||
            (password?.isEmpty ?? true)) {
          print('Have Space');
          normalDialog(context, 'Have Space ? Please Fill Every Blank');
        } else {
          print('No Space');
          registerFirebase();
        }
      },
      child: Icon(Icons.cloud_upload_rounded),
    );
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('#### Firebase Initiializa Success ####');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print('Register Success');
        await value.user?.updateDisplayName(name).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
