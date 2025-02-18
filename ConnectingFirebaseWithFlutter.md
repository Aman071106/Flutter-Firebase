# 🚀 Flutter Firebase Integration Guide

![Flutter Firebase](https://firebase.google.com/images/social.png)

## 🎯 Steps to Connect Flutter with Firebase

### 🔹 1. Setup Firebase Project  
1. Go to [Firebase Console](https://console.firebase.google.com/)  
2. Sign up or log in  
3. Click **Create Project** and follow the steps  

---

## 📱 2. Add an App (Android / iOS / Web)  

### 🔹 Android Setup  
1. Get the **Package Name** from:  
   - Open `android/app/build.gradle`  
   - Look for `applicationId`  
2. Enter this package name in Firebase  
3. Give an **App Nickname** (Optional)  
4. Skip SHA keys for now (needed for Google Authentication)  
5. Click **Register App**  
6. Download `google-services.json`  
7. Place it in:  
   ```
   android/app/google-services.json
   ```  
8. Add dependencies as per Firebase documentation  
9. Enable **MultiDex** in `android/app/build.gradle`:  
   ```gradle
   defaultConfig {
       multiDexEnabled true
   }
   ```

---

### 🍏 iOS Setup  
1. Get **Bundle ID** from:  
   - Open `ios/Runner.xcodeproj` in **Xcode**  
   - Check **Bundle Identifier** in the General tab  
2. App Store ID is **optional** (needed for App Store deployment)  
3. Download `GoogleService-Info.plist`  
4. Place it in:  
   ```
   ios/Runner/GoogleService-Info.plist
   ```  
5. In Xcode, ensure **"Copy items if needed"** is ticked  
6. Open `ios/Podfile` and add the platform version:  
   ```ruby
   platform :ios, '12.0'
   ```  
7. Follow Firebase documentation commands to install dependencies  

---

## 🔄 3. Common Firebase Configuration in Flutter  
📌 Add **firebase_core** dependency in `pubspec.yaml`:  
```yaml
dependencies:
  firebase_core: latest_version
```
📌 In `main.dart`, initialize Firebase:  
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

---

## 📝 Note  
📌 The `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files act as a **bridge** between Firebase and your Flutter app.  

✅ Now your Flutter app is connected to Firebase! 🚀🔥  


## CLI Integration (Windows)

1. **Install Node.js**:
   - Download from [Node.js](https://nodejs.org/) and install.

2. **Install Firebase CLI Tools**:
   ```bash
   npm install -g firebase-tools
   ```

3. **Login to Firebase**:
   ```bash
   firebase login
   ```

4. **Install `flutterfire_cli`**:
   ```bash
   dart pub global activate flutterfire_cli
   ```

5. **Add Dart Executable Path to System Environment Variables**:
   Add the following path to your system's PATH environment variable:
   ```plaintext
   C:\Users\<your_username>\AppData\Local\Pub\Cache\bin
   ```

6. **Navigate to Your Flutter Project**:
   ```bash
   cd <path_to_your_flutter_project>
   ```

7. **Run `flutterfire configure`**:
   ```bash
   flutterfire configure
   ```

8. **Update `pubspec.yaml`** to include `firebase_core`:
   ```yaml
   dependencies:
     firebase_core: latest_version
   ```

9. **Update `main.dart`** to initialize Firebase:
   ```dart
   import 'package:firebase_core/firebase_core.dart';
   import 'package:flutter/material.dart';
   import 'firebase_options.dart'; // Import the generated file from the CLI tool

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     runApp(const MyApp());
   }
   ```

10. **Enable MultiDex in `android/app/build.gradle`:**
    ```gradle
    defaultConfig {
        multiDexEnabled true
    }
    ```

---

### **Final Step: Run Your App**
```bash
flutter run
```
