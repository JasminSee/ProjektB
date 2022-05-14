const express = require('express');
const app = express();
const bcrypt = require('bcrypt');

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended:true}));

app.engine('.ejs', require('ejs').__express);
app.set('view engine', 'ejs');

const cookieParser = require('cookie-parser');
app.use(cookieParser());

const session = require('express-session');
app.use(session({
    secret: 'example',
    resave: false,
    saveUninitialized: true
}));

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

app.get('/allFigurines', function(req, res){
    let sql = 
        `select * from figurines;`
    db.all(sql, function(err, rows){
        res.render('allFigurines', {collector: rows});
      });
});

app.get('/trustedShops', function(req, res){
    res.render('trustedShops');
});

app.get('/login', function(req, res){
    res.render('login');
});

app.post('/doLogin', function(req, res){
    const email = req.body.email;
    const password = req.body.password;
    let sql2= `SELECT email FROM customers`
    db.all(sql2,function(err,row){
        valid=false;
        for(i=0; i<row.length;i++){
            if(email==row[i].email){
                valid=true;
            }
        }
        if(valid==true) {
            let sql = `SELECT * FROM customers WHERE email="${email}"`;
            db.get(sql,function(err, row) {
                 req.session.email = row.email;
                if (bcrypt.compareSync(password, row.psword)){
                    req.session["sessionVariable"]= "ist angemeldet";
                    req.session["id"]= row.id;
                    req.session["user"] = row.firstName +" "+ row.lastNname;
                    req.session["firstName"] = row.firstName ;
                    req.session["lastName"] = row.lastName ;
                    req.session["email"] = row.email ;
                    res.render("home"); 
                }
                else {
                    //res.render('false',{"message":"Wrong Password"})
                    console.log("falsches passwort")
                    res.render("login"); 
                };
            })
        }
        else{
            //res.render('false',{"message":"Account doesn't exist"})
            console.log("account exisitiert nicht")
            res.render("login"); 
        }
    })
});

//Session abbrechen zum ausloggen
app.get("/logout", function(req, res){
    delete req.session["sessionVariable"];
    delete req.session["user"];
    delete req.session["id"];
    delete req.session["firstname"];
    delete req.session["lastName"];
    delete req.session["email"];
    
    res.redirect("/");
});

//Auswertung nach der Registrierung
app.post('/doRegister', function(req, res) {
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const email = req.body.email;
    const password = req.body.password;
    const confirm = req.body.confirm;

    let hash = bcrypt.hashSync(password,10);
    let sql2=`SELECT email FROM customers;`
    db.all(sql2,function(err,row){
        var validy=false;
        for(i=0;i<row.length;i++){
            if(email==row[i].email){
                validy=true;
            }
        }
        if(validy==true){
            //res.render('registerfalse',{"message": "Account already exists"})
            console.log("account existiert bereits")
            res.render("register"); 

        }
        else{
            if(password==confirm){
                //SQL Befehl um einen neuen Eintrag der Tabelle user hinzuzufügen
                let sql = `INSERT INTO customers (email, psword, firstName, lastName) VALUES ("${email}","${hash}","${firstName}", "${lastName}");`
                
                db.all(sql, function(err) {
                    if (err) { 
                        console.error(err)
                    } else {
                        res.render('home',{"message":"Congratulation you are a member now! Email: "+email,"message2":""}); 
                        let sql3=`SELECT id FROM customers WHERE email="${email}";`
                    }
                })
            }
            else {
                //res.render('registerfalse',{"message": "Passwords don't match"})
                console.log("passwörter stimmen nicht überein")
                res.render("register"); 
            }
        }
    });
});


//Anzeigen von meinKonto bzw umleiten zum login, wenn nicht angemeldet
app.get("/myAccount", function(req, res){
    console.log(req.session);
    if (!req.session["sessionVariable"]){
        res.render('login');
    }
    else {
        res.render('myAccount')
    }
});

app.get('/register', function(req, res){
    res.render('register');
});

app.post('/search',function(req,res){
    const search= req.body.search;

    let sql = `SELECT * FROM figurines WHERE figurineName LIKE '%${search}%';`
    db.all(sql, function(err,rows){
        let sql2 = `SELECT * FROM companies WHERE companyName LIKE '%${search}%';`
            db.all(sql2, function(err,rows2) {
                let sql3 = `SELECT * FROM series WHERE seriesName LIKE '%${search}%' OR altName LIKE '%${search}%' OR sDescription LIKE '%${search}%';`
                db.all(sql3, function(err, rows3) {
                    res.render('search', {collectorFigures: rows, collectorCompanies: rows2, collectorSeries: rows3, search: search})
                })
            })  
    });
});

app.get('/top10', function(req, res){
    let sql = 
        `select wishlist.id, wishlist.customerId, wishlist.figuresId, count(wishlist.figuresId), figurines.figurineName ,figurines.picture 
        from wishlist, figurines 
        where figurines.fid = wishlist.figuresId 
        group BY wishlist.figuresId 
        order by count(wishlist.figuresId) DESC;`
    db.all(sql, function(err, rows){
        res.render('top10', {collector: rows});
      });
});

app.get('/hersteller', function(req, res){
    let sql = "SELECT * FROM companies";
    db.all(sql, function(err, rows){
        res.render('brandScreen', {collector: rows});
      });
});


app.get('/hersteller/:companyID', function(req, res){
    let sql = "SELECT * FROM companies ";
    var result;
    db.all(sql, function(err, rows){
        let sql2=`SELECT * FROM figurines WHERE company=${req.params.companyID}`;
        rows.forEach((company) => {
            if(company.companyID ==req.params.companyID){
                result = company;
                return true;
            }
        })
        db.all(sql2,function(err,row){
            res.render('brandDetails', {collector: rows, companies: result, figurines: row});
        })
        
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