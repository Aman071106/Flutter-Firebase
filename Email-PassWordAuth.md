## Firebase Authentication Setup in Flutter App

### Step 1: Configure Firebase in Flutter App
- Follow the steps in the Firebase Console to set up Firebase in your Flutter app.

### Step 2: Enable Email and Password Authentication
1. Go to the Firebase Console.
2. Select **Authentication** from the left sidebar.
3. Under the **Sign-in method** tab, enable **Email/Password** authentication.
4. Click **Save**.

### Step 3: Verify User in Firebase
- Go to the **Users** section in the Firebase Console to see if there are any existing users. Initially, there won't be any users.

### Step 4: Build UI for Login and Signup
- Create a UI that handles both login and signup.
  - Use a `Form` widget and wrap the container containing the `TextFormField` widgets with the form. Pass the form key to the `key` parameter of the `Form` widget.
  - Create a `bool` variable, `isLogin`, to toggle between login and signup states.

### Step 5: Validate Form and Text Fields
- Set up a `GlobalKey<FormState>` for form validation and handle text input with validators.

### Step 6: Create Authentication Functions
- Add the `signup` function as an `async` method and handle user sign-up.

### Step 7: Add Firebase Dependencies
- Add the `firebase_auth` package to your `pubspec.yaml`.

### Step 8: Handle State for Email, Username, and Password
- Create state variables for email, username, and password.

### Step 9: TextFormField Validation
- Add validation logic for `TextFormField` inputs for both email and password.

### Step 10: Update Minimum SDK Version
- Update your `minSdkVersion` to 23 in your `android/app/build.gradle` file for Firebase authentication to work.

---
