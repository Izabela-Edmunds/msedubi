﻿/*
Deployment script for HigherED_Staging

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "HigherED_Staging"
:setvar DefaultFilePrefix "HigherED_Staging"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                DATE_CORRELATION_OPTIMIZATION OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, OPERATION_MODE = READ_WRITE, FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating [dbo].[Term]...';


GO
CREATE TABLE [dbo].[Term] (
    [TermID]     INT          IDENTITY (1, 1) NOT NULL,
    [Term]       VARCHAR (50) NULL,
    [TermNumber] INT          NULL,
    [SchoolYear] VARCHAR (50) NULL,
    [StartDate]  VARCHAR (50) NULL,
    [EndDate]    VARCHAR (50) NULL,
    [TermAK]     VARCHAR (50) NULL,
    CONSTRAINT [PK_Term_TermPK] PRIMARY KEY CLUSTERED ([TermID] ASC)
);


GO
PRINT N'Creating [dbo].[StudentProfile]...';


GO
CREATE TABLE [dbo].[StudentProfile] (
    [StudentProfileID]      INT          IDENTITY (1, 1) NOT NULL,
    [CRMID]                 VARCHAR (50) NULL,
    [LAST_NAME]             VARCHAR (50) NULL,
    [FIRST_NAME]            VARCHAR (50) NULL,
    [MIDDLE_NAME]           VARCHAR (50) NULL,
    [ADMIT_TERM]            VARCHAR (50) NULL,
    [ADMIT_DESCR]           VARCHAR (50) NULL,
    [ACAD_CAREER]           VARCHAR (50) NULL,
    [ADMIT_TYPE]            VARCHAR (50) NULL,
    [ADMIT_TYPE_DESCR]      VARCHAR (50) NULL,
    [APPL_SOURCE]           VARCHAR (50) NULL,
    [ACAD_PROG]             VARCHAR (50) NULL,
    [ACAD_PROG_DESCR]       VARCHAR (50) NULL,
    [ACAD_PLAN]             VARCHAR (50) NULL,
    [ACAD_PLAN_DESCR]       VARCHAR (50) NULL,
    [GENDER]                VARCHAR (50) NULL,
    [AGE_BY_YEARS]          VARCHAR (50) NULL,
    [ADDRESS1]              VARCHAR (50) NULL,
    [ADDRESS2]              VARCHAR (50) NULL,
    [CITY]                  VARCHAR (50) NULL,
    [STATE]                 VARCHAR (50) NULL,
    [POSTAL]                VARCHAR (50) NULL,
    [CURRENT_PROGRAM]       VARCHAR (50) NULL,
    [CURRENT_PROGRAM_DESCR] VARCHAR (50) NULL,
    [CURRENT_PLAN]          VARCHAR (50) NULL,
    [CURRENT_PLAN_DESCR]    VARCHAR (50) NULL,
    CONSTRAINT [PK_StudentProfile_StudentProfileID] PRIMARY KEY CLUSTERED ([StudentProfileID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[EnrollmentSummary]...';


GO
CREATE TABLE [dbo].[EnrollmentSummary] (
    [EnrollmentSummaryID]   INT          IDENTITY (1, 1) NOT NULL,
    [Term]                  VARCHAR (50) NULL,
    [CRMID]                 VARCHAR (50) NULL,
    [Residential_Commuter]  VARCHAR (50) NULL,
    [InState_OutState]      VARCHAR (50) NULL,
    [Term_Credit_Attempted] VARCHAR (50) NULL,
    [Term_Credits_Earned]   VARCHAR (50) NULL,
    [Term_GPA]              VARCHAR (50) NULL,
    [Transfer_Credit]       VARCHAR (50) NULL,
    [Cum_Credits_Attempted] VARCHAR (50) NULL,
    [Cum_Credits_Earned]    VARCHAR (50) NULL,
    [Cum_GPA]               VARCHAR (50) NULL,
    [Academic_Level]        VARCHAR (50) NULL,
    [Academic_Standing]     VARCHAR (50) NULL,
    CONSTRAINT [PK_EnrollmentSummary_EnrollmentSummaryID] PRIMARY KEY CLUSTERED ([EnrollmentSummaryID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[EnrollmentDetails]...';


GO
CREATE TABLE [dbo].[EnrollmentDetails] (
    [EnrollmentDetailsID] INT          IDENTITY (1, 1) NOT NULL,
    [Subject]             VARCHAR (50) NULL,
    [Catalog]             VARCHAR (50) NULL,
    [Title]               VARCHAR (50) NULL,
    [Term]                VARCHAR (50) NULL,
    [CRMID]               VARCHAR (50) NULL,
    [Class_Section]       VARCHAR (50) NULL,
    [Course_Credit_Hour]  VARCHAR (50) NULL,
    [Instruction_Mode]    VARCHAR (50) NULL,
    [MidTerm_Grade]       VARCHAR (50) NULL,
    [EndofSem_Grade]      VARCHAR (50) NULL,
    [Enrolled_Dropped]    VARCHAR (50) NULL,
    [Enrolled_Date]       VARCHAR (50) NULL,
    [Dropped_Date]        VARCHAR (50) NULL,
    CONSTRAINT [PK_EnrollmentDetails_EnrollmentDetailID] PRIMARY KEY CLUSTERED ([EnrollmentDetailsID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[Summary]...';


GO
CREATE VIEW dbo.Summary
AS
SELECT 
	CAST([CRMID] AS int) StudentAK,
	--CAST([Term] AS int) TermAK,
	CAST(CONVERT( varchar(10),CAST(t.StartDate AS date), 112) AS int) EnrollmentTermDateAK,
	CAST(LEFT([InState_OutState], 1) AS char(1)) ResidencyStatusAK,
	CAST(LEFT([Academic_Level], 2) AS varchar(2)) AcademicLevelAK,
	CAST([Term_Credit_Attempted] AS int) CreditHoursAttempted,
	CAST([Term_Credits_Earned] AS int) CreditHoursEearned,
	CAST([Term_GPA] AS decimal(5,3)) TermGPA,
	CAST([Transfer_Credit] AS decimal(6,3)) TransferCredit,
	CAST([Cum_Credits_Attempted] AS int) CumCreditHoursAttempted,
	CAST([Cum_Credits_Earned] AS int) CumCreditHoursEarned,
	CAST([Cum_GPA] AS decimal(5,3)) CumGPA
FROM dbo.EnrollmentSummary es
INNER JOIN dbo.Term t
	ON es.Term = t.TermAK
GO
PRINT N'Creating [dbo].[Details]...';


GO

CREATE VIEW dbo.Details
AS
SELECT 
	CAST([CRMID] AS int) StudentAK,
	--CAST([Term] AS int) TermAK,
	CAST(CONVERT( varchar(10),CAST(t.StartDate AS date), 112) AS int) EnrollmentTermDateAK,
	CAST([Subject] AS varchar(10)) SubjectAK,
	CAST([Class_Section] AS varchar(5)) ClassSectionAK,
	CAST([Catalog] AS varchar(10)) CatalogAK,
	CONVERT(varchar(10), TRY_CAST([Enrolled_Date] AS date), 112) EnrolledDate,
	CONVERT(varchar(10), TRY_CAST([Dropped_Date] AS date), 112) DropDate,
	CAST([MidTerm_Grade] AS varchar(5)) MidTermGrade,
	CAST([EndofSem_Grade] AS varchar(5)) EndSemesterGrade,
	IIF([Enrolled_Dropped] = 'D', 1, 0) Dropped,
	IIF([Enrolled_Dropped] = 'E', 1, 0) Enrolled
FROM dbo.EnrollmentDetails ed
INNER JOIN dbo.Term t
	ON ed.Term = t.TermAK
WHERE CAST([CRMID] AS int) NOT IN (7148439,7201266,7204322,7270570,7309516,7634219);
GO
PRINT N'Creating [dbo].[Admission]...';


GO
CREATE VIEW dbo.Admission
AS
SELECT 
	CAST(CRMID AS bigint) StudentAK,
	--CAST([ADMIT_TERM] AS int) TermAK,
	CAST(CONVERT( varchar(10),CAST(t.StartDate AS date), 112) AS int) AdmitDateAK,
	CAST([ADMIT_TYPE] AS varchar(5)) AdmitTypeAK,
	LEFT([APPL_SOURCE], 1) ApplicationSourceAK,
	CAST([ACAD_PROG] AS varchar(10)) AcademicProgramAK,
	CAST([ACAD_PLAN] AS varchar(10)) AcademicPlanAK,
	CAST([CURRENT_PROGRAM] AS varchar(10)) CurrentAcademicProgramAK,
	CAST([CURRENT_PLAN] AS varchar(10)) CurrentAcademicPlanAK
FROM dbo.StudentProfile sp
INNER JOIN dbo.Term t
	ON sp.ADMIT_TERM = t.TermAK
GO
PRINT N'Creating [dbo].[Student]...';


GO
CREATE VIEW dbo.Student
AS
WITH results
AS
(
	SELECT DISTINCT
		ROW_NUMBER() OVER(ORDER BY CRMID) ID,
		CAST(CRMID AS bigint) StudentAK,
		CAST(Gender AS varchar(20)) Gender,
		CAST(AGE_BY_YEARS AS int) Age,
		CAST(CITY AS varchar(75)) City,
		CAST([STATE] AS varchar(3)) StateAbbrev,
		CAST(POSTAL AS varchar(15)) PostalCode,
		CAST(ADMIT_TERM AS int) AdmitTerm,
		First_Name FirstName,
		Last_Name LastName,
		MIDDLE_NAME MiddleName, 
		ADDRESS1 Address1,
		ADDRESS2 Address2
	FROM dbo.StudentProfile
)
SELECT *
FROM results
WHERE
ID IN
(
	SELECT MAX(ID) 
	FROM results GROUP BY StudentAK
)
GO
PRINT N'Creating [dbo].[ResidencyStatus]...';


GO
CREATE VIEW dbo.ResidencyStatus
AS
SELECT DISTINCT
	CAST(LEFT([InState_OutState], 1) AS char(1)) ResidencyStatusAK,
	CAST(IIF([InState_OutState] = 'NULL', 'Not Available', [InState_OutState]) AS varchar(15)) ResidencyStatus
FROM [dbo].[EnrollmentSummary]
GO
PRINT N'Creating [dbo].[Class]...';


GO
CREATE VIEW dbo.Class
AS
WITH results
AS
(
	SELECT DISTINCT
		ROW_NUMBER() OVER(ORDER BY [Subject], [Catalog], [Class_Section], [Instruction_Mode]) ID,
		CAST([Subject] AS varchar(10)) SubjectAK,
		CAST([Catalog] AS varchar(10)) CatalogAK,
		CAST([Class_Section] AS varchar(5)) ClassSectionAK,
				CAST(Instruction_Mode AS varchar(35)) InstructionModeAK,
		CAST(Title AS varchar(50)) Title,
		CAST([Course_Credit_Hour] AS int) CourseCreditHours
	FROM [dbo].[EnrollmentDetails]
)
SELECT *
FROM results r
WHERE ID IN
(
	SELECT MAX(ID)
	FROM results
	GROUP BY SubjectAK, ClassSectionAK, CatalogAK, InstructionModeAK
)
GO
PRINT N'Creating [dbo].[ApplicationSource]...';


GO
CREATE VIEW dbo.ApplicationSource
AS
SELECT DISTINCT
	CAST(LEFT(Appl_Source, 1) AS varchar(3)) ApplicationSourceAK,
	CAST(Appl_Source AS varchar(25)) ApplicationSource
FROM dbo.StudentProfile
GO
PRINT N'Creating [dbo].[AdmitType]...';


GO
CREATE VIEW dbo.AdmitType
AS
SELECT DISTINCT
	CAST(Admit_Type AS varchar(5)) AdmitTypeAK,
	CAST(Admit_Type_Descr AS varchar(75)) AdmitType
FROM dbo.StudentProfile
GO
PRINT N'Creating [dbo].[AcademicProgram]...';


GO
CREATE VIEW dbo.AcademicProgram
AS
SELECT DISTINCT
	CAST([ACAD_PROG] AS varchar(10)) AcademicProgramAK, 
	CAST([ACAD_PROG_DESCR] AS varchar(50)) AcademicProgram,
	CAST([ACAD_PLAN] AS varchar(10)) AcademicPlanAK, 
	CAST([ACAD_PLAN_DESCR] AS varchar(50)) AcademicPlan
FROM dbo.StudentProfile
UNION 
SELECT DISTINCT
	CAST([Current_Program] AS varchar(10)) AcademicProgramAK,  
	CAST([Current_Program_DESCR] AS varchar(50)) AcademicProgram,
	CAST([Current_PLAN] AS varchar(10)) AcademicPlanAK, 
	CAST([Current_PLAN_DESCR] AS varchar(50)) AcademicPlan
FROM dbo.StudentProfile
GO
PRINT N'Creating [dbo].[AcademicLevel]...';


GO
CREATE VIEW dbo.AcademicLevel
AS
SELECT DISTINCT 
	CAST(LEFT([Academic_Level], 2) AS varchar(2)) AcademicLevelAK,
	CAST([Academic_Level] AS varchar(25)) AcademicLevel
FROM dbo.EnrollmentSummary
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
