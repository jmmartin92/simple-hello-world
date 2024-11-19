const express = require('express');
const nodeserver = express();
const PORT = 8000;

nodeserver.use(express.static('htmlfiles') );

nodeserver.get('/', (req,resp) => {
    console.log(`${req.ip} ${req.method} ${req.originalUrl} ${req.query}`);
    resp.sendFile("htmlfiles/helloworld.html", {root: __dirname});
});
nodeserver.listen(PORT, ()=> console.log(`Server started at ${new Date()} on port ${PORT}`));
