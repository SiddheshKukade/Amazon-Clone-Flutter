const mongoose = require("mongoose")
let regexEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
const userSchema = mongoose.Schema({
    name: {
        type: String, required: true, trim: true,
    },
    email: {
        type: String, required: true, trim: true,
        validate: {
            validator: (value) => {
                return value.match(regexEmail)
            },
            message: "Please Enter correct E-mail"
        }
    },
    password: {
        type: String, required: true ,  validate: {
            validator: (value) => {
              return value.length > 8;
            },
            message: "Please Enter password more than 8 chracters !"
        }
    },
    address: {
        type: String,   trim: true,
    },
    type: {
        type: String, required: true, trim: true, default: "user"
    },
})
const User = mongoose.model("User", userSchema)
module.exports = User; 