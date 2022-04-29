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

CREATE TABLE figurines (
    fid INTEGER PRIMARY KEY AUTOINCREMENT,
    figurineName TEXT NOT NULL,
    picture TEXT NOT NULL,
    isbn TEXT NOT NULL,
    origin TEXT NOT NULL,
    characterName TEXT NOT NULL,
    classification TEXT,
    company TEXT NOT NULL,
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
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00);

INSERT INTO animeLeData(link, price) VALUES
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00);

INSERT INTO figuyaData(link, price) VALUES
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00),
("",0.00);