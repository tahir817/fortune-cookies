// require the express module 
const express = require('express');
const child_process = require('child_process')
// creat an experess web application 
const app = express();

// spcify how to respond to GET / 
app.get('/', (req, res) => {
    // run the system 'fortune' command and respond with the message 
    child_process.exec('fortune', (error, message) => {
        if(error === null){
            res.send(message);
        } else {
            res.send('Error: ' + error);
        }
    })
});

// start listening for HTTP requests on port 3000
app.listen(3000, () =>{
    console.log('Server started');
})

