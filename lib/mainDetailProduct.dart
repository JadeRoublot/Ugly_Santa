import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class MyAppDetailProduct extends StatefulWidget {

 
   MyAppDetailProduct(this.itemId ,{Key? key}): super(key:key) {
  
    _reference = FirebaseFirestore.instance.collection('product').doc(itemId);
    _futureData = _reference.get();
   }


  
 

  String itemId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;
  

  @override
  State<MyAppDetailProduct> createState() => _MyAppDetailProductState();
}

class _MyAppDetailProductState extends State<MyAppDetailProduct> {

  late Map data;
  late String id = widget.itemId;
  late bool touchs = false;

    Future<bool> setStateTouch()  async {
       var docSnashot = await FirebaseFirestore.instance.collection('favorit').where("idProduct" , isEqualTo : id).get();
      
      if (docSnashot.docs.isNotEmpty) {
        return  touchs = true;
      }
      return  touchs = false;
    
  }

  @override

  void _pop() {
    Navigator.pop(context);
   
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        
      ),
         body: FutureBuilder<DocumentSnapshot>(
        future: widget._futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return Column(
              children: [
                
                Image.network('${data['img']}' , 
                alignment : Alignment.center,
                errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Icon(Icons.do_not_disturb);
                 },),

                Text(""),

                Text('${data['name']}',   
                style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25), 
                textAlign : TextAlign.center),
                

                Text(''),

                Text('${data['descriptionExtend']}' ,
                textAlign: TextAlign.center,),

                Text(''),

                Text('${data['price']} €'),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

                        ElevatedButton(
                          child: Text("Ajouter au panier"),
                          onPressed: () async {

                          if (FirebaseAuth.instance.currentUser?.email.toString() != null) {
                              Map<String, String> dataToSave = {
                                'img' : data ['img'],
                                'name' : data['name'],
                                'price' : data['price'].toString(),
                                'description' : data ['description'],
                                'idProduct' : id ,
                                'idUser' : FirebaseAuth.instance.currentUser!.email.toString(),
                              };

                              FirebaseFirestore.instance.collection('panier').add(dataToSave);
                            
                            }
                          }
                        ),

                      IconButton(
                        icon: Icon (touchs ?(Icons.favorite) : (Icons.favorite_border_outlined) ),
                      
                        onPressed: ()  async {

                          if (FirebaseAuth.instance.currentUser?.email.toString() != null) {
                              Map<String, String> dataToSave = {
                                'img' : data ['img'],
                                'name' : data['name'],
                                'price' : data['price'].toString(),
                                'description' : data ['description'],
                                'idProduct' : id ,
                                'idUser' : FirebaseAuth.instance.currentUser!.email.toString(),
                              };

                            var docSnashot = await FirebaseFirestore.instance.collection('favorit').where("idProduct" , isEqualTo : id ).where("idUser", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).get();
                            
                            if (docSnashot.docs.isNotEmpty) {
                              var _docReferenceDelete = FirebaseFirestore.instance.collection('favorit').doc(docSnashot.docs[0].id);
                            
                              _docReferenceDelete.delete();

                              setState(() {
                                touchs = false; 
                              });
                            } else {
                              FirebaseFirestore.instance.collection('favorit').add(dataToSave);

                              setState(() {
                                touchs = true; 
                              });
                            }
                              
                          } else {
                              setState(() {
                                  touchs = false; 
                              });
                          }
                        
                        },
                      ),
                              
                              
                ]),
              
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
      
  }
}

class $ {
}
