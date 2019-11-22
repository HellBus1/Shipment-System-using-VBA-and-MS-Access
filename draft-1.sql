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
    ETA             VARCHAR(16) NOT NULL,
    Tarif_per_jarak INT NOT NULL
);

CREATE TABLE Kode_Pos (
    ID_Pos          CHAR(5) NOT NULL PRIMARY KEY,
    Desa            VARCHAR(64) NOT NULL,
    Kelurahan       VARCHAR(64) NOT NULL,
    Kecamatan       VARCHAR(64) NOT NULL,
    Kota            VARCHAR(64) NOT NULL,
    Provinsi        VARCHAR(64) NOT NULL
);

CREATE TABLE Kategori_Barang (
    ID_Kategori         CHAR(3) NOT NULL PRIMARY KEY,
    Nama_Kategori       VARCHAR(16) NOT NULL,
    Tarif_per_berat     INT NOT NULL
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
    Resi_Status         VARCHAR(16),
    Tgl_Kirim           DATE NOT NULL,
    Tgl_Sampai          DATE NOT NULL,
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
    CONSTRAINT ID_Resi FOREIGN KEY (ID_Resi) REFERENCES Resi(ID_Resi),
    CONSTRAINT ID_Kurir FOREIGN KEY (ID_Kurir) REFERENCES Data_Kurir(ID_Kurir)
);