import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

//create Something function
// What does doc('DocInCollection') do?
// The .doc('DocInCollection') method specifies a document ID inside the CreateTest collection.
// If a document with the ID "DocInCollection" exists, it will be updated with the new data.
// If it does not exist, Firestore will create it with the given data

void create(
    String collectionName, String docName, String name, String friend) async {
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(docName)
      .set({'name': name, 'Friend': friend});
  log("Created Successfully");
}

void delete(String collectionName, String docName) async {
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(docName)
      .delete();
  log("Deleted Successfully");
}

void update(
    String collectionName, String docName, String field, String newval) async {
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(docName)
      .update({field: newval});
  log("Updated Successfully");
}

//read operations
void retrieve() async {
  
}