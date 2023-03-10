
import 'package:flutter/material.dart';
import 'package:ugly_santa/main.dart';
import 'package:ugly_santa/mainDetailProduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ugly_santa/widget/NavDrawer.dart';



class MyAppProduct extends StatefulWidget {
  const MyAppProduct({super.key});

 

  @override
  State<MyAppProduct> createState() => _MyAppProductState();
}

class _MyAppProductState extends State<MyAppProduct> {
  
  
 

   Query<Map<String, dynamic>> reference (String text) {
    switch (text) {
    case "chausset":
      Query<Map<String, dynamic>> _referenceShoppingList = FirebaseFirestore.instance.collection('product').where("type", isEqualTo: "chausset");
      return _referenceShoppingList; break;
    case "bonnet":
      Query<Map<String, dynamic>> _referenceShoppingList = FirebaseFirestore.instance.collection('product').where("type", isEqualTo: "bonnet");
      return _referenceShoppingList; break;
    case "gant":
      Query<Map<String, dynamic>> _referenceShoppingList = FirebaseFirestore.instance.collection('product').where("type", isEqualTo: "gant");
      return _referenceShoppingList; break;
    case "pull":
      Query<Map<String, dynamic>> _referenceShoppingList = FirebaseFirestore.instance.collection('product').where("type", isEqualTo: "pull");
      return _referenceShoppingList; break;
    default: 
       Query<Map<String, dynamic>> _referenceShoppingList = FirebaseFirestore.instance.collection('product');
      return _referenceShoppingList; break;
      break;
  }
 }

 Stream<QuerySnapshot> test ( String text ) {
    
    late Stream<QuerySnapshot> _streamShoppingItems;
    return _streamShoppingItems = reference(text).snapshots();
 }

  int _cIndex = 1;
    
    void _incrementTab(index) {
      setState(() {
        _cIndex = index;
      });
    }

  initState() {
   
    super.initState();

   
   
  }
  @override
  
 
  void _pop() {
    Navigator.pop(context);
   
  }

  void _homePage() {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyApp()));
  }


   void _detailProduct(String id) {

        Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  MyAppDetailProduct(id)));
  }

  

  @override
  Widget build(BuildContext context) {

  return DefaultTabController(
     initialIndex: 0,
      length: 5,
    child :Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Product'),
         bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Tout",
              ),
              Tab(
                text: "Bonnet",
              ),
              Tab(
                text: "Chaussette",
              ),
              Tab(
                text: "Gant",
              ),
              Tab(
                text: "Pull",
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: test("tout"),
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
                  'id': e.id,
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
                       errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.do_not_disturb);
                        },),
                        title: Text('${thisItem['name']}'),
                        subtitle: Text('${thisItem['description']}'),
                        trailing: Text('${thisItem['price'.toString()]} €'),
                        onTap: () {_detailProduct(thisItem['id'] );
                        },
                      );
                    });
              }

                    return CircularProgressIndicator();

                  },
              ),
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: test("bonnet"),
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
                  'id': e.id,
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
                        errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.do_not_disturb);
                        },),
                        title: Text('${thisItem['name']}'),
                        subtitle: Text('${thisItem['description']}'),
                        trailing: Text('${thisItem['price'.toString()]} €'),
                        onTap: () {_detailProduct(thisItem['id'] );
                        },
                      );
                    });
              }

                    return const CircularProgressIndicator();

                  },
              ),
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: test("chausset"),
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
                  'id': e.id,
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
                        errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.do_not_disturb);
                        },),
                        title: Text('${thisItem['name']}'),
                        subtitle: Text('${thisItem['description']}'),
                        trailing: Text('${thisItem['price'.toString()]} €'),
                        onTap: () {_detailProduct(thisItem['id'] );
                        },
                      );
                    });
              }

                    return const CircularProgressIndicator();

                  },
              ),
            ),
             Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: test("gant"),
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
                  'id': e.id,
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
                        errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const Icon(Icons.do_not_disturb);
                        },),
                        title: Text('${thisItem['name']}'),
                        subtitle: Text('${thisItem['description']}'),
                        trailing: Text('${thisItem['price'.toString()]} €'),
                        onTap: () {_detailProduct(thisItem['id'] );
                        },
                      );
                    });
              }

                    return const CircularProgressIndicator();

                  },
              ),
            ),
             Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: test("pull"),
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
                  'id': e.id,
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
                        errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.do_not_disturb);
                        },),
                        title: Text('${thisItem['name']}'),
                        subtitle: Text('${thisItem['description']}'),
                        trailing: Text('${thisItem['price'.toString()]} €'),
                        onTap: () {_detailProduct(thisItem['id'] );
                        },
                      );
                    });
              }

                    return const CircularProgressIndicator();

                  },
              ),
            ),
          ],
        ),
    
         bottomNavigationBar:BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.fixed ,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),label: 'Product'),
         
        ],
        onTap: (value){
          if (value == 0) _homePage();
          if (value == 1) _incrementTab(value);
         
        },
      ),
        
    ),
  );
  }
}