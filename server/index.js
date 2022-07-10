//library imports
const express = require("express")
const mongoose = require("mongoose")
var morgan = require('morgan')
require('dotenv').config()
//local imports
const authRouter = require("./routes/auth")
const PORT = process.env.PORT || 4000;

//init
const app = express();

app.use(express.json())
app.use(morgan('tiny'));
//middlewares
app.use(authRouter)
app.get("/", (req, res) => {
    res.json({ "〽️ server-mood 〽️": "😀" });
});
mongoose.connect(process.env.MONGO_DB_URL, () => { console.log("Databse Connected " + new Date().getHours() + " : " + new Date().getMinutes(),) }).then(() => { }).catch(err => console.log("error occured " + new Date().getHours() + " : " + new Date().getMinutes(), err));

app.listen(PORT, () => console.log("😀 " + PORT))