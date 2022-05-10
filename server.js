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

//CSS files laden
app.use(express.static('stylesheets'));

app.get('/', function(req, res){
    res.render('home');
});

app.get('/trustedShops', function(req, res){
    res.render('trustedShops');
});

app.get('/login', function(req, res){
    res.render('login');
});

app.get('/register', function(req, res){
    res.render('register');
});

app.get('/top10', function(req, res){
    res.render('top10');
});

app.get('/hersteller', function(req, res){
    let sql = "SELECT * FROM companies";
    db.all(sql, function(err, rows){
        res.render('brandScreen', {collector: rows});
      });
});

app.get('/serien', function(req, res){
    let sql = "SELECT * FROM series ORDER BY seriesName ASC";
    db.all(sql, function(err, rows){
        res.render('seriesScreen', {collector: rows});
      });
});

app.get('/serien/:seriesID', function(req, res){
    let sql = "SELECT * FROM series ";
    var result;
    db.all(sql, function(err, rows){
        let sql2=`SELECT * FROM figurines WHERE origin=${req.params.seriesID}`;
        rows.forEach((serie) => {
            if(serie.seriesID ==req.params.seriesID){
                result = serie;
                return true;
            }
        })
        db.all(sql2,function(err,row){
            res.render('seriesDetails', {collector: rows, series: result, figurines: row});
        })
        
      });
});

app.get('/figurDetails/:fid', function(req, res){
    let sql = "SELECT * FROM figurines ";
    var result;
    db.all(sql, function(err, rows){
        rows.forEach((figur) => {
            if(figur.fid ==req.params.fid){
                result = figur;
                return true;
            }
        })
        
        res.render('figurDetails', {collector: rows, figurines: result});
        
        
      });
});