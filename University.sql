-- University Database-i yaradın, burada ola biləcək cədvəlləri, onlar arasında olan
-- əlaqələri və məlumat tiplərini təyin edin.

-- Minimum tələb olunan cədvəllər:
-- İşçilər, Müəllimlər, Tələbələr, Kafedralar, Fakultələr, Şöbələr, Fənnlər,
-- Otaqlar, Qruplar, Dərs cədvəli, Ödəniş cədvəli, Maaşlar, Təhsil haqqları

CREATE DATABASE University;

USE University;

CREATE TABLE Students(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(255) NOT NULL,
	LastName NVARCHAR(255),
	Birthdate DATE,
	Gender TINYINT NOT NULL,
	[Address]  NVARCHAR(255),
	Email NVARCHAR(255),
	Phone NVARCHAR(255),
);

CREATE TABLE Teachers(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(255) NOT NULL,
	LastName NVARCHAR(255),
	Birthdate DATE,
	Gender TINYINT NOT NULL,
	Salary FLOAT,
	[Address]  NVARCHAR(255),
	Email NVARCHAR(255),
	Phone NVARCHAR(255),
);

CREATE TABLE Workers(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(255) NOT NULL,
	LastName NVARCHAR(255),
	Birthdate DATE,
	Gender TINYINT NOT NULL,
	Salary FLOAT,
	[Address]  NVARCHAR(255),
	Email NVARCHAR(255),
	Phone NVARCHAR(255),
);

CREATE TABLE Departments(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[Name] NVARCHAR(255) UNIQUE NOT NULL,
);

CREATE TABLE Faculties(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[Name] NVARCHAR(255) UNIQUE NOT NULL,
	DepartmentId INT,
	FOREIGN KEY(DepartmentId) REFERENCES Departments(Id),
);

CREATE TABLE Groups(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[Name] NVARCHAR(255) UNIQUE NOT NULL,
	FacultyId INT,
	FOREIGN KEY (FacultyId) REFERENCES Faculties(Id),
);

CREATE TABLE Subjects(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[Name] NVARCHAR(255) UNIQUE NOT NULL,
	[Language] NVARCHAR(255) NOT NULL,
);

CREATE TABLE Sectors(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[Name] NVARCHAR(255) UNIQUE NOT NULL,
);

CREATE TABLE Rooms(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	[No] NVARCHAR(255) UNIQUE NOT NULL,
	[Name] NVARCHAR(255),
);

CREATE TABLE SubjectSchedules(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	SubjectId INT,
	RoomId INT,
	SubjectStartDate DATETIME,
	SubjectEndDate DATETIME,
	UNIQUE(SubjectId,RoomId, SubjectStartDate, SubjectEndDate),
	FOREIGN KEY(SubjectId) REFERENCES Subjects(Id),
	FOREIGN KEY(RoomId) REFERENCES Rooms(Id),
);

CREATE TABLE TuitionFees(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FacultyId INT,
	TuitionFee FLOAT,
	FOREIGN KEY(FacultyId) REFERENCES Faculties(Id), 
);

CREATE TABLE PayrollSchedules(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	StudentId INT,
	[Date] DATE,
	TuitionFeeId INT,
	FOREIGN KEY(StudentId) REFERENCES Students(Id),
	FOREIGN KEY(TuitionFeeId) REFERENCES TuitionFees(Id),
);



-- Many To Many relations

CREATE TABLE StudentsWithGroups(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	StudentId INT NOT NULL,
	GroupId INT NOT NULL,
	UNIQUE(StudentId, GroupId),
	FOREIGN KEY(StudentId) REFERENCES Students(Id),
	FOREIGN KEY(GroupId) REFERENCES Groups(Id),
);

CREATE TABLE TeachersWithGroups(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	GroupId INT,
	TeacherID INT,
	UNIQUE(GroupId, TeacherId),
	FOREIGN KEY(GroupId) REFERENCES Groups(Id),
	FOREIGN KEY(TeacherId) REFERENCES Teachers(Id),
);

CREATE TABLE TeachersWithDepartments(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	DepartmentId INT,
	TeacherId INT,
	UNIQUE(DepartmentId, TeacherId),
	FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
	FOREIGN KEY (TeacherId) REFERENCES Teachers(Id),
);

CREATE TABLE WorkersWithDepartments(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	DepartmentId INT,
	WorkerId INT,
	UNIQUE(DepartmentId, WorkerId),
	FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
	Foreign KEY (WorkerId) REFERENCES Workers(Id),
);

CREATE TABLE WorkersWithSectors(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	SectorID INT,
	WorkerId INT,
	UNIQUE(SectorId, WorkerId),
	FOREIGN KEY (SectorID) REFERENCES Sectors(Id),
	Foreign KEY (WorkerId) REFERENCES Workers(Id),
);


CREATE TABLE GroupsWithSubjectSchedules(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	GroupId INT NOT NULL,
	SubjectScheduleId INT NOT NULL,
	UNIQUE(GroupId, SubjectScheduleId),
	FOREIGN KEY(GroupId) REFERENCES Groups(Id),
	FOREIGN KEY(SubjectScheduleId) REFERENCES SubjectSchedules(Id),
);

-- Mockup datas

INSERT INTO Students VALUES(
	'Lewie',
	'Trayton',
	'09-23-2001',
	2,
	'USA New York',
	'lewie_trayton@gmail.com',
	'131-762-3821'
);

INSERT INTO Students VALUES(
	'Whitby',
	'Robilart',
	'12-13-2003',
	1,
	'USA New York',
	'whitby_robilart@gmail.com',
	'527-622-3224'
);

INSERT INTO Students VALUES(
	'Pearl',
	'Bradley',
	'04-06-2002',
	2,
	'USA New York',
	'pearl_bradley@gmail.com',
	'191-140-5684'
);

INSERT INTO Students VALUES(
	'North',
	'Southby',
	'01-25-2001',
	1,
	'USA New York',
	'north_southby@gmail.com',
	'235-890-1089'
);

INSERT INTO Students VALUES(
	'Gwenora',
	'McSpirron',
	'08-05-2003',
	2,
	'USA New York',
	'gwenora_mcspirron@gmail.com',
	'125-606-4044'
);

INSERT INTO Students VALUES(
	'Urban',
	'Fockes',
	'07-03-2001',
	1,
	'USA New York',
	'urban_fockes@gmail.com',
	'217-636-8530'
);

INSERT INTO Students VALUES(
	'Jorgan',
	'Perrin',
	'02-13-2002',
	1,
	'USA New York',
	'jorgan_perrin@gmail.com',
	'627-733-8227'
);

INSERT INTO Students VALUES(
	'Lonnie',
	'Shorten',
	'10-14-2000',
	2,
	'USA New York',
	'lonnie_shorten@gmail.com',
	'624-675-0004'
);

INSERT INTO Students VALUES(
	'Tiffanie',
	'Ferenc',
	'03-29-2001',
	2,
	'USA New York',
	'tiffanie_ferenc@gmail.com',
	'577-856-5246'
);

INSERT INTO Students VALUES(
	'Arch',
	'Hamer',
	'01-08-2001',
	2,
	'USA New York',
	'arch_hamer@gmail.com',
	'947-623-0256'
);

INSERT INTO Students VALUES(
	'Caressa',
	'Sauvage',
	'10-07-2002',
	2,
	'USA New York',
	'caressa_sauvage@gmail.com',
	'143-229-2510'
);

INSERT INTO Students VALUES(
	'Cad',
	'Maddin',
	'12-31-2003',
	1,
	'USA New York',
	'cad_maddin@gmail.com',
	'225-977-8763'
);

INSERT INTO Students VALUES(
	'Emlynn',
	'Farthing',
	'11-03-2000',
	2,
	'USA New York',
	'emlynn_farthing@gmail.com',
	'359-314-2037'
);

INSERT INTO Students VALUES(
	'Brandy',
	'Dowry',
	'11-21-2002',
	1,
	'USA New York',
	'brandy_dowry@gmail.com',
	'554-664-1102'
);

INSERT INTO Students VALUES(
	'Jean',
	'Tremblay',
	'05-31-2002',
	2,
	'USA New York',
	'jean_tremblay@gmail.com',
	'579-986-6746'
);

INSERT INTO Students VALUES(
	'Quinn',
	'Bardwall',
	'01-17-2004',
	2,
	'USA New York',
	'quinn_bardwall@gmail.com',
	'297-218-0313'
);

INSERT INTO Students VALUES(
	'Marwin',
	'Sunnucks',
	'08-30-2002',
	1,
	'USA New York',
	'marwin_sunnucks@gmail.com',
	'754-656-6073'
);

INSERT INTO Students VALUES(
	'Otto',
	'Isacq',
	'07-22-2002',
	1,
	'USA New York',
	'otto_isacq@gmail.com',
	'512-899-8210'
);

INSERT INTO Students VALUES(
	'Udell',
	'Caddock',
	'02-15-2004',
	1,
	'USA New York',
	'udell_caddock@gmail.com',
	'502-370-5866'
);

INSERT INTO Students VALUES(
	'Katalin',
	'Jardin',
	'06-11-2003',
	2,
	'USA New York',
	'katalin_jardin@gmail.com',
	'964-350-8472'
);

INSERT INTO Students VALUES(
	'Morissa',
	'Warde',
	'02-18-2001',
	2,
	'USA New York',
	'morissa_warde@gmail.com',
	'693-180-0113'
);

INSERT INTO Students VALUES(
	'Neall',
	'Jeggo',
	'10-23-2003',
	1,
	'USA New York',
	'neall_jeggo@gmail.com',
	'712-210-6805'
);

INSERT INTO Students VALUES(
	'Stoddard',
	'Gruszczak',
	'03-19-2001',
	1,
	'USA New York',
	'stoddard_gruszczak@gmail.com',
	'344-327-0987'
);

INSERT INTO Students VALUES(
	'Brandon',
	'Siddon',
	'02-03-2004',
	1,
	'USA New York',
	'brandon_siddon@gmail.com',
	'965-162-6598'
);

INSERT INTO Students VALUES(
	'Anette',
	'Snepp',
	'06-03-2001',
	2,
	'USA New York',
	'anette_snepp@gmail.com',
	'228-866-6296'
);

INSERT INTO Students VALUES(
	'Kristen',
	'Studeart',
	'05-26-2001',
	2,
	'USA New York',
	'kristen_studeart@gmail.com',
	'367-974-3611'
);

INSERT INTO Students VALUES(
	'Barth',
	'Devonish',
	'06-06-2003',
	1,
	'USA New York',
	'barth_devonish@gmail.com',
	'228-523-7128'
);

INSERT INTO Students VALUES(
	'Ambur',
	'Liveing',
	'08-26-2000',
	1,
	'USA New York',
	'ambur_liveing@gmail.com',
	'750-317-2376'
);

INSERT INTO Students VALUES(
	'Leia',
	'Caffrey',
	'09-23-2003',
	2,
	'USA New York',
	'leila_caffrey@gmail.com',
	'531-294-9554'
);

INSERT INTO Students VALUES(
	'Roy',
	'Lonie',
	'11-04-2000',
	1,
	'USA New York',
	'roy_lonie@gmail.com',
	'263-601-4091'
);

INSERT INTO Departments VALUES(
	'Information Technology'
);

INSERT INTO Departments VALUES(
	'Engineering'
);

INSERT INTO Departments VALUES(
	'Finance and Accounting'
);

INSERT INTO Departments VALUES(
	'Computer Science and Mathematics'
);

INSERT INTO Faculties VALUES(
	'Information Technology',
	1
);

INSERT INTO Faculties VALUES(
	'Computer Science',
	4
);

INSERT INTO Faculties VALUES(
	'Mechanical Engineering',
	2
);

INSERT INTO Faculties VALUES(
	'Electrical Engineering',
	2
);


INSERT INTO Faculties VALUES(
	'Mathematics and Physics',
	4
);


INSERT INTO Faculties VALUES(
	'Finance',
	3
);

INSERT INTO Faculties VALUES(
	'Economics',
	3
);

INSERT INTO Faculties VALUES(
	'Marketing',
	3
);


INSERT INTO Groups VALUES(
	'TXER_5393',
	1
);

INSERT INTO Groups VALUES(
	'NAFQ_7316',
	2
);

INSERT INTO Groups VALUES(
	'DDVK_4021',
	3
);


INSERT INTO Groups VALUES(
	'OLMU_9423',
	4
);


INSERT INTO Groups VALUES(
	'RVAE_2562',
	5
);

INSERT INTO Groups VALUES(
	'PMGM_5450',
	6
);

INSERT INTO Groups VALUES(
	'YIRA_6521',
	7
);

INSERT INTO StudentsWithGroups VALUES(
	1, 1
);

INSERT INTO StudentsWithGroups VALUES(
	2, 1
);

INSERT INTO StudentsWithGroups VALUES(
	3, 1
);

INSERT INTO StudentsWithGroups VALUES(
	4, 1
);

INSERT INTO StudentsWithGroups VALUES(
	5, 1
);


INSERT INTO StudentsWithGroups VALUES(
	6, 2
);

INSERT INTO StudentsWithGroups VALUES(
	7, 2
);

INSERT INTO StudentsWithGroups VALUES(
	8, 2
);

INSERT INTO StudentsWithGroups VALUES(
	9, 2
);

INSERT INTO StudentsWithGroups VALUES(
	10, 2
);

INSERT INTO StudentsWithGroups VALUES(
	11, 3
);

INSERT INTO StudentsWithGroups VALUES(
	12, 3
);

INSERT INTO StudentsWithGroups VALUES(
	13, 3
);

INSERT INTO StudentsWithGroups VALUES(
	14, 3
);

INSERT INTO StudentsWithGroups VALUES(
	15, 3
);

INSERT INTO StudentsWithGroups VALUES(
	16, 4
);

INSERT INTO StudentsWithGroups VALUES(
	17, 4
);

INSERT INTO StudentsWithGroups VALUES(
	18, 4
);

INSERT INTO StudentsWithGroups VALUES(
	19, 4
);

INSERT INTO StudentsWithGroups VALUES(
	20, 4
);

INSERT INTO StudentsWithGroups VALUES(
	21, 5
);

INSERT INTO StudentsWithGroups VALUES(
	22, 5
);

INSERT INTO StudentsWithGroups VALUES(
	23, 5
);

INSERT INTO StudentsWithGroups VALUES(
	24, 5
);

INSERT INTO StudentsWithGroups VALUES(
	25, 5
);

INSERT INTO StudentsWithGroups VALUES(
	26, 6
);

INSERT INTO StudentsWithGroups VALUES(
	27, 6
);

INSERT INTO StudentsWithGroups VALUES(
	28, 6
);

INSERT INTO StudentsWithGroups VALUES(
	29, 6
);

INSERT INTO StudentsWithGroups VALUES(
	30, 6
);


INSERT INTO StudentsWithGroups VALUES(
	5, 7
);
INSERT INTO StudentsWithGroups VALUES(
	11, 7
);

INSERT INTO StudentsWithGroups VALUES(
	8, 7
);

INSERT INTO StudentsWithGroups VALUES(
	17, 7
);

INSERT INTO StudentsWithGroups VALUES(
	25, 7
);

INSERT INTO StudentsWithGroups VALUES(
	30, 7
);

INSERT INTO StudentsWithGroups VALUES(
	9, 7
);

INSERT INTO Subjects VALUES(
	'Business & Management',
	'English'
);

INSERT INTO Subjects VALUES(
	'Computing and IT',
	'English'
);

INSERT INTO Subjects VALUES(
	'Engineering',
	'English'
);

INSERT INTO Subjects VALUES(
	'Mathematics & Statistics',
	'English'
);

INSERT INTO Subjects VALUES(
	'Economics',
	'English'
);

INSERT INTO Subjects VALUES(
	'Finance',
	'English'
);

INSERT INTO Subjects VALUES(
	'Physics',
	'English'
);

INSERT INTO Subjects VALUES(
	'Computer Architecture',
	'English'
);

INSERT INTO Subjects VALUES(
	'Networking',
	'English'
);

INSERT INTO Subjects VALUES(
	'Software design',
	'English'
);

INSERT INTO Rooms VALUES('11', 'IT');
INSERT INTO Rooms VALUES('12', 'Economics');
INSERT INTO Rooms VALUES('13', 'Computer Science And Mathematics');
INSERT INTO Rooms VALUES('14', 'Marketing');
INSERT INTO Rooms VALUES('15', 'Design');
INSERT INTO Rooms VALUES('16', 'Engineering');
INSERT INTO Rooms VALUES('17', 'IT LAB');
INSERT INTO Rooms VALUES('18', 'Physics lab');
INSERT INTO Rooms VALUES('19', 'Chemistry lab');
INSERT INTO Rooms VALUES('21', 'Design');
INSERT INTO Rooms VALUES('22', 'Engineering');
INSERT INTO Rooms VALUES('23', 'IT LAB');
INSERT INTO Rooms VALUES('24', 'IT');
INSERT INTO Rooms VALUES('25', 'Economics');
INSERT INTO Rooms VALUES('26', 'Computer Science And Mathematics');
INSERT INTO Rooms VALUES('27', 'Marketing');
INSERT INTO Rooms VALUES('28', 'Physics lab');
INSERT INTO Rooms VALUES('29', 'Chemistr lab');

INSERT INTO SubjectSchedules VALUES(
	1,
	4,
	'20210607 09:00',
	'20210607 10:00'
);

INSERT INTO SubjectSchedules VALUES(
	2,
	1,
	'20210607 10:00',
	'20210607 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	3,
	6,
	'20210607 13:00',
	'20210607 14:00'
);

INSERT INTO SubjectSchedules VALUES(
	4,
	3,
	'20210607 10:00',
	'20210607 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	5,
	2,
	'20210607 15:00',
	'20210607 16:00'
);

INSERT INTO SubjectSchedules VALUES(
	6,
	13,
	'20210607 17:00',
	'20210607 18:00'
);

INSERT INTO SubjectSchedules VALUES(
	7,
	15,
	'20210607 11:00',
	'20210607 12:00'
);

INSERT INTO SubjectSchedules VALUES(
	8,
	11,
	'20210607 10:00',
	'20210607 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	9,
	7,
	'20210607 13:00',
	'20210607 14:00'
);

INSERT INTO SubjectSchedules VALUES(
	10,
	13,
	'20210607 10:00',
	'20210607 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	1,
	14,
	'20210608 09:00',
	'20210608 10:00'
);

INSERT INTO SubjectSchedules VALUES(
	2,
	7,
	'20210608 10:00',
	'20210608 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	3,
	9,
	'20210608 13:00',
	'20210608 14:00'
);

INSERT INTO SubjectSchedules VALUES(
	4,
	13,
	'20210608 10:00',
	'20210608 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	5,
	12,
	'20210608 15:00',
	'20210608 16:00'
);

INSERT INTO SubjectSchedules VALUES(
	6,
	3,
	'20210608 17:00',
	'20210608 18:00'
);

INSERT INTO SubjectSchedules VALUES(
	7,
	17,
	'20210608 11:00',
	'20210608 12:00'
);

INSERT INTO SubjectSchedules VALUES(
	8,
	7,
	'20210608 10:00',
	'20210608 11:00'
);

INSERT INTO SubjectSchedules VALUES(
	9,
	11,
	'20210608 13:00',
	'20210608 14:00'
);

INSERT INTO SubjectSchedules VALUES(
	10,
	13,
	'20210608 10:00',
	'20210608 11:00'
);


INSERT INTO GroupsWithSubjectSchedules VALUES(1, 2);
INSERT INTO GroupsWithSubjectSchedules VALUES(1, 4);

INSERT INTO GroupsWithSubjectSchedules VALUES(2, 12);
INSERT INTO GroupsWithSubjectSchedules VALUES(2, 14);
INSERT INTO GroupsWithSubjectSchedules VALUES(2, 7);

INSERT INTO GroupsWithSubjectSchedules VALUES(3, 3);
INSERT INTO GroupsWithSubjectSchedules VALUES(3, 4);
INSERT INTO GroupsWithSubjectSchedules VALUES(3, 7);

INSERT INTO GroupsWithSubjectSchedules VALUES(4, 3);
INSERT INTO GroupsWithSubjectSchedules VALUES(4, 4);
INSERT INTO GroupsWithSubjectSchedules VALUES(4, 7);

INSERT INTO GroupsWithSubjectSchedules VALUES(4, 13);
INSERT INTO GroupsWithSubjectSchedules VALUES(4, 14);
INSERT INTO GroupsWithSubjectSchedules VALUES(4, 17);

INSERT INTO GroupsWithSubjectSchedules VALUES(5, 14);
INSERT INTO GroupsWithSubjectSchedules VALUES(5, 17);

INSERT INTO Teachers VALUES(
	'Galen',
	'Clemmey',
	'8-1-1972',
	1,
	1600,
	'USA NEW YORK',
	'galen_clemmey@gmail.com',
	'208-820-7059'
);

INSERT INTO Teachers VALUES(
	'Leicester',
	'Aldrick',
	'5-10-1979',
	1,
	1500,
	'USA NEW YORK',
	'leicester_aldrick@gmail.com',
	'533-210-4511'
);

INSERT INTO Teachers VALUES(
	'Marketa',
	'Beddingham',
	'3-5-1994',
	2,
	1200,
	'USA NEW YORK',
	'marketa_beddingham@gmail.com',
	'720-221-5716'
);

INSERT INTO Teachers VALUES(
	'Isiahi',
	'Hannis',
	'5-23-1980',
	2,
	1400,
	'USA NEW YORK',
	'isiahi_hannis@gmail.com',
	'441-888-1384'
);

INSERT INTO Teachers VALUES(
	'Clyve',
	'Lefeaver',
	'8-24-1991',
	1,
	1500,
	'USA NEW YORK',
	'clyve_lefeaver@gmail.com',
	'477-692-4803'
);

INSERT INTO Teachers VALUES(
	'Linn',
	'Shave',
	'10-22-1986',
	2,
	2000,
	'USA NEW YORK',
	'linn_shave@gmail.com',
	'635-821-3290'
);

INSERT INTO Teachers VALUES(
	'Shep',
	'Matyatin',
	'12-28-1991',
	2,
	2400,
	'USA NEW YORK',
	'shep_matyatin@gmail.com',
	'681-892-5954'
);

INSERT INTO Teachers VALUES(
	'Andris',
	'Bremner',
	'5-5-1990',
	1,
	2300,
	'USA NEW YORK',
	'andris_bremmer@gmail.com',
	'744-150-1489'
);

INSERT INTO Teachers VALUES(
	'Lolita',
	'Aery',
	'4-16-1984',
	2,
	2500,
	'USA NEW YORK',
	'lolita_aery@gmail.com',
	'753-557-4029'
);

INSERT INTO Teachers VALUES(
	'Hillyer',
	'Burgsma',
	'1-6-1978',
	2,
	1360,
	'USA NEW YORK',
	'hillyer_burgsma@gmail.com',
	'190-604-2690'
);

INSERT INTO Teachers VALUES(
	'Dimstam',
	'Shardlow',
	'1-3-1995',
	2,
	2000,
	'USA NEW YORK',
	'dimstam_shardlow@gmail.com',
	'205-115-5097'
);

INSERT INTO Teachers VALUES(
	'Andras',
	'Franzettoini',
	'5-15-1990',
	1,
	2000,
	'USA NEW YORK',
	'andras_franzettoini@gmail.com',
	'658-649-3097'
);

INSERT INTO TeachersWithDepartments VALUES(
	1, 1
);
INSERT INTO TeachersWithDepartments VALUES(
	1, 2
);
INSERT INTO TeachersWithDepartments VALUES(
	1, 3
);

INSERT INTO TeachersWithDepartments VALUES(
	2, 4
);
INSERT INTO TeachersWithDepartments VALUES(
	2, 5
);
INSERT INTO TeachersWithDepartments VALUES(
	2, 6
);

INSERT INTO TeachersWithDepartments VALUES(
	3, 7
);
INSERT INTO TeachersWithDepartments VALUES(
	3, 8
);
INSERT INTO TeachersWithDepartments VALUES(
	3, 9
);

INSERT INTO TeachersWithDepartments VALUES(
	4, 10
);
INSERT INTO TeachersWithDepartments VALUES(
	4, 11
);
INSERT INTO TeachersWithDepartments VALUES(
	4, 12
);

INSERT INTO TeachersWithGroups VALUES(
	1, 1
);

INSERT INTO TeachersWithGroups VALUES(
	1, 3
);

INSERT INTO TeachersWithGroups VALUES(
	1, 5
);

INSERT INTO TeachersWithGroups VALUES(
	2, 7
);

INSERT INTO TeachersWithGroups VALUES(
	2, 9
);

INSERT INTO TeachersWithGroups VALUES(
	2, 11
);

INSERT INTO TeachersWithGroups VALUES(
	3, 2
);

INSERT INTO TeachersWithGroups VALUES(
	3, 4
);

INSERT INTO TeachersWithGroups VALUES(
	3, 6
);

INSERT INTO TeachersWithGroups VALUES(
	4, 8
);

INSERT INTO TeachersWithGroups VALUES(
	4, 10
);

INSERT INTO TeachersWithGroups VALUES(
	4, 12
);

INSERT INTO TeachersWithGroups VALUES(
	5, 2
);

INSERT INTO TeachersWithGroups VALUES(
	5, 5
);

INSERT INTO TeachersWithGroups VALUES(
	5, 8
);

INSERT INTO TeachersWithGroups VALUES(
	6, 1
);

INSERT INTO TeachersWithGroups VALUES(
	6, 3
);

INSERT INTO TeachersWithGroups VALUES(
	6, 9
);

INSERT INTO TeachersWithGroups VALUES(
	7, 1
);

INSERT INTO TeachersWithGroups VALUES(
	7, 3
);

INSERT INTO TeachersWithGroups VALUES(
	7, 9
);

INSERT INTO TuitionFees VALUES(
	1, 40000
);

INSERT INTO TuitionFees VALUES(
	2, 50000
);

INSERT INTO TuitionFees VALUES(
	3, 35000
);

INSERT INTO TuitionFees VALUES(
	4, 45000
);

INSERT INTO TuitionFees VALUES(
	5, 25000
);

INSERT INTO TuitionFees VALUES(
	6, 60000
);

INSERT INTO TuitionFees VALUES(
	7, 55000
);

INSERT INTO TuitionFees VALUES(
	8, 40000
);

INSERT INTO PayrollSchedules VALUES(
	1,
	'20200901',
	1
);

INSERT INTO PayrollSchedules VALUES(
	2,
	'20200901',
	2
);

INSERT INTO PayrollSchedules VALUES(
	5,
	'20200901',
	3
);


INSERT INTO PayrollSchedules VALUES(
	3,
	'20200901',
	1
);

INSERT INTO PayrollSchedules VALUES(
	4,
	'20200901',
	1
);