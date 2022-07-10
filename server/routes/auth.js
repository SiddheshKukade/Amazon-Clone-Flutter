const express = require('express');
const mongoose = require('mongoose')
const authRouter = express.Router();
var User = require("./models/user")
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

authRouter.post('/api/signup', async (req, res) => {
    try {
        console.log("Body of the cureent request "
            + new Date().getHours() + " : "
            + new Date().getMinutes(), req.body)

        const { name, email, password } = req.body

        const existingUser = await User.findOne({ email })
        if (existingUser) {
            return res.status(400).json({ msg: "User already exists with the E-mail !" })
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        let user = new User({
            email, password: hashedPassword, name
        });
        user = await user.save();
        res.json(user)
    }

    catch (e) {
        res.status(500).json({ errMsg: e.message })
    }
}
);

authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email })
        if (!user) {
            return res.status(400).json({ msg: "User with this E-mail Does not exits! Try Signing up " })
        }

        const isMatch = await bcrypt.compare(password, user.password)
        if (!isMatch) {
            return res.status(400).json({ msg: "Password is Incorrect !  " })
        }
        const token = jwt.sign({ id: user._id }, "passwordKey")
        res.json({ token, ...user._doc })
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})


module.exports = authRouter;