use [jdm-sql-db1];
go

drop table if exists BarrelCategory;
go
drop table if exists Barrel;
go
drop table if exists Warehouse;
go
drop table if exists DSP;
go
drop table if exists Location;
go
drop table if exists Owner;
go
drop table if exists Lot;
go
drop table if exists InternalSpiritType;
go


CREATE TABLE DSP
(
  [DSP_Id] int NOT NULL,
  [DSP_Name] varchar(25)
  -- Didn't flesh out the other columns, Dan ERD named a few columns and said other...

  CONSTRAINT PK_DSP PRIMARY KEY NONCLUSTERED ([DSP_Id])
)
go -- Not needed after DDL




CREATE TABLE Lot
(
  [LotId] int NOT NULL,
  [DSP_Id] int NOT NULL,
  [FillDate] datetime NOT NULL,
  [CornPct] numeric(5,4) NOT NULL,
  [RyePct] numeric(5,4) NOT NULL,
  [WheatPct] numeric(5,4) NOT NULL,
  [BarleyPct] numeric(5,4) NOT NULL,
  [InternalSpiritTypeId] int NOT NULL,
  [ArchiveFlag] bit,
  [ArchiveDate] datetime,
  [FwdPurchaseFlag] bit,
  [FwdPurchaseDate] datetime,
  [FwdPurchasePrice] decimal(9,3),
  [FwdPurchaseBarrelCnt] int


  CONSTRAINT PK_Lot PRIMARY KEY NONCLUSTERED ([LotId], [DSP_Id])
)
go -- Not needed after DDL

CREATE TABLE Location
(
  [LocationId] int NOT NULL IDENTITY(1,1), 
  [LocationName] Varchar(50) NOT NULL,
  [BarrelPrefix] Varchar(50) NOT NULL,
  [NextId] int not null

  CONSTRAINT PK_Location PRIMARY KEY NONCLUSTERED ([LocationId])
 
)
go -- Not needed after DDL

CREATE TABLE BarrelCategory
(
  [BarrelCategoryId] int NOT NULL IDENTITY(1,1), 
  [BarrelCategoryName] Varchar(50) NOT NULL,
  

  CONSTRAINT PK_BarrelCategory PRIMARY KEY NONCLUSTERED ([BarrelCategoryId])
 
)
go -- Not needed after DDL

CREATE TABLE Owner
(
  [OwnerId] int NOT NULL IDENTITY(1,1), 
  [OwnerName] Varchar(50) NOT NULL,
  [OwnerParent] Varchar(50) NOT NULL

  CONSTRAINT PK_Owner PRIMARY KEY NONCLUSTERED ([OwnerId])
 
)
go -- Not needed after DDL


CREATE TABLE Warehouse
(
  [WarehouseId] int NOT NULL IDENTITY(1,1), 
  [WarehouseName] Varchar(50) NOT NULL,
  [LocationId] int NOT NULL

  CONSTRAINT PK_Warehouse PRIMARY KEY NONCLUSTERED ([WarehouseId]),
  CONSTRAINT FK_Warehouse_Location FOREIGN KEY ([LocationId])
        REFERENCES Location ([LocationId])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 
)
go -- Not needed after DDL


CREATE TABLE Barrel
(
  [BarrelId] int NOT NULL,
  [OwnerId] int NOT NULL,
  [LotId] int NOT NULL,
  [DSP_Id] int NOT NULL,
  [LocationId] int NOT NULL,
  [WarehouseId] int NOT NULL,
  [BarrelCategoryId] int NOT NULL,
  [InvoiceNo] varchar(25),
  [PurchaseDate] datetime NOT NULL,  
  [ArchiveFlag] bit,
  [ArchiveDate] datetime,
  [PendingSaleFlag] bit


  CONSTRAINT PK_Barrel PRIMARY KEY NONCLUSTERED ([BarrelId]),
  CONSTRAINT FK_Barrel_Lot FOREIGN KEY ([LotId], [DSP_Id])
        REFERENCES Lot ([LotId], [DSP_Id])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 CONSTRAINT FK_Barrel_Location FOREIGN KEY ([LocationId])
        REFERENCES Location ([LocationId])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 CONSTRAINT FK_Barrel_Owner FOREIGN KEY ([OwnerId])
        REFERENCES Owner ([OwnerId])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 CONSTRAINT FK_Barrel_Warehouse FOREIGN KEY ([WarehouseId])
        REFERENCES Warehouse ([WarehouseId]),
 CONSTRAINT FK_Barrel_DSP FOREIGN KEY (DSP_Id)
        REFERENCES DSP ([DSP_Id])
        
)
go -- Not needed after DDL

CREATE TABLE InternalSpiritType
(
  [InternalSpiritTypeId] int NOT NULL IDENTITY(1,1), 
  [SpiritName] Varchar(50) NOT NULL

  CONSTRAINT PK_InternalSpiritType PRIMARY KEY NONCLUSTERED ([InternalSpiritTypeId])
)
go -- Not needed after DDL



-- Populate Lot
INSERT INTO Lot 
		([LotId],[DSP_ID],[FillDate],[CornPct],[RyePct],[WheatPct],[BarleyPct],[InternalSpiritTypeId],[ArchiveFlag],[ArchiveDate],[FwdPurchaseFlag],[FwdPurchaseDate],[FwdPurchasePrice],[FwdPurchaseBarrelCnt])
  values(     1,       1, '1/1/2022',     .25,     .25,       .25,        .25,                     1,            0,   null,               1,       '10/31/2022',           999.89,                   60)

INSERT INTO Lot 
		([LotId],[DSP_ID],[FillDate],[CornPct],[RyePct],[WheatPct],[BarleyPct],[InternalSpiritTypeId],[ArchiveFlag],[ArchiveDate],[FwdPurchaseFlag],[FwdPurchaseDate],[FwdPurchasePrice],[FwdPurchaseBarrelCnt])
  values(     1,      2, '2/1/2022',     .20,     .20,       .20,        .40,                     2,            1,    '9/9/2022',               0,       null,           15000.89,                   120)

INSERT INTO Lot 
		([LotId],[DSP_ID],[FillDate],[CornPct],[RyePct],[WheatPct],[BarleyPct],[InternalSpiritTypeId],[ArchiveFlag],[ArchiveDate],[FwdPurchaseFlag],[FwdPurchaseDate],[FwdPurchasePrice],[FwdPurchaseBarrelCnt])
  values(    2,       1, '3/1/2022',     .25,     .25,       .25,        .25,                     3,            0,   null,               1,				   '9/30/2022',          3999.89,                   60)
  

INSERT INTO Lot 
		([LotId],[DSP_ID],[FillDate],[CornPct],[RyePct],[WheatPct],[BarleyPct],[InternalSpiritTypeId],[ArchiveFlag],[ArchiveDate],[FwdPurchaseFlag],[FwdPurchaseDate],[FwdPurchasePrice],[FwdPurchaseBarrelCnt])
  values(     2,      2, '4/1/2022',     .20,     .20,       .20,        .40,                     4,            1,    '9/19/2022',               0,       null,          75000.89,                   240)
go

-- Populate Location
INSERT INTO BarrelCategory VALUES('Barrel Cat 1')
INSERT INTO BarrelCategory VALUES('Barrel Cat 2')

-- Populate Location
INSERT INTO Location VALUES('Maine', 'ME', 9)
INSERT INTO Location VALUES('New Jersey', 'NJ', 19)
INSERT INTO Location VALUES('New York', 'NY', 29)

-- Populate Owner
INSERT INTO Owner VALUES('Dan', 'Mom')
INSERT INTO Owner VALUES('Jeff', 'Dad')
INSERT INTO Owner VALUES('Other', 'Vic')

-- Populate DSP
INSERT INTO DSP VALUES(1, 'AAAA')
INSERT INTO DSP VALUES(2, 'BBBBB')
INSERT INTO DSP VALUES(3, 'CCCC')
INSERT INTO DSP VALUES(4, 'FFFF')
INSERT INTO DSP VALUES(5, 'EEEE')
INSERT INTO DSP VALUES(6, 'DDDD')


-- Populate Warehouse
INSERT INTO Warehouse VALUES('Docks', 1)
INSERT INTO Warehouse VALUES('Downtown',  2)
INSERT INTO Warehouse VALUES('Uptown', 3)


-- Populate Barrel
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  1,		1,      1,      1,           1,            1,					1,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  2,		2,      1,      1,           1,            1,					2,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  3,		2,      1,      1,           1,            1,					1,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  4,		1,      1,      1,           1,            1,					2,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  5,		3,      1,      1,           2,            1,					1,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  6,		1,      1,      1,           3,            1,					2,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  7,		2,      1,      1,           2,            1,					2,	   '#101',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  8,		3,      1,      1,           1,            1,					1,	   '#101',	  '1/1/2022',			0,			null,				0)

INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  9,		1,      1,      2,           2,            2,					2,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  10,		2,      1,      2,           3,            2,					1,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  11,		3,      1,      2,           1,            2,					2,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  12,		1,      1,      2,           2,            2,					1,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  13,		2,      1,      2,           3,            2,					1,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  14,		3,      1,      2,           1,            2,				   2,		'#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  15,		2,      1,      2,           2,            2,					2,	   '#102',	  '1/1/2022',			0,			null,				0)
INSERT INTO Barrel
		([BarrelId],[OwnerId],[LotId],[DSP_Id],[LocationId],[WarehouseId],[BarrelCategoryId],[InvoiceNo],[PurchaseDate],[ArchiveFlag],[ArchiveDate],[PendingSaleFlag])
  values(		  16,		2,      1,      2,           3,            2,					1,	   '#102',	  '1/1/2022',			0,			null,				0)

-- Populate Internal Spirit
INSERT INTO InternalSpiritType values('Whiskey')
INSERT INTO InternalSpiritType values('Rye')
INSERT INTO InternalSpiritType values('Scotch')
INSERT INTO InternalSpiritType values('Bourbon')
go



select l.LotId,l.DSP_Id, SpiritName, InvoiceNo, lc.LocationName, w.WarehouseName, o.OwnerName, d.DSP_Name, bc.BarrelCategoryName from lot l 
inner join InternalSpiritType s on l.InternalSpiritTypeId = s.InternalSpiritTypeId
inner join Barrel b on l.LotId = b.LotId and l.DSP_Id = b.DSP_Id
inner join Location lc on b.LocationId = lc.LocationId
inner join Warehouse w on w.LocationId = lc.LocationId
inner join Owner o on o.OwnerId = b.OwnerId
inner join DSP d on d.DSP_Id = b.DSP_Id
inner join BarrelCategory bc on b.BarrelCategoryId = bc.BarrelCategoryId
