USE donation;

-- 1. Panchayat master table
CREATE TABLE IF NOT EXISTS panchayat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    panchayat_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Sample panchayat data
INSERT IGNORE INTO panchayat (panchayat_name) VALUES 
('Panchayat 1'), ('Panchayat 2'), ('Panchayat 3'), 
('Panchayat 4'), ('Panchayat 5');

-- 3. Admin registration table
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

-- 4. Add panchayat_id to donor_reg (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='donor_reg' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE donor_reg ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 5. Add panchayat_id to charity_reg (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='charity_reg' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE charity_reg ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 6. Add panchayat_id to campaign (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='campaign' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE campaign ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 7. Add panchayat_id to transaction (if not exists)
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='donation' AND TABLE_NAME='transaction' AND COLUMN_NAME='panchayat_id');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE `transaction` ADD COLUMN panchayat_id INT, ADD FOREIGN KEY (panchayat_id) REFERENCES panchayat(id)', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 8. Donation requests table
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

-- 9. Add donation limits to campaign
ALTER TABLE campaign ADD COLUMN min_donation DOUBLE DEFAULT 0;
ALTER TABLE campaign ADD COLUMN max_donation DOUBLE DEFAULT 0;
ALTER TABLE campaign ADD COLUMN min_donation_type VARCHAR(20) DEFAULT 'Number';
ALTER TABLE campaign ADD COLUMN max_donation_type VARCHAR(20) DEFAULT 'Number';

-- 10. Add donation limits to charity_reg
ALTER TABLE charity_reg ADD COLUMN min_donation DOUBLE DEFAULT 0;
ALTER TABLE charity_reg ADD COLUMN max_donation DOUBLE DEFAULT 0;
ALTER TABLE charity_reg ADD COLUMN min_donation_type VARCHAR(20) DEFAULT 'Number';
ALTER TABLE charity_reg ADD COLUMN max_donation_type VARCHAR(20) DEFAULT 'Number';

-- Verify
SELECT 'Migration complete' AS status;
SHOW TABLES;
