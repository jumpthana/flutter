import 'package:basic_flutter/utility/my_stye.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  late String name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
  }

  Future<Null> findNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
              ),
              accountName: MyStyle().titleH2While(name == null ? 'Name' : name),
              accountEmail:
                  MyStyle().titleH3While(email == null ? 'email' : email),
              currentAccountPicture: Image.asset('images/logo.png'),
            ),
            buildSignOut(),
          ],
        ),
      ),
    );
  }

/*decoration: BoxDecoration(//
                  gradient: RadialGradient(
                      colors: [Colors.white, Colors.orangeAccent])),*/

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: MyStyle().darkColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: MyStyle().titleH2While('Sign Out'),
          subtitle: MyStyle().titleH3While('Sign Out & Go to Authen'),
        ),
      ],
    );
  }
}
