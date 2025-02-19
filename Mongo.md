# Flutter MongoDB Backend Integration Guide

![Tech Stack](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white) ![Express](https://img.shields.io/badge/Express-000000?style=for-the-badge&logo=express&logoColor=white) ![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)

## Overview
This guide explains how to set up a full-stack application using Flutter for the frontend and MongoDB, Node.js, and Express for the backend. The stack is suitable for applications that require scalability and full control over data visibility rules, making it more appropriate for production environments compared to Firebase.

## Tech Stack Components
- **Flutter**: Frontend framework for building mobile/web UI
- **Node.js**: Backend runtime environment for server-side logic
- **Express**: Web framework for Node.js to handle API routing
- **MongoDB**: NoSQL database for data storage

## Project Structure
```
your-main-project-folder

│── /flutter_mongo_backend  (Node.js + Express Backend)
│    ├── server.js
│    ├── package.json
│    ├── .env
│    ├── /models
│    │   └── User.js
│    └── /routes
│        └── userRoutes.js
│
│── /flutter_app  (Flutter Project)
     ├── /lib
     │   ├── main.dart
     │   └── api_service.dart
     └── pubspec.yaml
```

## Backend Setup
### 1. MongoDB Atlas Setup
- Create an account on MongoDB Atlas
- Create a new project
- Create a free tier cluster
- Add a database user with appropriate permissions
- Configure network access:
  - Development: Allow access from anywhere (0.0.0.0/0)
  - Production: Use specific IP addresses for security
- Create database and collection

### 2. Node.js Backend Setup
```sh
mkdir flutter_mongo_backend && cd flutter_mongo_backend
npm init -y
npm install express mongodb cors dotenv mongoose bcryptjs
```

#### Create .env file:
```
MONGO_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/myDatabase?retryWrites=true&w=majority
PORT=5000
```

#### Create User Model (models/User.js):
```js
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    age: { type: Number, required: true }
});

const User = mongoose.model("User", userSchema);
module.exports = User;
```

#### Create Routes (routes/userRoutes.js):
```js
const express = require("express");
const bcrypt = require("bcryptjs");
const User = require("../models/User");
const router = express.Router();

router.post("/register", async (req, res) => {
    try {
        const { username, password, age } = req.body;
        const existingUser = await User.findOne({ username });
        if (existingUser) return res.status(400).json({ message: "Username already exists" });
        
        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new User({ username, password: hashedPassword, age });
        await newUser.save();
        
        res.status(201).json({ message: "User registered successfully" });
    } catch (error) {
        res.status(500).json({ message: "Server error", error });
    }
});

module.exports = router;
```

#### Configure Server (server.js):
```js
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect(process.env.MONGO_URI, { 
    useNewUrlParser: true, 
    useUnifiedTopology: true 
})
.then(() => console.log("MongoDB Connected"))
.catch((err) => console.error("MongoDB Connection Error:", err));

const userRoutes = require("./routes/userRoutes");
app.use("/api/users", userRoutes);

app.listen(5000, () => {
    console.log("Server running on port 5000");
});
```

## Flutter Setup
Add HTTP package to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: 
```

#### Configure API Service:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://YOUR_LOCAL_IP:5000/api/users';

  static Future<Map<String, dynamic>> registerUser(
      String username, String password, int age) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'age': age,
        }),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
```

## Testing API with Postman
1. Open Postman and create a new request.
2. Set the request type to `POST`.
3. Enter the URL: `http://localhost:5000/api/users/register`.
4. Go to the **Body** tab and select **raw**.
5. Set the content type to `JSON`.
6. Enter the following JSON:
   ```json
   {
     "username": "testuser",
     "password": "testpass",
     "age": 25
   }
   ```
7. Click **Send** and verify the response.

## Common Issues & Fixes
- **Connection refused error**:
  - Ensure the server is running on `0.0.0.0`
  - Verify correct IP address configuration
  -use ipconfig command and change base url in flutter apiservice
  - Check firewall settings
- **MongoDB connection issues**:
  - Verify network access settings in MongoDB Atlas
  - Check credentials in `.env` file
  - Ensure proper database user permissions

## Security Considerations
- Use environment variables for sensitive data
- Hash passwords before storing
- Implement authentication
- Use HTTPS in production

## License
Specify the license (e.g., MIT, Apache 2.0).

