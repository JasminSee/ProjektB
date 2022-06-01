const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
app.use("/media", express.static("media"));

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
    } else {
        res.render('editAccount', { "message": "Keine Änderung!" });
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
                delete req.session["cid"];
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
                    req.session["cid"] = row.id;
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

app.get('/deleteAccount', function (req, res) {
    res.render('deleteAccount', { "message": "" });
});

//Account löschen
app.post("/doDeleteAccount", function (req, res) {
    let password = req.body.password;
    let confirm = req.body.confirm;

    if (password != "") {
        if (password == confirm) {
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
        } else {
            res.render('deleteAccount', { "message": "Passwörter stimmen nicht überein!" });
        }
    } else {
        res.render('editPassword', { "message": "Gib dein Passwort ein!" });
    }
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
        let sql = `SELECT * FROM customers WHERE id = ${req.session.cid}`
        db.all(sql, function(err, rows) {
            res.render('myAccount', { "message": req.session.firstName, collector: rows })
        })
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
            let sql3 = `SELECT * FROM series WHERE seriesName LIKE '%${search}%' OR altName LIKE '%${search}%';`
            db.all(sql3, function (err, rows3) {
                res.render('search', { collectorFigures: rows, collectorCompanies: rows2, collectorSeries: rows3, search: search })
            })
        })
    });
});

app.get('/top10', function (req, res) {
    let sql =
        `select reviews.rid, reviews.fid, count(figurines.fid), round(avg(reviews.rating),1) as rating, figurines.figurineName ,figurines.picture, figurines.characterName 
        from reviews, figurines 
        where figurines.fid = reviews.fid
        group BY reviews.fid
        order by avg(reviews.rating) DESC, count(figurines.fid) DESC;`
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
app.get('/wunschliste', function (req, res) {
    let sql = `SELECT * FROM wishlist WHERE customerID=${req.session.cid}`;
    let sql2 = `SELECT * from figurines`;
    var row = [];
    db.all(sql, function (err, rows) {
        db.all(sql2, function (err, result) {
            result.forEach((figure) => {
                rows.forEach((listItem) => {
                    if (figure.fid == listItem.figuresId) {
                        row.push(figure);
                        return true;
                    }
                })
            })
            res.render('wishlist', { "message": (rows.length > 0 ? "Wunschliste" : "Du hast noch keine Figuren auf deiner Wunschliste!"), list: rows, figurines: result, collector: row });
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
                            let sql4 = `SELECT * FROM wishlist WHERE customerId=${req.session.cid} AND figuresId=${result.fid};`;
                            db.all(sql4, function (err, wish) {
                                if (wish.length != 0) {
                                    res.render('figurDetails', { collector: rows, figurines: result, series: ser, company: comp, seller: row, reviews: rev, moment: moment, rating: Math.round((averageReviews / rev.length) * 2) / 2, actualRating: averageReviews / rev.length, isLogged: isLoggedIn, inWishlist: true, user: req.session.cid });
                                }
                                else {
                                    res.render('figurDetails', { collector: rows, figurines: result, series: ser, company: comp, seller: row, reviews: rev, moment: moment, rating: Math.round((averageReviews / rev.length) * 2) / 2, actualRating: averageReviews / rev.length, isLogged: isLoggedIn, inWishlist: false, user: req.session.cid });
                                }

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
    let sql = `select * from figurines, series where figurines.origin = series.seriesID;`
    db.all(sql, function (err, rows) {
        res.render('allFigurines', { collector: rows });
    });
});

app.post('/addBookmark', function (req, res) {
    const fid = req.body.fid;
    let sql = `INSERT INTO wishlist(customerId, figuresId) VALUES (${req.session.cid},${fid});`;
    db.all(sql, function (err, rows) {
        res.redirect(`/figurDetails/${fid}`);
    });
});

app.post("/removeBookmark", function (req, res) {
    const fid = req.body.fid;
    let sql = `DELETE FROM wishlist WHERE customerId=${req.session.cid} AND figuresId=${fid};`;
    db.all(sql, function (err, rows) {
        res.redirect(`/figurDetails/${fid}`);
    });
});



app.post('/postReview', function (req, res) {
    var today = new Date();
    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    const fid = req.body.fid;
    const userId = req.session.cid;
    const userName = req.session.firstName + " " + req.session.lastName;
    const rating = req.body.rating;
    const title = req.body.title;
    const rDescription = req.body.rDescription;

    let sql = `INSERT INTO reviews(fid,userId,userName, postDate, rating, title, rDescription) VALUES (${fid},${userId},"${userName}", "${date}", ${rating}, "${title}", "${rDescription}");`;
    db.all(sql, function (err, rows) {
        res.redirect(`/figurDetails/${fid}`);
    });


});

//Filter
//---------------------------------------------------------------------------------------------
app.post('/allFigurines/sort', function (req, res) {
    const sort = [];

    //Sortieren
    const alphabeticalSort = req.body.alphabeticalSort;
    const seriesSort = req.body.seriesSort;
    const releaseSortDESC = req.body.releaseSortDESC;
    const releaseSortASC = req.body.releaseSortASC;
    const priceSortDESC = req.body.priceSortDESC;
    const priceSortASC = req.body.priceSortASC;
    const ratingSortDESC = req.body.ratingSortDESC;
    const ratingSortASC = req.body.ratingSortASC;

    sort.push({ checked: alphabeticalSort, orderBy: "characterName"}, { checked: seriesSort, orderBy: "series.seriesName ASC"}, { checked: releaseSortDESC, orderBy: "substr(releaseDate, 4,5) DESC"},
        { checked: priceSortDESC, orderBy: "originalPriceYen DESC"}, { checked: priceSortASC, orderBy: "originalPriceYen ASC"}, { checked: ratingSortDESC, orderBy: "rating DESC"},
        { checked: ratingSortASC, orderBy: "rating ASC"}, { checked: releaseSortASC, orderBy: "substr(releaseDate, 4,5) ASC"});

    for (i = 0; i <= sort.length; i++) {
        if (sort[i].checked !== undefined) {
            if (sort[i].checked == "on") {
                if (sort[i].orderBy == "rating ASC" || sort[i].orderBy == "rating DESC") {
                    let sqlRating =
                        `select reviews.rid, reviews.fid, round(avg(reviews.rating),1) as rating, figurines.figurineName ,figurines.picture, series.seriesID, series.seriesName, figurines.origin
                        from reviews, figurines, series
                        where figurines.fid = reviews.fid AND figurines.origin = series.seriesID
                        group BY reviews.fid
                        order by ${sort[i].orderBy};`
                    db.all(sqlRating, function (err, rows) {
                        res.render('filter', { collector: rows , "message": "Sortiert nach Bewertung"});
                    });
                } else if (sort[i].orderBy == "substr(releaseDate, 4,5) ASC" || sort[i].orderBy == "substr(releaseDate, 4,5) DESC") {
                    let sqlRating = `SELECT * FROM figurines, series where figurines.origin = series.seriesID ORDER BY ${sort[i].orderBy};`
                    db.all(sqlRating, function (err, rows) {
                        res.render('filter', { collector: rows , "message": "Sortiert nach Erscheinungsdatum"});
                    });
                } else {
                    let sql = `select * from figurines, series where figurines.origin = series.seriesID order by ${sort[i].orderBy};`
                    db.all(sql, function (err, rows) {
                        res.render('filter', { collector: rows  , "message": "Sortierte Figuren"});
                    });
                }
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

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
                let sql = `SELECT * FROM figurines, series WHERE figurines.origin = series.seriesID AND origin = ${filterSeries[i].id};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows , "message": "" + rows.length + " Suchergebniss(e)"});
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
                let sql = `Select * from figurines, series where figurines.origin = series.seriesID AND releaseDate like '%${filterRelease[i].year}%';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows  , "message": "" + rows.length + " Suchergebniss(e)"});
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
    const BStyle = req.body.BStyle;
    const Zero = req.body.Zero;
    const FNex = req.body.FNex;
    const Gals = req.body.Gals;
    const KDcolle = req.body.KDcolle;
    const PreciousGEM = req.body.PreciousGEM;
    filterClassification.push({ checked: PopUpParade, name: "Pop Up Parade" }, { checked: Nendroid, name: "Nendroid" }, { checked: ArtfxJ, name: "ARTFX J" }, { checked: BendaiSpirits, name: "Bandai Spirits" },
        { checked: ShibuyaScrample, name: "Shibuya Scramble Figure" }, { checked: Figma, name: "Figma" }, { checked: NarutoGals, name: "Naruto Gals DX" }, { checked: CharactersCollectionDX, name: "Game Characters Collection DX" },
        { checked: GEM, name: "G.E.M" }, { checked: PreciousGEM, name: "Precious G.E.M." }, { checked: BStyle, name: "B-style" }, { checked: Zero, name: "Figuarts ZERO" },
        { checked: FNex, name: "F:Nex" }, { checked: Gals, name: "Gals Series" }, { checked: KDcolle, name: "KDcolle" });

    for (i = 0; i <= filterClassification.length; i++) {
        if (filterClassification[i].checked !== undefined) {
            if (filterClassification[i].checked == "on") {
                let sql = `SELECT * FROM figurines, series WHERE figurines.origin = series.seriesID AND classification = '${filterClassification[i].name}';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows  , "message": "" + rows.length + " Suchergebniss(e)"});
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
                let sql = `SELECT * FROM figurines, series WHERE figurines.origin = series.seriesID AND  material LIKE '%${filterMaterial[i].name}%';`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows  , "message": "" + rows.length + " Suchergebniss(e)"});
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});

app.post('/allFigurines/filterRating', function (req, res) {
    const filterRating = [];
    const rowsResult = [];

    //Bewertung
    const Zero = req.body.Zero;
    const One = req.body.One;
    const Two = req.body.Two;
    const Three = req.body.Three;
    const Four = req.body.Four;
    const Five = req.body.Five;
    filterRating.push({ checked: One, von: 1, bis: 2 }, { checked: Zero, von: 0, bis: 1 }, { checked: Two, von: 2, bis: 3 }, { checked: Three, von: 3, bis: 4 },
        { checked: Four, von: 4, bis: 5 }, { checked: Five, von: 5, bis: 6 });

    for (i = 0; i <= filterRating.length; i++) {
        if (filterRating[i].checked !== undefined) {
            if (filterRating[i].checked == "on") {
                let sql = `select reviews.rid, reviews.fid, round(avg(reviews.rating),1) as rating, figurines.figurineName ,figurines.picture, figurines.fid, figurines.origin, series.seriesID, series.seriesName
                from reviews, figurines, series
                where figurines.fid = reviews.fid AND figurines.fid = series.seriesID
                group BY reviews.fid
                order by rating DESC;`
                db.all(sql, function (err, rows) {
                    for (j = 0; j < rows.length; j++) {
                        if (rows[j].rating >= filterRating[i].von && rows[j].rating < filterRating[i].bis) {
                            rowsResult.push(rows[j])
                        }
                    }
                    res.render('filter', { collector: rowsResult  , "message": "" + rowsResult.length + " Suchergebniss(e)"});
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
                let sql = `select * from figurines, series where figurines.origin = series.seriesID AND originalPriceYen >= ${filterPrice[i].min} AND originalPriceYen <= ${filterPrice[i].max};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows  , "message": "" + rows.length + " Suchergebniss(e)"});
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
    const FreeIng = req.body.FreeIng;
    const Kadokawa = req.body.Kadokawa;
    const FuRyu = req.body.FuRyu;
    const BandaiSpirits = req.body.BandaiSpirits;
    const MegaHouse = req.body.MegaHouse;
    filterCompanies.push({ checked: GoodSmile, id: 1 }, { checked: Kotobukiya, id: 2 }, { checked: Aniplex, id: 3 }, { checked: Bandai, id: 5 }, { checked: eStream, id: 4 },
        { checked: MaxFactory, id: 6 }, { checked: MegaHouse, id: 7 }, { checked: FreeIng, id: 8 }, { checked: Kadokawa, id: 9 }, { checked: FuRyu, id: 10 },
        { checked: BandaiSpirits, id: 11 });

    for (i = 0; i <= filterCompanies.length; i++) {
        if (filterCompanies[i].checked !== undefined) {
            if (filterCompanies[i].checked == "on") {
                let sql = `SELECT * FROM figurines, series WHERE figurines.origin = series.seriesID AND  company = ${filterCompanies[i].id};`
                db.all(sql, function (err, rows) {
                    res.render('filter', { collector: rows  , "message": "" + rows.length + " Suchergebniss(e)"});
                });
                break;
            } else {
                continue
            }
        } else {

        }
    }
});
