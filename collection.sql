CREATE TABLE allBlueData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    price FLOAT
);

CREATE TABLE mangaMafiaData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    price FLOAT
);

CREATE TABLE animeLeData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    price FLOAT
);

CREATE TABLE figuyaData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    price FLOAT
);

CREATE TABLE animes (
    animeID INTEGER PRIMARY KEY AUTOINCREMENT,
    animeName TEXT NOT NULL,
    altName TEXT,
    icon TEXT,
    adescription TEXT,
);

CREATE TABLE companies (
    companyID INTEGER PRIMARY KEY AUTOINCREMENT,
    companyName TEXT NOT NULL,
    banner TEXT NOT NULL,
    cdescription TEXT,
    link TEXT
);

CREATE TABLE figurines (
    fid INTEGER PRIMARY KEY AUTOINCREMENT,
    figurineName TEXT NOT NULL,
    picture TEXT NOT NULL,
    isbn TEXT NOT NULL,
    origin TEXT NOT NULL,
    characterName TEXT NOT NULL,
    company TEXT NOT NULL,
    classification TEXT,
    dimension TEXT,
    material TEXT NOT NULL,
    releaseDate TEXT,
    originalPriceYen INTEGER,
    allBlueID INTEGER,
    mangaMafiaID INTEGER,
    animeLeID INTEGER,
    figuyaID INTEGER,
    FOREIGN KEY (allBlueID) REFERENCES allBlueData(id),
    FOREIGN KEY (mangaMafiaID) REFERENCES mangaMafiaData(id),
    FOREIGN KEY (animeLeID) REFERENCES animeLeData(id),
    FOREIGN KEY (figuyaID) REFERENCES figuyaData(id)
);

INSERT INTO allBlueData(link, price) VALUES
("https://www.allblue-world.de/anime-manga/13464/demon-slayer-kimetsu-no-yaiba-tengen-uzui-figur/pop-up-parade-good-smile-company?c=0",44.90),
("https://www.allblue-world.de/shop/a-c/action-figuren/4462/darling-in-the-franxx-zero-two-nendoroid-good-smile-company?c=0",56.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/11624/inuyasha-inuyasha-statue/pop-up-parade-good-smile-company?c=0",44.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13126/super-danganronpa-1-2-reload-nagito-komaeda-statue/pop-up-parade-good-smile-company?c=0",44.90),
("https://www.allblue-world.de/shop/a-c/action-figuren/12364/naruto-shippuden-kakashi-hatake-nendoroid/anbu-black-ops-version-good-smile-company?c=0",58.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/11805/jujutsu-kaisen-satoru-gojo-statue/artfxj-bonus-edition-kotobukiya?c=0",124.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/12711/my-hero-academia-shoto-todoroki-statue/artfxj-version-2-bonus-edition-kotobukiya?c=0",194.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/4789/attack-on-titan-levi-statue/artfxj-neuauflage-kotobukiya?c=0",219.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/6551/darling-in-the-franxx-zero-two-statue/school-uniform-version-aniplex?c=0",279.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13183/demon-slayer-kimetsu-no-yaiba-tengen-uzui-statue-aniplex?c=0",289.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/12939/that-time-i-got-reincarnated-as-a-slime-rimuru-tempest-statue/hagun-version-estream?c=0",539.90),
("https://www.allblue-world.de/shop/a-c/anime-prize-figuren/12324/tokyo-revengers-ken-ryuguji-statue-banpresto?c=0",35.90),
("https://www.allblue-world.de/shop/a-c/anime-prize-figuren/12318/tokyo-revengers-manjiro-sano-statue-banpresto",35.90),
("https://www.allblue-world.de/shop/a-c/anime-prize-figuren/11290/one-piece-boa-hancock-figur/lady-fight-banpresto?c=0",39.90),
("https://www.allblue-world.de/shop/a-c/anime-prize-figuren/11740/shaman-king-hao-asakura-figur-banpresto?c=0",34.90),
("https://www.allblue-world.de/shop/a-c/action-figuren/11829/hololive-production-usada-pekora-figma-max-factory?c=0",91.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13124/black-rock-shooter-black-rock-shooter-statue/hxxg-edition-max-factory?c=0",394.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/12874/hololive-production-spiritale-houshou-marine-statue-max-factory?c=0",399.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13385/hololive-production-sakura-miko-statue/pop-up-parade-max-factory",55.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13322/konosuba-megumin-statue/pop-up-parade-max-factory?c=0",44.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13075/naruto-gals-sakura-haruno-statue-megahouse",424.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13097/persona-5-arsene-statue/anniversary-edition-megahouse?c=0",259.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/1675/digimon-adventure-wizardmon-gatomon-statue/g.e.m.-serie-megahouse?c=0",69.90),
("https://www.allblue-world.de/shop/o-s/statuen-buesten-figuren/13074/naruto-shippuden-uchiha-itachi-statue/g.e.m.-serie-precious-susanoo-version-megahouse?c=0",489.90),
("https://www.allblue-world.de/anime-manga/13215/evangelion-3.0-1.0-thrice-upon-a-time-rei-ayanami-statue/g.e.m.-megahouse?c=0",234.90);

INSERT INTO mangaMafiaData(link, price) VALUES
("https://manga-mafia.de/preorder-demon-slayer-tengen-uzui-pop-up-parade-18cm-pvc-statue.html",49.99),
("https://manga-mafia.de/figuren/collector-darling-in-the-franxx-zero-two-nendoroid-10cm-actionfigur.html",69.99),
("https://manga-mafia.de/inu-yasha-inu-yasha-pop-up-parade-17cm-pvc-statue.html",49.99),
("https://manga-mafia.de/preorder-danganronpa-nagito-komaeda-pop-up-parade-17cm-pvc-statue.html",49.99),
("https://manga-mafia.de/preorder-naruto-shippuden-kakashi-hatake-anbu-10cm-actionfigur.html",69.99),
("https://manga-mafia.de/preorder-jujutsu-kaisen-satoru-gojo-bonus-edition-artfxj-25cm-1-8-statue.html",159.99),
("https://manga-mafia.de/preorder-my-hero-academia-shoto-todoroki-bonus-edition-artfxj-26cm-1-8-pvc-statue.html",184.99),
("https://manga-mafia.de/preorder-attack-on-titan-levi-fortitude-ver-artfx-j-17cm-1-7-pvc-statue.html",199.99),
("https://manga-mafia.de/preorder-darling-in-the-franxx-zero-two-uniform-ver-29cm-1-7-pvc-statue.html",239.99),
("https://manga-mafia.de/preorder-demon-slayer-tengen-uzui-28cm-1-8-pvc-statue.html",259.99),
("https://manga-mafia.de/preorder-that-time-i-got-reincarnated-as-a-slime-rimuru-tempest-hagun-ver-27cm-pvc-statue.html",484.99),
("https://manga-mafia.de/preorder-tokyo-revengers-draken-18cm-pvc-statue.html",39.99),
("https://manga-mafia.de/preorder-tokyo-revengers-mikey-16cm-pvc-statue.html",39.99),
("https://manga-mafia.de/one-piece-boa-hancock-lady-fight-20cm-pvc-statue.html",39.99),
("https://manga-mafia.de/shaman-king-asakura-hao-14cm-pvc-statue.html",39.99),
("https://manga-mafia.de/preorder-hololive-pekora-figma-15cm-actionfigur.html",94.99),
("https://manga-mafia.de/preorder-black-rock-shooter-black-rock-shooter-hxxg-edition-30cm-pvc-statue.html",349.99),
("https://manga-mafia.de/preorder-hololive-houshou-marine-24cm-1-7-pvc-statue.html",369.99),
("https://manga-mafia.de/preorder-hololive-sakura-miko-pop-up-parade-17cm-pvc-statue.html",59.99),
("https://manga-mafia.de/preorder-konosuba-megumin-pop-up-parade-18cm-pvc-statue.html",49.99),
("https://manga-mafia.de/preorder-naruto-haruno-sakura-naruto-gals-dx-cm-pvc-statue.html",399.99),
("https://manga-mafia.de/preorder-persona-5-arsene-anniversary-edition-game-characters-collection-dx-28cm-pvc-statue.html",239.99),
("https://manga-mafia.de/collector-digimon-adventure-wizardmon-gatomon-g-e-m-18cm-pvc-statue.html",119.99),
("https://manga-mafia.de/preorder-naruto-shippuden-uchiha-itachi-susano-ver-38cm-pvc-statue.html",449.99),
("https://manga-mafia.de/preorder-evangelion-3-0-1-0-rei-ayanami-thrice-upon-a-time-g-e-m-22cm-pvc-statue.html",219.99);

INSERT INTO animeLeData(link, price) VALUES
("https://www.anime-le.de/detail/index/sArticle/11772",44.90),
("https://www.anime-le.de/detail/index/sArticle/8421",56.90),
("https://www.anime-le.de/detail/index/sArticle/8829",44.90),
("https://www.anime-le.de/detail/index/sArticle/11323",44.90),
("https://www.anime-le.de/detail/index/sArticle/9957/number/SW19933",62.90),
("https://www.anime-le.de/detail/index/sArticle/9201",139.90),
("https://www.anime-le.de/detail/index/sArticle/10572/sCategory/0",209.90),
("https://www.anime-le.de/coming-soon/4322/attack-on-titan-artfxj-statue-1/7-levi-fortitude-ver.",239.90),
("https://www.anime-le.de/coming-soon/2531/darling-in-the-franxx-pvc-statue-1/7-zero-two-school-uniform-version",279.90),
("https://www.anime-le.de/detail/index/sArticle/11432",299.90),
("https://www.anime-le.de/detail/index/sArticle/10886/sCategory/0",539.90),
("https://www.anime-le.de/detail/index/sArticle/8756",36.90),
("https://www.anime-le.de/detail/index/sArticle/10578",34.90),
("https://www.anime-le.de/detail/index/sArticle/8023",34.90),
("https://www.anime-le.de/detail/index/sArticle/9062",32.90),
("https://www.anime-le.de/detail/index/sArticle/9212",109.90),
("https://www.anime-le.de/detail/index/sArticle/11326/number/SW21300",359.90),
("https://www.anime-le.de/detail/index/sArticle/10766",389.90),
("https://www.anime-le.de/detail/index/sArticle/11695/sCategory/0",49.90),
("https://www.anime-le.de/detail/index/sArticle/6046",44.90),
("https://www.anime-le.de/detail/index/sArticle/11306",409.90),
("https://www.anime-le.de/detail/index/sArticle/11308",249.90),
("https://www.anime-le.de/detail/index/sArticle/9381",99.90),
("https://www.anime-le.de/detail/index/sArticle/11305",479.90),
("https://www.anime-le.de/detail/index/sArticle/11466/sCategory/0",219.90);

INSERT INTO figuyaData(link, price) VALUES
("https://figuya.com/de/produkte/tengen-uzui-demon-slayer-pop-up-parade-good-smile-company-37987-de",39.90),
("https://figuya.com/de/produkte/nendoroid-952-zero-two-neuauflage-11950-de",59.90),
("https://figuya.com/de/produkte/inuyasha-inuyasha-the-final-act-pop-up-parade-good-smile-company-32388-de",49.90),
("https://figuya.com/de/produkte/nagito-komaeda-danganronpa-pop-up-parade-good-smile-parade-36718-de",39.90),
("https://figuya.com/de/produkte/nendoroid-1636-kakashi-hatake-anbu-black-ops-34264-de",59.90),
("https://figuya.com/de/produkte/satoru-gojo-bonus-edition-artfx-j-kotobukiya-32901-de",119.90),
("https://figuya.com/de/produkte/shoto-todoroki-artfx-j-ver-2-bonus-edition-kotobukiya-35017-de",189.90),
("https://figuya.com/de/produkte/levi-fortitude-version-attack-on-titan-artfx-j-neuauflage-18485-de",199.90),
("https://figuya.com/de/produkte/zero-two-uniform-version-aniplex-neuauflage-14628-de",269.90),
("https://figuya.com/de/produkte/tengen-uzui-aniplex-revolve-36944-de",289.90),
("https://figuya.com/de/produkte/rimuru-tempest-po-jun-ver-tensei-shitara-slime-datta-ken-shibuya-scramble-figure-estream-35938-de",519.90),
("https://figuya.com/de/produkte/ken-ryuguji-tokyo-revengers-banpresto-neuauflage-02-38536-de",32.90),
("https://figuya.com/de/produkte/mikey-majiro-sano-tokyo-revengers-banpresto-neuauflage-38522-de",32.90),
("https://figuya.com/de/produkte/boa-hancock-lady-fight-banpresto-30898-de",32.90),
("https://figuya.com/de/produkte/hao-asakura-shaman-king-banpresto-32649-de",32.90),
("https://figuya.com/de/produkte/figma-529-usada-pekora-33049-de",94.90),
("https://figuya.com/de/produkte/black-rock-shooter-hxxg-edition-max-factory-36721-de",359.90),
("https://figuya.com/de/produkte/houshou-marine-hololive-max-factory-35655-de",389.90),
("https://figuya.com/de/produkte/sakura-miko-hololive-pop-up-parade-max-factory-37688-de",49.90),
("https://figuya.com/de/produkte/megumin-konosuba-pop-up-parade-max-factory-neuauflage-21854-de",39.90),
("https://figuya.com/de/produkte/sakura-haruno-naruto-gals-dx-version-3-megahouse-36389-de",429.90),
("https://figuya.com/de/produkte/arsene-anniversary-edition-game-characters-collection-dx-megahouse-36482-de",159.90),
("https://figuya.com/de/produkte/wizardmon-und-gatomon-g-e-m-serie-megahouse-neuauflage-5895-de",99.90),
("https://figuya.com/de/produkte/itachi-uchiha-susanoo-precious-g-e-m-megahouse-36379-de",499.90),
("https://figuya.com/de/produkte/rei-ayanami-thrice-upon-a-time-precious-g-e-m-series-megahouse-36991-de",249.90);

/*wird noch verändert!!!: AnimeName, Company und evtl character wird auf IDs geändert+ KommentarIDs kommt noch dazu*/
INSERT INTO figurines(figurineName, picture,isbn,origin,characterName,company,classification,dimension,material,releaseDate,originalPriceYen,allBlueID,mangaMafiaID,animeLeID,figuyaID) VALUES
("Demon Slayer - Uzui Tengen - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1087573.jpg","4580416945110","Demon Slayer: Kimetsu no Yaiba","Uzui Tengen","Good Smile Company","Pop Up Parade","Height=180mm","ABS, PVC"," 08/2022",3545,1,1,1,1),
("Darling in the Franxx - Zero Two - Nendoroid #952","https://static.myfigurecollection.net/upload/items/large/675280.jpg","4580590124585","Darling in the FranXX","Zero Two","Good Smile Company","Nendroid","Height=100mm","ABS, PVC","12/2018",4818,2,2,2,2),
("Inuyasha - Inuyasha Statue - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1209165.jpg","4580416943215","InuYasha: Sengoku Otogizoushi","InuYasha","Good Smile Company","Pop Up Parade","Height=170mm","ABS, PVC","10/2021",3545,3,3,3,3),
("Danganronpa - Komaeda Nagito - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1211232.jpg","4580416944731","Danganronpa ½ Reload","Komaeda Nagito","Good Smile Company","Pop Up Parade","Height=170mm","ABS, PVC","05/2022",3545,4,4,4,4),
("Naruto Shippuden - Kakashi Hatake Anbu Black Ops Version - Nendoroid #1636","https://static.myfigurecollection.net/upload/items/large/1304291.jpg","4580590125322","Naruto Shippuuden","Hatake Kakashi","Good Smile Company","Nendroid","Height=100mm","ABS, PVC","06/2022",5182,5,5,5,5),
("Jujutsu Kaisen - Gojou Satoru - ARTFX J","https://static.myfigurecollection.net/upload/items/large/1038873.jpg","4934054026876","Jujutsu Kaisen","Gojou Satoru","Kotobukiya","ARTFX J","⅛ Height=255mm","ABS, PVC, Acrylic","05/2022",10819,6,6,6,6),
("My Hero Academia - Todoroki Shouto Statue Version 2 - ARTFXJ ","https://static.myfigurecollection.net/upload/items/large/1166434.jpg","4934054034918","My Hero Academia: Boku No Hero Academia","Todoroki Shouto","Kotobukiya","ARTFX J","⅛ Height=262mm"," ABS, PVC","06/2022",15000,7,7,7,7),
("Attack on Titan - Levi Statue fortitude Version - ARTFXJ","https://static.myfigurecollection.net/upload/items/large/919608.jpg","4934054016945","Attack on Titan: Shingeki no Kyojin","Levi Ackerman","Kotobukiya","ARTFX J","1/7 Height= 171mm","ABS, PVC","06/2020",14800,8,8,8,8),
("Darling in the FranXX - Zero Two Uniform ver. - Aniplex","https://static.myfigurecollection.net/upload/items/large/675949.jpg","4534530853011","Darling in the FranXX","Zero Two","Aniplex","/","1/7 Height=288mm","ABS, PVC","12/2019",17200,9,9,9,9),
("Demon Slayer - Uzui Tengen Statue - Aniplex","https://static.myfigurecollection.net/upload/items/large/1359351.jpg","4534530741585","Demon Slayer: Kimetsu no Yaiba","Uzui Tengen","Aniplex","/","⅛ Height= 280mm","ABS, PVC","03/2023",18000,10,10,10,10),
("That Time I Got Reincarnated as a Slime - Rimuru Tempest Statue Hagun Version - eStream","https://static.myfigurecollection.net/upload/items/large/1328648.jpg","4580769940114","That Time I Got Reincarnated as a Slime: Tensei shitara Slime Datta Ken","Rimuru Tempest","eStream","Shibuya Scramble Figure","1/7 Height= 271mm Width=271mm Length=201mm","PVC","11/2022",31800,11,11,11,11),
("Tokyo Revengers - Ryuuguuji Ken/ Draken - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1167949.jpg","4983164177299","Tokyo Revengers","Ryuuguuji Ken/ Draken","Bandai / Banpresto","Bandai Spirits","Height= 180mm","ABS, PVC","08/2021",1800,12,12,12,12),
("Tokyo Revengers - Sano Manjirou/ Mikey - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1176171.jpg","4983164176155","Tokyo Revengers","Sano Manjirou / Mikey","Bandai / Banpresto","Bandai Spirits","Height= 160mm","ABS, PVC","07/2021",1800,13,13,13,13),
("One Piece - Boa Hancock Lady Fight Version - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1156565.jpg","4983164177619","One Piece","Boa Hancock","Bandai / Banpresto","Bandai Spirits","⅛ Height= 200mm","ABS, PVC","08/2021",1800,14,14,14,14),
("Shaman King - Asakura Hao - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1184621.jpg","4054058046554","Shaman King","Asakura Hao","Bandai / Banpresto","Bandai Spirits","⅛ Height= 140mm","ABS, PVC","10/2021",1800,15,15,15,15),
("Hololive - Usada Pekora - Figma #529","https://static.myfigurecollection.net/upload/items/large/1131756.jpg","4545784067611","Hololive","Usada Pekora","Max Factory","Figma","Height= 135mm","ABS, PVC","06/2022",8000,16,16,16,16),
("Black Rock Shooter - Black Rock Shooter - HxxG Edition","https://static.myfigurecollection.net/upload/pictures/2022/01/25/2984013.jpeg","4545784043219","Black Rock Shooter","Black Rock Shooter","Max Factory","/","1/7 Height= 300mm Length=360mm","ABS, PVC","08/2023",25000,17,17,17,17),
("Hololive - Houshou Marine - 1/7","https://static.myfigurecollection.net/upload/items/large/1131751.jpg","4545784043172","Hololive","Houshou Marine","Max Factory","/","1/7 Height= 245mm","ABS, PVC","12/2022",27091,18,18,18,18),
("Hololive - Sakura Miko - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1213441.jpg","4545784043288","Hololive","Sakura Miko","Max Factory","Pop Up Parade","Height= 170mm","ABS, PVC","08/2022",4455,19,19,19,19),
("KonoSuba - Megumin Statue - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/945888.jpg","4545784042915","KonoSuba: Eiga Kono Subarashii Sekai ni Shukufuku o! Kurenai Densetsu","Megumin","Max Factory","Pop Up Parade","Height= 175mm","ABS, PVC","12/2020",3545,20,20,20,20),
("Naruto Shippuuden - Haruno Sakura Version 3 - Naruto Gals DX","https://static.myfigurecollection.net/upload/items/large/1394911.jpg","4535123833045","Naruto Shippuuden","Haruno Sakura","MegaHouse","Naruto Gals DX","Height= 270mm Width=280mm","ABS, PVC","12/2022",28000,21,21,21,21),
("Persona 5 - Arsene Anniversary Edition - Game Characters Collection DX","https://static.myfigurecollection.net/upload/items/large/1394949.jpg","4535123832994","Persona 5","Arsène","MegaHouse","Game Characters Collection DX","Height= 280mm Width=270mm","ABS, PVC","07/2022",17000,22,22,22,22),
("Digimon Adventure - Wizardmon & Gatomon - G.E.M.","https://static.myfigurecollection.net/upload/items/large/362389.jpg","4535123831041","Digimon Adventure","Wizardmon, Tailmon","MegaHouse","G.E.M","Height= 145mm","ABS, PVC","05/2016",6800,23,23,23,23),
("Naruto Shippuden - Uchiha Itachi Susano Version - Precious G.E.M.","https://static.myfigurecollection.net/upload/items/large/1392334.jpg","4535123832598","Naruto Shippuuden","Uchiha Itachi","MegaHouse","Precious G.E.M.","Height= 380mm Width=350mm Length=280mm","ABS, PVC, LED","08/2022",37500,24,24,24,24),
("Evangelion: Thrice Upon a Time - Rei Ayanami Statue - Precious G.E.M.","https://static.myfigurecollection.net/upload/items/large/1394910.jpg","4535123833441","Evangelion","Ayanami Rei","MegaHouse","Precious G.E.M.","Height= 225mm","ABS, PVC","09/2022",15800,25,25,25,25);
