CREATE TABLE Data_Pengguna (
    ID_User         CHAR(5) NOT NULL PRIMARY KEY,
    Nama_User       VARCHAR(32) NOT NULL,
    Hp_User         VARCHAR(12) NOT NULL,
    Alamat          VARCHAR(128) NOT NULL
);

CREATE TABLE Data_Kurir (
    ID_Kurir            CHAR(5) NOT NULL PRIMARY KEY,
    Nama_Kurir          VARCHAR(32) NOT NULL,
    Hp_Kurir            VARCHAR(12) NOT NULL
);

CREATE TABLE Jenis_Servis (
    ID_Servis       CHAR(3) NOT NULL PRIMARY KEY,
    Nama_Servis     VARCHAR(16) NOT NULL,
    ETA             INT NOT NULL,
    Tarif_per_jarak INT NOT NULL
);

CREATE TABLE Kode_Pos (
    ID_Pos          CHAR(5) NOT NULL PRIMARY KEY,
    Kelurahan       VARCHAR(64) NOT NULL,
    Kecamatan       VARCHAR(64) NOT NULL,
    Kota            VARCHAR(64) NOT NULL,
    Provinsi        VARCHAR(64) NOT NULL
);

CREATE TABLE Jarak_Kota (
    ID_Pos_Kota_1   CHAR(5) NOT NULL,
    Nama_Kota_1     VARCHAR(64),
    ID_Pos_Kota_2   CHAR(5) NOT NULL,
    Nama_Kota_2     VARCHAR(64),
    Jarak           INT,
    CONSTRAINT ID_Pos_Kota_1 FOREIGN KEY (ID_Pos_Kota_1) REFERENCES Kode_Pos(ID_Pos),
    CONSTRAINT ID_Pos_Kota_2 FOREIGN KEY (ID_Pos_Kota_2) REFERENCES Kode_Pos(ID_Pos)
);

CREATE TABLE Kategori_Barang (
    ID_Kategori         CHAR(5) NOT NULL PRIMARY KEY,
    Nama_Kategori       VARCHAR(16) NOT NULL,
    Tarif_per_berat     INT NOT NULL
);

CREATE TABLE Status_Kirim (
    ID_Status CHAR(3) NOT NULL PRIMARY KEY,
    deskripsi VARCHAR(16) NOT NULL
);

CREATE TABLE Resi (
    ID_Resi             CHAR(16) NOT NULL PRIMARY KEY,
    Nama_Barang         VARCHAR(64) NOT NULL,
    Berat_barang        INT NOT NULL,
    ID_Kategori         CHAR(3) NOT NULL,
    ID_Servis           CHAR(3) NOT NULL,
    ID_User_Sender      CHAR(5) NOT NULL,
    ID_Pos_Sender       CHAR(5) NOT NULL,
    ID_User_Receiver    CHAR(5) NOT NULL,
    ID_Pos_Receiver     CHAR(5) NOT NULL,
    Tgl_Kirim           DATE NOT NULL,
    Tgl_Sampai          DATE,
    Jarak               INT,
    Total_Tarif         INT,
    CONSTRAINT ID_Servis FOREIGN KEY (ID_Servis) REFERENCES Jenis_Servis(ID_Servis),
    CONSTRAINT ID_Kategori FOREIGN KEY (ID_Kategori) REFERENCES Kategori_Barang(ID_Kategori),
    CONSTRAINT ID_User_Sender FOREIGN KEY (ID_User_Sender) REFERENCES Data_Pengguna(ID_User),
    CONSTRAINT ID_Pos_Sender FOREIGN KEY (ID_Pos_Sender) REFERENCES Kode_Pos(ID_Pos),
    CONSTRAINT ID_User_Receiver FOREIGN KEY (ID_User_Receiver) REFERENCES Data_Pengguna(ID_User),
    CONSTRAINT ID_Pos_Receiver FOREIGN KEY (ID_Pos_Receiver) REFERENCES Kode_Pos(ID_Pos)
);

CREATE TABLE Pengiriman (
    ID_Resi             CHAR(16) NOT NULL,
    ID_Kurir            CHAR(5) NOT NULL,
    Status_Resi         CHAR(3) NOT NULL,
    CONSTRAINT Status_Resi FOREIGN KEY (Status_Resi) REFERENCES Status_Kirim(ID_Status),
    CONSTRAINT ID_Resi FOREIGN KEY (ID_Resi) REFERENCES Resi(ID_Resi),
    CONSTRAINT ID_Kurir FOREIGN KEY (ID_Kurir) REFERENCES Data_Kurir(ID_Kurir)
);

--  data pengguna
INSERT INTO data_pengguna VALUES ('AA001', 'Rafi Nizar', '081218593545', 'Bumi Marina Emas Barat IV');
INSERT INTO data_pengguna VALUES ('AA002', 'Afiq Fawwaz', '0811124774', 'Rahayu Residence');

-- data kurir 
INSERT INTO data_kurir VALUES ('0X001', 'Satrio', '08125738863');

-- jenis servis
INSERT INTO jenis_servis VALUES ('S01','YES', '2', '25000');
INSERT INTO jenis_servis VALUES ('S02','REG', '4', '15000');
INSERT INTO jenis_servis VALUES ('S03','OKE', '8', '10000');

-- kode pos
INSERT INTO kode_pos VALUES ('60117', 'Gebang Putih', 'Sukolilo', 'Surabaya', 'Jawa Timur');
INSERT INTO kode_pos VALUES ('42113', 'Lopang', 'Serang', 'Serang', 'Banten');

-- jarak kota
INSERT INTO Jarak_Kota VALUES ('60117',
                                (SELECT Kota FROM Kode_Pos WHERE ID_Pos = '60117'),
                                '42113',
                                (SELECT Kota FROM Kode_Pos WHERE ID_Pos = '42113'),
                                '2000');

-- kategori barang
INSERT INTO Kategori_Barang VALUES ('DOC01', 'Dokumen', '500');

-- status pengiriman
INSERT INTO Status_Kirim VALUES ('NO1', 'Barang belum dikirim');
INSERT INTO Status_Kirim VALUES ('NO2', 'Barang berada di Warehouse');
INSERT INTO Status_Kirim VALUES ('OW1', 'Barang dalam perjalanan');
INSERT INTO Status_Kirim VALUES ('OW2', 'Barang sudah sampai tujuan');