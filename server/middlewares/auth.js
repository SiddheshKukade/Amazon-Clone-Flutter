const jwt = require('jsonwebtoken')

const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token')
        if (!token) res.status(401).json({ msg: "No Authorization found in header  of the request" })

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.status(401).json({ msg: "Token Verification Falied ! " })

        req.user = verified.id;
        req.token = token
        next()
    } catch (e) {
        res.status(500).json({ error: err.message })
    }
}
module.exports = auth;