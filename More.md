# Cloud-Based Databases

A cloud-based database is a database that is hosted, managed, and accessed over the internet, rather than being stored on a local server or computer. It provides scalable storage, real-time access, and automated backups without requiring direct hardware management.

## Types of Cloud-Based Databases

### SQL Cloud Databases (Structured, Relational)
- Example: Google Cloud SQL, Amazon RDS, Microsoft Azure SQL
- Uses structured tables and SQL queries for data management.

### NoSQL Cloud Databases (Flexible, Non-Relational)
- Example: Firebase Firestore, MongoDB Atlas, Amazon DynamoDB
- Stores data in key-value pairs, documents, or graphs for flexibility.

## Benefits of Cloud-Based Databases
- **Accessibility** – Data is accessible from anywhere with an internet connection.
- **Scalability** – Easily increases storage and performance based on demand.
- **Security** – Cloud providers offer encryption, authentication, and backup features.
- **Automatic Updates & Maintenance** – No need for manual hardware or software updates.
- **Cost-Effective** – Pay only for what you use.

## Firebase Realtime Database vs Firestore (Cloud Firestore)
Both Firebase Realtime Database and Cloud Firestore are NoSQL databases from Firebase, but they differ in structure, scalability, and performance.

### 1. Overview
| Feature | Firebase Realtime Database | Cloud Firestore |
|---------|--------------------------|----------------|
| **Data Structure** | JSON-based (nested tree) | Document-based (Collections & Documents) |
| **Querying** | Limited & hierarchical | Advanced, indexed queries |
| **Scalability** | Designed for small apps | Better scalability for large apps |
| **Offline Support** | Yes | Yes (more efficient syncing) |
| **Real-time Updates** | Yes (faster) | Yes (optimized for large datasets) |
| **Pricing** | Based on data size & connections | Based on document reads/writes |

### 2. When to Use What?
| Use Case | Recommended Database |
|----------|----------------------|
| Small-scale apps (chat apps, real-time syncing) | Firebase Realtime Database |
| Complex queries & large-scale apps | Cloud Firestore |
| Hierarchical (parent-child) structured data | Firebase Realtime Database |
| Scalable & structured data (e.g., social media, e-commerce, analytics) | Cloud Firestore |

## Uploading Files in Firebase (Paid Plan)
1. Add `firebase_storage` dependency in `pubspec.yaml`.
2. Create a reference object and use the following code:
   ```dart
   import 'package:firebase_storage/firebase_storage.dart';
   import 'dart:io';

   Future<void> uploadFile(File file, String path) async {
     try {
       FirebaseStorage storage = FirebaseStorage.instance;
       Reference ref = storage.ref().child(path);
       UploadTask uploadTask = ref.putFile(file);
       await uploadTask;
     } catch (e) {
       print("Upload failed: $e");
     }
   }
   ```