//library imports
const express = require("express")
const mongoose = require("mongoose")
var morgan = require('morgan')
require('dotenv').config()
//local imports
const authRouter = require("./routes/auth")

 
//init
const app = express();

 app.use(express.json())
 app.use(morgan('tiny'));
//middlewares
app.use(authRouter)

mongoose.connect(process.env.MONGO_DB_URL, () => { console.log("Databse Connected " + new Date().getHours() + " : " + new Date().getMinutes(),) }).then(() => { }).catch(err => console.log("error occured " + new Date().getHours() + " : " + new Date().getMinutes(), err));

app.listen(4000, "0.0.0.0", () => console.log("port is running good 4000"))