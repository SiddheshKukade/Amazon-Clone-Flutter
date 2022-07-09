const express = require('express');
const mongoose = require('mongoose')
const authRouter = express.Router();
var User = require("./models/user")
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

        let user = new User({
            email, password, name
        });
        user = await user.save();
        res.json(user)
    }

    catch (e) {
        res.json({errMsg : e.message})
    }
}
)


module.exports = authRouter;