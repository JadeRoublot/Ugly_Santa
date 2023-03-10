import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ugly_santa/mainDetailProduct.dart';




class MyAppFavoris extends StatefulWidget {
  const MyAppFavoris ({super.key});

 

  @override
  State<MyAppFavoris > createState() => _MyAppFavorisState();
}

class _MyAppFavorisState extends State<MyAppFavoris> {
  Query<Map<String, dynamic>> _referenceFavList = FirebaseFirestore.instance.collection('favorit').where("idUser", isEqualTo: 
  FirebaseAuth.instance.currentUser!.email.toString());

  late Stream<QuerySnapshot> _streamFavItems;

  @override
  initState() {

    super.initState();

  _streamFavItems = _referenceFavList.snapshots();
  }
 
  void _pop() {
    Navigator.pop(context);
   
  }
  
void _detailProduct(String id) {

        Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  MyAppDetailProduct(id)));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: StreamBuilder<QuerySnapshot>(
              stream:  _streamFavItems,
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if (snapshot.hasError){
                  return Text(snapshot.error.toString());
                }

                  if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) =>
            {
              'id' : e ['idProduct'],
              'name': e['name'],
              'img': e['img'],
              'description': e['description'],
              'price': e['price']

            }).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    leading: Image.network('${thisItem['img']}' ,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.do_not_disturb);
                    },),
                    title: Text('${thisItem['name']}'),
                    subtitle: Text('${thisItem['description']}'),
                    trailing: Text('${thisItem['price'.toString()]} €'),
                    onTap: () { _detailProduct(thisItem['id'] );
                    },
                  );
                });
          }

                return CircularProgressIndicator();

              },
          ),
        ),
      ),
      
    );
  }
}
