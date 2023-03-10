import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ugly_santa/main.dart';
import 'package:ugly_santa/mainFavoris.dart';
import 'package:ugly_santa/mainLogIn.dart';
import 'package:ugly_santa/mainPanier.dart';

class NavDrawer extends StatelessWidget {

  String text() {
    if (FirebaseAuth.instance.currentUser?.email.toString() != null) {
      return "Welcome on Ugly Santa${FirebaseAuth.instance.currentUser?.email}" ;
    }
    return "Welcome on Ugly Santa";
  }

  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();

}

  bool enableLogIn() {
     if (FirebaseAuth.instance.currentUser?.email.toString() != null) {
      return false;
     }else {
      return true;
     }

  }

  bool enableLogOut() {
   if (FirebaseAuth.instance.currentUser?.email.toString() != null) {
      return true;
     }else {
      return false;
     }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              text(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                ),
          ),
          ListTile(
            enabled: enableLogIn(),
            leading: Icon(Icons.account_circle),
            title: Text('Log In'),
            onTap: () => {Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAppLogIn()))},
          ),
          ListTile(
            enabled: enableLogOut(),
            leading: Icon(Icons.auto_awesome_sharp),
            title: Text('Favoris'),
            onTap: () => {  Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAppFavoris()))},
          ),
          ListTile(
            enabled: enableLogOut(),
            leading: Icon(Icons.shopping_cart),
            title: Text('Panier'),
            onTap: () => {  Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAppPanier()))},
          ),
          ListTile(
                  enabled: enableLogOut(),
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  onTap: () => {  _signOut()
                  },
                ),
        ], 
      ),
    );
  }
}