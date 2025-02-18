import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadNew1 extends StatefulWidget {
  const ReadNew1({super.key});
  @override
  createState() => _ReadNew1();
}

class _ReadNew1 extends State<ReadNew1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text("New1"),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('New1').snapshots(),
            builder: (context, new1snapshot) {
              if (new1snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final doc = new1snapshot.data!.docs;
                return ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Icon(Icons.book),
                            title: Text(doc[index]["name"]),
                            subtitle: Text(doc[index]["Friend"]),
                          ),
                        ));
              }
            }),
      ),
    );
  }
}
