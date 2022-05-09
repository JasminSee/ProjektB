const express = require('express');
const app = express();

const bodyParser = require('body-parser');

app.engine('.ejs', require('ejs').__express);
app.set('view engine', 'ejs');

app.listen(3000, function(){
    console.log('listening on 3000');
});

//verbindung zur Datenbank
const sqlite3 = require('sqlite3').verbose();

let db = new sqlite3.Database('collector.db', (err) => { 
    if (err) {
         console.error(err.message); 
    } 
    console.log('Connected to the shop database.');
});

app.get('/', function(req, res){
    res.render('home');
});

app.get('/trustedShops', function(req, res){
    res.render('trustedShops');
});

app.get('/login', function(req, res){
    res.render('login');
});

app.get('/hersteller', function(req, res){
    let sql = "SELECT * FROM companies";
    db.all(sql, function(err, rows){
        res.render('brandScreen', {collector: rows});
      });
});