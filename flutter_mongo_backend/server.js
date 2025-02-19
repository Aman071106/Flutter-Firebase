require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// 🔗 Connect to MongoDB
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log("✅ MongoDB Connected"))
    .catch((err) => console.error("❌ MongoDB Connection Error:", err));

// ✅ Import and use user routes

app.get("/", (res) => {
    res.send("Server is running! 🚀");
});

const userRoutes = require("./routes/userRoutes");
app.use("/api/users", userRoutes);

app.listen(5000,'0.0.0.0', () => console.log("🚀 Server running on port 5000"));
