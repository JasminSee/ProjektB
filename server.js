const express = require('express');
const app = express();
app.listen(3000, function(){
console.log('listening on 3000');
});
app.get('/hello', function(req, res){
res.send('Hello World!');
});

//verbindung zur Datenbank
const sqlite3 = require('sqlite3').verbose();

let db = new sqlite3.Database('collector.db', (err) => { 
    if (err) {
         console.error(err.message); 
    } 
    console.log('Connected to the shop database.');
});