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

# Google Authentication Setup in Flutter

## Provider: Google Authentication

### 🔧 Firebase Configuration
1. Configure Firebase as usual.
2. Enable Google authentication.
3. Add the SHA key:
   - Go to the apps configured in the Firebase project.
   - Navigate to the documentation for SHA certificate fingerprint.
   - Run the required command or use:
     ```sh
     keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android
     ```
   - Copy the SHA-1 fingerprint and add it to Firebase.
   - Save the changes.
   - Download `google-services.json` and place it in the `android/app/` directory.

### 📌 Dependencies
Add the following dependencies to `pubspec.yaml`:
```yaml
dependencies:
  firebase_auth: latest_version
  google_sign_in: latest_version
  firebase_core: latest_version
```

### 📝 Implementing Google Sign-In in Dart
1. **Initialize the `google_sign_in` object.**
2. **Create a sign-in button.**
3. **Handle authentication on button press.**

### ⚠️ Common Errors & Fixes
- Ensure the file is **exactly named** `google-services.json` (no extra spaces or wrong extensions).

---

## ✅ Steps to Configure Google Auth for All Platforms

### 1️⃣ Android (SHA-1 & SHA-256 Required)
- Add SHA-1 & SHA-256 in Firebase: **Firebase Console → Project Settings → Add Fingerprint**
- Download and replace `google-services.json` in `android/app/`

### 2️⃣ iOS (OAuth & URL Scheme Configuration)
- In Firebase Console, navigate to **Project Settings → iOS**.
- Copy the **iOS Client ID**.
- Add the following entry inside `Info.plist`:
  ```xml
  <key>CFBundleURLTypes</key>
  <array>
      <dict>
          <key>CFBundleURLSchemes</key>
          <array>
              <string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
          </array>
      </dict>
  </array>
  ```
- Download and replace `GoogleService-Info.plist` in `ios/Runner/`.

### 3️⃣ Web (OAuth 2.0 Client Setup)
- Go to **Firebase Console → Authentication → Sign-in method → Google**.
- Enable Google Sign-In and add your web app domain.
- Go to **Google Cloud Console → Credentials** and create an **OAuth 2.0 Client ID** for Web.
- Use this OAuth Client ID in your Flutter Web app.

### 🔹 Summary Table
| Platform  | Requires SHA-1? | Additional Setup |
|-----------|---------------|------------------|
| Android   | ✅ Yes (SHA-1 & SHA-256) | `google-services.json` |
| iOS       | ❌ No | `GoogleService-Info.plist` & `CFBundleURLSchemes` |
| Web       | ❌ No | OAuth 2.0 Client ID |

---

## 🚀 Final Steps
After setting up everything, run:
```sh
flutter clean
flutter pub get
flutter run
```
Now, Google authentication will work across **Android, iOS, and Web**! 🎉

# Google, Facebook, and Twitter Authentication in Flutter

## 🔥 Firebase Configuration

### 📌 General Setup
1. Configure Firebase as usual.
2. Enable Google, Facebook, and Twitter authentication.
3. Download the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.
4. Place them in the respective directories:
   - `android/app/`
   - `ios/Runner/`

### 🔑 SHA Key for Android
To get the SHA key, run:
```sh
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android
```
Copy the SHA-1 and SHA-256 fingerprints, then add them to Firebase.

## 📦 Dependencies
Add the following dependencies to `pubspec.yaml`:
```yaml
dependencies:
  firebase_auth: latest_version
  google_sign_in: latest_version
  firebase_core: latest_version
  flutter_facebook_auth: latest_version
  twitter_login: latest_version
```

## 🛠️ Authentication Implementation

### 1️⃣ Google Authentication

- Initialize `GoogleSignIn`.
- Create a sign-in button.
- Handle authentication on button press.

#### Dart Code:
```dart
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final UserCredential userCredential = await _auth.signInWithCredential(credential);
  return userCredential.user;
}
```

### 2️⃣ Facebook Authentication

- Set up **Facebook Developer Console**.
- Get the **App ID** and configure OAuth Redirect.

#### Dart Code:
```dart
final FirebaseAuth _auth = FirebaseAuth.instance;
final FacebookAuth _facebookAuth = FacebookAuth.instance;

Future<User?> signInWithFacebook() async {
  final LoginResult result = await _facebookAuth.login();
  if (result.status == LoginStatus.success) {
    final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }
  return null;
}
```

### 3️⃣ Twitter Authentication

- Set up **Twitter Developer Portal**.
- Get the **API Key & Secret**.

#### Dart Code:
```dart
final FirebaseAuth _auth = FirebaseAuth.instance;
final TwitterLogin twitterLogin = TwitterLogin(
  apiKey: 'YOUR_API_KEY',
  apiSecretKey: 'YOUR_API_SECRET',
  redirectURI: 'YOUR_REDIRECT_URI',
);

Future<User?> signInWithTwitter() async {
  final authResult = await twitterLogin.login();
  if (authResult.status == TwitterLoginStatus.loggedIn) {
    final AuthCredential credential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }
  return null;
}
```

## 📌 Summary Table

| Provider  | Requires Extra Setup?       | Additional Files |
|-----------|----------------------------|------------------|
| Google    | ✅ SHA-1 & SHA-256 (Android) | google-services.json |
| Facebook  | ✅ App ID & OAuth Redirect  | None |
| Twitter   | ✅ API Key & Secret         | None |

## 🚀 Final Steps
Run the following commands to ensure proper setup:
```sh
flutter clean
flutter pub get
flutter run
```
Now, **Google, Facebook, and Twitter authentication** are fully integrated into your Flutter app! 🚀🎉


# Firebase Anonymous Authentication in Flutter

## Overview
Anonymous authentication allows users to experience your app without signing up or logging in. It is useful for guest/demo access, enabling users to interact with the app before committing to an account.

## Steps to Implement

### 1. Configure Firebase
- Go to [Firebase Console](https://console.firebase.google.com/).
- Select your project or create a new one.
- Navigate to **Authentication** > **Sign-in method**.
- Enable **Anonymous Authentication**.

### 2. Add Dependencies
Include Firebase Authentication in your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_auth: latest_version
```

Run:
```sh
flutter pub get
```

### 3. Implement Anonymous Authentication

#### Import Packages
```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
```

#### Create Authentication Screen
```dart
class AnonymousAuthScreen extends StatefulWidget {
  @override
  _AnonymousAuthScreenState createState() => _AnonymousAuthScreenState();
}

class _AnonymousAuthScreenState extends State<AnonymousAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> _signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print("Error signing in anonymously: \$e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anonymous Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential? user = await _signInAnonymously();
            if (user != null) {
              print("User signed in: \${user.user?.uid}");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Entered Successfully")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error entering as guest")));
            }
          },
          child: Text('Continue as Guest'),
        ),
      ),
    );
  }
}
```

### 4. Firebase Authentication Behavior
- Anonymous users remain logged in even after closing and reopening the app.
- Firebase automatically restores the session unless the user signs out explicitly.
- If the app is uninstalled and reinstalled, a new anonymous account is created.

### 5. Firebase Firestore Rules for Guest & Authenticated Users
Update Firebase Firestore security rules to define access control for anonymous and logged-in users:
```json
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /guest_content/{docId} {
      allow read, write: if request.auth == null;
    }
    match /user_data/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 6. Testing
- Run the app using `flutter run`.
- Press **"Continue as Guest"** and check Firebase Console to confirm authentication.
- Verify that the session persists after closing and reopening the app.

### 7. Handling Anonymous to Registered User Upgrade
To convert an anonymous user into a permanent account:
```dart
User? user = FirebaseAuth.instance.currentUser;
if (user != null && user.isAnonymous) {
  AuthCredential credential = EmailAuthProvider.credential(
      email: "test@example.com", password: "password123");
  await user.linkWithCredential(credential);
}
```
This preserves the user’s data while linking it to a registered account.

## Conclusion
Anonymous authentication is a great way to onboard users without requiring immediate sign-ups. It helps improve user retention by allowing engagement before commitment.

# Phone authentication
-https://www.youtube.com/watch?v=RvocbCaGzlM&list=PLgGjX33Qsw-ENq5MWsPF5nI9OVUyqNwgb&index=12

# Firebase Authentication in Flutter Web App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white)

## Overview
This guide covers how to implement **Authentication** in a **Flutter Web App** using Firebase.


## 🌍 Web App vs Website

| Feature        | Web App 🖥️📱 | Website 🌐 |
|---------------|-------------|-----------|
| **Definition** | A software application accessible via a browser, designed for interaction and dynamic user experience. | A collection of web pages providing static or dynamic information. |
| **Purpose** | Focuses on user interaction and performing tasks (e.g., Gmail, Google Docs). | Primarily used to display information (e.g., blogs, news sites). |
| **Interactivity** | Highly interactive with authentication, data processing, etc. | Mostly static, with limited interaction. |
| **Technology** | Uses frontend (HTML, CSS, JS) + backend (APIs, databases, authentication, frameworks like React, Angular, Node.js, Django). | Primarily HTML, CSS, JS with minimal backend functionality. |
| **User Authentication** | Often requires login (e.g., social media, banking apps). | Usually no login required unless it has a member area. |
| **Examples** | Gmail, Facebook, Twitter, Google Docs, Amazon | Wikipedia, Portfolio Sites, Blogs, News Websites |
| **Hosting** | Hosted on servers with backend processing. | Can be static (just HTML/CSS) or dynamic (CMS-based like WordPress). |

## 📌 Setting Up Firebase Authentication for web

### Step 1: Configure Firebase
1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Add **Firebase Authentication** to your project.
3. Register the Web App in Firebase (CLI or GUI method).

### Step 2: Install Dependencies
Add the following dependencies to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_auth: latest_version
  firebase_auth_web: latest_version
```

### Step 3: Register Firebase Web App
1. Open **Firebase Console**.
2. Navigate to **Project Settings** → **General**.
3. Click **Add App** → **Web**.
4. Register your app and follow the setup instructions.
5. Modify `index.html` inside the `web/` folder as per Firebase documentation.

### Step 4: Implement Authentication

#### Import Required Packages
```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
```

#### Create Authentication Screen

## 🔧 Common Issues & Fixes
- **Web app fails to connect to Firebase**: Check if `index.html` contains Firebase initialization script.
- **Session lost after app restart**: Confirm that Firebase is correctly initialized at startup.




