import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ugly_santa/mainCheckOut.dart';
import 'package:ugly_santa/mainDetailProduct.dart';




class MyAppPanier extends StatefulWidget {
  const MyAppPanier({super.key});

 

  @override
  State<MyAppPanier> createState() => _MyAppPanierState();
}

class _MyAppPanierState extends State<MyAppPanier> {
   Query<Map<String, dynamic>> _referencePanierList = FirebaseFirestore.instance.collection('panier').where("idUser", isEqualTo: 
    FirebaseAuth.instance.currentUser!.email.toString());

  late Stream<QuerySnapshot> _streamPanierItems;
 
  @override
  
 initState() {

    super.initState();

  _streamPanierItems = _referencePanierList.snapshots();
  }
  
  void _pop() {
    Navigator.pop(context);
   
  }

 void _checkOut() {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyAppCheckOut()));
  }

  void _detailProduct(String id) {

        Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  MyAppDetailProduct(id)));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
        
      ),
      body:  Container(
        
        child: Column(
          
          children: <Widget>[
              Expanded( 
                child :  Center(child: StreamBuilder<QuerySnapshot>(
              stream:  _streamPanierItems,
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
                    subtitle: Text('${thisItem['price'.toString()]} €'),
                    trailing: 
                      IconButton(
                        icon: Icon (Icons.outbox) ,
                      
                        onPressed: ()  async {
                              var docSnashot = await FirebaseFirestore.instance.collection('panier').where("idProduct" , isEqualTo : thisItem['id']).where("idUser", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).get();
                            
                            if (docSnashot.docs.isNotEmpty) {
                              var _docReferenceDelete = FirebaseFirestore.instance.collection('panier').doc(docSnashot.docs[0].id);
                            
                              _docReferenceDelete.delete();
                            }
                        },
                      ),
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
          Align( alignment: Alignment.bottomCenter,
          child:  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                
                  Text('Prix : ', style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Text (' [Prix]', style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                 
                
              ],),),


            const Text(''),
          

            Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                
                  Text ('Frais de Port : ', style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Text("[frais de port] ", style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                
              ],),),

              const Text(''),

            Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                
                  Text ('Total : ', style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Text("[Total] ", style : TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
                
              ],),),


             const Text(''),

              SizedBox(
                      width: double.infinity,
                      height: 45,
                      child:  ElevatedButton(
                        
                        child: const Text("Acheter", style : TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold)),
                        onPressed:_checkOut,
                      )),
               const Text(''),

        ],)
          
          
       
        

       
      ),
     
    );
      
      
            
        
       
      
    
  }
}
