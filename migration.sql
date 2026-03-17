USE donation;

-- 1. Panchayat master table (create if not exists)
CREATE TABLE IF NOT EXISTS panchayat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    panchayat_name VARCHAR(100) NOT NULL
);

-- 1b. Add district column if not exists
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='panchayat' AND COLUMN_NAME='district');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE panchayat ADD COLUMN district VARCHAR(100) NOT NULL DEFAULT \'\' AFTER id', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 1c. Drop old unique key on panchayat_name only (if exists), add new composite unique key
SET @idx_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='panchayat' AND INDEX_NAME='panchayat_name');
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE panchayat DROP INDEX panchayat_name', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @idx2_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='panchayat' AND INDEX_NAME='unique_district_panchayat');
SET @sql = IF(@idx2_exists = 0, 'ALTER TABLE panchayat ADD UNIQUE KEY unique_district_panchayat (district, panchayat_name)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2. Remove old sample/hardcoded panchayat data (only those not linked to other tables)
DELETE p FROM panchayat p
  LEFT JOIN donor_reg d ON d.panchayat_id = p.id
  LEFT JOIN charity_reg c ON c.panchayat_id = p.id
  LEFT JOIN admin_reg a ON a.panchayat_id = p.id
  LEFT JOIN campaign ca ON ca.panchayat_id = p.id
  LEFT JOIN `transaction` t ON t.panchayat_id = p.id
WHERE p.panchayat_name LIKE 'Panchayat %'
  AND d.id IS NULL AND c.id IS NULL AND a.id IS NULL AND ca.id IS NULL AND t.id IS NULL;

-- 2b. Update old linked sample panchayats with a district so they don't break
UPDATE panchayat SET district = 'Unknown' WHERE district = '' AND panchayat_name LIKE 'Panchayat %';

-- 3. Insert real Kerala panchayat data
INSERT IGNORE INTO panchayat (district, panchayat_name) VALUES
('Thiruvananthapuram','Anad'),('Thiruvananthapuram','Anchuthengu'),('Thiruvananthapuram','Aryanad'),('Thiruvananthapuram','Athiyannur'),('Thiruvananthapuram','Azhoor'),('Thiruvananthapuram','Chemmaruthy'),('Thiruvananthapuram','Chirayinkeezhu'),('Thiruvananthapuram','Edava'),('Thiruvananthapuram','Elakamon'),('Thiruvananthapuram','Kadinamkulam'),('Thiruvananthapuram','Kallara'),('Thiruvananthapuram','Kallikkad'),('Thiruvananthapuram','Kanjiramkulam'),('Thiruvananthapuram','Karavaram'),('Thiruvananthapuram','Karumkulam'),('Thiruvananthapuram','Keezharoor'),('Thiruvananthapuram','Kilimanoor'),('Thiruvananthapuram','Kizhuvilam'),('Thiruvananthapuram','Kottukal'),('Thiruvananthapuram','Kovalam'),('Thiruvananthapuram','Kunnathukal'),('Thiruvananthapuram','Madavoor'),('Thiruvananthapuram','Manamboor'),('Thiruvananthapuram','Manickal'),('Thiruvananthapuram','Maranalloor'),('Thiruvananthapuram','Mudakkal'),('Thiruvananthapuram','Nagaroor'),('Thiruvananthapuram','Navaikulam'),('Thiruvananthapuram','Nellanad'),('Thiruvananthapuram','Ottoor'),('Thiruvananthapuram','Pallickal'),('Thiruvananthapuram','Panavoor'),('Thiruvananthapuram','Perumkadavila'),('Thiruvananthapuram','Pullampara'),('Thiruvananthapuram','Thirupuram'),('Thiruvananthapuram','Tholikkode'),('Thiruvananthapuram','Uzhamalakkal'),('Thiruvananthapuram','Vakkom'),('Thiruvananthapuram','Vamanapuram'),('Thiruvananthapuram','Vellarada'),('Thiruvananthapuram','Vembayam'),('Thiruvananthapuram','Venganoor'),('Thiruvananthapuram','Vilappil'),('Thiruvananthapuram','Vilavoorkal'),
('Kollam','Alayamon'),('Kollam','Anchal'),('Kollam','Ariencavu'),('Kollam','Chadayamangalam'),('Kollam','Chithara'),('Kollam','Clappana'),('Kollam','Elampalloor'),('Kollam','Ezhukone'),('Kollam','Ittiva'),('Kollam','Kadakkal'),('Kollam','Kalluvathukkal'),('Kollam','Karavaloor'),('Kollam','Kulakkada'),('Kollam','Kummil'),('Kollam','Mylom'),('Kollam','Mayyanad'),('Kollam','Melila'),('Kollam','Mukhathala'),('Kollam','Mundrothuruthu'),('Kollam','Neduvathur'),('Kollam','Nilamel'),('Kollam','Oachira'),('Kollam','Odanavattom'),('Kollam','Panayam'),('Kollam','Pavithreswaram'),('Kollam','Perinad'),('Kollam','Perumon'),('Kollam','Pooyappally'),('Kollam','Poruvazhy'),('Kollam','Sasthamcotta'),('Kollam','Sooranad North'),('Kollam','Sooranad South'),('Kollam','Thekkumbhagom'),('Kollam','Thevalakkara'),('Kollam','Thodiyoor'),('Kollam','Thrikkaruva'),('Kollam','Thrikkovilvattom'),('Kollam','Ummannoor'),('Kollam','Velinalloor'),('Kollam','West Kallada'),
('Pathanamthitta','Anicadu'),('Pathanamthitta','Aranmula'),('Pathanamthitta','Ayiroor'),('Pathanamthitta','Chenneerkara'),('Pathanamthitta','Chittar'),('Pathanamthitta','Elanthur'),('Pathanamthitta','Ezhamkulam'),('Pathanamthitta','Kadampanad'),('Pathanamthitta','Kalanjoor'),('Pathanamthitta','Kallooppara'),('Pathanamthitta','Kaviyoor'),('Pathanamthitta','Kodumon'),('Pathanamthitta','Kottangal'),('Pathanamthitta','Kozhencherry'),('Pathanamthitta','Kulanada'),('Pathanamthitta','Kunnamthanam'),('Pathanamthitta','Kuttoor'),('Pathanamthitta','Malayalappuzha'),('Pathanamthitta','Mallappally'),('Pathanamthitta','Mezhuveli'),('Pathanamthitta','Naranammoozhi'),('Pathanamthitta','Naranganam'),('Pathanamthitta','Nedumon'),('Pathanamthitta','Niranam'),('Pathanamthitta','Omalloor'),('Pathanamthitta','Pandalam Thekkekara'),('Pathanamthitta','Peringara'),('Pathanamthitta','Ranni Angadi'),('Pathanamthitta','Ranni Pazhavangadi'),('Pathanamthitta','Seethathode'),('Pathanamthitta','Thannithode'),('Pathanamthitta','Thottapuzhassery'),('Pathanamthitta','Thumpamon'),('Pathanamthitta','Vadasserikkara'),('Pathanamthitta','Vallicode'),('Pathanamthitta','Vechoochira'),
('Alappuzha','Arookutty'),('Alappuzha','Aryad'),('Alappuzha','Champakulam'),('Alappuzha','Chennamkary'),('Alappuzha','Cheppad'),('Alappuzha','Chingoli'),('Alappuzha','Devikulangara'),('Alappuzha','Edathua'),('Alappuzha','Ezhupunna'),('Alappuzha','Kainakary'),('Alappuzha','Kanjikuzhy'),('Alappuzha','Karuvatta'),('Alappuzha','Kodamthuruthu'),('Alappuzha','Kokkothamangalam'),('Alappuzha','Krishnapuram'),('Alappuzha','Kumarapuram'),('Alappuzha','Mannanchery'),('Alappuzha','Mararikulam North'),('Alappuzha','Mararikulam South'),('Alappuzha','Muhamma'),('Alappuzha','Muthukulam'),('Alappuzha','Nedumudi'),('Alappuzha','Neelamperoor'),('Alappuzha','Nooranad'),('Alappuzha','Pallippad'),('Alappuzha','Pandanad'),('Alappuzha','Pathiyoor'),('Alappuzha','Perumbalam'),('Alappuzha','Pulinkunnu'),('Alappuzha','Purakkad'),('Alappuzha','Ramankary'),('Alappuzha','Thakazhi'),('Alappuzha','Thalavady'),('Alappuzha','Thanneermukkom'),('Alappuzha','Thiruvanvandoor'),('Alappuzha','Thrikkunnapuzha'),('Alappuzha','Veeyapuram'),('Alappuzha','Veliyanad'),
('Kottayam','Aimanam'),('Kottayam','Akalakunnam'),('Kottayam','Arpookara'),('Kottayam','Ayarkunnam'),('Kottayam','Bharananganam'),('Kottayam','Chempu'),('Kottayam','Chirakkadavu'),('Kottayam','Kadaplamattom'),('Kottayam','Kaduthuruthy'),('Kottayam','Kallara'),('Kottayam','Kanjirappally'),('Kottayam','Karoor'),('Kottayam','Karukachal'),('Kottayam','Kooroppada'),('Kottayam','Kumarakom'),('Kottayam','Kuravilangad'),('Kottayam','Madappally'),('Kottayam','Manarcad'),('Kottayam','Marangattupilly'),('Kottayam','Melukavu'),('Kottayam','Mundakayam'),('Kottayam','Nedumkunnam'),('Kottayam','Neendoor'),('Kottayam','Paippad'),('Kottayam','Pampady'),('Kottayam','Panachikkad'),('Kottayam','Parathodu'),('Kottayam','Peruva'),('Kottayam','Poonjar'),('Kottayam','Puthuppally'),('Kottayam','Ramapuram'),('Kottayam','Teekoy'),('Kottayam','Thalayazham'),('Kottayam','Thalayolaparambu'),('Kottayam','Udayanapuram'),('Kottayam','Vakathanam'),('Kottayam','Veliyannoor'),('Kottayam','Velloor'),('Kottayam','Vijayapuram'),
('Idukki','Adimali'),('Idukki','Ayyappancoil'),('Idukki','Bison Valley'),('Idukki','Chakkupallam'),('Idukki','Chathurangapara'),('Idukki','Edamalakudy'),('Idukki','Elappara'),('Idukki','Kanchiyar'),('Idukki','Kanjikuzhy'),('Idukki','Karimannoor'),('Idukki','Karunapuram'),('Idukki','Kodikulam'),('Idukki','Kokkayar'),('Idukki','Konnathady'),('Idukki','Kudayathoor'),('Idukki','Kumaramangalam'),('Idukki','Mankulam'),('Idukki','Marayoor'),('Idukki','Pallivasal'),('Idukki','Rajakkad'),('Idukki','Rajakumari'),('Idukki','Santhanpara'),('Idukki','Senapathy'),('Idukki','Upputhara'),('Idukki','Vandiperiyar'),('Idukki','Vattavada'),('Idukki','Vazhathope'),
('Ernakulam','Aikkaranad'),('Ernakulam','Alangad'),('Ernakulam','Avoly'),('Ernakulam','Ayavana'),('Ernakulam','Chendamangalam'),('Ernakulam','Chengamanad'),('Ernakulam','Chellanam'),('Ernakulam','Choornikkara'),('Ernakulam','Edakkattuvayal'),('Ernakulam','Edathala'),('Ernakulam','Elanji'),('Ernakulam','Kadamakudy'),('Ernakulam','Kadungalloor'),('Ernakulam','Kalloorkad'),('Ernakulam','Karimalloor'),('Ernakulam','Karukutty'),('Ernakulam','Kizhakkambalam'),('Ernakulam','Kottuvally'),('Ernakulam','Kumbalam'),('Ernakulam','Kumbalangi'),('Ernakulam','Kunnukara'),('Ernakulam','Kuttampuzha'),('Ernakulam','Malayattoor-Neeleswaram'),('Ernakulam','Manjapra'),('Ernakulam','Mazhuvannoor'),('Ernakulam','Mookkannoor'),('Ernakulam','Mudakuzha'),('Ernakulam','Mulanthuruthy'),('Ernakulam','Mulavukad'),('Ernakulam','Nedumbassery'),('Ernakulam','Nellikuzhi'),('Ernakulam','Okkal'),('Ernakulam','Pallarimangalam'),('Ernakulam','Pallippuram'),('Ernakulam','Parakkadavu'),('Ernakulam','Pindimana'),('Ernakulam','Pothanikkad'),('Ernakulam','Puthenvelikkara'),('Ernakulam','Rayamangalam'),('Ernakulam','Sreemoolanagaram'),('Ernakulam','Thirumarady'),('Ernakulam','Thuravoor'),('Ernakulam','Udayamperoor'),('Ernakulam','Vadavucode-Puthencruz'),('Ernakulam','Varapuzha'),('Ernakulam','Vazhakkulam'),('Ernakulam','Vengola'),
('Thrissur','Adat'),('Thrissur','Alagappa Nagar'),('Thrissur','Alur'),('Thrissur','Annamanada'),('Thrissur','Arimbur'),('Thrissur','Choondal'),('Thrissur','Chowannur'),('Thrissur','Desamangalam'),('Thrissur','Edathiruthy'),('Thrissur','Elavally'),('Thrissur','Eriyad'),('Thrissur','Kadangode'),('Thrissur','Kadappuram'),('Thrissur','Kadavallur'),('Thrissur','Kandanassery'),('Thrissur','Kattakampal'),('Thrissur','Kattur'),('Thrissur','Kodakara'),('Thrissur','Kolazhy'),('Thrissur','Kondazhy'),('Thrissur','Koratty'),('Thrissur','Kurumal'),('Thrissur','Mala'),('Thrissur','Mattathur'),('Thrissur','Melur'),('Thrissur','Mullassery'),('Thrissur','Mullurkara'),('Thrissur','Mundathikode'),('Thrissur','Nattika'),('Thrissur','Nenmenikkara'),('Thrissur','Padiyur'),('Thrissur','Panjal'),('Thrissur','Pavaratty'),('Thrissur','Pazhayannur'),('Thrissur','Porkulam'),('Thrissur','Puthukkad'),('Thrissur','Thekkumkara'),('Thrissur','Tholur'),('Thrissur','Thrikkur'),('Thrissur','Valappad'),('Thrissur','Varandarappilly'),('Thrissur','Vatanappilly'),('Thrissur','Vellangallur'),('Thrissur','Venkitangu'),
('Palakkad','Agali'),('Palakkad','Alanallur'),('Palakkad','Ambalapara'),('Palakkad','Anakkara'),('Palakkad','Chalissery'),('Palakkad','Elappully'),('Palakkad','Erimayur'),('Palakkad','Kanjirappuzha'),('Palakkad','Kannadi'),('Palakkad','Kappur'),('Palakkad','Karimba'),('Palakkad','Karimpuzha'),('Palakkad','Kavassery'),('Palakkad','Keralassery'),('Palakkad','Kodumbu'),('Palakkad','Koduvayur'),('Palakkad','Kollengode'),('Palakkad','Koppam'),('Palakkad','Kottayi'),('Palakkad','Kozhinjampara'),('Palakkad','Kulukkallur'),('Palakkad','Kumaramputhur'),('Palakkad','Kuthanur'),('Palakkad','Mankara'),('Palakkad','Mannur'),('Palakkad','Marutharoad'),('Palakkad','Muthalamada'),('Palakkad','Nagallassery'),('Palakkad','Nalleppilly'),('Palakkad','Nellaya'),('Palakkad','Ongallur'),('Palakkad','Peringottukurissi'),('Palakkad','Perumatty'),('Palakkad','Puducode'),('Palakkad','Sholayur'),('Palakkad','Sreekrishnapuram'),('Palakkad','Tarur'),('Palakkad','Thenkurissi'),('Palakkad','Thiruvegappura'),('Palakkad','Thrikkadeeri'),('Palakkad','Thrithala'),('Palakkad','Vadavannur'),('Palakkad','Vallapuzha'),('Palakkad','Vaniyamkulam'),
('Malappuram','Alamcode'),('Malappuram','Aliparamba'),('Malappuram','Anakkayam'),('Malappuram','Athavanad'),('Malappuram','Chaliyar'),('Malappuram','Cheekkode'),('Malappuram','Chungathara'),('Malappuram','Edakkara'),('Malappuram','Edappal'),('Malappuram','Edavanna'),('Malappuram','Kalikavu'),('Malappuram','Karuvarakundu'),('Malappuram','Kavannur'),('Malappuram','Keezhattur'),('Malappuram','Kottappadi'),('Malappuram','Kuttippuram'),('Malappuram','Mankada'),('Malappuram','Marakkara'),('Malappuram','Melattur'),('Malappuram','Morayur'),('Malappuram','Muthuvallur'),('Malappuram','Othukkungal'),('Malappuram','Pandikkad'),('Malappuram','Perumpadappa'),('Malappuram','Pookkottur'),('Malappuram','Pulamanthole'),('Malappuram','Pulikkal'),('Malappuram','Thazhekkode'),('Malappuram','Thennala'),('Malappuram','Thirunavaya'),('Malappuram','Thrikkalangode'),('Malappuram','Urangattiri'),('Malappuram','Vazhakkad'),('Malappuram','Vazhayur'),('Malappuram','Vengara'),('Malappuram','Vettom'),('Malappuram','Wandoor'),
('Kozhikode','Atholi'),('Kozhikode','Balussery'),('Kozhikode','Changaroth'),('Kozhikode','Chelannur'),('Kozhikode','Chemancheri'),('Kozhikode','Elathur'),('Kozhikode','Eramala'),('Kozhikode','Kakkodi'),('Kozhikode','Kavilumpara'),('Kozhikode','Kayanna'),('Kozhikode','Keezhariyur'),('Kozhikode','Kodenchery'),('Kozhikode','Kodiyathur'),('Kozhikode','Koorachundu'),('Kozhikode','Kunnamangalam'),('Kozhikode','Kunnummal'),('Kozhikode','Madavoor'),('Kozhikode','Melady'),('Kozhikode','Moodadi'),('Kozhikode','Nadapuram'),('Kozhikode','Narikkuni'),('Kozhikode','Nochad'),('Kozhikode','Olavanna'),('Kozhikode','Omassery'),('Kozhikode','Onchiyam'),('Kozhikode','Perambra'),('Kozhikode','Perumanna'),('Kozhikode','Panangad'),('Kozhikode','Thikkodi'),('Kozhikode','Thiruvallur'),('Kozhikode','Thiruvambadi'),('Kozhikode','Ulliyeri'),('Kozhikode','Unnikulam'),('Kozhikode','Valayam'),('Kozhikode','Villiappally'),
('Wayanad','Ambalavayal'),('Wayanad','Edavaka'),('Wayanad','Kaniyambetta'),('Wayanad','Kottathara'),('Wayanad','Krishnagiri'),('Wayanad','Meenangadi'),('Wayanad','Mullankolly'),('Wayanad','Muttil'),('Wayanad','Nenmeni'),('Wayanad','Noolpuzha'),('Wayanad','Padinjarathara'),('Wayanad','Panamaram'),('Wayanad','Pulpally'),('Wayanad','Thariyode'),('Wayanad','Thirunelly'),('Wayanad','Vellamunda'),
('Kannur','Azhikode'),('Kannur','Ancharakandi'),('Kannur','Chapparapadavu'),('Kannur','Chengalai'),('Kannur','Cherukunnu'),('Kannur','Cherupuzha'),('Kannur','Dharmadam'),('Kannur','Eramam-Kuttoor'),('Kannur','Irikkur'),('Kannur','Kalliasseri'),('Kannur','Kanichar'),('Kannur','Kanhirangad'),('Kannur','Kankol-Alappadamba'),('Kannur','Karivellur-Peralam'),('Kannur','Keezhallur'),('Kannur','Koodali'),('Kannur','Kottayam-Malabar'),('Kannur','Kottiyoor'),('Kannur','Kudiyanmala'),('Kannur','Kunhimangalam'),('Kannur','Kuttiyattur'),('Kannur','Madayi'),('Kannur','Malapattam'),('Kannur','Mayyil'),('Kannur','Mokeri'),('Kannur','Muzhappilangad'),('Kannur','Narath'),('Kannur','New Mahe'),('Kannur','Padiyur-Kalliad'),('Kannur','Panniyannur'),('Kannur','Pappinisseri'),('Kannur','Pariyaram'),('Kannur','Payam'),('Kannur','Payyavoor'),('Kannur','Peralassery'),('Kannur','Peringome-Vayakkara'),('Kannur','Ramanthali'),('Kannur','Thillankeri'),('Kannur','Udayagiri'),('Kannur','Valapattanam'),
('Kasaragod','Ajanoor'),('Kasaragod','Balal'),('Kasaragod','Bedadka'),('Kasaragod','Badiadka'),('Kasaragod','Chemnad'),('Kasaragod','Chengala'),('Kasaragod','Cheruvathur'),('Kasaragod','East Eleri'),('Kasaragod','Enmakaje'),('Kasaragod','Kallar'),('Kasaragod','Karadka'),('Kasaragod','Kayyur-Cheemeni'),('Kasaragod','Kumbadaje'),('Kasaragod','Kumbla'),('Kasaragod','Kuttikol'),('Kasaragod','Madikai'),('Kasaragod','Manjeshwar'),('Kasaragod','Mangalpady'),('Kasaragod','Meenja'),('Kasaragod','Muliyar'),('Kasaragod','Padne'),('Kasaragod','Pallikkara'),('Kasaragod','Panathady'),('Kasaragod','Pullur-Periya'),('Kasaragod','Trikaripur'),('Kasaragod','Udma'),('Kasaragod','Valiyaparamba'),('Kasaragod','West Eleri');

-- 4. Admin registration table
CREATE TABLE IF NOT EXISTS admin_reg (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Mailid VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    panchayat_id INT NOT NULL,
    Tor VARCHAR(100),
    FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)
);

-- 5. Add panchayat_id to donor_reg (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='donor_reg' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE donor_reg ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 6. Add panchayat_id to charity_reg (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='charity_reg' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE charity_reg ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 7. Add panchayat_id to campaign (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='campaign' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE campaign ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 8. Add panchayat_id to transaction (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='transaction' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE `transaction` ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 9. Donation requests table
CREATE TABLE IF NOT EXISTS donation_req (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cid VARCHAR(45) NOT NULL,
  cname VARCHAR(45) NOT NULL,
  campid VARCHAR(45) NOT NULL,
  campname VARCHAR(45) NOT NULL,
  amount VARCHAR(45) NOT NULL,
  did VARCHAR(45) NOT NULL,
  dname VARCHAR(45) NOT NULL,
  reqStatus VARCHAR(45) NOT NULL,
  reqTime VARCHAR(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 10. Add donation limits to campaign (safe - skip if already exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='campaign' AND COLUMN_NAME='min_donation');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE campaign ADD COLUMN min_donation DOUBLE DEFAULT 0, ADD COLUMN max_donation DOUBLE DEFAULT 0, ADD COLUMN min_donation_type VARCHAR(20) DEFAULT \'Number\', ADD COLUMN max_donation_type VARCHAR(20) DEFAULT \'Number\'', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 11. Add donation limits to charity_reg (safe - skip if already exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='charity_reg' AND COLUMN_NAME='min_donation');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE charity_reg ADD COLUMN min_donation DOUBLE DEFAULT 0, ADD COLUMN max_donation DOUBLE DEFAULT 0, ADD COLUMN min_donation_type VARCHAR(20) DEFAULT \'Number\', ADD COLUMN max_donation_type VARCHAR(20) DEFAULT \'Number\'', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Verify
SELECT 'Migration complete' AS status;
SELECT COUNT(*) AS total_panchayats FROM panchayat;
SELECT district, COUNT(*) AS count FROM panchayat GROUP BY district ORDER BY district;
