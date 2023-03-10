import 'package:flutter/material.dart';




class MyAppCheckOut extends StatefulWidget {
  const MyAppCheckOut({super.key});

 

  @override
  State<MyAppCheckOut> createState() => _MyAppCheckOutState();
}

class _MyAppCheckOutState extends State<MyAppCheckOut> {
 



  

  @override
  
 
  void _pop() {
    Navigator.pop(context);
   
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut'),
        
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network("https://drive.google.com/uc?export=view&id=1BlfDTDXZj4YvBK_mhMx3oHAyxTUoFVNS",
              errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Icon(Icons.do_not_disturb);
            },),   
             const Text('"Merci pour votre Achat"',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 25),
            ),
            ],
          ),
        ),
      ),
      
    );
  }
}
