import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/Functions/CRUD/databaseFunctions.dart';
import 'package:flutter_with_firebase/features/Screens/New1Collection.dart';

class Databaseview extends StatefulWidget {
  const Databaseview({super.key});
  @override
  createState() => _Databaseview();
}

class _Databaseview extends State<Databaseview> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
        title: Center(
            child: Text("CRUD-Operations",
                style: TextStyle(fontWeight: FontWeight.w500))),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: w,
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //create operation
            ElevatedButton(
                onPressed: () {
                  create("New1", "Doc", "Person", "Friend");
                },
                child: Text("Create")),
            //Read operation
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.amberAccent)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReadNew1()));
                },
                child: Text("Read")),
            //Update operation
            ElevatedButton(
                onPressed: () {
                  update("New1", "Doc", "name", "Aman");
                },
                child: Text("Update")),
            //Delete operation
            ElevatedButton(
                onPressed: () {
                  delete("CreateTest", "DocInCollection");
                },
                child: Text("Delete"))
          ],
        ),
      ),
    );
  }
}
