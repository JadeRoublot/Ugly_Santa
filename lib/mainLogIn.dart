import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'mainCheckOut.dart';





class MyAppLogIn extends StatefulWidget {
  const MyAppLogIn({super.key});

 

  @override
  State<MyAppLogIn> createState() => _MyAppLogInState();
}

class _MyAppLogInState extends State<MyAppLogIn> {
 
Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

static Future<User?> loginUsingEmailPassword({required String email, required String password , required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if(e.code == "user-not-found") {
      print("No User Found for that email");
    }
  }

  return user;

}
  @override
  
 
  void _pop() {
    Navigator.pop(context);
   
  }

   
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection'),
        
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder (
            future: _initializeFirebase(),
            builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.done) {
            return  Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                Center(child:  Text("Connection",
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold
                  ))),
                      
                  SizedBox(
                    height: 70.0,
                  ),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "User Email",
                      prefixIcon: Icon(Icons.mail)),
                  ),
                    
                    SizedBox(
                      height: 26.0,
                    ),    
                      
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "User Password",
                          prefixIcon: Icon(Icons.lock)
                        ),
                      ),

                      SizedBox(
                        height: 100.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: RawMaterialButton(
                          fillColor: Colors.blueGrey,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                          onPressed: () async{
                            User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                            print(user);
                            if (user != null) {
                              _pop();
                            }
                          },
                          child: Text("Login",
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 18.0),
                            )),
                      )
                    ],
                  );
            }
            return const Center(child: CircularProgressIndicator(),);
              },)
          
            ),
          ),
          
    );
  }
}
