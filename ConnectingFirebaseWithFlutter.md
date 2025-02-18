this is for demonstrating how to connect futter with firebase

go to firebase.com
sign up
create project
ios/android/web
get package name from android/build/gradle
give nickname(optional)
sha keys if google authentication(for now leave)
register
download google service.json
put under app folder
add dependecies as per documentation in the firebase.com
add multiDexEnabled true in default config

//ios
add bundle id
open it in xcode
see the bundleidentfier
app store id is optional(it is for deploying on app store)
download info.plist
put in runner
ensure copy item tickmark
add the platform:ios 'version' in PodFile
follow documentation commands 

//common
dependecies: 
    firebase_core:
in main.dart
add then async wrap on void main
and fireabse intialize and Widgetbinding.ensureInitialized


//note:
The json or plist file act as bridge between firebase and flutter app
