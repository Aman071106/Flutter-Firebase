const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },  // Unique username
    password: { type: String, required: true },  // Hashed password
    age: { type: Number, required: true }  // Age field
});

//it will always access the collection name with lowercase letters no matter UserEntries or userentries
const User = mongoose.model("UserEntries", userSchema);

module.exports = User;
