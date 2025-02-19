const express = require("express");
const bcrypt = require("bcryptjs");
const User = require("../models/User");

const router = express.Router();

//define functionalities
// ✅ 1️⃣ User Registration Route
router.post("/register", async (req, res) => {
    try {
        const { username, password, age } = req.body;

        // Check if user exists
        const existingUser = await User.findOne({ username });
        if (existingUser) return res.status(400).json({ message: "Username already exists" });

        // Hash the password before saving
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new user
        const newUser = new User({ username, password: hashedPassword, age });
        await newUser.save();

        res.status(201).json({ message: "User registered successfully" });
    } catch (error) {
        res.status(500).json({ message: "Server error", error });
    }
});

// ✅ 2️⃣ User Login Route
router.post("/login", async (req, res) => {
    try {
        const { username, password } = req.body;

        // Find user in DB
        const user = await User.findOne({ username });
        if (!user) return res.status(400).json({ message: "Invalid credentials" });

        // Check password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

        res.status(200).json({ message: "Login successful" });
    } catch (error) {
        res.status(500).json({ message: "Server error", error });
    }
});

// ✅ 3️⃣ Get Age Route
router.get("/get-age/:username", async (req, res) => {
    try {
        const { username } = req.params;

        // Find user and return age
        const user = await User.findOne({ username });
        if (!user) return res.status(404).json({ message: "User not found" });

        res.status(200).json({ age: user.age });
    } catch (error) {
        res.status(500).json({ message: "Server error", error });
    }
});

module.exports = router;
