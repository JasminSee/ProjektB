const express = require('express');
const app = express();
const bcrypt = require('bcrypt');

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

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

app.listen(3000, function () {
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

app.get('/', function (req, res) {
    res.render('home', { "message": "Willkommen!" });
});

app.get('/trustedShops', function (req, res) {
    res.render('trustedShops');
});

app.get('/editAccount', function (req, res) {
    res.render('editAccount', { "message": "", "firstName": req.session.firstName, "lastName": req.session.lastName, "email": req.session.email });
});

app.post('/edit', function (req, res) {
    let firstName = req.body.firstName;
    let lastName = req.body.lastName;
    let email = req.body.email;

    if (firstName != "" || lastName != "" || emailName != "" || password != "") {
        const editedFirstName = firstName = "" ? req.session.firstName : firstName;
        const editedLastName = lastName = "" ? req.session.lastName : lastName;
        const editedEmail = email = "" ? req.session.email : email;
        let sql = `UPDATE customers SET 
    firstName = "${editedFirstName}",
    lastName = "${editedLastName}",
    email = "${editedEmail}"
    WHERE email = '${req.session.email}';`
        db.all(sql, function (err, rows) {
            req.session["firstName"] = editedFirstName;
            req.session["lastName"] = editedLastName;
            req.session["email"] = editedEmail;
            res.render('editAccount', { "message": "Erfolgreich geändert", "firstName": editedFirstName, "lastName": editedLastName, "email": editedEmail });
        });
    }
});


app.get('/editPassword', function (req, res) {
    res.render('editPassword', { "message": "" });
});

app.post('/doEditPassword', function (req, res) {
    let password = req.body.password;
    let confirm = req.body.confirm;

    if (password != "") {
        if (password == confirm) {
            let hash = bcrypt.hashSync(password, 10);
            let sql = `UPDATE customers SET psword = "${hash}" WHERE email = '${req.session.email}';`
            db.all(sql, function (err, rows) {
                delete req.session["sessionVariable"];
                delete req.session["id"];
                delete req.session["firstName"];
                delete req.session["lastName"];
                delete req.session["email"];
                res.render('home', { "message": "Passwort erfolgreich geändert! Logge Dich erneut ein!" });
            });
        } else {
            res.render('editPassword', { "message": "Passwörter stimmen nicht überein!" });
        }
    } else {
        res.render('editPassword', { "message": "keine Änderung" });
    }
});

app.get('/login', function (req, res) {
    res.render('login', { "message": "" });
});

app.post('/doLogin', function (req, res) {
    const email = req.body.email;
    const password = req.body.password;
    let sql2 = `SELECT email FROM customers`
    db.all(sql2, function (err, row) {
        valid = false;
        for (i = 0; i < row.length; i++) {
            if (email == row[i].email) {
                valid = true;
            }
        }
        if (valid == true) {
            let sql = `SELECT * FROM customers WHERE email="${email}"`;
            db.get(sql, function (err, row) {
                req.session.email = row.email;
                if (bcrypt.compareSync(password, row.psword)) {
                    req.session["sessionVariable"] = "ist angemeldet";
                    req.session["id"] = row.id;
                    req.session["firstName"] = row.firstName;
                    req.session["lastName"] = row.lastName;
                    req.session["email"] = row.email;
                    res.render("home", { "message": "Willkommen" + " " + req.session.firstName + "!" });
                }
                else {
                    res.render("login", { "message": "Falsches Passwort" });
                };
            })
        }
        else {
            res.render("login", { "message": "Account existiert nicht" });
        }
    })
});

//Session abbrechen zum ausloggen
app.get("/logout", function (req, res) {
    delete req.session["sessionVariable"];
    delete req.session["id"];
    delete req.session["firstName"];
    delete req.session["lastName"];
    delete req.session["email"];

    res.render("home", { "message": "Du hast dich erfolgreich ausgeloggt!" });
});

//Account löschen
app.get("/deleteAccount", function (req, res) {
    let sql = `DELETE FROM customers WHERE email = '${req.session.email}';`;
    db.all(sql, function (err, rows) {
        delete req.session["sessionVariable"];
        delete req.session["user"];
        delete req.session["id"];
        delete req.session["firstname"];
        delete req.session["lastName"];
        delete req.session["email"];
        res.render('home', { collector: rows, "message": "Account erfolgreich gelöscht!" });
    });
});

//Auswertung nach der Registrierung
app.post('/doRegister', function (req, res) {
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const email = req.body.email;
    const password = req.body.password;
    const confirm = req.body.confirm;
    let hash = bcrypt.hashSync(password, 10);
    let sql2 = `SELECT email FROM customers;`
    db.all(sql2, function (err, row) {
        var validy = false;
        for (i = 0; i < row.length; i++) {
            if (email == row[i].email) {
                validy = true;
            }
        }
        if (validy == true) {
            res.render("register", { "message": "Account existiert bereits!" });

        }
        else {
            if (password == confirm) {
                //SQL Befehl um einen neuen Eintrag der Tabelle user hinzuzufügen
                let sql = `INSERT INTO customers (email, psword, firstName, lastName) VALUES ("${email}","${hash}","${firstName}", "${lastName}");`

                db.all(sql, function (err) {
                    if (err) {
                        console.error(err)
                    } else {
                        res.render('login', { "message": "Du hast dich erfolgreich registriert!" });
                    }
                })
            }
            else {
                res.render("register", { "message": "Passwörter stimmen nicht überein!" });
            }
        }
    });
});


//Anzeigen von meinKonto bzw umleiten zum login, wenn nicht angemeldet
app.get("/myAccount", function (req, res) {
    if (!req.session["sessionVariable"]) {
        res.render('login', { "message": "" });
    }
    else {
        res.render('myAccount', { "message": req.session.firstName })
    }
});

app.get('/register', function (req, res) {
    res.render('register', { "message": "" });
});

app.post('/search', function (req, res) {
    const search = req.body.search;

    let sql = `SELECT * FROM figurines WHERE figurineName LIKE '%${search}%';`
    db.all(sql, function (err, rows) {
        let sql2 = `SELECT * FROM companies WHERE companyName LIKE '%${search}%';`
        db.all(sql2, function (err, rows2) {
            let sql3 = `SELECT * FROM series WHERE seriesName LIKE '%${search}%' OR altName LIKE '%${search}%' OR sDescription LIKE '%${search}%';`
            db.all(sql3, function (err, rows3) {
                res.render('search', { collectorFigures: rows, collectorCompanies: rows2, collectorSeries: rows3, search: search })
            })
        })
    });
});

app.get('/top10', function (req, res) {
    let sql =
        `select wishlist.id, wishlist.customerId, wishlist.figuresId, count(wishlist.figuresId), figurines.figurineName ,figurines.picture 
        from wishlist, figurines 
        where figurines.fid = wishlist.figuresId 
        group BY wishlist.figuresId 
        order by count(wishlist.figuresId) DESC;`
    db.all(sql, function (err, rows) {
        res.render('top10', { collector: rows });
    });
});

app.get('/hersteller', function (req, res) {
    let sql = "SELECT * FROM companies";
    db.all(sql, function (err, rows) {
        res.render('brandScreen', { collector: rows });
    });
});

app.get('/hersteller/:companyID', function (req, res) {
    let sql = "SELECT * FROM companies ";
    var result;
    db.all(sql, function (err, rows) {
        let sql2 = `SELECT * FROM figurines WHERE company=${req.params.companyID}`;
        rows.forEach((company) => {
            if (company.companyID == req.params.companyID) {
                result = company;
                return true;
            }
        })
        db.all(sql2, function (err, row) {
            res.render('brandDetails', { collector: rows, companies: result, figurines: row });
        })

    });
});

app.get('/serien', function (req, res) {
    let sql = "SELECT * FROM series ORDER BY seriesName ASC";
    db.all(sql, function (err, rows) {
        res.render('seriesScreen', { collector: rows });
    });
});

app.get('/serien/:seriesID', function (req, res) {
    let sql = "SELECT * FROM series ";
    var result;
    db.all(sql, function (err, rows) {
        let sql2 = `SELECT * FROM figurines WHERE origin=${req.params.seriesID}`;
        rows.forEach((serie) => {
            if (serie.seriesID == req.params.seriesID) {
                result = serie;
                return true;
            }
        })
        db.all(sql2, function (err, row) {
            res.render('seriesDetails', { collector: rows, series: result, figurines: row });
        })

    });
});

app.get('/figurDetails/:fid', function (req, res) {
    var moment = require('moment');
    let sql = "SELECT * FROM figurines ";
    var result;
    var averageReviews = 0;
    var isLoggedIn;
    if (!req.session["sessionVariable"]) {
        isLoggedIn = false;
    }
    else { isLoggedIn = true; }
    db.all(sql, function (err, rows) {

        rows.forEach((figur) => {
            if (figur.fid == req.params.fid) {
                result = figur;
                return true;
            }
        })
        let sql2 = `SELECT * FROM (SELECT * FROM allBlueData WHERE id=${result.allBlueID} UNION SELECT * FROM mangaMafiaData WHERE id=${result.mangaMafiaID} UNION SELECT * FROM animeLeData WHERE id=${result.animeLeID} UNION SELECT * FROM figuyaData WHERE id=${result.figuyaID} ORDER BY price);`;
        db.all(sql2, function (err, row) {
            sql3 = `SELECT * FROM reviews WHERE fid=${result.fid}`;
            db.get(`SELECT * FROM companies WHERE companyID=${result.company}`, (err, comp) => {
                db.get(`SELECT * FROM series WHERE seriesID=${result.origin}`, (err, ser) => {
                    db.all(sql3, function (err, rev) {
                        rev.forEach((review) => {
                            averageReviews += review.rating;
                        })
                        if (isLoggedIn == true) {
                            let sql5 = `SELECT id FROM customers WHERE email='${req.session.email}';`;
                            db.get(sql5, function (err, userId) {
                                let sql4 = `SELECT * FROM wishlist WHERE customerId=${userId.id} AND figuresId=${result.fid};`;
                                db.all(sql4, function (err, wish) {
                                    if (wish.length !=0) {
                                        res.render('figurDetails', { collector: rows, figurines: result, series: ser, company: comp, seller: row, reviews: rev, moment: moment, rating: Math.round((averageReviews / rev.length) * 2) / 2, actualRating: averageReviews / rev.length, isLogged: isLoggedIn, inWishlist: true , user: userId.id});
                                    }
                                    else {
                                        res.render('figurDetails', { collector: rows, figurines: result, series: ser, company: comp, seller: row, reviews: rev, moment: moment, rating: Math.round((averageReviews / rev.length) * 2) / 2, actualRating: averageReviews / rev.length, isLogged: isLoggedIn, inWishlist: false, user: userId.id });
                                    }

                                })
                            })

                        }
                        else {
                            res.render('figurDetails', { collector: rows, figurines: result, series: ser, company: comp, seller: row, reviews: rev, moment: moment, rating: Math.round((averageReviews / rev.length) * 2) / 2, actualRating: averageReviews / rev.length, isLogged: isLoggedIn });
                        }
                    })
                })

            })

        })



    });
});

app.get('/allFigurines', function (req, res) {
    let sql = `select * from figurines;`
    db.all(sql, function (err, rows) {
        res.render('allFigurines', { collector: rows });
    });
});

app.put('/addedBookmark/:fid/:userId', function (req, res) {
    let sql = `INSERT INTO wishlist(customerId, figuresId) VALUES (${req.body.userId},${req.body.fid});`;
    db.all(sql, function (err, rows) {
        res.send('added to wishlist!');
    });
});

app.post('/postReview', function (req, res) {

});

//Filter
//---------------------------------------------------------------------------------------------
app.post('/allFigurines/filterSeries', function (req, res) {
    const filterSeries = [];

    //Serien
    const AOT = req.body.AOT;
    const BlackRockShooter = req.body.BlackRockShooter;
    const Danganronpa = req.body.Danganronpa;
    const DarlingInTheFranXX = req.body.DarlingInTheFranXX;
    const DemonSlayer = req.body.DemonSlayer;
    const Digimon = req.body.Digimon;
    const Hololive = req.body.Hololive;
    const Inuyasha = req.body.Inuyasha;
    const JujutsuKaisen = req.body.JujutsuKaisen;
    const KonoSuba = req.body.KonoSuba;
    const MyHeroAcademia = req.body.MyHeroAcademia;
    const Naruto = req.body.Naruto;
    const NeonGenesis = req.body.NeonGenesis;
    const OnePiece = req.body.OnePiece;
    const Persona = req.body.Persona;
    const ShamanKing = req.body.ShamanKing;
    const TokyoRevengers = req.body.TokyoRevengers;
    const Slime = req.body.Slime;
    filterSeries.push({ checked: DemonSlayer, id: 1 }, { checked: DarlingInTheFranXX, id: 2 }, { checked: Inuyasha, id: 3 }, { checked: Danganronpa, id: 4 }, { checked: Naruto, id: 5 },
        { checked: JujutsuKaisen, id: 6 }, { checked: MyHeroAcademia, id: 7 }, { checked: AOT, id: 8 }, { checked: Slime, id: 9 }, { checked: TokyoRevengers, id: 10 }, { checked: OnePiece, id: 11 },
        { checked: ShamanKing, id: 12 }, { checked: Hololive, id: 13 }, { checked: BlackRockShooter, id: 14 }, { checked: KonoSuba, id: 15 }, { checked: Persona, id: 16 }, { checked: Digimon, id: 17 },
        { checked: NeonGenesis, id: 18 });


    for (i = 0; i <= filterSeries.length; i++) {
        if (filterSeries[i].checked !== undefined) {
            if (filterSeries[i].checked == "on") {
                let sql = `SELECT * FROM figurines WHERE origin = ${filterSeries[i].id};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterRelease', function (req, res) {
    const filterRelease = [];

    //Erscheinungsdatum
    const release2016 = req.body.release2016;
    const release2017 = req.body.release2017;
    const release2018 = req.body.release2018;
    const release2019 = req.body.release2019;
    const release2020 = req.body.release2020;
    const release2021 = req.body.release2021;
    const release2022 = req.body.release2022;
    const release2023 = req.body.release2023;
    filterRelease.push({ checked: release2016, year: "2016" }, { checked: release2017, year: "2017" }, { checked: release2018, year: "2018" }, { checked: release2019, year: "2019" }, { checked: release2020, year: "2020" },
        { checked: release2021, year: "2021" }, { checked: release2022, year: "2022" }, { checked: release2023, year: "2023" });

    for (i = 0; i <= filterRelease.length; i++) {
        if (filterRelease[i].checked !== undefined) {
            if (filterRelease[i].checked == "on") {
                let sql = `Select * from figurines where releaseDate like '%${filterRelease[i].year}%';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterClassification', function (req, res) {
    const filterClassification = [];

    //Klassifikation
    const PopUpParade = req.body.PopUpParade;
    const Nendroid = req.body.Nendroid;
    const ArtfxJ = req.body.ArtfxJ;
    const BendaiSpirits = req.body.BendaiSpirits;
    const ShibuyaScrample = req.body.ShibuyaScrample;
    const Figma = req.body.Figma;
    const NarutoGals = req.body.NarutoGals;
    const CharactersCollectionDX = req.body.CharactersCollectionDX;
    const GEM = req.body.GEM;
    const PreciousGEM = req.body.PreciousGEM;
    filterClassification.push({ checked: PopUpParade, name: "Pop Up Parade" }, { checked: Nendroid, name: "Nendroid" }, { checked: ArtfxJ, name: "ARTFX J" }, { checked: BendaiSpirits, name: "Bandai Spirits" },
        { checked: ShibuyaScrample, name: "Shibuya Scramble Figure" }, { checked: Figma, name: "Figma" }, { checked: NarutoGals, name: "Naruto Gals DX" }, { checked: CharactersCollectionDX, name: "Game Characters Collection DX" },
        { checked: GEM, name: "G.E.M" }, { checked: PreciousGEM, name: "Precious G.E.M." });

    for (i = 0; i <= filterClassification.length; i++) {
        if (filterClassification[i].checked !== undefined) {
            if (filterClassification[i].checked == "on") {
                let sql = `SELECT * FROM figurines WHERE classification = '${filterClassification[i].name}';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterMaterial', function (req, res) {
    const filterMaterial = [];

    //Material
    const ABS = req.body.ABS;
    const PVC = req.body.PVC;
    const Acryl = req.body.Acryl;
    const LED = req.body.LED;
    filterMaterial.push({ checked: ABS, name: "ABS" }, { checked: PVC, name: "PVC" }, { checked: Acryl, name: "Acrylic" }, { checked: LED, name: "LED" });

    for (i = 0; i <= filterMaterial.length; i++) {
        if (filterMaterial[i].checked !== undefined) {
            if (filterMaterial[i].checked == "on") {
                let sql = `SELECT * FROM figurines WHERE material LIKE '%${filterMaterial[i].name}%';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterHeight', function (req, res) {
    const filterHeight = [];

    //Hoehe
    const MM160 = req.body.MM160;
    const MM170 = req.body.MM170;
    const MM190 = req.body.MM190;
    const MM260 = req.body.MM260;
    const MM300 = req.body.MM300;
    filterMaterial.push({ checked: MM160, height: "160" }, { checked: MM170, height: "170" }, { checked: MM190, height: "190" }, { checked: MM260, height: "260" },
        { checked: MM300, height: "Height=300" });

    for (i = 0; i <= filterHeight.length; i++) {
        if (filterHeight[i].checked !== undefined) {
            if (filterHeight[i].checked == "on") {
                let sql = `select * from figurines where dimension like ${filterHeight[i].height};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterPrice', function (req, res) {
    const filterPrice = [];

    //Originalpreis
    const Yen3000 = req.body.Yen3000;
    const Yen6000 = req.body.Yen6000;
    const Yen10000 = req.body.Yen10000;
    const Yen16000 = req.body.Yen16000;
    const Yen20000 = req.body.Yen20000;
    const Yen25000 = req.body.Yen25000;
    const Yen30000 = req.body.Yen30000;
    const YenMax = req.body.YenMax;
    filterPrice.push({ checked: Yen3000, min: 0, max: 2999 }, { checked: Yen6000, min: 3000, max: 5999 }, { checked: Yen10000, min: 6000, max: 9999 }, { checked: Yen16000, min: 10000, max: 15999 },
        { checked: Yen20000, min: 16000, max: 19999 }, { checked: Yen25000, min: 20000, max: 24999 }, { checked: Yen30000, min: 25000, max: 29999 }, { checked: YenMax, min: 30000, max: 60000 });

    for (i = 0; i <= filterPrice.length; i++) {
        if (filterPrice[i].checked !== undefined) {
            if (filterPrice[i].checked == "on") {
                let sql = `select * from figurines where originalPriceYen >= ${filterPrice[i].min} AND originalPriceYen <= ${filterPrice[i].max};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterCompanies', function (req, res) {
    const filterCompanies = [];

    //Hersteller
    const GoodSmile = req.body.GoodSmile;
    const Kotobukiya = req.body.Kotobukiya;
    const Aniplex = req.body.Aniplex;
    const Bandai = req.body.Bandai;
    const eStream = req.body.eStream;
    const MaxFactory = req.body.MaxFactory;
    const MegaHouse = req.body.MegaHouse;
    filterCompanies.push({ checked: GoodSmile, id: 1 }, { checked: Kotobukiya, id: 2 }, { checked: Aniplex, id: 3 }, { checked: Bandai, id: 5 }, { checked: eStream, id: 4 },
        { checked: MaxFactory, id: 6 }, { checked: MegaHouse, id: 7 });

    for (i = 0; i <= filterCompanies.length; i++) {
        if (filterCompanies[i].checked !== undefined) {
            if (filterCompanies[i].checked == "on") {
                let sql = `SELECT * FROM figurines WHERE company = ${filterCompanies[i].id};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows });
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});
