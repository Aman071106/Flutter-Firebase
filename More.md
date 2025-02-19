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