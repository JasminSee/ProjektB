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

CREATE TABLE series (
    seriesID INTEGER PRIMARY KEY AUTOINCREMENT,
    seriesName TEXT NOT NULL,
    altName TEXT,
    icon TEXT,
    seriesType TEXT,
    release TEXT,
    sDescription TEXT,
);

CREATE TABLE companies (
    companyID INTEGER PRIMARY KEY AUTOINCREMENT,
    companyName TEXT NOT NULL,
    banner TEXT NOT NULL,
    link TEXT
);

CREATE TABLE figurines (
    fid INTEGER PRIMARY KEY AUTOINCREMENT,
    figurineName TEXT NOT NULL,
    picture TEXT NOT NULL,
    isbn TEXT NOT NULL,
    origin INTEGER,
    characterName TEXT NOT NULL,
    company INTEGER,
    classification TEXT,
    dimension TEXT,
    material TEXT NOT NULL,
    releaseDate TEXT,
    originalPriceYen INTEGER,
    allBlueID INTEGER,
    mangaMafiaID INTEGER,
    animeLeID INTEGER,
    figuyaID INTEGER,
    FOREIGN KEY (origin) REFERENCES series(seriesID),
    FOREIGN KEY (company) REFERENCES companies(companyID),
    FOREIGN KEY (allBlueID) REFERENCES allBlueData(id),
    FOREIGN KEY (mangaMafiaID) REFERENCES mangaMafiaData(id),
    FOREIGN KEY (animeLeID) REFERENCES animeLeData(id),
    FOREIGN KEY (figuyaID) REFERENCES figuyaData(id)
);

INSERT INTO companies(companyName, banner, link) VALUES
("Good Smile Company","https://cf.goodsmile.jp/GSCSite/gsc_logo.png", "https://www.goodsmile.info/en/"),
("Kotobukiya","https://en.kotobukiya.co.jp/wp-content/themes/kotobukiya/images/logo.png", "https://en.kotobukiya.co.jp/"),
("Aniplex","https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Aniplex_logo.svg/430px-Aniplex_logo.svg.png","https://www.aniplex.co.jp/"),
("eStream","https://www.estream.co.jp/wp-content/themes/df_estream/images/common/img_header_logo.png?ver=20210521","https://www.estream.co.jp/"),
("Bandai / Banpresto","https://www.banpresto.jp/img/ico-logo.png","https://www.banpresto.jp/"),
("Max Factory","https://images.goodsmile.info/media/mxf_logo-69d28fa57d11c2fa5f5deac7fbdf2d3b.jpg","https://www.maxfactory.jp/en/mxf/"),
("MegaHouse", "https://cdn.shopify.com/s/files/1/1843/8169/t/7/assets/logo.svg?v=12938583478828802353","https://en.megahobby.jp/");

INSERT INTO series(seriesName,altName,icon,seriesType,release,sDescription) VALUES
("Demon Slayer", "鬼滅の刃 / Kimetsu no Yaiba","https://d2y6mqrpjbqoe6.cloudfront.net/image/upload/f_auto,q_auto/media/library-400/28_637635175735318571DS-DE_Small_hq.jpg", "TV-Serie","06.04.2019 - 28.09.2019","Japan in der Taishō-Ära (1912-1926). Viel passiert nicht im Leben des gutherzigen Jungen Tanjirō, seinen friedlichen Alltag verbringt er damit Kohle zu verkaufen. Doch plötzlich verändert eine Tragödie alles: Ein blutrünstiger Teufel tötet seine gesamte Familie. Die einzige Überlebende, seine kleine Schwester Nezuko, verwandelt sich jedoch selbst auch in einen gewalttätigen Teufel. Um einen Weg zu finden Nezuko zurückzuverwandeln und Rache für ihre Familie zu nehmen, brechen die beiden zu einer langen Reise auf. Seid gespannt auf ein Abenteuer voller blutiger Kämpfe, Schwertkämpfer und Teufel aus der Feder eines Genies!"),
("Darling in the FranXX", "ダーリン・イン・ザ・フランキス / Dārin In Za Furankisu","https://static.wikia.nocookie.net/darling-in-the-franxx/images/2/27/Kv04.jpg/revision/latest/scale-to-width-down/350?cb=20171209072941", "TV-Serie","13.01.2018 - 07.07.2018","Sie träumen davon, durch den freien, weiten Himmel zu fliegen – ein Traum, von dem sie wissen, dass er niemals in Erfüllung gehen wird… <br>In einer fernen Zukunft, in der die Erde weitgehend zerstört und ein Großteil der menschlichen Zivilisation ausgelöscht wurde, errichteten die wenigen Überlebenden wandelnde Festungsstädte – die „Plantations“ –, um sich selbst und die wenigen Reste der Zivilisation am Leben zu halten. Die Kinder der Bewohner leben in einer Trainingseinrichtung, die weithin als „Vogelkäfig“ bekannt ist. Ohne je mit der Außenwelt in Berührung gekommen zu sein, werden sie dort für den Kampf gegen die mysteriösen Lebensformen ausgebildet, die die Menschheit so dezimierten. So lernen die Kinder, wie man die riesigen Roboter, die „Franxx“, steuert und wie man in ihnen kämpft – denn nur Pilot eines „Franxx“ zu sein, ist ein Beweis für die eigene Existenz. <br>Code-Nummer 016 – Hiro – wurde einst als Wunderkind angesehen, doch als er mit seinen Kameraden nicht mehr mithalten konnte und es ihm nicht mehr möglich war, einen „Franxx“ zu steuern, verlor seine Existenz jegliche Bedeutung … schließlich ist es fast dasselbe als würde er gar nicht existieren. Eines Tages jedoch erscheint ein mysteriöses Mädchen vor ihm. Zero Two, so ihr Name, schaut ihn mit vertrautem Blick an und während Lichtreflexe mit den zwei glänzenden Hörnern auf ihrer Stirn spielen, sagt sie: „Ich habe dich gefunden, mein Darling.“"),
("InuYasha","犬夜叉","https://cdn.anisearch.de/images/anime/cover/full/2/2581.webp", "TV-Serie","16.10.2000 - 13.09.2004","Vor einigen Jahrhunderten, zur Zeit des feudalen Japans, entwendete der Halbdämon Inu Yasha das Shikon-Juwel, auch bekannt als das Juwel der vier Seelen. Diesem Juwel sagt man nach, die Kräfte seines Besitzers enorm zu steigern. Doch seine Freude währt nicht lang, denn die Priesterin Kikyou schafft es trotz schwerer Verletzungen, Inu Yasha an einen besonderen Baum namens Goshinboku zu binden, ihn in ewigen Schlaf zu versetzen und das Juwel an sich zu nehmen. <br>In der Neuzeit versucht der Großvater von Kagome Higurashi, ihr eben diese Geschichte zu erzählen, dabei hat sie an solchen Dingen doch praktisch kein Interesse. Das Schicksal scheint jedoch ein launischen Wesen zu sein: Als Kagome am folgenden Morgen – an ihrem 15. Geburtstag – auf der Suche nach ihrem Kater in einen sagenumwobenen Brunnen steigen muss, verschlägt sie es prompt in eben jene Epoche aus der Geschichte ihres Großvaters. <br>Und die Ereignisse überschlagen sich: Ausgerechnet Kagome trägt das Shikon-Juwel in sich, muss in höchster Not Inu Yasha befreien und ist wenig später dafür verantwortlich, dass das Juwel in hunderte Splitter zerspringt. Zu allem Übel soll sich sie auch noch um deren Wiederbeschaffung kümmern, denkt aber gar nicht daran und schafft es sogar, in ihre Zeit zurückzukehren. Doch bald muss Kagome feststellen, dass sie ihrem Schicksal nicht einfach so entgehen kann und begibt sich letztendlich mit Inu Yasha auf die Suche nach den Juwelensplittern."),
("Danganronpa: Kibou no Gakuen to Zetsubou no Koukousei", "ダンガンロンパ 希望の学園と絶望の高校生 / Danganronpa: Kibō no Gakuen to Zetsubō no Kōkōsei", "https://cdn.anisearch.de/images/anime/cover/full/8/8222.webp", "TV-Serie","05.07.2013 - 27.09.2013","Eine Gruppe von 15 Elite High School Schülern hat sich zu einer besonderen Informationsstunde in einer High School versammelt. Wer diese High School abschließt, wird im Leben erfolgreich sein, was bei dieser Schule allerdings nur schwer zu erreichen ist. Der Direktor dieser Schule ist ein Bär namens Monokuma, der den Schülern erklärt, dass sie jemanden umbringen müssen, um diese spezielle Schule abschließen zu können. Der einzige Weg, dieses Ziel zu erreichen, ist, einen Klassenkameraden unbemerkt umzubringen. Wenn andere Mitschüler den Mörder allerdings fassen können, wird der Mörder der einzige sein, der stirbt. Wenn die Schüler allerdings daran scheitern, den Mörder zu finden, werden sie auch sterben und nur der Mörder wird seinen Abschluss bekommen. Welcher von den 15 Schülern wird dieses Blutbad überleben?"),
("Naruto Shippuuden", "Naruto Shippūden / ナルト:疾風伝", "https://cdn.anisearch.de/images/anime/cover/full/3/3972.webp", "TV-Serie", "15.02.2007 - 23.03.2017","Zweieinhalb Jahre sind vergangen seit Naruto mit Jiraiya zusammen Konoha verließ, um zu trainieren. Da die Gruppe der Akatsuki allmählich aktiv wird und es nur eine Frage der Zeit ist, bis sie Naruto angreifen, kehren beide ins Dorf zurück. Den Blick immer Richtung Orochimaru und Sasuke gerichtet, planen Kakashi, Sakura und Naruto als „Team Kakashi“ ihre weitere Vorgehensweise. Doch die drohende Gefahr lässt nicht lange auf sich warten und die Akatsuki überfallen den „Hidden Sand“ mit dem Kazekage." ),
("Jujutsu Kaisen","呪術廻戦", "https://cdn.anisearch.de/images/anime/cover/full/14/14790.webp","TV-Serie","19.09.2020 - 27.03.2021", "Bitternis, Schuldgefühle, Schmach … In »Jujutsu Kaisen«, der Anime-Adaption des gleichnamigen Mangas aus der Feder Gege Akutamis, können sich solche von Menschen hervorgebrachten negativen Emotionen in Flüche verwandeln, die dann im alltäglichen Leben lauern. Flüche sind der Ursprung allen Unglücks, das in der Welt umgeht, und treiben die Menschen, die sie heimsuchen, im schlimmsten Fall in den Tod. Das einzige Mittel, einen Fluch zu beseitigen, ist die Verwendung weiterer Flüche.<br>Oberschüler Yuuji Itadori ist mit erstaunlichen körperlichen Fähigkeiten gesegnet und wird von den Sportclubs seiner Schule regelrecht gejagt, als er sich im ersten Schuljahr für eine Clubmitgliedschaft entscheiden muss. Seine Wahl fällt jedoch stattdessen auf den Okkultismus-Club, welcher sich mit der Erforschung übernatürlicher Phänomene befasst.<br>Eines Tages ergibt es sich, dass dem Club ein versiegeltes Fluchobjekt in die Hände fällt. In Abwesenheit Yuujis brechen Sasaki und Iguchi, die anderen beiden Clubmitglieder, das Siegel und locken damit weitere Flüche an. Derweil trifft Yuuji auf den Exorzistenlehrling Megumi Fushiguro, der auf der Suche nach dem Fluchobjekt ist. Gemeinsam eilen die beiden zurück zum Schulgelände, wo Megumi jedoch von einem Fluch überwältigt wird. Um ihn und seine Freunde zu retten, trifft Yuuji daraufhin eine folgenschwere Entscheidung …"),
("My Hero Academia","Boku no Hero Academia / 僕のヒーローアカデミア","https://cdn.anisearch.de/images/anime/cover/full/10/10978.webp","TV-Serie","03.04.2016 - 26.06.2016","Izuku Midoriya lebt in einer Welt, in der die Menschheit „Macken“ genannte Superkräfte entwickelt hat. Doch zu seinem Pech besitzt „nur“ ungefähr 80 % der Bevölkerung solch eine Superkraft und Izuku gehört zu den restlichen 20 %, die ohne Macke geboren wurden. Fest entschlossen, seinen Traum ein Held zu werden nicht einfach so aufzugeben, bewirbt er sich dennoch an der U.A. High, einer der höchst angesehenen Heldenschulen aller Zeiten. Diese Schule bildet junge Menschen zu Superhelden aus, um die Ganoven, die sich auf der Welt herumtreiben, aus dem Verkehr zu ziehen und unschädlich zu machen. Glücklicherweise sticht Izuku dann dem größten Helden der Geschichte ins Auge: All Might! Dieser versichert ihm, dass auch er ein Held werden kann und hilft ihm beim Training, damit er bei seiner Wunschschule aufgenommen werden kann."),
("Attack on Titan","Shingeki no Kyojin / 進撃の巨人","https://cdn.anisearch.de/images/anime/cover/full/8/8219.webp","TV-Serie","07.04.2013 - 28.09.2013","Vor einem Jahrhundert wurde die Menschheit nahezu von Titanen, deren Ursprung unbekannt ist, ausgerottet. Sie sind riesig, verfügen über geringe Intelligenz und scheinen Menschen nur des Vergnügens wegen zu fressen. Ein kleiner Teil der Menschheit überlebte, indem sie sich in einer Stadt verschanzten, deren gewaltige Mauern höher sind als selbst die größten Titanen.<br>Seit mehr als 100 Jahren hat der Rest der Menschheit nun keinen Titanen mehr gesehen. Doch an jenem schicksalhaften Tag erscheint wie aus dem Nichts ein „Supertitan“ vor der Stadt und durchbricht die Mauer. Als die Titanen in die Stadt einfallen, müssen Eren und seine Ziehschwester Mikasa mit ansehen, wie ihre Mutter bei lebendigem Leibe gefressen wird. Eren schwört, dass er jeden einzelnen Titanen auf der Welt abschlachten und Rache für die gesamte Menschheit nehmen wird."),
("That Time I Got Reincarnated as a Slime","Tensei Shitara Slime datta Ken / 転生したらスライムだった件","https://cdn.anisearch.de/images/anime/cover/full/13/13436.webp","TV-Serie","02.10.2018 - 19.03.2019","Der 37-jährige Japaner Satoru Mikami ist mit seinem Leben sehr zufrieden. Das einzige, was sein Glück komplettieren würde, wäre eine Freundin. Als er sich mit einem Kollegen und dessen neuer Freundin zum Essen verabredet, läuft ihnen ein Dieb auf der Flucht entgegen. Satoru stellt sich schützend vor seinen Kollegen und wird dabei erstochen. Doch plötzlich hört er eine weibliche Computerstimme und als Satoru das nächste Mal die Augen öffnet, findet er sich in einer Höhle inmitten einer fremden Welt wieder – im Körper eines Schleims! Nach und nach entdeckt er die Vorteile, die das Leben als Schleim mit sich bringt. So besitzt er die Fähigkeit, andere Monster in sich aufzulösen, um so wiederum deren Fähigkeiten zu erlernen. Während seiner Erkundungstour durch die Höhle trifft er schließlich auf den mächtigen Drachen Veldora, der vor Jahrhunderten von einer unbekannten Heldin in der Höhle eingesperrt wurde. Die beiden werden schnell Freunde und Veldora schenkt ihm einen neuen Namen: Rimuru Tempest! Dadurch geht auch ein Teil von Veldoras Kraft auf Rimuru über, der mit dem Versprechen, nach einem Weg zu suchen, um Veldora aus seinem Bann zu befreien, diesen in sich aufnimmt. Als Rimuru der Höhle endlich entkommt, lernt er die Vielfältigkeit der neuen Welt, in der er nun lebt, kennen. Darin existieren Zwerge, Oger, Goblins, Schattenwölfe und viele weitere Kreaturen. Rimuru beschließt, ein eigenes Dorf zu gründen, in dem nach und nach viele verschiedene und einst verfeindete Rassen friedlich miteinander zusammenleben. Eines Tages begegnet Rimuru Shizue Izawa, die ebenfalls aus Japan stammt und als Kind von einem Dämonenkönig in diese fremde Welt beschworen wurde. Rimuru ahnt dabei noch nicht, dass das Zusammentreffen der beiden auf sein Schicksal erheblichen Einfluss nehmen wird."),
("Tokyo Revengers", "東京リベンジャーズ","https://cdn.anisearch.de/images/anime/cover/full/15/15335.webp","TV-Serie","11.04.2021 - 19.09.2021","Takemichi Hanagaki ist am Tiefpunkt seines Lebens angelangt. Als wäre das nicht schlimm genug für ihn, erfährt er, dass seine Ex-Freundin Hinata Tachibana, seine einzige Freundin aus der Mittelschule, von der Tokyo Manji Gang ermordet wurde. Am nächsten Tag wird er plötzlich von einem Bahnsteig gestoßen und erwacht zu seinem Erstaunen als Mittelschüler. Nachdem ihm klar wird, dass er zwölf Jahre in die Vergangenheit gereist ist, sieht er eine Chance, die Tokyo Manji Gang zu infiltrieren, um Hinata vor ihrem tragischen Schicksal zu bewahren."),
("One Piece", "ワンピース","https://cdn.anisearch.de/images/anime/cover/full/2/2227.webp", "TV-Serie","20.10.1999 - ?","Reichtum, Macht und Ruhm. Der Mann, der sich dies alles erkämpft hatte, war Gold Roger, der König der Piraten. Als er hingerichtet wurde, waren seine letzten Worte: „Ihr wollt meinen Schatz? Den könnt ihr haben! Sucht ihn doch! Irgendwo habe ich den größten Schatz der Welt versteckt. Dieser Schatz ist das One Piece und er liegt irgendwo auf der Grandline. Damit brach das große Piratenzeitalter an …“<br>Monkey D. Ruffy ist 17 Jahre alt und hat ein großes Ziel: Er will König der Piraten werden und den Schatz „One Piece“ finden! Ruffy hat besondere Kräfte durch die Teufelsfrucht „GumGum“ erhalten und ist ein Gummimensch. Sein Traum wurde angefeuert durch den Piraten Shanks, der ihm einst das Leben rettete und Ruffy kurz vor seiner Abreise seinen, ihm sehr wichtigen, Strohhut schenkte. Zunächst muss er also eine Mannschaft und ein Schiff finden … Gesagt, getan! Mit dem starken Schwertkämpfer Zorro, dem Lügenbold Usopp, der hübschen Diebin Nami, dem Meisterkoch Sanji und später auch dem Elch Chopper und einigen weiteren Gefährten schafft er sich ein zwar merkwürdiges, doch gelungenes Team. Die nun entstandene „Strohhutbande“ (von Ruffys Strohhut abgeleitet) hat aber viel Ärger mit ihrem durchgeknallten Gummikapitän, doch das ist längst nicht das einzige Problem, denn viele Fieslinge stellen sich der Bande in den Weg. Da wären zum Beispiel Käpt’n Black, der Usopps Dorf vernichten will, Arlong, der Schuld an Namis düsterer Vergangenheit ist, aber auch die Marine wird sehr schnell aktiv und will die Strohhutbande schnappen …"),
("Shaman King","シャーマンキング","https://cdn.anisearch.de/images/anime/cover/full/0/877.webp","TV-Serie","04.07.2001 - 25.09.2002","Alle 500 Jahre findet der große Kampf um den Thron des Schamanenkönigs statt. Schamanen stehen in Verbindung mit den Toten und Geistern und können sich deren Fähigkeiten zu Nutze machen. Der junge Schamane Yo Asakura hat das Ziel, diesen Thron zu besteigen. Dazu müssen er und sein Geist Amidamaru gegen viele gefährliche Gegner antreten und einige schwierige Prüfungen bestehen. Zusammen mit seinen Freunden ist Yo sehr stark, aber ob das ausreichen wird, um die mächtigsten Feinde zu besiegen?"),
("Hololive","","https://custom-images.strikinglycdn.com/res/hrscywv4p/image/upload/c_limit,fl_lossy,h_1440,w_720,f_auto,q_auto/1369026/553937_363426.png","Virtuelles Entertaunment","02.12.2019","Hololive Production ist eine virtuelle Talentagentur bestehend aus virtuellen Youtubern."),
("Black Rock Shooter","ブラック★ロックシューター","https://cdn.anisearch.de/images/anime/cover/full/7/7275.webp","TV-Serie","03.02.2012 - 23.03.2012","Diese alternative Version zu Black Rock Shooter spielt einige Jahre später und Mato Kuroi geht mittlerweile auf die Oberschule. Mit ihrem offenen und freundlichen Auftreten versucht sie auf Anhieb neue Freunde zu gewinnen. Allen voran die schüchterne Mitschülerin Yomi Takanashi, doch deren Freundin Kagari scheint eine tiefe Abneigung gegen Mato zu haben. Das hält das quirlige Mädchen natürlich nicht davon ab, es trotzdem zu versuchen. Währenddessen kämpft Black Rock Shooter in einer Parallelwelt gegen neue Gegner und gegen ihre erbitterte Widersacherin Dead Master."),
("KonoSuba","Kono Subarashī Sekai ni Shukufuku o! / この素晴らしい世界に祝福を！","https://cdn.anisearch.de/images/anime/cover/full/10/10448.webp","TV-Serie","14.01.2016 - 17.03.2016","Kazuma Satou wäre eigentlich bei einem Autounfall gestorben. Doch er wacht wieder auf und findet sich bei einem hübschen Mädchen wieder, das sich selbst als die Göttin Aqua vorstellt. Sie fragt den noch verwirrten Kazuma, ob er lieber in den Himmel gehen oder in einer Fantasy-Welt wiedergeboren werden möchte; der Himmel sei langweilig und es gebe nichts zu tun, doch die Fantasy-Welt müsse von einem schrecklichen Bösewicht befreit werden. Für Letzteres darf er sogar eine Sache mitnehmen: eine Fähigkeit oder übermächtige Waffe, die sein künftiges Abenteurerdasein erleichtern soll. Aber das will wohl überlegt sein, denn in seinem bisherigen Leben war Kazuma ein Hikikomori und ebenso ein Hardcore-Fan von Anime, Manga und Videospielen. Als Aqua nach zu langer Bedenkzeit ungeduldig wird, wählt Kazuma schlussendlich die Göttin selbst und damit startet seine Reise.<br>Jedoch entpuppt sich die Welt als relativ gewöhnlich und so verbringen Kazuma und Aqua ihren Alltag zunächst mit Zeitarbeit und Saufen in der örtlichen Gilde, anstatt mit heroischen Kämpfen gegen das Böse. Doch um diesem tristen Dasein zu entgehen, rekrutieren die beiden weitere starke Abenteurer für ihre Gruppe und schon bald schließen sich die explosionssüchtige Magierin Megumin und die lüsterne Ritterin Darkness der Truppe an."),
("Persona 5","","https://upload.wikimedia.org/wikipedia/en/b/b0/Persona_5_cover_art.jpg","Video-Spiel","15.09.2016","In Persona 5 geht es um die inneren und äußeren Konflikte einer Gruppe von außergewöhnlichen Highschool-Schülern. Sie setzt sich aus dem Protagonisten und einer Reihe von Begleitern zusammen, die er im Laufe der Geschichte kennenlernt und mit denen er ein Doppelleben als sogenannte Phantomdiebe führt. Sie führen auf der einen Seite das übliche Leben normaler Highschool-Schüler in Tokio - Unterricht besuchen, Aktivitäten nach der Schule, Teilzeitjobs. Auf der anderen Seite durchleben sie aber auch fantastische Abenteuer, indem sie mit übersinnlichen Kräften in die Herzen der Menschen eindringen. Diese Kräfte stammen aus der Persona - dem Jung'schen Konzept des -Selbst-. Die Helden des Spiels erkennen, dass die Menschen von der Gesellschaft gezwungen werden, Masken zu tragen, um ihre innere Verwundbarkeit zu schützen. Und indem sich die Helden selbst ihre Schutzmasken buchstäblich herunterreißen und sich ihrem inneren Selbst stellen, erwecken sie ihre immensen inneren Kräfte, die sie dann wiederum einsetzen, um anderen Menschen in Not zu helfen. Das übergeordnete Ziel der Gruppe von Phantomdieben lautet, ihre Alltagswelt an ihre besondere Wahrnehmung anzupassen und die Masken zu durchschauen, die die heutige Gesellschaft trägt."),
("Digimon Adventure","デジモンアドベンチャー","https://cdn.anisearch.de/images/anime/cover/full/14/14907.webp","TV-Serie","07.03.1999 - 26.03.2000","Sieben Kinder, die sich in den Sommerferien in einem Zeltlager treffen, werden Zeuge von seltsamen Wettererscheinungen, welche in einer riesigen Flutwelle gipfeln. Kaum wieder zu sich gekommen, folgt jedem von ihnen ein kleines Wesen. Selbige stellen sich sogleich als „Digitale Monster“, kurz Digimon, vor. Noch bevor sie sich in der fremden Umgebung zurechtfinden können, werden sie auch schon von einem bösartigen Vertreter angegriffen…"),
("Neon Genesis Evangelion","Shinseiki Evangelion / 新世紀エヴァンゲリオン","https://cdn.anisearch.de/images/anime/cover/full/0/345.webp","TV-Serie","04.10.1995 - 27.03.1996","Am 13. September 2000 schlägt ein Meteorit in der Antarktis ein. Die Polkappen schmelzen und es folgen Fluten, Elend, Unruhen und Bürgerkriege, denen die Hälfte der Weltbevölkerung zum Opfer fällt.<br>15 Jahre später wird der 14-jährige Shinji Ikari von seinem Vater Gendou, nach über drei Jahren Abwesenheit, zu sich gerufen. Glücklich darüber, Anerkennung zu finden und in Selbstzweifel, ob er die an ihn gestellten Erwartungen erfüllen könne, stellt er bei seiner Ankunft fest, dass Neo Tokyo-3 bedroht wird. Den Mut verliert er, als er erfährt, dass ausgerechnet er in einen von seinem Vater bereitgestellten Mecha, genannt Evangelion, steigen und gegen die feindlich gesinnten „Engel“, welche die Stadt attackieren, kämpfen soll. Schließlich entscheidet sich Shinji dazu, den Evangelion zu steuern und den Kampf gegen die „Engel“ aufzunehmen.");

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

/*wird noch verändert!!!: bewertung + KommentarIDs kommt noch dazu*/
INSERT INTO figurines(figurineName, picture,isbn,origin,characterName,company,classification,dimension,material,releaseDate,originalPriceYen,allBlueID,mangaMafiaID,animeLeID,figuyaID) VALUES
("Demon Slayer - Uzui Tengen - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1087573.jpg","4580416945110",1,"Uzui Tengen",1,"Pop Up Parade","Height=180mm","ABS, PVC"," 08/2022",3545,1,1,1,1),
("Darling in the Franxx - Zero Two - Nendoroid #952","https://static.myfigurecollection.net/upload/items/large/675280.jpg","4580590124585",2,"Zero Two",1,"Nendroid","Height=100mm","ABS, PVC","12/2018",4818,2,2,2,2),
("Inuyasha - Inuyasha Statue - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1209165.jpg","4580416943215",3,"InuYasha",1,"Pop Up Parade","Height=170mm","ABS, PVC","10/2021",3545,3,3,3,3),
("Danganronpa - Komaeda Nagito - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1211232.jpg","4580416944731",4,"Komaeda Nagito",1,"Pop Up Parade","Height=170mm","ABS, PVC","05/2022",3545,4,4,4,4),
("Naruto Shippuden - Kakashi Hatake Anbu Black Ops Version - Nendoroid #1636","https://static.myfigurecollection.net/upload/items/large/1304291.jpg","4580590125322",5,"Hatake Kakashi",1,"Nendroid","Height=100mm","ABS, PVC","06/2022",5182,5,5,5,5),
("Jujutsu Kaisen - Gojou Satoru - ARTFX J","https://static.myfigurecollection.net/upload/items/large/1038873.jpg","4934054026876",6,"Gojou Satoru",2,"ARTFX J","⅛ Height=255mm","ABS, PVC, Acrylic","05/2022",10819,6,6,6,6),
("My Hero Academia - Todoroki Shouto Statue Version 2 - ARTFXJ ","https://static.myfigurecollection.net/upload/items/large/1166434.jpg","4934054034918",7,"Todoroki Shouto",2,"ARTFX J","⅛ Height=262mm"," ABS, PVC","06/2022",15000,7,7,7,7),
("Attack on Titan - Levi Statue fortitude Version - ARTFXJ","https://static.myfigurecollection.net/upload/items/large/919608.jpg","4934054016945",8,"Levi Ackerman",2,"ARTFX J","1/7 Height= 171mm","ABS, PVC","06/2020",14800,8,8,8,8),
("Darling in the FranXX - Zero Two Uniform ver. - Aniplex","https://static.myfigurecollection.net/upload/items/large/675949.jpg","4534530853011",2,"Zero Two",3,"/","1/7 Height=288mm","ABS, PVC","12/2019",17200,9,9,9,9),
("Demon Slayer - Uzui Tengen Statue - Aniplex","https://static.myfigurecollection.net/upload/items/large/1359351.jpg","4534530741585",1,"Uzui Tengen",3,"/","⅛ Height= 280mm","ABS, PVC","03/2023",18000,10,10,10,10),
("That Time I Got Reincarnated as a Slime - Rimuru Tempest Statue Hagun Version - eStream","https://static.myfigurecollection.net/upload/items/large/1328648.jpg","4580769940114",9,"Rimuru Tempest",4,"Shibuya Scramble Figure","1/7 Height= 271mm Width=271mm Length=201mm","PVC","11/2022",31800,11,11,11,11),
("Tokyo Revengers - Ryuuguuji Ken/ Draken - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1167949.jpg","4983164177299",10,"Ryuuguuji Ken/ Draken",5,"Bandai Spirits","Height= 180mm","ABS, PVC","08/2021",1800,12,12,12,12),
("Tokyo Revengers - Sano Manjirou/ Mikey - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1176171.jpg","4983164176155",10,"Sano Manjirou / Mikey",5,"Bandai Spirits","Height= 160mm","ABS, PVC","07/2021",1800,13,13,13,13),
("One Piece - Boa Hancock Lady Fight Version - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1156565.jpg","4983164177619",11,"Boa Hancock",5,"Bandai Spirits","⅛ Height= 200mm","ABS, PVC","08/2021",1800,14,14,14,14),
("Shaman King - Asakura Hao - Bandai Spirits","https://static.myfigurecollection.net/upload/items/large/1184621.jpg","4054058046554",12,"Asakura Hao",5,"Bandai Spirits","⅛ Height= 140mm","ABS, PVC","10/2021",1800,15,15,15,15),
("Hololive - Usada Pekora - Figma #529","https://static.myfigurecollection.net/upload/items/large/1131756.jpg","4545784067611",13,"Usada Pekora",6,"Figma","Height= 135mm","ABS, PVC","06/2022",8000,16,16,16,16),
("Black Rock Shooter - Black Rock Shooter - HxxG Edition","https://static.myfigurecollection.net/upload/pictures/2022/01/25/2984013.jpeg","4545784043219",14,"Black Rock Shooter",6,"/","1/7 Height= 300mm Length=360mm","ABS, PVC","08/2023",25000,17,17,17,17),
("Hololive - Houshou Marine - 1/7","https://static.myfigurecollection.net/upload/items/large/1131751.jpg","4545784043172",13,"Houshou Marine",6,"/","1/7 Height= 245mm","ABS, PVC","12/2022",27091,18,18,18,18),
("Hololive - Sakura Miko - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/1213441.jpg","4545784043288",13,"Sakura Miko",6,"Pop Up Parade","Height= 170mm","ABS, PVC","08/2022",4455,19,19,19,19),
("KonoSuba - Megumin Statue - Pop Up Parade","https://static.myfigurecollection.net/upload/items/large/945888.jpg","4545784042915",15,"Megumin",6,"Pop Up Parade","Height= 175mm","ABS, PVC","12/2020",3545,20,20,20,20),
("Naruto Shippuuden - Haruno Sakura Version 3 - Naruto Gals DX","https://static.myfigurecollection.net/upload/items/large/1394911.jpg","4535123833045",5,"Haruno Sakura",7,"Naruto Gals DX","Height= 270mm Width=280mm","ABS, PVC","12/2022",28000,21,21,21,21),
("Persona 5 - Arsene Anniversary Edition - Game Characters Collection DX","https://static.myfigurecollection.net/upload/items/large/1394949.jpg","4535123832994",16,"Arsène",7,"Game Characters Collection DX","Height= 280mm Width=270mm","ABS, PVC","07/2022",17000,22,22,22,22),
("Digimon Adventure - Wizardmon & Gatomon - G.E.M.","https://static.myfigurecollection.net/upload/items/large/362389.jpg","4535123831041",17,"Wizardmon, Tailmon",7,"G.E.M","Height= 145mm","ABS, PVC","05/2016",6800,23,23,23,23),
("Naruto Shippuden - Uchiha Itachi Susano Version - Precious G.E.M.","https://static.myfigurecollection.net/upload/items/large/1392334.jpg","4535123832598",5,"Uchiha Itachi",7,"Precious G.E.M.","Height= 380mm Width=350mm Length=280mm","ABS, PVC, LED","08/2022",37500,24,24,24,24),
("Evangelion: Thrice Upon a Time - Rei Ayanami Statue - Precious G.E.M.","https://static.myfigurecollection.net/upload/items/large/1394910.jpg","4535123833441",18,"Ayanami Rei",7,"Precious G.E.M.","Height= 225mm","ABS, PVC","09/2022",15800,25,25,25,25);
