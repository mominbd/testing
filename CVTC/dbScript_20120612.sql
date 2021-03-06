USE MASTER
GO
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME='StudentSuccess')
DROP DATABASE StudentSuccess
GO
CREATE DATABASE StudentSuccess
go
USE StudentSuccess

GO

/****** Object:  User [migration]    Script Date: 06/12/2012 20:29:11 ******/
CREATE USER [migration] FOR LOGIN [migration] WITH DEFAULT_SCHEMA=[dbo]
GO

/****** Object:  StoredProcedure [dbo].[AnswerOfQuestion_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AnswerOfQuestion_insert]

@AnswerOID int, 
@SectionOID int,
@QuestionOID int, 
@Response varchar(10),
@CreatedBy int 

AS
BEGIN

	INSERT INTO AnswerOfQuestion( AnswerOID, SectionOID, QuestionOID, Response, CreatedBy)
	values( @AnswerOID, @SectionOID, @QuestionOID, @Response, @CreatedBy)

END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_RefUpdate]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_RefUpdate]

AS
--BEGIN
--	DECLARE @menuID int
--	DECLARE @aID int
--
--	DECLARE aidUpdate_Cursor CURSOR FOR
--	SELECT MenuID,AssessmentOID--,AssessmentName
--	FROM dbo.Assessment,dbo.Menu
--	WHERE dbo.Assessment.RefMenuID=dbo.Menu.MenuID
--
--	OPEN aidUpdate_Cursor;
--	FETCH NEXT FROM aidUpdate_Cursor
--	INTO @menuID,@aID
--
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--
--		UPDATE dbo.Menu
--		SET URL=SUBSTRING(URL, 1, CHARINDEX('=', URL) )+CAST(@aID AS varchar(10))		
--		FROM dbo.Menu
--		WHERE menuID BETWEEN @MenuID and @MenuID+8 and  URL!=' '
--
----		PRINT @MenuID
----		PRINT  @aID
--		----Get Next
--		FETCH NEXT FROM aidUpdate_Cursor
--		INTO @menuID,@aID
--	END
--	CLOSE aidUpdate_Cursor;
--	DEALLOCATE aidUpdate_Cursor;
--END
GO
/****** Object:  Table [dbo].[Course]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[BannerStudentName] [varchar](80) NOT NULL,
	[BannerStudentIDNumber] [varchar](12) NULL,
	[TermCodeofProgramEnrollment] [varchar](20) NOT NULL,
	[CourseNumber] [varchar](15) NULL,
	[CourseTitle] [varchar](100) NULL,
	[FinalGrade] [varchar](15) NULL,
	[TermCodeOfCourseEnrollment] [varchar](15) NULL,
	[MethodOfDelivery] [varchar](50) NULL,
	[ImportDate] [datetime] NULL,
	[CourseOID] [int] IDENTITY(1,1) NOT NULL,
	[FileCreationDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Domain]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Domain](
	[DomainOID] [int] IDENTITY(1,1) NOT NULL,
	[DomainName] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_Domain] PRIMARY KEY CLUSTERED 
(
	[DomainOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Assessment](
	[AssessmentOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentName] [varchar](100) NOT NULL,
	[RefMenuID] [int] NOT NULL,
	[TotalQuestion] [int] NULL,
	[TotalFlag] [int] NULL,
	[TotalFlagPoint] [int] NULL,
	[TotalSection] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
	[Locked] [smallint] NOT NULL,
	[RedirectURL] [varchar](400) NULL,
	[Note] [varchar](400) NULL,
	[Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[AssessmentOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu_backup]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu_backup](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[NameMenu] [varchar](50) NOT NULL,
	[MenuID] [int] NOT NULL,
	[URL] [varchar](100) NOT NULL,
	[MenuLevel] [int] NOT NULL,
	[Parent] [int] NULL,
	[IsLeave] [int] NOT NULL,
	[IsExpanded] [int] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[NameMenu] [varchar](50) NOT NULL,
	[MenuID] [int] NOT NULL,
	[URL] [varchar](100) NOT NULL,
	[MenuLevel] [int] NOT NULL,
	[Parent] [int] NULL,
	[IsLeave] [int] NOT NULL,
	[IsExpanded] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MessageCenter]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MessageCenter](
	[MessageOID] [int] IDENTITY(1,1) NOT NULL,
	[SendFrom] [int] NULL,
	[Recipient] [varchar](500) NULL,
	[Subject] [varchar](500) NULL,
	[Status] [varchar](50) NULL,
	[Mark] [int] NULL,
	[MessageBody] [varchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MessageCenter] PRIMARY KEY CLUSTERED 
(
	[MessageOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Intervention]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Intervention](
	[InterventionOID] [int] IDENTITY(1,1) NOT NULL,
	[InterventionName] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
	[DomainID] [int] NULL,
 CONSTRAINT [PK_Intervention] PRIMARY KEY CLUSTERED 
(
	[InterventionOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Prescription]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prescription](
	[PrescriptionOID] [int] IDENTITY(1,1) NOT NULL,
	[StudentOID] [int] NULL,
	[RiskOID] [int] NULL,
	[UserOID] [int] NULL,
	[DomainOID] [int] NULL,
	[InterventionOID] [int] NULL,
	[LatestActionDate] [datetime] NULL,
	[LatestContact] [datetime] NULL,
	[Internal] [int] NULL,
	[Prescribed] [int] NULL,
	[Completed] [int] NULL,
	[Email] [int] NULL,
	[Telephone] [int] NULL,
	[InPerson] [int] NULL,
	[HandOff] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
	[Comment] [varchar](100) NULL,
	[Urgent] [int] NULL,
	[Participating] [int] NULL,
	[Testing] [int] NULL,
	[Unread] [varchar](50) NOT NULL,
	[AssessmentOID] [int] NULL,
 CONSTRAINT [PK_Prescription] PRIMARY KEY CLUSTERED 
(
	[PrescriptionOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Mominul1]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mominul1]
@output varchar(100) OUTPUT

AS
BEGIN
DECLARE @document varchar(64)

SELECT @document = 'Reflectors,are,vital safety' +
                   ' components of vital your bi,cycle.'
--select @output= CHARINDEX('vital', @document)
select @output=SUBSTRING (@document,10,CHARINDEX (',',@document))
	
END
GO
/****** Object:  StoredProcedure [dbo].[Mominul]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mominul]
@output varchar(100) OUTPUT

AS
BEGIN
declare @tempColTest varchar(100)
declare @SortColumnName varchar(100)
declare @count int
declare @i int
declare @posCol int
declare @numberOfDelimeterOfCol int

set @SortColumnName='Career Choice:-Rank,Degree Focus:-Rank'
set @count = CHARINDEX (',',@SortColumnName)-1

set  @numberOfDelimeterOfCol=(LEN(@SortColumnName) - LEN(REPLACE(@SortColumnName, ',', '')))
set @i=0
set @posCol=1

while(@i<=@numberOfDelimeterOfCol)
begin
--if(@count >0)
--begin
--set @tempColTest=SUBSTRING(@SortColumnName,1,@count)
set @tempColTest=SUBSTRING(@SortColumnName,@posCol,CHARINDEX (',',@SortColumnName)-1)
set @posCol=len(@tempColTest)+2

--end
set @i=@i+1
select @output=@tempColTest
end
--select @output=@numberOfDelimeterOfCol
	
END
GO
/****** Object:  Table [dbo].[MessageUser]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MessageUser](
	[MessageUserOID] [int] IDENTITY(1,1) NOT NULL,
	[UserOID] [int] NOT NULL,
	[MessageOID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UStatus] [varchar](50) NULL,
	[UMark] [int] NULL,
 CONSTRAINT [PK_MessageUser] PRIMARY KEY CLUSTERED 
(
	[MessageUserOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrescriptionStatus]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrescriptionStatus](
	[PrescriptionStatusID] [int] IDENTITY(1,1) NOT NULL,
	[UserOID] [int] NULL,
	[PrescriptionOID] [int] NULL,
	[Status] [varchar](50) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PrescriptionStatus] PRIMARY KEY CLUSTERED 
(
	[PrescriptionStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NTO]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NTO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BannerID] [varchar](100) NOT NULL,
	[Type] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_NTO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Report]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Report](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[ColModel] [varchar](max) NULL,
	[ColNames] [varchar](500) NULL,
	[CurrentData] [varchar](max) NULL,
	[ReportName] [varchar](200) NULL,
	[TableName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reports](
	[ReportOID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](100) NULL,
	[SPName] [varchar](1000) NULL,
	[SPParams] [varchar](5000) NULL,
	[GridColumns] [varchar](5000) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED 
(
	[ReportOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ScoreDetailTable]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScoreDetailTable](
	[AssessmentOID] [int] NULL,
	[SectionOID] [int] NULL,
	[ScoreName] [varchar](100) NULL,
	[RankName] [varchar](100) NULL,
	[StudentOID] [int] NULL,
	[BannerID] [varchar](20) NULL,
	[StudentName] [varchar](100) NULL,
	[Program] [varchar](100) NULL,
	[Score] [decimal](18, 2) NULL,
	[Rank] [decimal](18, 0) NULL,
	[CreatedDate] [datetime] NULL,
	[NumberOfPrinted] [int] NULL,
	[NumberOfFlag] [int] NULL,
	[FullTimeOrPartTimeIndicator] [varchar](50) NULL,
	[CumulativeGPA] [numeric](3, 2) NULL,
	[CreditsAttempted] [numeric](11, 2) NULL,
	[CreditsEarned] [numeric](13, 2) NULL,
	[LatestCompassPrealgebraTestScore] [varchar](15) NULL,
	[LatestCompassAlgebraTestScore] [varchar](15) NULL,
	[LatestCompassWritingTestScore] [varchar](15) NULL,
	[LatestCompassReadingTestScore] [varchar](15) NULL,
	[LatestACTEnglishAssessmentScore] [varchar](15) NULL,
	[LatestACTMathAssessmentScore] [varchar](15) NULL,
	[LatestACTReadingAssessmentScore] [varchar](15) NULL,
	[LatestACTScienceAssessmentScore] [varchar](15) NULL,
	[LatestTestingDate] [datetime] NULL,
	[HighSchoolName] [varchar](80) NULL,
	[HighSchoolGraduationDate] [datetime] NULL,
	[HomeTelephoneNumber] [varchar](20) NULL,
	[MailingAddressLineOne] [varchar](75) NULL,
	[MailingAddressLineTwo] [varchar](75) NULL,
	[MailingAddressLineThree] [varchar](75) NULL,
	[City] [varchar](50) NULL,
	[StateName] [varchar](20) NULL,
	[ZipCode] [varchar](30) NULL,
	[EmailAddress] [varchar](128) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[BannerStudentName] [varchar](80) NOT NULL,
	[BannerStudentIDNumber] [varchar](12) NOT NULL,
	[TermCodeofProgramEnrollment] [varchar](20) NOT NULL,
	[FullTimeOrPartTimeIndicator] [varchar](10) NULL,
	[CumulativeGPA] [numeric](3, 2) NULL,
	[CreditsAttempted] [numeric](11, 2) NULL,
	[CreditsEarned] [numeric](11, 2) NULL,
	[LatestCompassPrealgebraTestScore] [varchar](15) NULL,
	[LatestCompassAlgebraTestScore] [varchar](15) NULL,
	[LatestCompassWritingTestScore] [varchar](15) NULL,
	[LatestCompassReadingTestScore] [varchar](15) NULL,
	[LatestACTEnglishAssessmentScore] [varchar](15) NULL,
	[LatestACTMathAssessmentScore] [varchar](15) NULL,
	[LatestACTReadingAssessmentScore] [varchar](15) NULL,
	[LatestACTScienceAssessmentScore] [varchar](15) NULL,
	[LatestTestingDate] [datetime] NULL,
	[HighSchoolName] [varchar](80) NULL,
	[HighSchoolGraduationDate] [datetime] NULL,
	[HomeTelephoneNumber] [varchar](20) NULL,
	[MailingAddressLineOne] [varchar](75) NULL,
	[MailingAddressLineTwo] [varchar](75) NULL,
	[MailingAddressLineThree] [varchar](75) NULL,
	[City] [varchar](50) NULL,
	[StateName] [varchar](20) NULL,
	[ZipCode] [varchar](30) NULL,
	[EmailAddress] [varchar](128) NULL,
	[ImportDateFileCreationDate] [datetime] NOT NULL,
	[PreprogramIndicator] [varchar](5) NULL,
	[MajorProgramEnrollmentName] [varchar](75) NULL,
	[StudentOID] [int] IDENTITY(1,1) NOT NULL,
	[FileCreationDate] [datetime] NOT NULL,
	[ResultLetterSentTimes] [int] NULL,
	[Status] [varchar](50) NULL,
	[FirstName] [varchar](80) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[BirthDate] [date] NULL,
	[PriorCreditQuestion] [varchar](400) NULL,
 CONSTRAINT [PK__Student__48CFD27E] PRIMARY KEY CLUSTERED 
(
	[StudentOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [StudentIDNumber] UNIQUE NONCLUSTERED 
(
	[BannerStudentIDNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split](@String varchar(8000), @Delimiter char(1))       
    returns @temptable TABLE (items varchar(8000))       
    as       
    begin       
        declare @idx int       
        declare @slice varchar(8000)       
          
        select @idx = 1       
            if len(@String)<1 or @String is null  return       
         
       while @idx!= 0       
       begin       
           set @idx = charindex(@Delimiter,@String)       
           if @idx!=0       
               set @slice = left(@String,@idx - 1)       
           else       
               set @slice = @String       
             
           if(len(@slice)>0)  
               insert into @temptable(Items) values(@slice)       
     
           set @String = right(@String,len(@String) - @idx)       
           if len(@String) = 0 break       
       end   
   return       
   end
GO
/****** Object:  Table [dbo].[User]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserOID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[LastName] [varchar](200) NULL,
	[FirstName] [varchar](200) NULL,
	[Phone] [varchar](100) NULL,
	[Email] [varchar](200) NULL,
	[Advocacy] [varchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Freez] [varchar](30) NULL,
	[Status] [varchar](100) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Task_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_Delete]
@TaskOID int 
AS

BEGIN

DELETE FROM [dbo.Task]  
WHERE  TaskOID= @TaskOID

END
GO
/****** Object:  Table [dbo].[tmp]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp](
	[LastFirst] [varchar](300) NULL,
	[test] [nchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TermCode]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TermCode](
	[TermCodeOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentOID] [int] NULL,
	[TermCodeName] [varchar](20) NULL,
 CONSTRAINT [PK_TermCode] PRIMARY KEY CLUSTERED 
(
	[TermCodeOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TEMP]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMP](
	[OID] [int] NOT NULL,
	[inactive_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskUser]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskUser](
	[TaskUserOID] [int] IDENTITY(1,1) NOT NULL,
	[UserOID] [int] NOT NULL,
	[TaskOID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UStatus] [varchar](50) NULL,
	[UMark] [int] NULL,
 CONSTRAINT [PK_TaskUser] PRIMARY KEY CLUSTERED 
(
	[TaskUserOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Task]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[TaskOID] [int] IDENTITY(1,1) NOT NULL,
	[SendFrom] [int] NOT NULL,
	[Recipient] [varchar](500) NULL,
	[Subject] [varchar](500) NULL,
	[Priority] [int] NULL,
	[MessageBody] [varchar](max) NULL,
	[CompletionDateTime] [datetime] NOT NULL,
	[Status] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Mark] [int] NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[TaskOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Student_UpdateTestingDate]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Student_UpdateTestingDate]
@BannerID varchar (12),
@LatestTestingDate datetime
AS
                                BEGIN
UPDATE [Student]   SET LatestTestingDate = @LatestTestingDate
WHERE BannerStudentIDNumber = @BannerID
END
GO
/****** Object:  StoredProcedure [dbo].[Student_Update_Temp]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Update_Temp]
@StudentOID int,
@BannerStudentIDNumber varchar(12),
@BannerStudentName varchar(80),
@TermCodeofProgramEnrollment varchar(20),
@MajorProgramEnrollmentName varchar(75),
@FullTimeOrPartTimeIndicator varchar(10),
@CumulativeGPA numeric(3,2) ,
@CreditsAttempted numeric(11,3),
@CreditsEarned numeric(11,3),
@LatestCompassPrealgebraTestScore varchar(15),
@LatestCompassAlgebraTestScore varchar(15),
@LatestCompassWritingTestScore varchar(15),
@LatestCompassReadingTestScore varchar(15),
@LatestACTEnglishAssessmentScore varchar(15),
@LatestACTMathAssessmentScore varchar(15),
@LatestACTReadingAssessmentScore varchar(15),
@LatestACTScienceAssessmentScore varchar(15),
@LatestTestingDate datetime,
@HighSchoolName varchar(80),
@HighSchoolGraduationDate datetime,
@HomeTelephoneNumber varchar(20),
@MailingAddressLineOne varchar(75),
@MailingAddressLineTwo varchar(75),
@MailingAddressLineThree varchar(75),
@City varchar(50),
@StateName varchar(20),
@ZipCode varchar(30),
@EmailAddress varchar(128),
@ImportDateFileCreationDate datetime,
@PreprogramIndicator varchar(5),
@BirthDate Datetime,
@FirstName varchar(80),
@LastName varchar(80),
@MiddleName varchar(80),
@PriorCredit varchar(80),
@Status varchar(80)

AS
BEGIN

UPDATE dbo.Student
SET BannerStudentName=@BannerStudentName,BannerStudentIDNumber=@BannerStudentIDNumber,
 TermCodeofProgramEnrollment=@TermCodeofProgramEnrollment, MajorProgramEnrollmentName=@MajorProgramEnrollmentName,
FullTimeOrPartTimeIndicator=@FullTimeOrPartTimeIndicator, 
CumulativeGPA=@CumulativeGPA, CreditsAttempted=@CreditsAttempted, CreditsEarned=@CreditsEarned, 
LatestCompassPrealgebraTestScore=@LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore=@LatestCompassAlgebraTestScore,
 LatestCompassWritingTestScore=@LatestCompassWritingTestScore, LatestCompassReadingTestScore=@LatestCompassReadingTestScore,
 LatestACTEnglishAssessmentScore=@LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore=@LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore=@LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore=@LatestACTScienceAssessmentScore, 
LatestTestingDate=@LatestTestingDate, HighSchoolName=@HighSchoolName,
 HighSchoolGraduationDate=@HighSchoolGraduationDate, HomeTelephoneNumber=@HomeTelephoneNumber, 
MailingAddressLineOne=@MailingAddressLineOne, MailingAddressLineTwo=@MailingAddressLineTwo, 
MailingAddressLineThree=@MailingAddressLineThree, City=@City, StateName=@StateName, ZipCode=@ZipCode, EmailAddress=@EmailAddress,
 ImportDateFileCreationDate=@ImportDateFileCreationDate, PreprogramIndicator=@PreprogramIndicator,
 FirstName=@FirstName,LastName=@LastName,MiddleName=@MiddleName,BirthDate=@BirthDate,PriorCreditQuestion=@PriorCredit,
 Status=@Status

WHERE StudentOID=@StudentOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Student_Update_Old]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Update_Old]
@StudentOID int,
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@MajorProgramEnrollmentName varchar(75),
@BirthDate Datetime,
@FirstName varchar(80),
@LastName varchar(80),
@MiddleName varchar(80),
@PriorCredit varchar(80),
@Status varchar(20)

AS
BEGIN

UPDATE dbo.Student
SET BannerStudentName=@BannerStudentName, BannerStudentIDNumber=@BannerStudentIDNumber,
 TermCodeofProgramEnrollment=@TermCodeofProgramEnrollment, 
 FirstName=@FirstName,LastName=@LastName,MiddleName=@MiddleName,BirthDate=@BirthDate,PriorCreditQuestion=@PriorCredit,
 Status=@Status,MajorProgramEnrollmentName=@MajorProgramEnrollmentName

WHERE StudentOID=@StudentOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Student_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Update]
@StudentOID int,
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@FullTimeOrPartTimeIndicator varchar(10),
@CumulativeGPA numeric(3,2) ,
@CreditsAttempted numeric(11,3),
@CreditsEarned numeric(11,3),
@LatestCompassPrealgebraTestScore varchar(15),
@LatestCompassAlgebraTestScore varchar(15),
@LatestCompassWritingTestScore varchar(15),
@LatestCompassReadingTestScore varchar(15),
@LatestACTEnglishAssessmentScore varchar(15),
@LatestACTMathAssessmentScore varchar(15),
@LatestACTReadingAssessmentScore varchar(15),
@LatestACTScienceAssessmentScore varchar(15),
@LatestTestingDate datetime,
@HighSchoolName varchar(80),
@HighSchoolGraduationDate datetime,
@HomeTelephoneNumber varchar(20),
@MailingAddressLineOne varchar(75),
@MailingAddressLineTwo varchar(75),
@MailingAddressLineThree varchar(75),
@City varchar(50),
@StateName varchar(20),
@ZipCode varchar(30),
@EmailAddress varchar(128),
@ImportDateFileCreationDate datetime,
@PreprogramIndicator varchar(5),
@MajorProgramEnrollmentName varchar(75)



AS
BEGIN

UPDATE dbo.Student
SET BannerStudentName=@BannerStudentName, BannerStudentIDNumber=@BannerStudentIDNumber,
 TermCodeofProgramEnrollment=@TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator=@FullTimeOrPartTimeIndicator, 
CumulativeGPA=@CumulativeGPA, CreditsAttempted=@CreditsAttempted, CreditsEarned=@CreditsEarned, 
LatestCompassPrealgebraTestScore=@LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore=@LatestCompassAlgebraTestScore,
 LatestCompassWritingTestScore=@LatestCompassWritingTestScore, LatestCompassReadingTestScore=@LatestCompassReadingTestScore,
 LatestACTEnglishAssessmentScore=@LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore=@LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore=@LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore=@LatestACTScienceAssessmentScore, 
LatestTestingDate=@LatestTestingDate, HighSchoolName=@HighSchoolName,
 HighSchoolGraduationDate=@HighSchoolGraduationDate, HomeTelephoneNumber=@HomeTelephoneNumber, 
MailingAddressLineOne=@MailingAddressLineOne, MailingAddressLineTwo=@MailingAddressLineTwo, 
MailingAddressLineThree=@MailingAddressLineThree, City=@City, StateName=@StateName, ZipCode=@ZipCode, EmailAddress=@EmailAddress,
 ImportDateFileCreationDate=@ImportDateFileCreationDate, PreprogramIndicator=@PreprogramIndicator, 
MajorProgramEnrollmentName=@MajorProgramEnrollmentName
WHERE StudentOID=@StudentOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Student_SelectjqGrid{0}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Student_SelectjqGrid{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Student]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TermCodeofProgramEnrollment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TermCodeofProgramEnrollment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullTimeOrPartTimeIndicator'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullTimeOrPartTimeIndicator'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CumulativeGPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CumulativeGPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditsAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditsAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditsEarned'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditsEarned'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestCompassPrealgebraTestScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestCompassPrealgebraTestScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestCompassAlgebraTestScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestCompassAlgebraTestScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestCompassWritingTestScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestCompassWritingTestScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestCompassReadingTestScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestCompassReadingTestScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestACTEnglishAssessmentScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestACTEnglishAssessmentScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestACTMathAssessmentScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestACTMathAssessmentScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestACTReadingAssessmentScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestACTReadingAssessmentScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestACTScienceAssessmentScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestACTScienceAssessmentScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestTestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestTestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchoolName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchoolName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchoolGraduationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchoolGraduationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HomeTelephoneNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HomeTelephoneNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineOne'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineOne'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineTwo'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineTwo'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineThree'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MailingAddressLineThree'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'City'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'City'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StateName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StateName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZipCode'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZipCode'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EmailAddress'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EmailAddress'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDateFileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDateFileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PreprogramIndicator'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PreprogramIndicator'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MajorProgramEnrollmentName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MajorProgramEnrollmentName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate 
   FROM     [Student] ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[Student_ByStudentBannerID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Student_ByStudentBannerID]
@BannerID varchar(100)

AS
BEGIN
	SELECT *
	FROM dbo.Student
	WHERE BannerStudentIDNumber=@BannerID

END
GO
/****** Object:  StoredProcedure [dbo].[Student_ByBannerAndStudentName]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_ByBannerAndStudentName]
@BannerID varchar(12),
@StudentName varchar(80)

AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, StateName, ZipCode, EmailAddress, ImportDateFileCreationDate, PreprogramIndicator, MajorProgramEnrollmentName, StudentOID, FileCreationDate
	FROM dbo.Student
	WHERE BannerStudentIDNumber=@BannerID AND BannerStudentName=@StudentName

END
GO
/****** Object:  StoredProcedure [dbo].[StudentByRowID_Profile]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentByRowID_Profile]
@RowID int 
AS
BEGIN
	
	SELECT * FROM
	(
	
	SELECT  ROW_NUMBER() OVER (ORDER BY Student.BannerStudentIDNumber ASC  ) AS RowNum,Student.BannerStudentName, Student.BannerStudentIDNumber,Student.StudentOID
	
	 FROM         Student 
                     

	) AS T 
	WHERE T.RowNum=@RowID
	--ORDER BY  T.RowNum ASC
	

END
GO
/****** Object:  StoredProcedure [dbo].[StudentOID_ByStudentBannerID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentOID_ByStudentBannerID]
@BannerOID varchar(12)

AS
BEGIN
	SELECT StudentOID
	FROM dbo.Student
	WHERE BannerStudentIDNumber=@BannerOID

END
GO
/****** Object:  StoredProcedure [dbo].[StudentID_ByStudentBannerOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentID_ByStudentBannerOID]
@BannerOID int 

AS
BEGIN
	SELECT BannerStudentIDNumber
	FROM dbo.Student
	WHERE StudentOID=@BannerOID

END
GO
/****** Object:  StoredProcedure [dbo].[TaskStatus_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TaskStatus_Update]
@TaskOID int,
@Status varchar(50) 
 
AS
BEGIN
UPDATE dbo.Task
SET Status=@Status 
WHERE TaskOID = @TaskOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Task_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_Update]
@TaskOID int,
@SendFrom int,
@Recipient varchar (500),
@Subject varchar (500),
@MessageBody varchar (MAX),
@CompletionDate datetime ,
@priority int

AS
BEGIN

	UPDATE dbo.Task
	 SET SendFrom = @SendFrom,Recipient = @Recipient,Subject = @Subject,Priority = @priority,MessageBody = @MessageBody,CompletionDateTime = @CompletionDate
	WHERE TaskOID = @TaskOID
END
GO
/****** Object:  StoredProcedure [dbo].[Task_Select{0}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_Select{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Task]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'TaskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TaskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TaskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TaskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN SendFrom
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN SendFrom
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Recipient
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Recipient
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Subject
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Subject
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Priority'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Priority
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Priority'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Priority
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageBody
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageBody
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CompletionDateTime'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CompletionDateTime
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CompletionDateTime'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CompletionDateTime
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Status
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Status
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
TaskOID, 
SendFrom, 
Recipient, 
Subject, 
Priority, 
MessageBody, 
CompletionDateTime, 
Status, 
CreatedDate 
   FROM     [Task] ) 
SELECT
TaskOID, 
SendFrom, 
Recipient, 
Subject, 
Priority, 
MessageBody, 
CompletionDateTime, 
Status, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[Task_Select]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_Select]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
												@createdBy int,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Task]
														WHERE SendFrom=@createdBy 
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'TaskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TaskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TaskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TaskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN SendFrom
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN SendFrom
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Recipient
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Recipient
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Subject
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Subject
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Priority'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Priority
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Priority'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Priority
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageBody
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageBody
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CompletionDateTime'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CompletionDateTime
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CompletionDateTime'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CompletionDateTime
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Status
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Status
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
TaskOID, 
SendFrom, 
Recipient, 
Subject, 
Priority, 
MessageBody, 
CompletionDateTime, 
Status, 
CreatedDate 
   FROM     [Task] 
WHERE SendFrom=@createdBy 
) 
SELECT
TaskOID, 
SendFrom, 
Recipient, 
Subject, 
Priority, 
MessageBody, 
CompletionDateTime, 
Status, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1 AND SendFrom=@createdBy 
 END
GO
/****** Object:  StoredProcedure [dbo].[Task_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_insert]

@SendFrom int,
@Recipient varchar (500),
@Subject varchar (500),
@MessageBody varchar (MAX),
@CompletionDate datetime,
@priority int,
@Status varchar (500),
@Mark int

AS
                                BEGIN
INSERT INTO Task (SendFrom ,Recipient,Subject,MessageBody,CompletionDateTime,priority,Status, Mark)
Values ( @SendFrom,@Recipient,@Subject,@MessageBody,@CompletionDate,@priority, @Status, @Mark)

--Insert Into MessageUSER table
DECLARE @title varchar(80), @message varchar(80)
DECLARE @lastName varchar(200)
DECLARE @firstName varchar(200)
DECLARE @taskOID int
DECLARE @useroid int 
SET @taskOID=(SELECT MAX(TaskOID) FROM dbo.Task)

DECLARE titles_cursor CURSOR FOR
SELECT * FROM dbo.split(@Recipient,',')

 OPEN titles_cursor
   FETCH NEXT FROM titles_cursor INTO @title

 WHILE @@FETCH_STATUS = 0
   BEGIN
      
	SELECT @title=LTRIM(RTRIM(@title))
	SELECT @lastName = LEFT(@title,CHARINDEX(' ', @title))    
    --PRINT @lastName
	SELECT @firstName = RIGHT(@title,CHARINDEX(' ', @title)-1)  
	--PRINT @firstName  
    SET @useroid=(SELECT TOP(1) useroid FROM [User]
				 WHERE LastName=@lastName and FirstName=@firstName)
	--Insert
	INSERT INTO dbo.TaskUser( UserOID, TaskOID, UStatus, UMark)
	VALUES(@useroid,@taskOID, @Status, @Mark)
      FETCH NEXT FROM titles_cursor INTO @title
   
   END

CLOSE titles_cursor
DEALLOCATE titles_cursor
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetTaskByStartAndEndDateUOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetTaskByStartAndEndDateUOID]
	 @start datetime,
	 @end datetime,
	 @userOID int
AS
BEGIN

	SELECT dbo.Task.TaskOID, SendFrom, '' AS TaskFrom ,Recipient, Subject, Priority, MessageBody, CompletionDateTime, Status, dbo.Task.CreatedDate
	FROM dbo.Task--,dbo.[User] LEFT JOIN dbo.TaskUser ON dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	WHERE CompletionDateTime between @start and @end AND SendFrom=@userOID
	--AND  dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	--AND dbo.TaskUser.UserOID=dbo.[User].UserOID
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetTaskByStartAndEndDate]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetTaskByStartAndEndDate]
	 @start datetime,
	 @end datetime
	 --@userOID int
AS
BEGIN

	SELECT dbo.Task.TaskOID, SendFrom, '' AS TaskFrom ,Recipient, Subject, Priority, MessageBody, CompletionDateTime, Status, dbo.Task.CreatedDate
	FROM dbo.Task--,dbo.[User] LEFT JOIN dbo.TaskUser ON dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	WHERE CompletionDateTime between @start and @end --AND SendFrom=@userOID
	--AND  dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	--AND dbo.TaskUser.UserOID=dbo.[User].UserOID
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetByUserOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetByUserOID]
@UserOID int


AS
BEGIN

	SELECT  TaskOID, SendFrom, LastName+','+FirstName AS TaskFrom ,Recipient, Subject, Priority, MessageBody, CompletionDateTime, [User].Status, dbo.Task.CreatedDate 
	FROM dbo.Task,dbo.[User]
	WHERE SendFrom = @UserOID
AND dbo.Task.SendFrom=dbo.[User].UserOID AND ([User].[Status] <> 'Completed')
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetByOID]
@TaskOID int


AS
BEGIN

	SELECT  TaskOID, SendFrom, Recipient, Subject, Priority, MessageBody, CompletionDateTime, Status, CreatedDate 
	FROM dbo.Task
	WHERE TaskOID = @TaskOID
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetAllTask]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetAllTask]


AS
BEGIN
	SELECT TaskOID, SendFrom, Recipient, Subject, Priority, MessageBody, CompletionDateTime, Status, CreatedDate
	FROM dbo.Task

END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetAllRecipientCompletedByUserOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetAllRecipientCompletedByUserOID]
	@UserOID int
AS
BEGIN

	SELECT  dbo.Task.TaskOID, SendFrom, LastName+','+FirstName AS TaskFrom ,Recipient, Subject, Priority, MessageBody, CompletionDateTime, [User].Status, dbo.Task.CreatedDate, 
	dbo.TaskUser.TaskUserOID, dbo.TaskUser.UStatus, dbo.TaskUser.UMark
	FROM dbo.Task,dbo.TaskUser,dbo.[User]
	WHERE dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	AND dbo.TaskUser.UserOID=@UserOID
AND dbo.TaskUser.UserOID=dbo.[User].UserOID AND dbo.TaskUser.UStatus = 'Completed'
END
GO
/****** Object:  StoredProcedure [dbo].[Task_GetAllRecipientByUserOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_GetAllRecipientByUserOID]
	@UserOID int
AS
BEGIN

	SELECT  dbo.Task.TaskOID, SendFrom, LastName+','+FirstName AS TaskFrom ,Recipient, Subject, Priority, MessageBody, CompletionDateTime, [User].Status, dbo.Task.CreatedDate,
	dbo.TaskUser.TaskUserOID, dbo.TaskUser.UStatus, dbo.TaskUser.UMark
	FROM dbo.Task,dbo.TaskUser,dbo.[User]
	WHERE dbo.Task.TaskOID=dbo.TaskUser.TaskOID
	AND dbo.TaskUser.UserOID=@UserOID
AND dbo.TaskUser.UserOID=dbo.[User].UserOID  AND dbo.TaskUser.UStatus <> 'Completed'
END
GO
/****** Object:  StoredProcedure [dbo].[TaskUserUStatus_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TaskUserUStatus_Update]
@TaskUserOID int,
@UStatus varchar(50) 
 
AS
BEGIN
UPDATE dbo.TaskUser
SET UStatus=@UStatus 
WHERE TaskUserOID=@TaskUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[TaskUserUMark_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TaskUserUMark_Update]
@TaskUserOID int,
  
@UMark int
 
AS
BEGIN
UPDATE dbo.TaskUser
SET   UMark=@UMark 
WHERE TaskUserOID=@TaskUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[TaskUser_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TaskUser_Delete]
@TaskUserOID int 
 
AS
BEGIN
DELETE FROM dbo.TaskUser
WHERE TaskUserOID=@TaskUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[TermCode_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TermCode_Update]
@TermCodeOID int,
@AssessmentOID int,
@TermCodeName varchar(20) 
 
AS
BEGIN
UPDATE dbo.TermCode
SET AssessmentOID = @AssessmentOID, TermCodeName = @TermCodeName
WHERE TermCodeOID = @TermCodeOID 	
END
GO
/****** Object:  StoredProcedure [dbo].[TermCode_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TermCode_insert]
@AssessmentOID int,
@TermCodeName varchar(20) 

AS
BEGIN
INSERT INTO [TermCode] ( AssessmentOID,TermCodeName)
Values ( @AssessmentOID, @TermCodeName)
END
GO
/****** Object:  StoredProcedure [dbo].[TermCode_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TermCode_Delete]
@TermCodeOID int 
AS
BEGIN
DELETE FROM dbo.TermCode
WHERE TermCodeOID = @TermCodeOID 	
END
GO
/****** Object:  StoredProcedure [dbo].[TermCode_ByTermCodeOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TermCode_ByTermCodeOID]
@TCOID int
AS
BEGIN
	SELECT TermCodeOID, AssessmentOID, TermCodeName
	FROM dbo.TermCode
	where TermCodeOID=@TCOID
END
GO
/****** Object:  StoredProcedure [dbo].[TermCode_ByAssessmentOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TermCode_ByAssessmentOID]
@AssessmentOID int
AS
BEGIN
	SELECT TermCodeOID, AssessmentOID, TermCodeName
	FROM dbo.TermCode
	where AssessmentOID=@AssessmentOID
END
GO
/****** Object:  StoredProcedure [dbo].[StudentRowIDByBannerID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentRowIDByBannerID]
@SOID VARCHAR(12)
AS
BEGIN
	
	SELECT * FROM
	(
	
	SELECT  ROW_NUMBER() OVER (ORDER BY Student.BannerStudentIDNumber ASC  ) AS RowNum,Student.BannerStudentName, Student.BannerStudentIDNumber,Student.StudentOID
	
	 FROM         Student 
                     

	) AS T 
	WHERE T.BannerStudentIDNumber=@SOID
	
	

END
GO
/****** Object:  StoredProcedure [dbo].[Students_GetStudentsForMerge]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Students_GetStudentsForMerge]
@bannerID varchar(80)

AS

BEGIN
	SELECT  *
	FROM dbo.Student
	WHERE BannerStudentIDNumber =@bannerID
	AND 
	(Status<>'Pending' OR Status is NULL)
	
END
GO
/****** Object:  View [dbo].[View_Prescription]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Prescription]
AS
SELECT     ROW_NUMBER() OVER (ORDER BY PrescriptionOID) AS 'RowID', *
FROM         dbo.Prescription
GO
/****** Object:  StoredProcedure [dbo].[UserOID_ByUserName]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserOID_ByUserName]
@Name Varchar(100) 

AS

BEGIN
	SET NOCOUNT ON;
	SELECT UserOID, UserName, Password, LastName, FirstName, Phone, Email, CreatedDate,Advocacy, Freez
	FROM [User]  
	WHERE @Name = UserName 

END
GO
/****** Object:  StoredProcedure [dbo].[UserFreez_ByUserName]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserFreez_ByUserName]
@Name Varchar(100) 

AS

BEGIN
	SET NOCOUNT ON;
	SELECT UserOID, UserName, Password, LastName, FirstName, Phone, Email, CreatedDate,Advocacy,Freez
	FROM [dbo].[User]  
	WHERE UserName = @Name 

END
GO
/****** Object:  StoredProcedure [dbo].[User_Update]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_Update]
@UserOID int ,
@UserName varchar (100),
@Password varchar (50),
@LastName varchar (200),
@FirstName varchar (200),
@Phone varchar (100),
@Email varchar (200),
@Advocacy varchar (20),
@Freez varchar (20)
AS
                                BEGIN
UPDATE [User]  SET UserName = @UserName,Password = @Password,LastName = @LastName,FirstName = @FirstName,Phone = @Phone,Email = @Email,Advocacy=@Advocacy,Freez=@Freez
WHERE UserOID = @UserOID
END
GO
/****** Object:  StoredProcedure [dbo].[User_Search{0}]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_Search{0}]
        @PageIndex INT ,
        @SortColumnName VARCHAR(50) ,
        @SortOrderBy VARCHAR(4) ,
        @NumberOfRows INT ,
        @TotalRecords INT OUTPUT,
		@UserName varchar (100),
		@Password varchar (50),
		@LastName varchar (200),
		@FirstName varchar (200),
		@Phone varchar (100),
		@Email varchar (200)
AS
BEGIN

		SELECT  @TotalRecords = ( SELECT    COUNT(UserName)
		FROM      [User]
		WHERE UserName LIKE '%'+@UserName+'%' AND 
		Password LIKE '%'+@Password+'%' AND
		LastName LIKE '%'+@LastName+'%' AND
		FirstName LIKE '%'+@FirstName+'%' AND
		Phone LIKE '%'+@Phone+'%' AND
		Email LIKE '%'+@Email+'%'
		)

                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Password
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Password
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FirstName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FirstName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Phone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Phone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate,
Advocacy 
   FROM     [User] ) 
SELECT
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate ,
Advocacy
 FROM    CTE
 WHERE     --RN BETWEEN @StartRow - @NumberOfRows  AND     @StartRow - 1  
UserName LIKE '%'+@UserName+'%' AND 
Password LIKE '%'+@Password+'%'AND
LastName LIKE '%'+@LastName+'%' AND
FirstName LIKE '%'+@FirstName+'%' AND
Phone LIKE '%'+@Phone+'%' AND
Email LIKE '%'+@Email+'%' 

END
GO
/****** Object:  StoredProcedure [dbo].[User_Search]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_Search]
        @PageIndex INT ,
        @SortColumnName VARCHAR(50) ,
        @SortOrderBy VARCHAR(4) ,
        @NumberOfRows INT ,
        @TotalRecords INT OUTPUT,
		@UserName varchar (100),
		@Password varchar (50),
		@LastName varchar (200),
		@FirstName varchar (200),
		@Phone varchar (100),
		@Email varchar (200),
		@Advocacy varchar (20),
		@Freez varchar (30)
AS
BEGIN

		SELECT  @TotalRecords = ( SELECT    COUNT(UserName)
		FROM      [User]
		WHERE (@UserName = '' OR UserName LIKE '%'+@UserName+'%') AND 
		(@Password = '' OR Password LIKE '%'+@Password+'%') AND
		(@LastName = '' OR LastName LIKE '%'+@LastName+'%') AND
		(@FirstName = '' OR FirstName LIKE '%'+@FirstName+'%') AND
		(@Phone = '' OR Phone LIKE '%'+@Phone+'%') AND
		(@Email = '' OR Email LIKE '%'+@Email+'%') AND
		(@Advocacy = '' OR Advocacy LIKE '%'+@Advocacy+'%') AND
		(@Freez = '' OR Freez LIKE '%'+@Freez+'%')
		)

                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Password
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Password
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FirstName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FirstName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Phone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Phone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate,
Advocacy,
Freez 
   FROM     [User] ) 
SELECT
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate ,
Advocacy,
Freez
 FROM    CTE
 WHERE     --RN BETWEEN @StartRow - @NumberOfRows  AND     @StartRow - 1  
		(@UserName = '' OR UserName LIKE '%'+@UserName+'%') AND 
		(@Password = '' OR Password LIKE '%'+@Password+'%') AND
		(@LastName = '' OR LastName LIKE '%'+@LastName+'%') AND
		(@FirstName = '' OR FirstName LIKE '%'+@FirstName+'%') AND
		(@Phone = '' OR Phone LIKE '%'+@Phone+'%') AND
		(@Email = '' OR Email LIKE '%'+@Email+'%') AND
		(@Advocacy = '' OR Advocacy LIKE '%'+@Advocacy+'%') AND
		(@Freez = '' OR Freez LIKE '%'+@Freez+'%')

END
GO
/****** Object:  StoredProcedure [dbo].[User_insert]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_insert]

@UserName varchar (100),
@Password varchar (50),
@LastName varchar (200),
@FirstName varchar (200),
@Phone varchar (100),
@Email varchar (200),
@Advocacy varchar (20),
@Freez varchar (20)

AS
                                BEGIN
INSERT INTO [User] ( UserName,Password,LastName,FirstName,Phone,Email,Advocacy,Freez)
Values ( @UserName,@Password,@LastName,@FirstName,@Phone,@Email,@Advocacy,@Freez )
END
GO
/****** Object:  StoredProcedure [dbo].[User_GetByUserNameAndPassword]    Script Date: 06/12/2012 20:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_GetByUserNameAndPassword]
@UserName Varchar(100) ,
@Password varchar(50)
AS

BEGIN
	SET NOCOUNT ON;
	SELECT UserOID, UserName, Password, LastName, FirstName, Phone, Email, CreatedDate,Advocacy, Freez
	FROM [User]  
	WHERE @UserName = UserName and @Password=Password

END
GO
/****** Object:  StoredProcedure [dbo].[User_GETAllUser]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_GETAllUser]


AS
BEGIN
SELECT UserOID, UserName, Password, LastName, FirstName, Phone, Email, CreatedDate,Advocacy, Freez
FROM [User]

END
GO
/****** Object:  StoredProcedure [dbo].[User_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[User_Delete]
@UserOID int 
AS

BEGIN

DELETE FROM [User]  
WHERE UserOID = @UserOID

END
GO
/****** Object:  StoredProcedure [dbo].[User_ByUserName]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[User_ByUserName]
@UserName varchar(100)

AS
BEGIN
	SELECT *
	FROM [User]
	WHERE UserName=@UserName

END
GO
/****** Object:  StoredProcedure [dbo].[User_BYOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_BYOID]
@UserOD int

AS
BEGIN
SELECT UserOID, UserName, Password, LastName, FirstName, Phone, Email, CreatedDate,Advocacy
FROM [User]
WHERE UserOID=@UserOD

END
GO
/****** Object:  View [dbo].[vw_PendingStudents]    Script Date: 06/12/2012 20:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_PendingStudents]
AS
SELECT     BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, BirthDate, PriorCreditQuestion, Status, FullTimeOrPartTimeIndicator, CumulativeGPA, 
                      CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, 
                      LatestCompassReadingTestScore, LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, 
                      LatestACTScienceAssessmentScore, HighSchoolName, LatestTestingDate, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, 
                      MailingAddressLineTwo, MailingAddressLineThree, City, StateName, ZipCode, EmailAddress, ImportDateFileCreationDate, PreprogramIndicator, 
                      MajorProgramEnrollmentName, StudentOID, FileCreationDate, ResultLetterSentTimes, FirstName, MiddleName, LastName
FROM         dbo.Student
WHERE     (Status = 'Pending')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Student"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PendingStudents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PendingStudents'
GO
/****** Object:  View [dbo].[vw_interventions]    Script Date: 06/12/2012 20:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_interventions]
AS
SELECT     dbo.Student.BannerStudentName, dbo.Prescription.PrescriptionOID, dbo.Prescription.StudentOID, dbo.Prescription.RiskOID, dbo.Prescription.UserOID, 
                      dbo.Prescription.DomainOID, dbo.Prescription.InterventionOID, dbo.Prescription.LatestActionDate, dbo.Prescription.LatestContact, dbo.Prescription.Internal, 
                      dbo.Prescription.Prescribed, dbo.Prescription.Completed, dbo.Prescription.Email, dbo.Prescription.Telephone, dbo.Prescription.InPerson, dbo.Prescription.HandOff, 
                      dbo.Domain.DomainName, dbo.Intervention.InterventionName, dbo.[User].UserName, dbo.Student.BannerStudentIDNumber AS BannerID, 
                      dbo.Prescription.CreatedDate, dbo.Prescription.CreatedBy, dbo.Prescription.LastModifiedDate, dbo.Prescription.LastModifiedBy, dbo.Prescription.Comment, 
                      dbo.Prescription.Urgent, dbo.Prescription.Participating, dbo.Prescription.Testing, dbo.Prescription.Unread
FROM         dbo.Prescription INNER JOIN
                      dbo.Domain ON dbo.Prescription.DomainOID = dbo.Domain.DomainOID INNER JOIN
                      dbo.Intervention ON dbo.Prescription.InterventionOID = dbo.Intervention.InterventionOID INNER JOIN
                      dbo.[User] ON dbo.Prescription.UserOID = dbo.[User].UserOID LEFT OUTER JOIN
                      dbo.Student ON dbo.Prescription.StudentOID = dbo.Student.StudentOID
WHERE     (dbo.Prescription.StudentOID <> 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Prescription"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Domain"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 114
               Right = 402
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Intervention"
            Begin Extent = 
               Top = 6
               Left = 440
               Bottom = 114
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 645
               Bottom = 114
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Student"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_interventions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_interventions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_interventions'
GO
/****** Object:  View [dbo].[vw_DomainIntervention]    Script Date: 06/12/2012 20:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_DomainIntervention]
AS
SELECT     dbo.Domain.DomainName, dbo.Intervention.InterventionName, dbo.Intervention.InterventionOID, dbo.Intervention.DomainID
FROM         dbo.Domain INNER JOIN
                      dbo.Intervention ON dbo.Domain.DomainOID = dbo.Intervention.DomainID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Domain"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Intervention"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 114
               Right = 406
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_DomainIntervention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_DomainIntervention'
GO
/****** Object:  StoredProcedure [dbo].[Task_ByCompletionDateRang]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Task_ByCompletionDateRang]
	@StartDate Datetime,
	@EndDate Datetime
AS
BEGIN
	--DECLARE @StartDate Datetime
	--DECLARE @EndDate Datetime

	--SET @StartDate='7/15/2011'
	--SET @EndDate='7/30/2011'

	SELECT TaskOID, SendFrom, Recipient, Subject, Priority, MessageBody, CompletionDateTime, Status, CreatedDate
	FROM dbo.Task
	WHERE CompletionDateTime between @StartDate and @EndDate
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Reports_Insert]
@ReportOID int output,
@ReportName varchar (100),
@SPName varchar (1000),
@SPParams varchar (5000),
@GridColumns varchar (5000),
@CreatedDate datetime


AS
BEGIN
	
INSERT INTO dbo.Reports(ReportName, SPName, SPParams, GridColumns, CreatedDate)
Values (@ReportName,@SPName, @SPParams, @GridColumns, @CreatedDate)

SELECT @ReportOID=  MAX(ReportOID) FROM Reports 
RETURN @ReportOID

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_GetByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Reports_GetByOID]
@ReportOID int
AS 
BEGIN
	SELECT * 
	FROM dbo.Reports
	WHERE  ReportOID = @ReportOID
END
GO
/****** Object:  StoredProcedure [dbo].[ScoreDetailTable_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[ScoreDetailTable_Update]
@StudentOID int ,
@BannerID varchar (100)
AS
                                BEGIN
UPDATE [ScoreDetailTable]   SET BannerID = @BannerID
WHERE StudentOID = @StudentOID
END
GO
/****** Object:  Table [dbo].[Risk]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Risk](
	[RiskOID] [int] NOT NULL,
	[AssessmentOID] [int] NOT NULL,
	[RiskName] [varchar](100) NOT NULL,
	[FlagPoint] [int] NULL,
	[SectionFailed] [int] NULL,
	[PrescriptionOID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_Risk] PRIMARY KEY CLUSTERED 
(
	[RiskOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid_Domain]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid_Domain]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Domain]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY

CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN DomainName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN DomainName
                                                              END DESC 
 ) AS RN ,
DomainOID, 
DomainName

   FROM     [Domain] ) 
SELECT
DomainOID, 
DomainName

 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [User]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Password
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Password
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FirstName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FirstName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Phone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Phone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate ,
Advocacy,
Freez 
   FROM     [User] ) 
SELECT
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate,
Advocacy,
Freez   
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[Student_Insert_import]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Insert_import]
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@FullTimeOrPartTimeIndicator varchar(10),
@CumulativeGPA numeric(3,2) ,
@CreditsAttempted numeric(11,3),
@CreditsEarned numeric(11,3),
@LatestCompassPrealgebraTestScore varchar(15),
@LatestCompassAlgebraTestScore varchar(15),
@LatestCompassWritingTestScore varchar(15),
@LatestCompassReadingTestScore varchar(15),
@LatestACTEnglishAssessmentScore varchar(15),
@LatestACTMathAssessmentScore varchar(15),
@LatestACTReadingAssessmentScore varchar(15),
@LatestACTScienceAssessmentScore varchar(15),
@LatestTestingDate datetime,
@HighSchoolName varchar(80),
@HighSchoolGraduationDate datetime,
@HomeTelephoneNumber varchar(20),
@MailingAddressLineOne varchar(75),
@MailingAddressLineTwo varchar(75),
@MailingAddressLineThree varchar(75),
@City varchar(50),
@StateName varchar(20),
@ZipCode varchar(30),
@EmailAddress varchar(128),
@PreprogramIndicator varchar(5),
@MajorProgramEnrollmentName varchar(75),

@FirstName varchar(80),
@LastName varchar(80),
@MiddleName varchar(80),
@PriorCredit varchar(80),
@DOB datetime



AS
BEGIN
insert into dbo.Student(BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, StateName, ZipCode, EmailAddress,PreprogramIndicator,MajorProgramEnrollmentName,FirstName,MiddleName,LastName,BirthDate,PriorCreditQuestion)
				  values(@BannerStudentName,@BannerStudentIDNumber,@TermCodeofProgramEnrollment,@FullTimeOrPartTimeIndicator,@CumulativeGPA,@CreditsAttempted,@CreditsEarned,@LatestCompassPrealgebraTestScore,@LatestCompassAlgebraTestScore,@LatestCompassWritingTestScore,@LatestCompassReadingTestScore,@LatestACTEnglishAssessmentScore,@LatestACTMathAssessmentScore,@LatestACTReadingAssessmentScore,@LatestACTScienceAssessmentScore,@LatestTestingDate,@HighSchoolName,@HighSchoolGraduationDate,@HomeTelephoneNumber,@MailingAddressLineOne,@MailingAddressLineTwo,@MailingAddressLineThree,@City,@StateName,@ZipCode,@EmailAddress,@PreprogramIndicator,@MajorProgramEnrollmentName,@FirstName ,@MiddleName ,@LastName ,@DOB ,@PriorCredit )
	
END
GO
/****** Object:  StoredProcedure [dbo].[Student_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Insert]
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@MajorProgramEnrollmentName varchar(75),
@Status varchar(50),
@FirstName varchar(80),
@LastName varchar (80),
@MiddleName varchar(80),
@BirthDate DateTime,
@PriorCreditQuestion varchar(400),
@Email varchar(80)


AS
BEGIN
insert into dbo.Student(BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment,MajorProgramEnrollmentName,Status,FirstName,MiddleName,LastName,BirthDate,PriorCreditQuestion,EmailAddress)
				  values(@BannerStudentName,@BannerStudentIDNumber,@TermCodeofProgramEnrollment,@MajorProgramEnrollmentName,@Status,@FirstName,@MiddleName,@LastName,@BirthDate,@PriorCreditQuestion,@Email)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Student_GetAllTerms]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Student_GetAllTerms]
 

AS
BEGIN
	select distinct TermCodeofProgramEnrollment from student
	where TermCodeofProgramEnrollment <>'' and TermCodeofProgramEnrollment is not null
	order by TermCodeofProgramEnrollment desc

END
GO
/****** Object:  StoredProcedure [dbo].[Student_GetAllProgramInterest]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Student_GetAllProgramInterest]
 

AS
BEGIN
	select distinct MajorProgramEnrollmentName from student
	where MajorProgramEnrollmentName <>'' and MajorProgramEnrollmentName is not null
	order by MajorProgramEnrollmentName asc

END
GO
/****** Object:  StoredProcedure [dbo].[Student_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Student_Delete]
@StudentOID int
AS

BEGIN

DELETE FROM Student 
WHERE StudentOID = @StudentOID

END
GO
/****** Object:  StoredProcedure [dbo].[SelectReport{0}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[SelectReport{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Report]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'OID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN OID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'OID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN OID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ColModel'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ColModel
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ColModel'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ColModel
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ColNames'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ColNames
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ColNames'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ColNames
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CurrentData'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CurrentData
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CurrentData'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CurrentData
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReportName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ReportName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReportName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ReportName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TableName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TableName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TableName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TableName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
OID, 
ColModel, 
ColNames, 
CurrentData, 
ReportName, 
TableName, 
CreatedDate 
   FROM     [Report] ) 
SELECT
OID, 
ColModel, 
ColNames, 
CurrentData, 
ReportName, 
TableName, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectReport]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectReport]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Report]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'OID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN OID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'OID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN OID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ColModel'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ColModel
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ColModel'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ColModel
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ColNames'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ColNames
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ColNames'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ColNames
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CurrentData'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CurrentData
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CurrentData'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CurrentData
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReportName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ReportName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReportName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ReportName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TableName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TableName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TableName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TableName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
OID, 
ColModel, 
ColNames, 
CurrentData, 
ReportName, 
TableName, 
CreatedDate 
   FROM     [Report] ) 
SELECT
OID, 
ColModel, 
ColNames, 
CurrentData, 
ReportName, 
TableName, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid{Intervention}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid{Intervention}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Intervention]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY

CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InterventionName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InterventionName
                                                              END DESC 

 ) AS RN ,
InterventionOID, 
InterventionName

   FROM     [Intervention] ) 
SELECT
InterventionOID, 
InterventionName

 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid{Domain}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid{Domain}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Domain]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY

CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN DomainName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN DomainName
                                                              END DESC 
 ) AS RN ,
DomainOID, 
DomainName

   FROM     [Domain] ) 
SELECT
DomainOID, 
DomainName

 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid{0}]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [User]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Password
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Password
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FirstName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FirstName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Phone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Phone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate ,
Advocacy 
   FROM     [User] ) 
SELECT
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate,
Advocacy  
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid_User]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid_User]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [User]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Password
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Password'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Password
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FirstName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FirstName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FirstName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Phone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Phone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate ,
Advocacy 
   FROM     [User] ) 
SELECT
UserOID, 
UserName, 
Password, 
LastName, 
FirstName, 
Phone, 
Email, 
CreatedDate,
Advocacy  
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[ScoreDetails_Update_NumberofPrinted]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ScoreDetails_Update_NumberofPrinted]
@RLST int,
@AOID int,
@StudentOID int 

AS
BEGIN
	
	UPDATE ScoreDetailTable
	SET NumberOfPrinted = NumberOfPrinted + 1
	FROM dbo.ScoreDetailTable
	WHERE AssessmentOID=@AOID AND NumberOfPrinted=@RLST and StudentOID=@StudentOID


END
GO
/****** Object:  Table [dbo].[Section]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Section](
	[SectionOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentOID] [int] NOT NULL,
	[SectionName] [varchar](50) NOT NULL,
	[TotalQuestion] [int] NOT NULL,
	[PassingTotal] [int] NOT NULL,
	[TotalFlag] [int] NOT NULL,
	[FlagPointTotal] [int] NOT NULL,
	[Flag] [int] NULL,
	[Low] [int] NULL,
	[Medium] [int] NULL,
	[High] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_Section] PRIMARY KEY CLUSTERED 
(
	[SectionOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RiskCalculation]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskCalculation](
	[RiskOID] [int] IDENTITY(1,1) NOT NULL,
	[RiskName] [varchar](100) NULL,
	[AssessmentOID] [int] NOT NULL,
	[NumSection] [int] NOT NULL,
	[NumFlag] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_RiskCalculation] PRIMARY KEY CLUSTERED 
(
	[RiskOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Report_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Report_Update]
@OID int,
@ColModel varchar (MAX),
@ColNames varchar (500),
@CurrentData varchar (MAX),
@ReportName varchar (200),
@TableName varchar (50)
AS
                                BEGIN
UPDATE Report  SET ColModel = @ColModel,ColNames = @ColNames,CurrentData = @CurrentData,ReportName = @ReportName,TableName = @TableName
WHERE OID = @OID
END
GO
/****** Object:  StoredProcedure [dbo].[Report_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Report_insert]
@ColModel varchar (MAX),
@ColNames varchar (500),
@CurrentData varchar (MAX),
@ReportName varchar (200),
@TableName varchar (50)

AS
                                BEGIN
INSERT INTO Report ( ColModel,ColNames,CurrentData,ReportName,TableName)Values ( 
@ColModel,@ColNames,@CurrentData,@ReportName,@TableName)
END
GO
/****** Object:  StoredProcedure [dbo].[Report_Delete]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Report_Delete]
@url varchar(200)
AS

BEGIN

DELETE FROM [Menu]  
WHERE URL = @url

END
GO
/****** Object:  StoredProcedure [dbo].[PendingStudent_Search]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PendingStudent_Search]                                                
	@BannerStudentName varchar(80),
	@BannerStudentIDNumber varchar(12),
	@TermCodeofProgramEnrollment varchar(20),
	@FullTimeOrPartTimeIndicator varchar(10),
	@CumulativeGPA numeric(11,2) ,
	@CumulativeGPA1 numeric(11,2),
	@CreditsAttempted numeric(11,3),
	@CreditsAttempted1 numeric(11,3),
	@CreditsEarned numeric(11,3),
	@CreditsEarned1 numeric(11,3),
	@LatestCompassPrealgebraTestScore numeric(11,3),
	@LatestCompassPrealgebraTestScore1 numeric(11,3),
	@LatestCompassAlgebraTestScore numeric(11,3),
	@LatestCompassAlgebraTestScore1 numeric(11,3),
	@LatestCompassWritingTestScore numeric(11,3),
	@LatestCompassWritingTestScore1 numeric(11,3),
	@LatestCompassReadingTestScore numeric(11,3),
	@LatestCompassReadingTestScore1 numeric(11,3),
	@LatestACTEnglishAssessmentScore numeric(11,3),
	@LatestACTEnglishAssessmentScore1 numeric(11,3),
	@LatestACTMathAssessmentScore numeric(11,3),
	@LatestACTMathAssessmentScore1 numeric(11,3),
	@LatestACTReadingAssessmentScore numeric(11,3),
	@LatestACTReadingAssessmentScore1 numeric(11,3),
	@LatestACTScienceAssessmentScore numeric(11,3),
	@LatestACTScienceAssessmentScore1 numeric(11,3),
	@LatestTestingDate datetime,
	@HighSchoolName varchar(80),
	@HighSchoolGraduationDate datetime,
	@HomeTelephoneNumber varchar(20),
	@MailingAddressLineOne varchar(75),
	@MailingAddressLineTwo varchar(75),
	@MailingAddressLineThree varchar(75),
	@City varchar(50),
	@StateName varchar(20),
	@ZipCode varchar(30),
	@EmailAddress varchar(128),
	@ImportDateFileCreationDate datetime,
	@PreprogramIndicator varchar(5),
	@MajorProgramEnrollmentName varchar(75),
	@PageIndex INT ,
    @SortColumnName VARCHAR(50) ,
    @SortOrderBy VARCHAR(4) ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT
    

 AS
 BEGIN
 
 
 
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
 FROM      [Student]
 WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
 --AND (CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
  AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
 --AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1) 

 AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%') 
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
												 --declare @StartGPA numeric(11,2)
												 --set @StartGPA= @CumulativeGPA1;
												 
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITYCITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate,
Status

   FROM     [Student]
   
WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
--AND (@CumulativeGPA>=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 --AND (@CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 

--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1)  

AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' )
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
Status
 FROM    CTE
 WHERE     RN BETWEEN @StartRow - @NumberOfRows  AND     @StartRow - 1  and  (Status='Pending')
-- AND (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
-- AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
-- AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
-- AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
-- AND (@CumulativeGPA=0 OR CumulativeGPA =@CumulativeGPA ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
--AND (@LatestCompassPrealgebraTestScore = '' OR LatestCompassPrealgebraTestScore LIKE '%'+@LatestCompassPrealgebraTestScore +'%')
-- AND (@LatestCompassAlgebraTestScore = '' OR LatestCompassAlgebraTestScore LIKE '%'+@LatestCompassAlgebraTestScore +'%') 
-- AND (@LatestCompassWritingTestScore = '' OR LatestCompassWritingTestScore LIKE '%'+@LatestCompassWritingTestScore +'%')
-- AND (@LatestCompassReadingTestScore = '' OR LatestCompassReadingTestScore LIKE '%'+@LatestCompassReadingTestScore +'%') 
-- AND (@LatestACTEnglishAssessmentScore = '' OR LatestACTEnglishAssessmentScore LIKE '%'+@LatestACTEnglishAssessmentScore +'%') 
-- AND (@LatestACTMathAssessmentScore = '' OR LatestACTMathAssessmentScore LIKE '%'+@LatestACTMathAssessmentScore +'%') 
-- AND (@LatestACTReadingAssessmentScore = '' OR LatestACTReadingAssessmentScore LIKE '%'+@LatestACTReadingAssessmentScore +'%' )
--AND (@LatestACTScienceAssessmentScore = '' OR LatestACTScienceAssessmentScore LIKE '%'+@LatestACTScienceAssessmentScore +'%' )
--AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
--AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
--AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
--AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
--AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
--AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
--AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
--AND (@City = '' OR City LIKE '%'+@City+'%' )
--AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
--AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' AND EmailAddress LIKE '%'+@EmailAddress +'%' )
--AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
-- AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
-- AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')

END
GO
/****** Object:  StoredProcedure [dbo].[NTO_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[NTO_insert]
@BannerID varchar (100),
@Type varchar (50)
AS
BEGIN
INSERT INTO NTO ( BannerID,[Type])Values (@BannerID,@Type)
END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Intervention_insert]

@InterventionName varchar (100)

AS
BEGIN
INSERT INTO [Intervention] ( InterventionName)Values ( 
@InterventionName )
END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_Delete]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Intervention_Delete]
@InterventionOID int 
AS

BEGIN

DELETE FROM [Intervention]  
WHERE InterventionOID = @InterventionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_ByDomainName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Intervention_ByDomainName]
@Name varchar(100)

AS
BEGIN
	SELECT     dbo.Intervention.InterventionName
FROM         dbo.Domain INNER JOIN
                      dbo.Intervention ON dbo.Domain.DomainOID = dbo.Intervention.DomainID
	WHERE Domain.DomainName=@Name

END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_Update_Status]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_Update_Status]
@poid int 
AS
BEGIN
UPDATE Prescription   SET Unread = 'no'
WHERE PrescriptionOID = @poid
END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetBySOID_Print]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetBySOID_Print]
@soid int,
@RiskOID int
AS 
BEGIN

	SELECT     dbo.Prescription.PrescriptionOID, dbo.Prescription.StudentOID, dbo.Prescription.RiskOID, dbo.Prescription.UserOID, dbo.Prescription.DomainOID, 
                      dbo.Prescription.InterventionOID, dbo.Prescription.LatestActionDate, dbo.Prescription.LatestContact, dbo.Prescription.Internal, dbo.Prescription.Prescribed, 
                      dbo.Prescription.Completed, dbo.Prescription.Email, dbo.Prescription.Telephone, dbo.Prescription.InPerson, dbo.Prescription.HandOff, dbo.Prescription.CreatedDate, 
                      dbo.Prescription.Comment, dbo.Prescription.Urgent, dbo.Prescription.Participating, dbo.Prescription.Testing, dbo.Intervention.InterventionName, 
                      dbo.Domain.DomainName, dbo.[User].UserName,dbo.Prescription.CreatedBy, dbo.Prescription.LastModifiedDate, dbo.Prescription.LastModifiedBy

FROM         dbo.Prescription INNER JOIN
                      dbo.Domain ON dbo.Prescription.DomainOID = dbo.Domain.DomainOID INNER JOIN
                      dbo.[User] ON dbo.Prescription.UserOID = dbo.[User].UserOID INNER JOIN
                      dbo.Intervention ON dbo.Prescription.InterventionOID = dbo.Intervention.InterventionOID
	WHERE Prescription.StudentOID=@soid AND dbo.Prescription.RiskOID=@RiskOID 
	
END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetBySOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetBySOID]
@soid int
AS 
BEGIN

	SELECT     dbo.Prescription.PrescriptionOID, dbo.Prescription.StudentOID, dbo.Prescription.RiskOID, dbo.Prescription.UserOID, dbo.Prescription.DomainOID, 
                      dbo.Prescription.InterventionOID, dbo.Prescription.LatestActionDate, dbo.Prescription.LatestContact, dbo.Prescription.Internal, dbo.Prescription.Prescribed, 
                      dbo.Prescription.Completed, dbo.Prescription.Email, dbo.Prescription.Telephone, dbo.Prescription.InPerson, dbo.Prescription.HandOff, dbo.Prescription.CreatedDate, 
                      dbo.Prescription.Comment, dbo.Prescription.Urgent, dbo.Prescription.Participating, dbo.Prescription.Testing, dbo.Intervention.InterventionName, 
                      dbo.Domain.DomainName, dbo.[User].UserName,dbo.Prescription.CreatedBy, dbo.Prescription.LastModifiedDate, dbo.Prescription.LastModifiedBy

FROM         dbo.Prescription INNER JOIN
                      dbo.Domain ON dbo.Prescription.DomainOID = dbo.Domain.DomainOID INNER JOIN
                      dbo.[User] ON dbo.Prescription.UserOID = dbo.[User].UserOID INNER JOIN
                      dbo.Intervention ON dbo.Prescription.InterventionOID = dbo.Intervention.InterventionOID
	WHERE Prescription.StudentOID=@soid
	
END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetByRiskOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetByRiskOID]
@roid int
AS 
BEGIN

	SELECT     Prescription.*, Domain.DomainName, [User].UserName, Intervention.InterventionName
	FROM         Prescription LEFT OUTER JOIN
                      Domain ON Prescription.DomainOID = Domain.DomainOID LEFT OUTER JOIN
                      Intervention ON Prescription.InterventionOID = Intervention.InterventionOID LEFT OUTER JOIN
                      [User] ON Prescription.UserOID = [User].UserOID
	WHERE RiskOID=@roid
END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetByOID]
@poid int
AS 
BEGIN

	SELECT Prescription.PrescriptionOID, StudentOID, Prescription.UserOID,Prescription.AssessmentOID ,UserName, Prescription.DomainOID,DomainName, Prescription.InterventionOID,InterventionName, LatestActionDate, LatestContact, Internal, Prescribed, Completed, Prescription.Email, Telephone, InPerson, HandOff, Prescription.CreatedDate, Prescription.CreatedBy, Prescription.LastModifiedDate, Prescription.LastModifiedBy, Comment, Urgent, Participating, Testing
	FROM Prescription,dbo.Domain,dbo.Intervention,dbo.[User]
	WHERE Prescription.PrescriptionOID=@poid
	AND [Prescription].DomainOID=dbo.Domain.DomainOID 
		AND [Prescription].InterventionOID=dbo.Intervention.InterventionOID
		AND [Prescription].UserOID=dbo.[User].UserOID 
END
GO
/****** Object:  StoredProcedure [dbo].[PrescriptionStatus_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PrescriptionStatus_insert]

@UserOID int,
@PrescriptionOID INT

AS
BEGIN
INSERT INTO dbo.PrescriptionStatus(UserOID, PrescriptionOID)
Values ( @UserOID, @PrescriptionOID)
END
GO
/****** Object:  StoredProcedure [dbo].[PrescriptionStatus_Check]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrescriptionStatus_Check]

@UserOID int,
@PrescriptionOID INT

AS
BEGIN
SELECT * FROM dbo.PrescriptionStatus
Where UserOID=@UserOID AND PrescriptionOID=@PrescriptionOID
END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenterStatus_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageCenterStatus_Update]
@MessageOID int,
@Status varchar(50) 
 
AS
BEGIN
UPDATE dbo.MessageCenter
SET Status=@Status 
WHERE MessageOID = @MessageOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenter_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageCenter_Update]
@MessageOID int ,
@SendFrom int,
@Recipient varchar (500),
@Subject varchar (500),
@Status varchar (50),
@Mark int ,
@MessageBody varchar (MAX)

AS
                                BEGIN
UPDATE MessageCenter 
 SET SendFrom = @SendFrom,Recipient = @Recipient,Subject = @Subject,Status = @Status,Mark = @Mark,MessageBody = @MessageBody
WHERE MessageOID = @MessageOID
END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenter_Search{0}]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[MessageCenter_Search{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [MessageCenter]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'MessageOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN SendFrom
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN SendFrom
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Recipient
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Recipient
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Subject
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Subject
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Status
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Status
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Mark'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Mark
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Mark'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Mark
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageBody
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageBody
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
MessageOID, 
SendFrom, 
Recipient, 
Subject, 
Status, 
Mark, 
MessageBody, 
CreatedDate 
   FROM     [MessageCenter] ) 
SELECT
MessageOID, 
SendFrom, 
Recipient, 
Subject, 
Status, 
Mark, 
MessageBody, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenter_Search]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageCenter_Search]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [MessageCenter]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'MessageOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN SendFrom
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'SendFrom'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN SendFrom
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Recipient
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Recipient'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Recipient
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Subject
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Subject'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Subject
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Status
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Status'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Status
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Mark'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Mark
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Mark'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Mark
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MessageBody
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MessageBody'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MessageBody
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC 
 ) AS RN ,
MessageOID, 
SendFrom, 
Recipient, 
Subject, 
Status, 
Mark, 
MessageBody, 
CreatedDate 
   FROM     [MessageCenter] ) 
SELECT
MessageOID, 
SendFrom, 
Recipient, 
Subject, 
Status, 
Mark, 
MessageBody, 
CreatedDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenter_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageCenter_insert]
@SendFrom int,
@Recipient varchar (500),
@Subject varchar (500),
@Status varchar (50),
@Mark int ,
@MessageBody varchar (MAX)

AS
                                BEGIN
INSERT INTO MessageCenter ( SendFrom,Recipient,Subject,Status,Mark,MessageBody)Values ( 
@SendFrom,@Recipient,@Subject,@Status,@Mark,@MessageBody )
--Insert Into MessageUSER table
DECLARE @title varchar(80), @message varchar(80)
DECLARE @lastName varchar(200)
DECLARE @firstName varchar(200)
DECLARE @messOID int
DECLARE @useroid int 
SET @messOID=(SELECT MAX(MessageOID) FROM dbo.MessageCenter)

DECLARE titles_cursor CURSOR FOR
SELECT * FROM dbo.split(@Recipient,',')

 OPEN titles_cursor
   FETCH NEXT FROM titles_cursor INTO @title

 WHILE @@FETCH_STATUS = 0
   BEGIN
      
	SELECT @title=LTRIM(RTRIM(@title))
	SELECT @lastName = LEFT(@title,CHARINDEX(' ', @title))    
    --PRINT @lastName
	SELECT @firstName = RIGHT(@title,CHARINDEX(' ', @title)-1)  
	--PRINT @firstName  
    SET @useroid=(SELECT TOP(1) useroid FROM [User]
				 WHERE LastName=@lastName and FirstName=@firstName)
	--Insert
	INSERT INTO dbo.MessageUser( UserOID, MessageOID, UStatus, UMark)
	VALUES(@useroid,@messOID, @Status, @Mark)
      FETCH NEXT FROM titles_cursor INTO @title
   
   END

CLOSE titles_cursor
DEALLOCATE titles_cursor
END
GO
/****** Object:  StoredProcedure [dbo].[MessageCenter_GetByOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageCenter_GetByOID]
@MessageOID int 
AS
BEGIN
	SELECT *
	FROM dbo.MessageCenter
	WHERE MessageOID = @MessageOID
END
GO
/****** Object:  StoredProcedure [dbo].[MessageUserUStatus_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageUserUStatus_Update]
@MessageUserOID int,
@UStatus varchar(50) 
 
AS
BEGIN
UPDATE dbo.MessageUser
SET UStatus=@UStatus 
WHERE MessageUserOID=@MessageUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[MessageUserUMark_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageUserUMark_Update]
@MessageUserOID int,
  
@UMark int
 
AS
BEGIN
UPDATE dbo.MessageUser
SET   UMark=@UMark 
WHERE MessageUserOID=@MessageUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[MessageUser_Delete]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MessageUser_Delete]
@MessageUserOID int 
 
AS
BEGIN
DELETE FROM dbo.MessageUser
WHERE MessageUserOID=@MessageUserOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[PendingStudent_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PendingStudent_Update]
@StudentOID int,
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@FullTimeOrPartTimeIndicator varchar(10),
@CumulativeGPA numeric(3,2) ,
@CreditsAttempted numeric(11,3),
@CreditsEarned numeric(11,3),
@LatestCompassPrealgebraTestScore varchar(15),
@LatestCompassAlgebraTestScore varchar(15),
@LatestCompassWritingTestScore varchar(15),
@LatestCompassReadingTestScore varchar(15),
@LatestACTEnglishAssessmentScore varchar(15),
@LatestACTMathAssessmentScore varchar(15),
@LatestACTReadingAssessmentScore varchar(15),
@LatestACTScienceAssessmentScore varchar(15),
@LatestTestingDate datetime,
@HighSchoolName varchar(80),
@HighSchoolGraduationDate datetime,
@HomeTelephoneNumber varchar(20),
@MailingAddressLineOne varchar(75),
@MailingAddressLineTwo varchar(75),
@MailingAddressLineThree varchar(75),
@City varchar(50),
@StateName varchar(20),
@ZipCode varchar(30),
@EmailAddress varchar(128),
@ImportDateFileCreationDate datetime,
@PreprogramIndicator varchar(5),
@MajorProgramEnrollmentName varchar(75),
@Status varchar(50)


AS
BEGIN

UPDATE dbo.Student
SET BannerStudentName=@BannerStudentName, BannerStudentIDNumber=@BannerStudentIDNumber,
 TermCodeofProgramEnrollment=@TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator=@FullTimeOrPartTimeIndicator, 
CumulativeGPA=@CumulativeGPA, CreditsAttempted=@CreditsAttempted, CreditsEarned=@CreditsEarned, 
LatestCompassPrealgebraTestScore=@LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore=@LatestCompassAlgebraTestScore,
 LatestCompassWritingTestScore=@LatestCompassWritingTestScore, LatestCompassReadingTestScore=@LatestCompassReadingTestScore,
 LatestACTEnglishAssessmentScore=@LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore=@LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore=@LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore=@LatestACTScienceAssessmentScore, 
LatestTestingDate=@LatestTestingDate, HighSchoolName=@HighSchoolName,
 HighSchoolGraduationDate=@HighSchoolGraduationDate, HomeTelephoneNumber=@HomeTelephoneNumber, 
MailingAddressLineOne=@MailingAddressLineOne, MailingAddressLineTwo=@MailingAddressLineTwo, 
MailingAddressLineThree=@MailingAddressLineThree, City=@City, StateName=@StateName, ZipCode=@ZipCode, EmailAddress=@EmailAddress,
 ImportDateFileCreationDate=@ImportDateFileCreationDate, PreprogramIndicator=@PreprogramIndicator, 
MajorProgramEnrollmentName=@MajorProgramEnrollmentName,
Status=@Status
WHERE StudentOID=@StudentOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Intervations_ByStudentOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Intervations_ByStudentOID]
@SOID int,
@PageIndex INT ,
@NumberOfRows INT 
	
AS
BEGIN


SELECT DISTINCT       [User].UserName,Intervention.InterventionName,Domain.DomainName,vwPres.LatestActionDate,vwPres.LatestContact,
vwPres.Internal,vwPres.Prescribed,vwPres.Completed,vwPres.Email,vwPres.Telephone,vwPres.InPerson,vwPres.HandOff,vwPres.CreatedDate,
vwPres.CreatedBy,vwPres.LastModifiedDate,vwPres.LastModifiedBy,vwPres.Comment, vwPres.Urgent, vwPres.Participating,vwPres.Testing, 
vwPres.PrescriptionOID,vwPres.StudentOID, vwPres.UserOID, vwPres.DomainOID, vwPres.InterventionOID ,BannerStudentIDNumber AS BannerID ,vwPres.Unread
                       
FROM Domain INNER JOIN
		(
		SELECT     ROW_NUMBER() OVER (ORDER BY PrescriptionOID) AS 'RowID', *
		FROM         dbo.Prescription
		WHERE StudentOID=@SOID
		) AS vwPres
		ON Domain.DomainOID = vwPres.DomainOID 
		INNER JOIN   Intervention ON vwPres.InterventionOID = Intervention.InterventionOID 
		INNER JOIN   [User] ON vwPres.UserOID = [User].UserOID
		INNER JOIN dbo.Student ON vwPres.StudentOID=dbo.Student.StudentOID
where 
		RowID BETWEEN (( @PageIndex * @NumberOfRows ) + 1) - @NumberOfRows AND  (( @PageIndex * @NumberOfRows ) + 1)-1
END
GO
/****** Object:  StoredProcedure [dbo].[Intervations_ByRiskOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Intervations_ByRiskOID]
@ROID int,
@StudentBannerID VARCHAR(20),
@PageIndex INT ,
@NumberOfRows INT 

	
AS
BEGIN

SELECT DISTINCT [User].UserName,Intervention.InterventionName,Domain.DomainName,vwPres.LatestActionDate,
vwPres.LatestContact,vwPres.Internal,vwPres.Prescribed,vwPres.Completed,vwPres.Email,vwPres.Telephone,vwPres.InPerson,
vwPres.HandOff,vwPres.CreatedDate,vwPres.CreatedBy,vwPres.LastModifiedDate,vwPres.LastModifiedBy,                      
vwPres.Comment, vwPres.Urgent, vwPres.Participating,vwPres.Testing, vwPres.PrescriptionOID,               
vwPres.StudentOID, vwPres.UserOID, vwPres.DomainOID, vwPres.InterventionOID ,@StudentBannerID AS BannerID ,vwPres.Unread,vwPres .RiskOID 
FROM Domain INNER JOIN
		(
		SELECT     ROW_NUMBER() OVER (ORDER BY PrescriptionOID) AS 'RowID', *
		FROM         dbo.Prescription
		WHERE RiskOID=@ROID
		) AS vwPres
		ON Domain.DomainOID = vwPres.DomainOID 
		INNER JOIN   Intervention ON vwPres.InterventionOID = Intervention.InterventionOID 
		INNER JOIN   [User] ON vwPres.UserOID = [User].UserOID
		Left Outer JOIN dbo.Student ON vwPres.StudentOID=dbo.Student.StudentOID
where 
		RowID BETWEEN (( @PageIndex * @NumberOfRows ) + 1) - @NumberOfRows AND  (( @PageIndex * @NumberOfRows ) + 1)-1
END
GO
/****** Object:  UserDefinedFunction [dbo].[ImportDataByBanner]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ImportDataByBanner](@BannerID varchar(100),@Type varchar(50))
RETURNS varchar(50)
AS 	
BEGIN
	DECLARE @result varchar(50)
	SET @result=(SELECT @Type AS  NTO 	FROM dbo.NTO WHERE BannerID=@BannerID and [Type]=@Type	)
	
	SET @Result=COalesce(@Result,'0')
	return @Result
END
GO
/****** Object:  StoredProcedure [dbo].[GetValidStudents_ForMerge]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetValidStudents_ForMerge]
@BannerID  varchar(12),
@FirstName varchar(80),
@MiddleName varchar(80),
@LastName varchar(80),
@Term varchar(100),
@DOB datetime
AS

BEGIN

	 
	  SELECT * FROM dbo.Student 
	 WHERE  (LTRIM(RTRIM(FirstName))=LTRIM(RTRIM(@FirstName))
	        AND LTRIM(RTRIM(LastName))=LTRIM(RTRIM(@LastName)) )
	        
	 AND (Status<>'Pending' OR Status is NULL)
	 AND (@Term IS NULL OR LTRIM(RTRIM(TermCodeofProgramEnrollment)) = LTRIM(RTRIM(@Term)))
	 AND (@BannerID IS NULL OR BannerStudentIDNumber = @BannerID)
	 AND (@MiddleName IS NULL OR LTRIM(RTRIM(MiddleName)) = LTRIM(RTRIM(@MiddleName)))
	 AND (@DOB IS NULL OR CONVERT(varchar,BirthDate,103) = CONVERT(varchar,@DOB,103))
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetValidStudents_ForAssessment]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetValidStudents_ForAssessment]
@BannerID  varchar(12),
@FirstName varchar(80),
@MiddleName varchar(80),
@LastName varchar(80),
@Term varchar(100),
@DOB datetime
AS

BEGIN

SELECT * FROM dbo.Student 
	 WHERE LTRIM(RTRIM(FirstName))=LTRIM(RTRIM(@FirstName))
	 AND LTRIM(RTRIM(LastName))=LTRIM(RTRIM(@LastName))
	 AND (CONVERT(varchar,BirthDate,103)=CONVERT(varchar,@DOB,103) OR @DOB IS NULL) 
	 AND (BannerStudentIDNumber=@BannerID OR @BannerID IS NULL) 
	 AND (@MiddleName IS NULL OR LTRIM(RTRIM(MiddleName)) = LTRIM(RTRIM(@MiddleName)))
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserNameAndPasswordByEmail]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[GetUserNameAndPasswordByEmail]
@Email varchar(100)

AS
BEGIN
SELECT *from [User] 
where Email=@Email
END
GO
/****** Object:  StoredProcedure [dbo].[Message_GetByUserOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Message_GetByUserOID]
@UserOID int

AS
BEGIN

	SELECT  MessageOID, SendFrom, Recipient, [Subject], [Status], Mark, MessageBody, CreatedDate
	FROM dbo.MessageCenter
	WHERE (SendFrom = @UserOID) AND ([Status] <> 'Trashed')
END
GO
/****** Object:  StoredProcedure [dbo].[Message_GetAllRecipientTrashedByUserOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Message_GetAllRecipientTrashedByUserOID]
	@UserOID int 
AS
BEGIN

SELECT  dbo.MessageCenter.MessageOID, SendFrom, Recipient, Subject, Status, Mark, MessageBody, dbo.MessageCenter.CreatedDate,
	dbo.MessageUser.MessageUserOID, dbo.MessageUser.UStatus, dbo.MessageUser.UMark
FROM dbo.MessageCenter,dbo.MessageUser
WHERE dbo.MessageCenter.MessageOID=dbo.MessageUser.MessageOID
AND dbo.MessageUser.UserOID=@UserOID  AND dbo.MessageUser.UStatus = 'Trashed'
END
GO
/****** Object:  StoredProcedure [dbo].[Message_GetAllRecipientByUserOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Message_GetAllRecipientByUserOID]
	@UserOID int 
AS
BEGIN

SELECT  dbo.MessageCenter.MessageOID, SendFrom, Recipient, Subject, Status, Mark, MessageBody, dbo.MessageCenter.CreatedDate,
	dbo.MessageUser.MessageUserOID, dbo.MessageUser.UStatus, dbo.MessageUser.UMark
FROM dbo.MessageCenter,dbo.MessageUser
WHERE dbo.MessageCenter.MessageOID=dbo.MessageUser.MessageOID
AND dbo.MessageUser.UserOID=@UserOID  AND dbo.MessageUser.UStatus <> 'Trashed'
END
GO
/****** Object:  StoredProcedure [dbo].[Message_GetAllMessage]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Message_GetAllMessage]


AS
BEGIN
	SELECT MessageOID, SendFrom, Recipient, Subject, Status, Mark, MessageBody, CreatedDate
	FROM dbo.MessageCenter

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_MenuName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_MenuName]
@MOID int

AS
BEGIN
	SELECT OID, NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded, CreatedDate
	FROM dbo.Menu
	WHERE OID=@MOID

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_insert]

@NameMenu varchar(50),
@MenuID int,
@URL varchar(100),
@MenuLevel int,
@Parent int,
@IsLeaf int,
@IsExpanded int

AS
BEGIN


--UPDATE [Menu]
--SET MenuID=MenuID+1--,Parent=Parent+1
--FROM [Menu]
--WHERE MenuID>=@MenuID-- and parent!=24

--UPDATE [Menu]
--SET parent=parent+1
--FROM [Menu]
--WHERE  parent>=@MenuID and parent!=24-- and MenuID>=@MenuID 


--UPDATE [Menu]
--SET MenuID=MenuID+1
--FROM [Menu]
--WHERE MenuID>=@MenuID and parent=24

INSERT INTO [Menu] ( NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded)
Values ( @NameMenu,@MenuID,@URL,@MenuLevel,@Parent,@IsLeaf,@IsExpanded )


--RETURN @OID
END
GO
/****** Object:  StoredProcedure [dbo].[Menu_GetAllParentMenu]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_GetAllParentMenu]
 

AS
BEGIN
	SELECT *
	FROM dbo.Menu
	WHERE (Parent = 0) AND (MenuLevel = 0)

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_GetAllMenuByParentID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_GetAllMenuByParentID]
@parentid varchar(50)

AS
BEGIN
SELECT OID, NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded, CreatedDate
FROM dbo.Menu
WHERE Parent=@parentid

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_GetAllMenu]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_GetAllMenu]


AS
BEGIN
SELECT OID, NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded, CreatedDate
FROM dbo.Menu
--WHERE MenuID!=35 --and MenuID!=36
ORDER BY MenuID asc
--WHERE Parent is null OR Parent=''

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_DeleteByURL]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_DeleteByURL]
@MenuURL as VARCHAR(400) 
AS

BEGIN

DELETE FROM [Menu] 
WHERE URL = @MenuURL

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_DeleteByParent]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_DeleteByParent]
@ParentID int 
AS

BEGIN

DELETE FROM [Menu] 
WHERE Parent = @ParentID

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_DeleteByID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_DeleteByID]
@MenuID int 
AS

BEGIN

DELETE FROM [Menu] 
WHERE MenuID = @MenuID

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_ByOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Menu_ByOID]
@MOID int

AS
BEGIN
	SELECT OID, NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded, CreatedDate
	FROM dbo.Menu
	WHERE MenuID=@MOID

END
GO
/****** Object:  StoredProcedure [dbo].[Menu_ByName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Menu_ByName]
@MenuName as VARCHAR(200)

AS
BEGIN
	SELECT OID, NameMenu, MenuID, URL, MenuLevel, Parent, IsLeave, IsExpanded, CreatedDate
	FROM dbo.Menu
	WHERE NameMenu=@MenuName

END
GO
/****** Object:  StoredProcedure [dbo].[Interventions_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Interventions_Update]
@PrescriptionOID int,
@RiskOID int,
@StudentOID int,
@UserOID int,
@DomainOID int,
@InterventionOID int, 
@LatestActionDate datetime, 
@LatestContact datetime,
@Internal int,
@Prescribed int,
@Completed int,
@Email int, 
@Telephone int,
@InPerson int,
@HandOff int, 
@Comment varchar(100),
@Urgent int, 
@Participating int,
@Testing int,
@AssessmentOID int
AS
BEGIN

	UPDATE [Prescription]
	SET StudentOID=@StudentOID, RiskOID=@RiskOID,UserOID=@UserOID, DomainOID=@DomainOID, InterventionOID=@InterventionOID, LatestActionDate=@LatestActionDate, LatestContact=@LatestContact, Internal=@Internal, Prescribed=@Prescribed, Completed=@Completed, Email=@Email, Telephone=@Telephone, InPerson=@InPerson, HandOff=@HandOff,Comment=@Comment, Urgent=@Urgent, Participating=@Participating, Testing=@Testing,AssessmentOID=@AssessmentOID
	WHERE PrescriptionOID=@PrescriptionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Interventions_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Interventions_insert]
@OID int OUTPUT,
@RiskOID int,
@StudentOID int,
@UserOID int,
@DomainOID int,
@InterventionOID int, 
@LatestActionDate datetime, 
@LatestContact datetime,
@Internal int,
@Prescribed int,
@Completed int,
@Email int, 
@Telephone int,
@InPerson int,
@HandOff int, 
@Comment varchar(100),
@Urgent int, 
@Participating int,
@Testing int,
@CreatedBy int,
@AssessmentOID int
AS
BEGIN
	--DECLARE @OID int

	INSERT INTO [Prescription] (StudentOID, RiskOID,UserOID, DomainOID, InterventionOID, LatestActionDate, LatestContact, Internal, Prescribed, Completed, Email, Telephone, InPerson, HandOff,Comment, Urgent, Participating, Testing,CreatedBy,AssessmentOID )
						Values ( @StudentOID,@RiskOID, @UserOID, @DomainOID, @InterventionOID, @LatestActionDate, @LatestContact, @Internal, @Prescribed, @Completed, @Email, @Telephone, @InPerson, @HandOff,@Comment, @Urgent, @Participating, @Testing,@CreatedBy,@AssessmentOID)

	SELECT @OID=  MAX(PrescriptionOID) FROM [Prescription] 
	RETURN @OID

END
GO
/****** Object:  StoredProcedure [dbo].[InterventionOID_ByInterventionName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InterventionOID_ByInterventionName]
@Name varchar(100)

AS
BEGIN
	SELECT InterventionOID
	FROM dbo.Intervention
	WHERE InterventionName=@Name

END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Intervention_Update]
@InterventionOID int ,
@InterventionName varchar (100)

AS
                                BEGIN
UPDATE [Intervention]  SET InterventionName = @InterventionName
WHERE InterventionOID = @InterventionOID
END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_Search_Report]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Intervention_Search_Report]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,												
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Prescription]
													  WHERE StudentOID !=0 
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PrescriptionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PrescriptionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RiskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RiskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].DomainOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].DomainOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].InterventionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].InterventionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestActionDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestActionDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestContact
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestContact
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Internal
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Internal
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Prescribed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Prescribed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Completed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Completed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Telephone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Telephone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InPerson
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InPerson
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HandOff
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HandOff
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].CreatedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].CreatedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].CreatedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].LastModifiedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].LastModifiedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].LastModifiedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].LastModifiedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Comment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Comment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Urgent
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Urgent
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Participating
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Participating
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Testing
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Testing
                                                              END DESC 
 ) AS RN ,
PrescriptionOID, 
StudentOID, 
RiskOID, 
[Prescription].UserOID, 
UserName,
[Prescription].DomainOID, 
DomainName,
[Prescription].InterventionOID, 
InterventionName,
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
[Prescription].Email, 
Telephone, 
InPerson, 
HandOff, 
[Prescription].CreatedDate, 
[Prescription].CreatedBy, 
[Prescription].LastModifiedDate, 
[Prescription].LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing 
   FROM     [Prescription],dbo.Domain,dbo.Intervention,dbo.[User]
WHERE [Prescription].DomainOID=dbo.Domain.DomainOID 
		AND [Prescription].InterventionOID=dbo.Intervention.InterventionOID
		AND [Prescription].UserOID=dbo.[User].UserOID 
		AND StudentOID !=0 
 ) 
SELECT
PrescriptionOID, 
CTE.StudentOID, 
BannerStudentIDNumber AS BannerID,
RiskOID, 
UserOID, 
UserName,
DomainOID, 
DomainName,
InterventionOID,
InterventionName, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing,
Student.BannerStudentName
 FROM    CTE LEFT JOIN Student

ON CTE.StudentOID=Student.StudentOID
--WHERE     RN BETWEEN @StartRow - @NumberOfRows
--AND     @StartRow - 1  AND CTE.StudentOID !=0 

END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_Search_Param]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Intervention_Search_Param]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,												
                                                @TotalRecords INT OUTPUT,
                                                
                                                @Datestamp DATETIME , 
                                                @BannerId VARCHAR(12), 
                                                @Participating INT, 
                                                @ActionDate DATETIME, 
                                                @Sponsor VARCHAR(100), 
                                                @CriteriaType  VARCHAR(100),  
                                                @OutcomeType VARCHAR(50), 
                                                @Urgent INT, 
                                                @Internal INT, 
                                                @Prescribed INT, 
                                                @Completed  INT, 
                                                @Email  INT, 
                                                @Telephone INT, 
                                                @InPerson  INT, 
                                                @Handoff INT, 
                                                @ContactDate DATETIME, 
                                                @Comment  VARCHAR(100)
                                                
                                                
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Prescription]
													  WHERE StudentOID !=0 
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PrescriptionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PrescriptionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RiskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RiskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].DomainOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].DomainOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].InterventionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].InterventionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestActionDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestActionDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestContact
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestContact
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Internal
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Internal
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Prescribed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Prescribed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Completed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Completed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Telephone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Telephone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InPerson
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InPerson
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HandOff
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HandOff
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].CreatedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].CreatedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].CreatedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].LastModifiedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].LastModifiedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN [Prescription].LastModifiedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN [Prescription].LastModifiedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Comment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Comment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Urgent
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Urgent
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Participating
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Participating
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Testing
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Testing
                                                              END DESC 
 ) AS RN ,
PrescriptionOID, 
StudentOID, 
RiskOID, 
[Prescription].UserOID, 
UserName,
[Prescription].DomainOID, 
DomainName,
[Prescription].InterventionOID, 
InterventionName,
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
[Prescription].Email, 
Telephone, 
InPerson, 
HandOff, 
[Prescription].CreatedDate, 
[Prescription].CreatedBy, 
[Prescription].LastModifiedDate, 
[Prescription].LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing 
   FROM     [Prescription],dbo.Domain,dbo.Intervention,dbo.[User]
WHERE [Prescription].DomainOID=dbo.Domain.DomainOID 
		AND [Prescription].InterventionOID=dbo.Intervention.InterventionOID
		AND [Prescription].UserOID=dbo.[User].UserOID 
		AND StudentOID !=0 
		
		AND (@Datestamp = '1/1/1900' OR [Prescription].LatestContact = @Datestamp)
		AND (@Participating = -1 OR [Prescription].Participating = @Participating)
		AND (@ActionDate = '1/1/1900' OR [Prescription].LatestActionDate = @ActionDate)
		AND (@Sponsor = '' OR [USER].UserName LIKE '%' + @Sponsor + '%')
		AND (@CriteriaType = '' OR [Domain].DomainName LIKE '%' + @CriteriaType + '%')
		AND (@OutcomeType = '' OR [Intervention].InterventionName LIKE '%' + @OutcomeType + '%')
		AND (@Urgent = -1 OR [Prescription].Urgent = @Urgent)
		AND (@Internal = -1 OR [Prescription].Internal = @Internal)
		AND (@Prescribed = -1 OR [Prescription].Prescribed = @Prescribed)
		AND (@Completed = -1 OR [Prescription].Completed = @Completed)
		AND (@Email = -1 OR [Prescription].Email = @Email)
		AND (@Telephone = -1 OR [Prescription].Telephone = @Telephone)
		AND (@InPerson = -1 OR [Prescription].InPerson = @InPerson)
		AND (@Handoff = -1 OR [Prescription].HandOff = @Handoff)
		AND (@ContactDate = '1/1/1900' OR [Prescription].LatestContact = @ContactDate)
		AND (@Comment = '' OR [Prescription].Comment LIKE '%' + @Comment + '%')
 ) 
SELECT
PrescriptionOID, 
CTE.StudentOID, 
BannerStudentIDNumber AS BannerID,
RiskOID, 
UserOID, 
UserName,
DomainOID, 
DomainName,
InterventionOID,
InterventionName, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing,
Student.BannerStudentName
 FROM    CTE LEFT JOIN Student

ON CTE.StudentOID=Student.StudentOID
WHERE     RN BETWEEN @StartRow - @NumberOfRows
AND     @StartRow - 1  AND CTE.StudentOID !=0 
AND		(@BannerId = '' OR [Student].BannerStudentIDNumber LIKE '%' + @BannerId + '%')

END
GO
/****** Object:  StoredProcedure [dbo].[AllStudent_Update_ByResultLetterSentTimes]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AllStudent_Update_ByResultLetterSentTimes]
@ResultLetterSentTimes int
AS
BEGIN
	UPDATE dbo.Student
	SET ResultLetterSentTimes = (@ResultLetterSentTimes + 1)
	WHERE ResultLetterSentTimes=@ResultLetterSentTimes
END
GO
/****** Object:  StoredProcedure [dbo].[AllStudent_ByTermCodeofProgramEnrollment]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AllStudent_ByTermCodeofProgramEnrollment]
@TermCodeofProgramEnrollment varchar(20)
AS
BEGIN
	SELECT TOP(10) *
	FROM dbo.Student
	WHERE (TermCodeofProgramEnrollment <> @TermCodeofProgramEnrollment)
END
GO
/****** Object:  StoredProcedure [dbo].[AllStudent_ByStudentOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AllStudent_ByStudentOID]

AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, StateName, ZipCode, EmailAddress, ImportDateFileCreationDate, PreprogramIndicator, MajorProgramEnrollmentName, StudentOID, FileCreationDate
	FROM dbo.Student
	
END
GO
/****** Object:  StoredProcedure [dbo].[AllStudent_ByResultLetterSentTimes]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AllStudent_ByResultLetterSentTimes]
@ResultLetterSentTimes int
AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, StateName, ZipCode, EmailAddress, ImportDateFileCreationDate, PreprogramIndicator, MajorProgramEnrollmentName, StudentOID, FileCreationDate, ResultLetterSentTimes
	FROM dbo.Student
	WHERE ResultLetterSentTimes=@ResultLetterSentTimes
END
GO
/****** Object:  StoredProcedure [dbo].[AllCourse_ByCourseOID]    Script Date: 06/12/2012 20:29:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AllCourse_ByCourseOID]

AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, CourseNumber, CourseTitle, FinalGrade, TermCodeOfCourseEnrollment, MethodOfDelivery, ImportDate, CourseOID, FileCreationDate
	FROM dbo.Course
	
END
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 06/12/2012 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerOID] [int] IDENTITY(1,1) NOT NULL,
	[BannerStudentIDNumber] [varchar](12) NULL,
	[AssessmentOID] [int] NOT NULL,
	[StudentOID] [int] NULL,
	[NumberOfPrinted] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[AnswerOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssessmentResultLetter]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssessmentResultLetter](
	[AssessmentResultLetter] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentOID] [int] NULL,
	[Header] [varchar](max) NULL,
	[ShowAboveResult] [varchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentResultLetter] PRIMARY KEY CLUSTERED 
(
	[AssessmentResultLetter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssessmentResultEmail]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssessmentResultEmail](
	[AssessmentResultOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentOID] [int] NULL,
	[Header] [nvarchar](max) NULL,
	[ShowAboveResult] [varchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentResultEmail] PRIMARY KEY CLUSTERED 
(
	[AssessmentResultOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssessmentReminderEmail]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssessmentReminderEmail](
	[AssessmentReminderOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentOID] [int] NOT NULL,
	[EmailBody] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentReminderEmail] PRIMARY KEY CLUSTERED 
(
	[AssessmentReminderOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AssessmentOIDBY_NMAE]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AssessmentOIDBY_NMAE]
@AssName varchar(100)

AS
BEGIN
	SELECT AssessmentOID, AssessmentName, RefMenuID, TotalQuestion, TotalFlag, TotalFlagPoint, TotalSection, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.Assessment
	WHERE AssessmentName=@AssName

END
GO
/****** Object:  StoredProcedure [dbo].[Course_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_Update]
@CourseOID int,
@BannerStudentName varchar(80), 
@BannerStudentIDNumber varchar(12), 
@TermCodeofProgramEnrollment varchar(20), 
@CourseNumber varchar(15), 
@CourseTitle varchar(100),
@FinalGrade varchar(15), 
@TermCodeOfCourseEnrollment varchar(15),
@MethodOfDelivery varchar(50), 
@ImportDate datetime


AS
BEGIN
UPDATE dbo.Course
SET BannerStudentName=@BannerStudentName, BannerStudentIDNumber=@BannerStudentIDNumber, 
TermCodeofProgramEnrollment=@TermCodeofProgramEnrollment, CourseNumber=@CourseNumber, 
CourseTitle=@CourseTitle, FinalGrade=@FinalGrade, TermCodeOfCourseEnrollment=@TermCodeOfCourseEnrollment,
 MethodOfDelivery=@MethodOfDelivery, ImportDate=@ImportDate  
WHERE CourseOID=@CourseOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Course_SelectjqGrid{0}]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_SelectjqGrid{0}]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Course]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TermCodeofProgramEnrollment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TermCodeofProgramEnrollment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseTitle'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseTitle
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseTitle'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseTitle
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FinalGrade'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FinalGrade
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FinalGrade'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FinalGrade
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TermCodeOfCourseEnrollment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeOfCourseEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TermCodeOfCourseEnrollment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeOfCourseEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MethodOfDelivery'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MethodOfDelivery
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MethodOfDelivery'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MethodOfDelivery
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
   FROM     [Course] ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[DomainOID_ByDomainName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DomainOID_ByDomainName]
@Name varchar(100)

AS
BEGIN
	SELECT DomainOID
	FROM dbo.Domain
	WHERE DomainName=@Name

END
GO
/****** Object:  StoredProcedure [dbo].[DomainInterventions_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DomainInterventions_insert]
@DomainID int,
@InterventionName varchar (100)

AS
BEGIN
INSERT INTO [Intervention] ( DomainID,InterventionName)Values ( 
@DomainID,@InterventionName )
END
GO
/****** Object:  StoredProcedure [dbo].[Domain_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Domain_Update]
@DomainOID int ,
@DomainName varchar (100)

AS
                                BEGIN
UPDATE [Domain]  SET DomainName = @DomainName
WHERE DomainOID = @DomainOID
END
GO
/****** Object:  StoredProcedure [dbo].[Domain_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Domain_insert]

@DomainName varchar (100)

AS
BEGIN
INSERT INTO [Domain] ( DomainName)Values ( 
@DomainName )
END
GO
/****** Object:  StoredProcedure [dbo].[Domain_GetAll]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Domain_GetAll]
AS
BEGIN
	SELECT *
	FROM dbo.Domain
END
GO
/****** Object:  StoredProcedure [dbo].[Domain_Delete]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Domain_Delete]
@DomainOID int 
AS

BEGIN

DELETE FROM [Domain]  
WHERE DomainOID = @DomainOID

END
GO
/****** Object:  StoredProcedure [dbo].[Course_SelectjqGrid]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_SelectjqGrid]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [Course]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseTitle
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseTitle
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FinalGrade
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FinalGrade
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeOfCourseEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeOfCourseEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MethodOfDelivery
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MethodOfDelivery
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
   FROM     [Course] ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[GetNoOfFlagByAOID1]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNoOfFlagByAOID1]
@AOID int

AS
BEGIN
SELECT  DISTINCT StudentOID,AssessmentOID,sum(NumberOfFlag) as FlagRating,NumberOfPrinted  FROM ScoreDetailTable WHERE AssessmentOID = @AOID 
group by StudentOID,AssessmentOID,NumberOfPrinted
order by StudentOID asc
END
GO
/****** Object:  StoredProcedure [dbo].[GetMaxMenuID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMaxMenuID]

AS
BEGIN
	SELECT MAX(MenuID) AS MenuID
	FROM dbo.Menu
END
GO
/****** Object:  StoredProcedure [dbo].[GetNoOfFlagByAOIDANDSOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNoOfFlagByAOIDANDSOID]
@AOID INT,
@SOID INT,
@Counter int OUTPUT
AS
BEGIN

 --SELECT  sum(NumberOfFlag) as FlagRating  FROM ScoreDetailTable WHERE AssessmentOID = @AOID AND StudentOID = @SOID


SELECT @Counter = (SELECT sum(NumberOfFlag) as FlagRating  FROM ScoreDetailTable WHERE AssessmentOID = @AOID AND StudentOID = @SOID) 
RETURN @Counter 

END
GO
/****** Object:  StoredProcedure [dbo].[GetNoOfFlagByAOID1_Test]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNoOfFlagByAOID1_Test] @AOID INT
AS 
    BEGIN
        SELECT  DISTINCT
                StudentOID ,
                AssessmentOID ,
                SUM(NumberOfFlag) AS FlagRating ,
                NumberOfPrinted
        FROM    ScoreDetailTable
        WHERE   AssessmentOID = @AOID
        GROUP BY StudentOID ,
                AssessmentOID ,
                NumberOfPrinted
        ORDER BY StudentOID ASC
    END
GO
/****** Object:  StoredProcedure [dbo].[GetScoreDetailTableByAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[GetScoreDetailTableByAOID]
@AOID varchar(20)

AS
BEGIN
	SELECT *
	FROM dbo.ScoreDetailTable
	where AssessmentOID=@AOID 
END
GO
/****** Object:  StoredProcedure [dbo].[Course_Search]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_Search]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT,
                                                
                                                @BannerStudentName VARCHAR(80), 
                                                @BannerStudentIDNumber VARCHAR(12), 
                                                @TermCodeofProgramEnrollment VARCHAR(20), 
                                                @CourseNumber VARCHAR(15), 
                                                @CourseTitle VARCHAR(100), 
                                                @FinalGrade VARCHAR(15), 
                                                @TermCodeOfCourseEnrollment VARCHAR(15), 
                                                @MethodOfDelivery VARCHAR(50), 
                                                
                                                @ImportDate DateTime, 
                                                @CourseOID INT,
                                                @FileCreationDate DateTime
                                                AS
                                                    BEGIN
                                                    
 SELECT  @TotalRecords = ( SELECT    COUNT(BannerStudentName)
        FROM      [Course]
		WHERE 
		(@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%' )
		AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber+'%') 
		AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%')
		AND (@CourseNumber = '' OR CourseNumber LIKE '%'+@CourseNumber+'%')
		AND (@CourseTitle = '' OR CourseTitle LIKE '%'+@CourseTitle+'%')
		AND (@FinalGrade = '' OR FinalGrade LIKE '%'+@FinalGrade+'%')
		AND (@TermCodeOfCourseEnrollment = '' OR TermCodeOfCourseEnrollment LIKE '%'+@TermCodeOfCourseEnrollment+'%') 
		AND (@MethodOfDelivery = '' OR MethodOfDelivery LIKE '%'+@MethodOfDelivery+'%')
		AND (@ImportDate='1/1/1900' OR ImportDate = @ImportDate) 
		AND (@CourseOID = 0 OR CourseOID = @CourseOID)
		AND (@FileCreationDate='1/1/1900' OR FileCreationDate = @FileCreationDate)
        )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
          
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseTitle
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseTitle
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FinalGrade
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FinalGrade
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeOfCourseEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeOfCourseEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MethodOfDelivery
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MethodOfDelivery
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, 
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
   FROM     [Course] 
   Where
			(@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%' )
		AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber+'%') 
		AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%')
		AND (@CourseNumber = '' OR CourseNumber LIKE '%'+@CourseNumber+'%')
		AND (@CourseTitle = '' OR CourseTitle LIKE '%'+@CourseTitle+'%')
		AND (@FinalGrade = '' OR FinalGrade LIKE '%'+@FinalGrade+'%')
		AND (@TermCodeOfCourseEnrollment = '' OR TermCodeOfCourseEnrollment LIKE '%'+@TermCodeOfCourseEnrollment+'%') 
		AND (@MethodOfDelivery = '' OR MethodOfDelivery LIKE '%'+@MethodOfDelivery+'%')
		AND (@ImportDate='1/1/1900' OR ImportDate = @ImportDate) 
		AND (@CourseOID = 0 OR CourseOID = @CourseOID)
		AND (@FileCreationDate='1/1/1900' OR FileCreationDate = @FileCreationDate)   
   ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
CourseNumber, 
CourseTitle, 
FinalGrade, 
TermCodeOfCourseEnrollment, 
MethodOfDelivery, 
ImportDate, 
CourseOID, 
FileCreationDate 
 FROM    CTE
        WHERE    
        RN BETWEEN @StartRow - @NumberOfRows  AND  @StartRow - 1  --AND
		--(@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%' )
		--AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber+'%') 
		--AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%')
		--AND (@CourseNumber = '' OR CourseNumber LIKE '%'+@CourseNumber+'%')
		--AND (@CourseTitle = '' OR CourseTitle LIKE '%'+@CourseTitle+'%')
		--AND (@FinalGrade = '' OR FinalGrade LIKE '%'+@FinalGrade+'%')
		--AND (@TermCodeOfCourseEnrollment = '' OR TermCodeOfCourseEnrollment LIKE '%'+@TermCodeOfCourseEnrollment+'%') 
		--AND (@MethodOfDelivery = '' OR MethodOfDelivery LIKE '%'+@MethodOfDelivery+'%')
		--AND (@ImportDate='1/1/1900' OR ImportDate = @ImportDate) 
		--AND (@CourseOID = 0 OR CourseOID = @CourseOID)
		--AND (@FileCreationDate='1/1/1900' OR FileCreationDate = @FileCreationDate)                                                 
		 END
GO
/****** Object:  StoredProcedure [dbo].[Course_Insert_import]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Course_Insert_import]
@BannerStudentName varchar(80),
@BannerStudentIDNumber varchar(12),
@TermCodeofProgramEnrollment varchar(20),
@CourseNumber varchar(200),
@CourseTitle varchar(200),
@FinalGrade varchar(15),
@MethodOfDelivery varchar(150),
@TermCodeOfCourseEnrollment varchar(75),
@ImportDate varchar(50)


AS
BEGIN
insert into dbo.Course (BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, CourseNumber, CourseTitle, FinalGrade, MethodOfDelivery,TermCodeOfCourseEnrollment,  ImportDate)
				  values(@BannerStudentName,@BannerStudentIDNumber,@TermCodeofProgramEnrollment,@CourseNumber,@CourseTitle,@FinalGrade,@MethodOfDelivery,@TermCodeOfCourseEnrollment,@ImportDate)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Course_ByStudentOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_ByStudentOID]
@SOID varchar(20)
AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, CourseNumber, CourseTitle, FinalGrade, TermCodeOfCourseEnrollment, MethodOfDelivery, ImportDate, CourseOID, FileCreationDate
	FROM dbo.Course
	where BannerStudentIDNumber=@SOID
END
GO
/****** Object:  StoredProcedure [dbo].[Course_ByCourseOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_ByCourseOID]
@COID int
AS
BEGIN
	SELECT BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, CourseNumber, CourseTitle, FinalGrade, TermCodeOfCourseEnrollment, MethodOfDelivery, ImportDate, CourseOID, FileCreationDate
	FROM dbo.Course
	where CourseOID=@COID
END
GO
/****** Object:  StoredProcedure [dbo].[AssessmentOID_BYName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AssessmentOID_BYName]
@AOID varchar(100)

AS
BEGIN
SELECT AssessmentOID
FROM dbo.Assessment
WHERE AssessmentName=@AOID

END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_UpdateStatus]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_UpdateStatus]
@AOID int
AS
BEGIN
UPDATE Assessment SET Locked=1
where AssessmentOID=@AOID
END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_BYPOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_BYPOID]
@POID int

AS
BEGIN
	SELECT *
	FROM  Prescription     
                      
	WHERE PrescriptionOID=@POID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_BYOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_BYOID]
@AOID int

AS
BEGIN
	SELECT *
	FROM dbo.Assessment
	WHERE AssessmentOID=@AOID

END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_insert]

@AOID int OUTPUT,
@AssessmentName varchar(100), 
@CreatedBy int,  
@LastModifiedBy int,
@RefMenuID int,
@TotalFlag int, 
@TotalFlagPoint int, 
@TotalQuestion int,
@TotalSection int 




AS
BEGIN

 


	INSERT INTO Assessment(AssessmentName, TotalQuestion, TotalFlag, TotalFlagPoint, TotalSection, CreatedBy,  LastModifiedBy,RefMenuID)
	values(@AssessmentName, @TotalQuestion, @TotalFlag, @TotalFlagPoint, @TotalSection, @CreatedBy,  @LastModifiedBy,@RefMenuID)
	SELECT @AOID=  MAX(AssessmentOID) FROM Assessment 
	RETURN @AOID
END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_GetAll]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_GetAll]
AS
BEGIN
	SELECT *
	FROM dbo.Assessment
	WHERE Status='active'
END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_First]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Assessment_First]


AS
BEGIN
SELECT top(1) AssessmentName
FROM dbo.Assessment

END
GO
/****** Object:  StoredProcedure [dbo].[Chart_GETLabels]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Chart_GETLabels]


AS
BEGIN
SELECT     
					  MAX(CAST(LatestCompassPrealgebraTestScore AS numeric(11, 0))) AS maxPrealgebra, 
					  MIN(CAST(LatestCompassPrealgebraTestScore AS numeric(11, 0))) AS minPrealgebra, 
                      AVG(CAST(LatestCompassPrealgebraTestScore AS numeric(11, 3))) AS avgPrealgebra, 
					  
					  MAX(CAST(LatestCompassAlgebraTestScore AS numeric(11, 0))) AS maxAlgebra, 
                      MIN(CAST(LatestCompassAlgebraTestScore AS numeric(11, 0))) AS minAlgebra, 
                      AVG(CAST(LatestCompassAlgebraTestScore AS numeric(11, 3))) AS avgAlgebra,


					  MAX(CAST(LatestCompassWritingTestScore AS numeric(11, 0))) AS maxWritting, 
                      MIN(CAST(LatestCompassWritingTestScore AS numeric(11, 0))) AS minWritting, 
                      AVG(CAST(LatestCompassWritingTestScore AS numeric(11, 3))) AS avgWritting,
                                            
                      MAX(CAST(LatestCompassReadingTestScore AS numeric(11, 0))) AS maxReading,
                      MIN(CAST(LatestCompassReadingTestScore AS numeric(11, 0))) AS minReading, 
                      AVG(CAST(LatestCompassReadingTestScore AS numeric(11, 3))) AS avgReading,


                      
                      MAX(CAST(LatestACTEnglishAssessmentScore AS numeric(11, 0))) AS maxAssessmentEnglish, 
                      MIN(CAST(LatestACTEnglishAssessmentScore AS numeric(11, 0))) AS minAssessmentEnglish, 
                      AVG(CAST(LatestACTEnglishAssessmentScore AS numeric(11, 3))) AS avgAssessmentEnglish,
                      
                      
                      MAX(CAST(LatestACTMathAssessmentScore AS numeric(11, 0))) AS maxAssessmentMath, 
                      MIN(CAST(LatestACTMathAssessmentScore AS numeric(11, 0))) AS minAssessmentMath, 
                      AVG(CAST(LatestACTMathAssessmentScore AS numeric(11, 3))) AS avgAssessmentMath,
                      
                      MAX(CAST(LatestACTReadingAssessmentScore AS numeric(11, 0))) AS maxReadingAssessment, 
                      MIN(CAST(LatestACTReadingAssessmentScore AS numeric(11, 0))) AS minReadingAssessment, 
                      AVG(CAST(LatestACTReadingAssessmentScore AS numeric(11, 3))) AS avgReadingAssessment,
                      
                      MAX(CAST(LatestACTScienceAssessmentScore AS numeric(11, 0))) AS maxScienceAssessment, 
                      MIN(CAST(LatestACTScienceAssessmentScore AS numeric(11, 0))) AS minScienceAssessment, 
                      AVG(CAST(LatestACTScienceAssessmentScore AS numeric(11, 3))) AS avgScienceAssessment
                      
FROM         dbo.Student
where LatestCompassPrealgebraTestScore!='0' and LatestCompassAlgebraTestScore!='0' and LatestCompassWritingTestScore!='0' and
LatestCompassReadingTestScore!='0' and LatestACTEnglishAssessmentScore!='0' and LatestACTMathAssessmentScore!='0' and
LatestACTReadingAssessmentScore!='0' and LatestACTScienceAssessmentScore!='0'

END
GO
/****** Object:  Table [dbo].[AssResultLetterSectionComment]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssResultLetterSectionComment](
	[ResultLetterSectionCommentOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentLetterOID] [int] NOT NULL,
	[SectionOID] [int] NOT NULL,
	[SectionDefinition] [varchar](500) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_AssResultLetterSectionComment] PRIMARY KEY CLUSTERED 
(
	[ResultLetterSectionCommentOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssessmentResultSectionComment]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssessmentResultSectionComment](
	[ResultSectionOID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentResultOID] [int] NOT NULL,
	[SectionOID] [int] NOT NULL,
	[PositiveResult] [varchar](500) NULL,
	[NegativeResult] [varchar](500) NULL,
	[LowResult] [varchar](500) NULL,
	[MediumResult] [varchar](500) NULL,
	[HighResult] [varchar](500) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentResultSectionComment] PRIMARY KEY CLUSTERED 
(
	[ResultSectionOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Assessment_DisableStatus]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_DisableStatus]
@AOID int
AS
BEGIN
UPDATE Assessment SET Status='inactive'
where AssessmentOID=@AOID

delete from dbo.Answer where AssessmentOID=@AOID
delete from dbo.AssessmentResultLetter where AssessmentOID=@AOID
delete from AssessmentResultEmail where AssessmentOID=@AOID
delete from AssessmentReminderEmail where AssessmentOID=@AOID
delete from Section where AssessmentOID=@AOID
delete from RiskCalculation where AssessmentOID=@AOID
delete from Assessment  where AssessmentOID=@AOID
delete from dbo.ScoreDetailTable where AssessmentOID=@AOID

END
GO
/****** Object:  StoredProcedure [dbo].[Assessment_BYSOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessment_BYSOID]
@SOID varchar(100)

AS
BEGIN
	SELECT distinct dbo.Assessment.AssessmentName,dbo.Assessment.AssessmentOID 
	FROM         dbo.Answer LEFT OUTER JOIN
                      dbo.Assessment ON dbo.Answer.AssessmentOID = dbo.Assessment.AssessmentOID
                      
	WHERE dbo.Answer.BannerStudentIDNumber=@SOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetRiskOID_ByAOIDAndName]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[GetRiskOID_ByAOIDAndName]
@AOID varchar(20),
@RiskName varchar(100)
AS
BEGIN
	SELECT *
	FROM dbo.RiskCalculation
	where AssessmentOID=@AOID and RiskName=@RiskName
END
GO
/****** Object:  StoredProcedure [dbo].[GetRiskCalculationByAOIDANDSOIDANDRISKNAME]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetRiskCalculationByAOIDANDSOIDANDRISKNAME]
@AOID INT,
@SOID INT,
@RISK_NAME varchar(100)
AS
BEGIN
 
DECLARE @return_value int, @Counter int;

EXEC @return_value = [dbo].[GetNoOfFlagByAOIDANDSOID] @AOID, @SOID, @Counter OUTPUT;

SELECT TOP(1) RiskOID, RiskName, AssessmentOID, NumSection, NumFlag, CreatedDate, CreatedBy
 
FROM dbo.RiskCalculation 
WHERE (AssessmentOID = @AOID) AND (NumFlag = @return_value) AND (RiskName=@RISK_NAME )
ORDER BY NumFlag Desc

END
GO
/****** Object:  StoredProcedure [dbo].[GetRiskCalculationByAOIDANDSOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetRiskCalculationByAOIDANDSOID]
@AOID INT,
@SOID INT
AS
BEGIN
 
DECLARE @return_value int, @Counter int;

EXEC @return_value = [dbo].[GetNoOfFlagByAOIDANDSOID] @AOID, @SOID, @Counter OUTPUT;

SELECT TOP(1) RiskOID, RiskName, AssessmentOID, NumSection, NumFlag, CreatedDate, CreatedBy
 
FROM dbo.RiskCalculation
WHERE (AssessmentOID = @AOID) AND (NumFlag <= @return_value)
ORDER BY NumFlag Desc

END
GO
/****** Object:  StoredProcedure [dbo].[GET_StudentByOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_StudentByOID]
@SOID INT

AS
BEGIN
SELECT *
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALLERT') AS ALLERT

	FROM dbo.Student
	WHERE StudentOID=@SOID

END



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[AssessmentOID_BYSectionOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AssessmentOID_BYSectionOID]
@SectionOID int

AS
BEGIN
	SELECT SectionOID, AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag,Low, Medium, High, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.Section
	WHERE SectionOID=@SectionOID
END
GO
/****** Object:  StoredProcedure [dbo].[Assessement_ResultByAOID_Test]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessement_ResultByAOID_Test]
    @PageIndex INT ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT ,
    @AOID INT ,
    @SearchColumnName VARCHAR(400) ,
    @SortOrderBy VARCHAR(4) ,
    @BannerID VARCHAR(20) ,
    @Program VARCHAR(250) ,
    @StudentName VARCHAR(150),
    @SearchValue VARCHAR(max),
    @SortColumnName VARCHAR(50),
    @SortOrSearchFlag varchar(10),
    @MultiCoulumn Varchar(10) 
AS 
    BEGIN

        DECLARE @startRow INT
        DECLARE @endRow INT
       
        
        SET @startRow = ( @PageIndex - 1 ) * @NumberOfRows + 1
        SET @endRow = @PageIndex * @NumberOfRows
        
        
		--Added for sorting
        DECLARE @SortString VARCHAR(MAX)
        
        --Temp added by mominul
        declare @srchVal VARCHAR(MAX)
        set @srchVal = @SearchValue
        --end Temp
        declare @numberOfDelimeterOfCol int
        DECLARE @WhereString VARCHAR(MAX)
        declare @posCol int
        declare @posVal int
        declare @tempCol varchar(250)
        declare @tempColTest varchar(100)
        declare @tempVal varchar(100)
        declare @lengthCol int
        declare @lengthVal int
        declare @ColOperated VARCHAR(250)
        declare @ValOperated VARCHAR(250)
        declare @removedCol varchar(400)
        declare @removedVal varchar(400)
        declare @uptoCol int
        declare @uptoVal int
        
     SET @WhereString = 'WHERE (1=1)'
     --Start IF for Search
     if(@SortOrSearchFlag='Search')
     begin
     set @posCol =1
     set @posVal =1
     set @ColOperated = ''
     set @ValOperated = ''
     set @removedCol=''
     set @removedVal=''
     set @uptoCol=1
     set @uptoVal=1
    
     declare @i int
     set @i=0
        if(@MultiCoulumn = 'No')
		begin 
			set @numberOfDelimeterOfCol = 0
		end
	 else
		begin
			set  @numberOfDelimeterOfCol=(LEN(@SearchColumnName) - LEN(REPLACE(@SearchColumnName, ',', '')))	
			
		end
		
     
   while(@i<@numberOfDelimeterOfCol)
    begin
     if(@numberOfDelimeterOfCol > 0)
		 begin
			
			
			if(@i>0)
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@removedCol)-1))
				
				end
			else
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@SearchColumnName)-1))
				end
			set @ColOperated = @ColOperated +  @tempCol+','
			set @removedCol=REPLACE (@SearchColumnName,@ColOperated,'')
			set @uptoCol =CHARINDEX (',',@removedCol)
			
			if(@i>0)
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@removedVal)-1))
				end
			else
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@srchVal)-1))
				end
			set @ValOperated = @ValOperated +  @tempVal+','			
			set @removedVal=REPLACE (@srchVal,@ValOperated,'')
			set @uptoVal =CHARINDEX (',',@removedVal)
		 end
     
     else
		 begin
			set @tempCol=@SearchColumnName
			set @tempVal=@srchVal
		 end
     set @posCol=LEN(@ColOperated)+1
     set @posVal=LEN(@ValOperated)+1
   
       if(CHARINDEX ('-',@tempVal)>0)
		 begin
			  declare @startRange varchar(100), @endRange varchar(100),@position int
			  set @position =charindex('-',@tempVal)
			  set @startRange=ltrim(SUBSTRING (@tempVal,1,@position-1))
			  set @endRange =ltrim(SUBSTRING (@tempVal,@position+1,(len(@tempVal)-@position)))
			  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] >= ' + @startRange + '  and [' + @tempCol + '] <=  ' + @endRange + '' ;
		 end
		else
		  begin
			 if(@tempCol='Program'or @tempCol='StudentName' or @tempCol='BannerID')
				 begin
				  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] like  ''%' + @tempVal + '%''' ;
				 end
	         
			 else
				 begin
				 SET @WhereString = @WhereString + ' AND [' + @tempCol + '] =  ' + @tempVal + '' ;
				 end
         end
         set @i=@i+1
       end
     end
     --End IF for Search
       
       
        --> ADDED by CVTC
        IF ( @SortColumnName IS NULL
             OR @SortColumnName = ''
           ) 
            SET @SortColumnName = 'BannerID'
            
        
        IF ( @SortOrderBy IS NULL
             OR @SortOrderBy = ''
           ) 
            SET @SortOrderBy = 'ASC'
            
        SET @SortString = ' ORDER BY [' + @SortColumnName + '] '
            + UPPER(ISNULL(@SortOrderBy, 'ASC'))
            
      
		
        DECLARE cur CURSOR
        FOR
            SELECT DISTINCT
                    SectionName
            FROM    Section
            WHERE   AssessmentOID = @AOID
                    AND SectionName != 'NoScore'

        DECLARE @Temp NVARCHAR(MAX) ,
            @AllSectionNames NVARCHAR(MAX) ,
            @SectionQuery NVARCHAR(MAX)
        DECLARE @AllSectionScore NVARCHAR(MAX)
        DECLARE @AllSectionRank NVARCHAR(MAX)

        SET @AllSectionNames = ' '
        SET @AllSectionRank = ' '
        SET @AllSectionScore = ' '

        OPEN Cur
			-- Getting all the subjects
        FETCH NEXT FROM Cur INTO @Temp
        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @AllSectionNames = @AllSectionNames + '[' + @Temp + '],'
                SET @AllSectionRank = @AllSectionRank + '[' + @Temp
                    + '-Rank],'
                SET @AllSectionScore = @AllSectionScore + '[' + @Temp
                    + '-Score],'
                FETCH NEXT FROM Cur INTO @Temp
            END
        CLOSE Cur
        DEALLOCATE Cur

        SET @AllSectionNames = SUBSTRING(@AllSectionNames, 0,
                                         LEN(@AllSectionNames))
        SET @AllSectionScore = SUBSTRING(@AllSectionScore, 0,
                                         LEN(@AllSectionScore))
        SET @AllSectionRank = SUBSTRING(@AllSectionRank, 0,
                                        LEN(@AllSectionRank))

		-- Building the pivot query
        SET @SectionQuery = 'SELECT AssessmentOID,StdScore.StudentOID ,BannerID,Program,StudentName,StdScore.StudentOID Flag,StdScore.StudentOID NumberOfPrinted, '
        
            + @AllSectionRank + ', ' + @AllSectionScore
            + ', ROW_NUMBER() OVER (' + @SortString + ') AS RowNum FROM'
        SET @SectionQuery = @SectionQuery
            + '(SELECT AssessmentOID,StudentOID ,BannerID,Program,StudentName, '
            + @AllSectionRank
            + '

	FROM
	(SELECT ScoreDetailTable.AssessmentOID,StudentOID,BannerID,Program,StudentName,COALESCE(Rank,'' '') AS Rank,RankName--Section.SectionName
	FROM   ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Rank)
	FOR RankName IN
	(' + @AllSectionRank + ')) AS pvt) AS StdScore'


        SET @SectionQuery = @SectionQuery + ' INNER JOIN '
            + '(SELECT StudentOID , ' + @AllSectionScore + '

	FROM
	(SELECT StudentOID,COALESCE(Score,'' '') AS Score,ScoreName
	FROM ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Score)
	FOR ScoreName IN
	(' + @AllSectionScore + ')) AS pvt) AS StdRank'
            + ' ON StdScore.StudentOID= StdRank.StudentOID'

		
		
        
        SET @SectionQuery = @SectionQuery + CHAR(10) +@WhereString ;
	
		--For Counter
        DECLARE @SectionQueryCounter NVARCHAR(MAX)
        SET @SectionQueryCounter = 'SELECT COUNT(*) FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable'
	 
        CREATE TABLE #tmpTable ( OutputValue INT )
        INSERT  INTO #tmpTable
                ( OutputValue
                )
                EXEC sp_executesql @SectionQueryCounter

        SELECT  @TotalRecords = OutputValue
        FROM    #tmpTable

        DROP TABLE #tmpTable	
		--
	 
        SET @SectionQuery = 'SELECT * FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable WHERE MyDerivedTable.RowNum BETWEEN '
            + CAST(@startRow AS VARCHAR(5)) + ' AND '
            --> ADDED by CVTC
            + CAST(@endRow AS VARCHAR(5)) + CHAR(10) + @SortString 
			--> END ADDED by CVTC
			
        EXEC sp_executesql @SectionQuery
        --PRINT @SectionQuery
    END
GO
/****** Object:  StoredProcedure [dbo].[Assessement_ResultByAOID_Report]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessement_ResultByAOID_Report]
    @PageIndex INT ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT ,
    @AOID INT ,
    @SearchColumnName VARCHAR(400) ,
    @SortOrderBy VARCHAR(4) ,
    @BannerID VARCHAR(20) ,
    @Program VARCHAR(250) ,
    @StudentName VARCHAR(150),
    @SearchValue VARCHAR(max),
    @SortColumnName VARCHAR(50),
    @SortOrSearchFlag varchar(10),
    @MultiCoulumn Varchar(10) 
AS 
    BEGIN

        DECLARE @startRow INT
        DECLARE @endRow INT
       
        
        SET @startRow = ( @PageIndex - 1 ) * @NumberOfRows + 1
        SET @endRow = @PageIndex * @NumberOfRows
        
        
		--Added for sorting
        DECLARE @SortString VARCHAR(MAX)
        
        --Temp added by mominul
        declare @srchVal VARCHAR(MAX)
        set @srchVal = @SearchValue
        --end Temp
        declare @numberOfDelimeterOfCol int
        DECLARE @WhereString VARCHAR(MAX)
        declare @posCol int
        declare @posVal int
        declare @tempCol varchar(250)
        declare @tempColTest varchar(100)
        declare @tempVal varchar(100)
        declare @lengthCol int
        declare @lengthVal int
        declare @ColOperated VARCHAR(250)
        declare @ValOperated VARCHAR(250)
        declare @removedCol varchar(400)
        declare @removedVal varchar(400)
        declare @uptoCol int
        declare @uptoVal int
        
     SET @WhereString = 'WHERE (1=1)'
     --Start IF for Search
     if(@SortOrSearchFlag='Search')
     begin
     set @posCol =1
     set @posVal =1
     set @ColOperated = ''
     set @ValOperated = ''
     set @removedCol=''
     set @removedVal=''
     set @uptoCol=1
     set @uptoVal=1
    
     declare @i int
     set @i=0
        if(@MultiCoulumn = 'No')
		begin 
			set @numberOfDelimeterOfCol = 0
		end
	 else
		begin
			set  @numberOfDelimeterOfCol=(LEN(@SearchColumnName) - LEN(REPLACE(@SearchColumnName, ',', '')))	
			
		end
		
     
   while(@i<@numberOfDelimeterOfCol)
    begin
     if(@numberOfDelimeterOfCol > 0)
		 begin
			
			
			if(@i>0)
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@removedCol)-1))
				
				end
			else
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@SearchColumnName)-1))
				end
			set @ColOperated = @ColOperated +  @tempCol+','
			set @removedCol=REPLACE (@SearchColumnName,@ColOperated,'')
			set @uptoCol =CHARINDEX (',',@removedCol)
			
			if(@i>0)
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@removedVal)-1))
				end
			else
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@srchVal)-1))
				end
			set @ValOperated = @ValOperated +  @tempVal+','			
			set @removedVal=REPLACE (@srchVal,@ValOperated,'')
			set @uptoVal =CHARINDEX (',',@removedVal)
		 end
     
     else
		 begin
			set @tempCol=@SearchColumnName
			set @tempVal=@srchVal
		 end
     set @posCol=LEN(@ColOperated)+1
     set @posVal=LEN(@ValOperated)+1
   
       if(CHARINDEX ('-',@tempVal)>0)
		 begin
			  declare @startRange varchar(100), @endRange varchar(100),@position int
			  set @position =charindex('-',@tempVal)
			  set @startRange=ltrim(SUBSTRING (@tempVal,1,@position-1))
			  set @endRange =ltrim(SUBSTRING (@tempVal,@position+1,(len(@tempVal)-@position)))
			  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] >= ' + @startRange + '  and [' + @tempCol + '] <=  ' + @endRange + '' ;
		 end
		else
		  begin
			 if(@tempCol='Program'or @tempCol='StudentName' or @tempCol='BannerID')
				 begin
				  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] like  ''%' + @tempVal + '%''' ;
				 end
	         
			 else
				 begin
				 SET @WhereString = @WhereString + ' AND [' + @tempCol + '] =  ' + @tempVal + '' ;
				 end
         end
         set @i=@i+1
       end
     end
     --End IF for Search
       
       
        --> ADDED by CVTC
        IF ( @SortColumnName IS NULL
             OR @SortColumnName = ''
           ) 
            SET @SortColumnName = 'BannerID'
            
        
        IF ( @SortOrderBy IS NULL
             OR @SortOrderBy = ''
           ) 
            SET @SortOrderBy = 'ASC'
            
        SET @SortString = ' ORDER BY [' + @SortColumnName + '] '
            + UPPER(ISNULL(@SortOrderBy, 'ASC'))
            
      
		
        DECLARE cur CURSOR
        FOR
            SELECT DISTINCT
                    SectionName
            FROM    Section
            WHERE   AssessmentOID = @AOID
                    AND SectionName != 'NoScore'

        DECLARE @Temp NVARCHAR(MAX) ,
            @AllSectionNames NVARCHAR(MAX) ,
            @SectionQuery NVARCHAR(MAX)
        DECLARE @AllSectionScore NVARCHAR(MAX)
        DECLARE @AllSectionRank NVARCHAR(MAX)

        SET @AllSectionNames = ''
        SET @AllSectionRank = ''
        SET @AllSectionScore = ''

        OPEN Cur
			-- Getting all the subjects
        FETCH NEXT FROM Cur INTO @Temp
        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @AllSectionNames = @AllSectionNames + '[' + @Temp + '],'
                SET @AllSectionRank = @AllSectionRank + '[' + @Temp
                    + '_Rank],'
                SET @AllSectionScore = @AllSectionScore + '[' + @Temp
                    + '_Score],'
                FETCH NEXT FROM Cur INTO @Temp
            END
        CLOSE Cur
        DEALLOCATE Cur

        SET @AllSectionNames = SUBSTRING(@AllSectionNames, 0,
                                         LEN(@AllSectionNames))
        SET @AllSectionScore = SUBSTRING(@AllSectionScore, 0,
                                         LEN(@AllSectionScore))
        SET @AllSectionRank = SUBSTRING(@AllSectionRank, 0,
                                        LEN(@AllSectionRank))

		-- Building the pivot query
        SET @SectionQuery = 'SELECT AssessmentOID,StdScore.StudentOID ,BannerID,Program,StudentName,StdScore.StudentOID Flag,
        StdScore.StudentOID NumberOfPrinted, '
        
            + @AllSectionRank + ', ' + @AllSectionScore
            + ', ROW_NUMBER() OVER (' + @SortString + ') AS RowNum 
            ,FullTimeOrPartTimeIndicator as FullOrPart,CumulativeGPA as GPA,CreditsAttempted as CreditAttempted,CreditsEarned as EarnedCredit
			,LatestCompassPrealgebraTestScore as Prealgebra,LatestCompassAlgebraTestScore as Algebra,LatestCompassWritingTestScore as Writting
			,LatestCompassReadingTestScore as Reading,LatestACTEnglishAssessmentScore as English,LatestACTMathAssessmentScore as Math
			,LatestACTReadingAssessmentScore as ReadingScore,LatestACTScienceAssessmentScore as ScienceScore,LatestTestingDate as TestingDate
			,HighSchoolName as HighSchool,HighSchoolGraduationDate as HS_GRAD_DATE,HomeTelephoneNumber as Phone,MailingAddressLineOne as ADDR1
			,MailingAddressLineTwo as ADDR2,MailingAddressLineThree as ADDR3,City as CITY,StateName as STATE,ZipCode as ZIP,EmailAddress as Email FROM'
	       
        SET @SectionQuery = @SectionQuery
            + '(SELECT AssessmentOID,StudentOID ,BannerID,Program,StudentName, '
            + @AllSectionRank
            + ',FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
     	 LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress


	FROM
	(SELECT ScoreDetailTable.AssessmentOID,StudentOID,BannerID,Program,StudentName,COALESCE(Rank,'' '') AS Rank,RankName,
	FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
	LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress--Section.SectionName
	FROM   ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Rank)
	FOR RankName IN
	(' + @AllSectionRank + ')) AS pvt) AS StdScore'


        SET @SectionQuery = @SectionQuery + ' INNER JOIN '
            + '(SELECT StudentOID , ' + @AllSectionScore + '

	FROM
	(SELECT StudentOID,COALESCE(Score,'' '') AS Score,ScoreName
	FROM ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Score)
	FOR ScoreName IN
	(' + @AllSectionScore + ')) AS pvt) AS StdRank'
            + ' ON StdScore.StudentOID= StdRank.StudentOID'

		

        
        SET @SectionQuery = @SectionQuery + CHAR(10) +@WhereString ;
	
		--For Counter
        DECLARE @SectionQueryCounter NVARCHAR(MAX)
        SET @SectionQueryCounter = 'SELECT COUNT(*) FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable'
	 
        CREATE TABLE #tmpTable ( OutputValue INT )
        INSERT  INTO #tmpTable
                ( OutputValue
                )
                EXEC sp_executesql @SectionQueryCounter

        SELECT  @TotalRecords = OutputValue
        FROM    #tmpTable

        DROP TABLE #tmpTable	
		--
	 
        SET @SectionQuery = 'SELECT * FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable '
            --WHERE MyDerivedTable.RowNum BETWEEN '
           -- + CAST(@startRow AS VARCHAR(5)) + ' AND '
            --> ADDED by CVTC
            --+ CAST(@endRow AS VARCHAR(5)) + CHAR(10) + @SortString 
			--> END ADDED by CVTC
			
        EXEC sp_executesql @SectionQuery
        --PRINT @SectionQuery
    END
GO
/****** Object:  StoredProcedure [dbo].[Assessement_ResultByAOID_bk]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Assessement_ResultByAOID_bk]
    @PageIndex INT ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT ,
    @AOID INT ,
    @SearchColumnName VARCHAR(400) ,
    @SortOrderBy VARCHAR(4) ,
    @BannerID VARCHAR(20) ,
    @Program VARCHAR(250) ,
    @StudentName VARCHAR(150),
    @SearchValue VARCHAR(max),
    @SortColumnName VARCHAR(50),
    @SortOrSearchFlag varchar(10),
    @MultiCoulumn Varchar(10) 
AS 
    BEGIN

        DECLARE @startRow INT
        DECLARE @endRow INT
       
        
        SET @startRow = ( @PageIndex - 1 ) * @NumberOfRows + 1
        SET @endRow = @PageIndex * @NumberOfRows
        
        
		--Added for sorting
        DECLARE @SortString VARCHAR(MAX)
        
        --Temp added by mominul
        declare @srchVal VARCHAR(MAX)
        set @srchVal = @SearchValue
        --end Temp
        declare @numberOfDelimeterOfCol int
        DECLARE @WhereString VARCHAR(MAX)
        declare @posCol int
        declare @posVal int
        declare @tempCol varchar(250)
        declare @tempColTest varchar(100)
        declare @tempVal varchar(100)
        declare @lengthCol int
        declare @lengthVal int
        declare @ColOperated VARCHAR(250)
        declare @ValOperated VARCHAR(250)
        declare @removedCol varchar(400)
        declare @removedVal varchar(400)
        declare @uptoCol int
        declare @uptoVal int
        
     SET @WhereString = 'WHERE (1=1)'
     --Start IF for Search
     if(@SortOrSearchFlag='Search')
     begin
     set @posCol =1
     set @posVal =1
     set @ColOperated = ''
     set @ValOperated = ''
     set @removedCol=''
     set @removedVal=''
     set @uptoCol=1
     set @uptoVal=1
    
     declare @i int
     set @i=0
        if(@MultiCoulumn = 'No')
		begin 
			set @numberOfDelimeterOfCol = 0
		end
	 else
		begin
			set  @numberOfDelimeterOfCol=(LEN(@SearchColumnName) - LEN(REPLACE(@SearchColumnName, ',', '')))	
			
		end
		
     
   while(@i<@numberOfDelimeterOfCol)
    begin
     if(@numberOfDelimeterOfCol > 0)
		 begin
			
			
			if(@i>0)
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@removedCol)-1))
				
				end
			else
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@SearchColumnName)-1))
				end
			set @ColOperated = @ColOperated +  @tempCol+','
			set @removedCol=REPLACE (@SearchColumnName,@ColOperated,'')
			set @uptoCol =CHARINDEX (',',@removedCol)
			
			if(@i>0)
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@removedVal)-1))
				end
			else
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@srchVal)-1))
				end
			set @ValOperated = @ValOperated +  @tempVal+','			
			set @removedVal=REPLACE (@srchVal,@ValOperated,'')
			set @uptoVal =CHARINDEX (',',@removedVal)
		 end
     
     else
		 begin
			set @tempCol=@SearchColumnName
			set @tempVal=@srchVal
		 end
     set @posCol=LEN(@ColOperated)+1
     set @posVal=LEN(@ValOperated)+1
   
       if(CHARINDEX ('-',@tempVal)>0)
		 begin
			  declare @startRange varchar(100), @endRange varchar(100),@position int
			  set @position =charindex('-',@tempVal)
			  set @startRange=ltrim(SUBSTRING (@tempVal,1,@position-1))
			  set @endRange =ltrim(SUBSTRING (@tempVal,@position+1,(len(@tempVal)-@position)))
			  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] >= ' + @startRange + '  and [' + @tempCol + '] <=  ' + @endRange + '' ;
		 end
		else
		  begin
			 if(@tempCol='Program'or @tempCol='StudentName' or @tempCol='BannerID')
				 begin
				  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] like  ''%' + @tempVal + '%''' ;
				 end
	         
			 else
				 begin
				 SET @WhereString = @WhereString + ' AND [' + @tempCol + '] =  ' + @tempVal + '' ;
				 end
         end
         set @i=@i+1
       end
     end
     --End IF for Search
       
       
        --> ADDED by CVTC
        IF ( @SortColumnName IS NULL
             OR @SortColumnName = ''
           ) 
            SET @SortColumnName = 'BannerID'
            
        
        IF ( @SortOrderBy IS NULL
             OR @SortOrderBy = ''
           ) 
            SET @SortOrderBy = 'ASC'
            
        SET @SortString = ' ORDER BY [' + @SortColumnName + '] '
            + UPPER(ISNULL(@SortOrderBy, 'ASC'))
            
      
		
        DECLARE cur CURSOR
        FOR
            SELECT DISTINCT
                    SectionName
            FROM    Section
            WHERE   AssessmentOID = @AOID
                    AND SectionName != 'NoScore'

        DECLARE @Temp NVARCHAR(MAX) ,
            @AllSectionNames NVARCHAR(MAX) ,
            @SectionQuery NVARCHAR(MAX)
        DECLARE @AllSectionScore NVARCHAR(MAX)
        DECLARE @AllSectionRank NVARCHAR(MAX)

        SET @AllSectionNames = ''
        SET @AllSectionRank = ''
        SET @AllSectionScore = ''

        OPEN Cur
			-- Getting all the subjects
        FETCH NEXT FROM Cur INTO @Temp
        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @AllSectionNames = @AllSectionNames + '[' + @Temp + '],'
                SET @AllSectionRank = @AllSectionRank + '[' + @Temp
                    + '_Rank],'
                SET @AllSectionScore = @AllSectionScore + '[' + @Temp
                    + '_Score],'
                FETCH NEXT FROM Cur INTO @Temp
            END
        CLOSE Cur
        DEALLOCATE Cur

        SET @AllSectionNames = SUBSTRING(@AllSectionNames, 0,
                                         LEN(@AllSectionNames))
        SET @AllSectionScore = SUBSTRING(@AllSectionScore, 0,
                                         LEN(@AllSectionScore))
        SET @AllSectionRank = SUBSTRING(@AllSectionRank, 0,
                                        LEN(@AllSectionRank))

		-- Building the pivot query
        SET @SectionQuery = 'SELECT AssessmentOID,StdScore.StudentOID ,BannerID,Program,StudentName,StdScore.StudentOID Flag,
        StdScore.StudentOID NumberOfPrinted, '
        
            + @AllSectionRank + ', ' + @AllSectionScore
            + ', ROW_NUMBER() OVER (' + @SortString + ') AS RowNum 
            ,FullTimeOrPartTimeIndicator as FullOrPart,CumulativeGPA as GPA,CreditsAttempted as CreditAttempted,CreditsEarned as EarnedCredit
			,LatestCompassPrealgebraTestScore as Prealgebra,LatestCompassAlgebraTestScore as Algebra,LatestCompassWritingTestScore as Writting
			,LatestCompassReadingTestScore as Reading,LatestACTEnglishAssessmentScore as English,LatestACTMathAssessmentScore as Math
			,LatestACTReadingAssessmentScore as ReadingScore,LatestACTScienceAssessmentScore as ScienceScore,LatestTestingDate as TestingDate
			,HighSchoolName as HighSchool,HighSchoolGraduationDate as HS_GRAD_DATE,HomeTelephoneNumber as Phone,MailingAddressLineOne as ADDR1
			,MailingAddressLineTwo as ADDR2,MailingAddressLineThree as ADDR3,City as CITY,StateName as STATE,ZipCode as ZIP,EmailAddress as Email FROM'
	       
        SET @SectionQuery = @SectionQuery
            + '(SELECT AssessmentOID,StudentOID ,BannerID,Program,StudentName, '
            + @AllSectionRank
            + ',FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
     	 LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress


	FROM
	(SELECT ScoreDetailTable.AssessmentOID,StudentOID,BannerID,Program,StudentName,COALESCE(Rank,'' '') AS Rank,RankName,
	FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
	LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress--Section.SectionName
	FROM   ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Rank)
	FOR RankName IN
	(' + @AllSectionRank + ')) AS pvt) AS StdScore'


        SET @SectionQuery = @SectionQuery + ' INNER JOIN '
            + '(SELECT StudentOID , ' + @AllSectionScore + '

	FROM
	(SELECT StudentOID,COALESCE(Score,'' '') AS Score,ScoreName
	FROM ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Score)
	FOR ScoreName IN
	(' + @AllSectionScore + ')) AS pvt) AS StdRank'
            + ' ON StdScore.StudentOID= StdRank.StudentOID'

		

        
        SET @SectionQuery = @SectionQuery + CHAR(10) +@WhereString ;
	
		--For Counter
        DECLARE @SectionQueryCounter NVARCHAR(MAX)
        SET @SectionQueryCounter = 'SELECT COUNT(*) FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable'
	 
        CREATE TABLE #tmpTable ( OutputValue INT )
        INSERT  INTO #tmpTable
                ( OutputValue
                )
                EXEC sp_executesql @SectionQueryCounter

        SELECT  @TotalRecords = OutputValue
        FROM    #tmpTable

        DROP TABLE #tmpTable	
		--
	 
        SET @SectionQuery = 'SELECT * FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable WHERE MyDerivedTable.RowNum BETWEEN '
            + CAST(@startRow AS VARCHAR(5)) + ' AND '
            --> ADDED by CVTC
            + CAST(@endRow AS VARCHAR(5)) + CHAR(10) + @SortString 
			--> END ADDED by CVTC
			
        EXEC sp_executesql @SectionQuery
        --PRINT @SectionQuery
    END
GO
/****** Object:  StoredProcedure [dbo].[Assessement_ResultByAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessement_ResultByAOID]
    @PageIndex INT ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT ,
    @AOID INT ,
    @SearchColumnName VARCHAR(400) ,
    @SortOrderBy VARCHAR(4) ,
    @BannerID VARCHAR(20) ,
    @Program VARCHAR(250) ,
    @StudentName VARCHAR(150),
    @SearchValue VARCHAR(max),
    @SortColumnName VARCHAR(50),
    @SortOrSearchFlag varchar(10),
    @MultiCoulumn Varchar(10) 
AS 
    BEGIN

        DECLARE @startRow INT
        DECLARE @endRow INT
       
        
        SET @startRow = ( @PageIndex - 1 ) * @NumberOfRows + 1
        SET @endRow = @PageIndex * @NumberOfRows
        
        
		--Added for sorting
        DECLARE @SortString VARCHAR(MAX)
        
        --Temp added by mominul
        declare @srchVal VARCHAR(MAX)
        set @srchVal = @SearchValue
        --end Temp
        declare @numberOfDelimeterOfCol int
        DECLARE @WhereString VARCHAR(MAX)
        declare @posCol int
        declare @posVal int
        declare @tempCol varchar(250)
        declare @tempColTest varchar(100)
        declare @tempVal varchar(100)
        declare @lengthCol int
        declare @lengthVal int
        declare @ColOperated VARCHAR(250)
        declare @ValOperated VARCHAR(250)
        declare @removedCol varchar(400)
        declare @removedVal varchar(400)
        declare @uptoCol int
        declare @uptoVal int
        
     SET @WhereString = 'WHERE (1=1)'
     --Start IF for Search
     if(@SortOrSearchFlag='Search')
     begin
     set @posCol =1
     set @posVal =1
     set @ColOperated = ''
     set @ValOperated = ''
     set @removedCol=''
     set @removedVal=''
     set @uptoCol=1
     set @uptoVal=1
    
     declare @i int
     set @i=0
        if(@MultiCoulumn = 'No')
		begin 
			set @numberOfDelimeterOfCol = 0
		end
	 else
		begin
			set  @numberOfDelimeterOfCol=(LEN(@SearchColumnName) - LEN(REPLACE(@SearchColumnName, ',', '')))	
			
		end
		
     
   while(@i<@numberOfDelimeterOfCol)
    begin
     if(@numberOfDelimeterOfCol > 0)
		 begin
			
			
			if(@i>0)
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@removedCol)-1))
				
				end
			else
				begin
				set @tempCol=ltrim(SUBSTRING(@SearchColumnName,@posCol,CHARINDEX (',',@SearchColumnName)-1))
				end
			set @ColOperated = @ColOperated +  @tempCol+','
			set @removedCol=REPLACE (@SearchColumnName,@ColOperated,'')
			set @uptoCol =CHARINDEX (',',@removedCol)
			
			if(@i>0)
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@removedVal)-1))
				end
			else
				begin
				set @tempVal=ltrim(SUBSTRING(@srchVal,@posVal,CHARINDEX (',',@srchVal)-1))
				end
			set @ValOperated = @ValOperated +  @tempVal+','			
			set @removedVal=REPLACE (@srchVal,@ValOperated,'')
			set @uptoVal =CHARINDEX (',',@removedVal)
		 end
     
     else
		 begin
			set @tempCol=@SearchColumnName
			set @tempVal=@srchVal
		 end
     set @posCol=LEN(@ColOperated)+1
     set @posVal=LEN(@ValOperated)+1
   
       if(CHARINDEX ('-',@tempVal)>0)
		 begin
			  declare @startRange varchar(100), @endRange varchar(100),@position int
			  set @position =charindex('-',@tempVal)
			  set @startRange=ltrim(SUBSTRING (@tempVal,1,@position-1))
			  set @endRange =ltrim(SUBSTRING (@tempVal,@position+1,(len(@tempVal)-@position)))
			  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] >= ' + @startRange + '  and [' + @tempCol + '] <=  ' + @endRange + '' ;
		 end
		else
		  begin
			 if(@tempCol='Program'or @tempCol='StudentName' or @tempCol='BannerID')
				 begin
				  SET @WhereString = @WhereString + ' AND [' + @tempCol + '] like  ''%' + @tempVal + '%''' ;
				 end
	         
			 else
				 begin
				 SET @WhereString = @WhereString + ' AND [' + @tempCol + '] =  ' + @tempVal + '' ;
				 end
         end
         set @i=@i+1
       end
     end
     --End IF for Search
       
       
        --> ADDED by CVTC
        IF ( @SortColumnName IS NULL
             OR @SortColumnName = ''
           ) 
            SET @SortColumnName = 'BannerID'
            
        
        IF ( @SortOrderBy IS NULL
             OR @SortOrderBy = ''
           ) 
            SET @SortOrderBy = 'ASC'
            
        SET @SortString = ' ORDER BY [' + @SortColumnName + '] '
            + UPPER(ISNULL(@SortOrderBy, 'ASC'))
            
      
		
        DECLARE cur CURSOR
        FOR
            SELECT DISTINCT
                    SectionName
            FROM    Section
            WHERE   AssessmentOID = @AOID
                    AND SectionName != 'NoScore'

        DECLARE @Temp NVARCHAR(MAX) ,
            @AllSectionNames NVARCHAR(MAX) ,
            @SectionQuery NVARCHAR(MAX)
        DECLARE @AllSectionScore NVARCHAR(MAX)
        DECLARE @AllSectionRank NVARCHAR(MAX)

        SET @AllSectionNames = ''
        SET @AllSectionRank = ''
        SET @AllSectionScore = ''

        OPEN Cur
			-- Getting all the subjects
        FETCH NEXT FROM Cur INTO @Temp
        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @AllSectionNames = @AllSectionNames + '[' + @Temp + '],'
                SET @AllSectionRank = @AllSectionRank + '[' + @Temp
                    + '_Rank],'
                SET @AllSectionScore = @AllSectionScore + '[' + @Temp
                    + '_Score],'
                FETCH NEXT FROM Cur INTO @Temp
            END
        CLOSE Cur
        DEALLOCATE Cur

        SET @AllSectionNames = SUBSTRING(@AllSectionNames, 0,
                                         LEN(@AllSectionNames))
        SET @AllSectionScore = SUBSTRING(@AllSectionScore, 0,
                                         LEN(@AllSectionScore))
        SET @AllSectionRank = SUBSTRING(@AllSectionRank, 0,
                                        LEN(@AllSectionRank))

		-- Building the pivot query
        SET @SectionQuery = 'SELECT AssessmentOID,StdScore.StudentOID ,BannerID,Program,StudentName,StdScore.StudentOID Flag,
        StdScore.StudentOID NumberOfPrinted, '
        
            + @AllSectionRank + ', ' + @AllSectionScore
            + ', ROW_NUMBER() OVER (' + @SortString + ') AS RowNum 
            ,FullTimeOrPartTimeIndicator,CumulativeGPA ,CreditsAttempted ,CreditsEarned as EarnedCredit
			,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,LatestCompassWritingTestScore
			,LatestCompassReadingTestScore ,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore
			,LatestACTReadingAssessmentScore ,LatestACTScienceAssessmentScore,LatestTestingDate
			,HighSchoolName ,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne 
			,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress FROM'
	       
        SET @SectionQuery = @SectionQuery
            + '(SELECT AssessmentOID,StudentOID ,BannerID,Program,StudentName, '
            + @AllSectionRank
            + ',FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
     	 LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress


	FROM
	(SELECT ScoreDetailTable.AssessmentOID,StudentOID,BannerID,Program,StudentName,COALESCE(Rank,'' '') AS Rank,RankName,
	FullTimeOrPartTimeIndicator,CumulativeGPA,CreditsAttempted,CreditsEarned,LatestCompassPrealgebraTestScore,LatestCompassAlgebraTestScore,
	LatestCompassWritingTestScore,LatestCompassReadingTestScore,LatestACTEnglishAssessmentScore,LatestACTMathAssessmentScore,LatestACTReadingAssessmentScore,LatestACTScienceAssessmentScore,LatestTestingDate,HighSchoolName,HighSchoolGraduationDate,HomeTelephoneNumber,MailingAddressLineOne,MailingAddressLineTwo,MailingAddressLineThree,City,StateName,ZipCode,EmailAddress--Section.SectionName
	FROM   ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Rank)
	FOR RankName IN
	(' + @AllSectionRank + ')) AS pvt) AS StdScore'


        SET @SectionQuery = @SectionQuery + ' INNER JOIN '
            + '(SELECT StudentOID , ' + @AllSectionScore + '

	FROM
	(SELECT StudentOID,COALESCE(Score,'' '') AS Score,ScoreName
	FROM ScoreDetailTable WHERE ScoreDetailTable.AssessmentOID='
            + CAST(@AOID AS VARCHAR(100)) + ' ) S
	PIVOT
	(
	SUM (Score)
	FOR ScoreName IN
	(' + @AllSectionScore + ')) AS pvt) AS StdRank'
            + ' ON StdScore.StudentOID= StdRank.StudentOID'

		

        
        SET @SectionQuery = @SectionQuery + CHAR(10) +@WhereString ;
	
		--For Counter
        DECLARE @SectionQueryCounter NVARCHAR(MAX)
        SET @SectionQueryCounter = 'SELECT COUNT(*) FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable'
	 
        CREATE TABLE #tmpTable ( OutputValue INT )
        INSERT  INTO #tmpTable
                ( OutputValue
                )
                EXEC sp_executesql @SectionQueryCounter

        SELECT  @TotalRecords = OutputValue
        FROM    #tmpTable

        DROP TABLE #tmpTable	
		--
	 
        SET @SectionQuery = 'SELECT * FROM ( ' + @SectionQuery
            + ' ) AS MyDerivedTable WHERE MyDerivedTable.RowNum BETWEEN '
            + CAST(@startRow AS VARCHAR(5)) + ' AND '
            --> ADDED by CVTC
            + CAST(@endRow AS VARCHAR(5)) + CHAR(10) + @SortString 
			--> END ADDED by CVTC
			
        EXEC sp_executesql @SectionQuery
        --PRINT @SectionQuery
    END
GO
/****** Object:  StoredProcedure [dbo].[Assessement_ColumnByAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Assessement_ColumnByAOID]
@AOID int

AS
BEGIN


--	DECLARE @AOID int
--	SET @AOID=1
	DECLARE cur CURSOR FOR 
	SELECT distinct SectionName
	FROM Section
	WHERE AssessmentOID=@AOID and SectionName!='NoScore'

	DECLARE @Temp NVARCHAR(MAX),   @AllSectionNames NVARCHAR(MAX),   @SectionQuery NVARCHAR(MAX)
	DECLARE @AllSectionScore NVARCHAR(MAX)
	DECLARE @AllSectionRank NVARCHAR(MAX)
	DECLARE @ALL nvarchar(MAX)

	SET @AllSectionNames=' '
	SET @AllSectionRank=' '
	SET @AllSectionScore=' '

	OPEN Cur
	-- Getting all the subjects
	FETCH NEXT FROM Cur INTO @Temp
	WHILE @@FETCH_STATUS = 0
	BEGIN
	 SET @AllSectionNames = @AllSectionNames + '' + @Temp + ', '
	 SET @AllSectionRank = @AllSectionRank + '' + @Temp + '_Rank, '
	 SET @AllSectionScore = @AllSectionScore + '' + @Temp + '_Score, '
	 FETCH NEXT FROM Cur INTO @Temp
	END

	CLOSE Cur
	DEALLOCATE Cur

	SET @AllSectionNames = SUBSTRING(@AllSectionNames, 0, LEN(@AllSectionNames))
	SET @AllSectionScore = SUBSTRING(@AllSectionScore, 0, LEN(@AllSectionScore))
	SET @AllSectionRank = SUBSTRING(@AllSectionRank, 0, LEN(@AllSectionRank))
	
	SET @ALL='AssessmentOID, StudentOID, BannerID, Program, StudentName, Flag, NumberOfPrinted,'
	SET @ALL=@ALL+@AllSectionRank+','+@AllSectionScore

	SELECT @All AS colName
END
GO
/****** Object:  StoredProcedure [dbo].[AnsOID_AssOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[AnsOID_AssOID]
@AOID int

AS
BEGIN
	SELECT AnswerOID
	FROM dbo.Answer
	WHERE AssessmentOID=@AOID

END
GO
/****** Object:  StoredProcedure [dbo].[Answer_CheckBannerID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_CheckBannerID]
@BannerID varchar(12),
@AOID int 

AS
BEGIN
	SELECT *
	FROM dbo.Answer
	WHERE BannerStudentIDNumber=@BannerID and AssessmentOID=@AOID

END
GO
/****** Object:  StoredProcedure [dbo].[Answer_ByStudentOIDAndAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Answer_ByStudentOIDAndAOID]
@SOID int,
@AOID int 



AS
BEGIN
	SELECT AnswerOID, AssessmentOID, StudentOID, NumberOfPrinted, CreatedDate, CreatedBy,BannerStudentIDNumber
	FROM dbo.Answer
WHERE AssessmentOID=@AOID AND StudentOID=@SOID
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_ByStudentID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_ByStudentID]
@StudentID varchar(20)


AS
BEGIN
	SELECT distinct AssessmentOID,CreatedDate 
	FROM dbo.Answer
	
	WHERE BannerStudentIDNumber=@StudentID
	order by CreatedDate desc
	


END
GO
/****** Object:  StoredProcedure [dbo].[Answer_BySOIDAndAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_BySOIDAndAOID]
@SOID varchar(20),
@AOID int 



AS
BEGIN
	SELECT AnswerOID, AssessmentOID, StudentOID, NumberOfPrinted, CreatedDate, CreatedBy,BannerStudentIDNumber
	FROM dbo.Answer
WHERE AssessmentOID=@AOID AND BannerStudentIDNumber=@SOID
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_BySOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_BySOID]
@SOID varchar(20)




AS
BEGIN
	SELECT *
	FROM dbo.Answer
	 WHERE BannerStudentIDNumber=@SOID
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_ByRLSTAndAOID_ForResultLetter]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_ByRLSTAndAOID_ForResultLetter]
@RLST int,
@AOID int 

AS
BEGIN
	SELECT *
	FROM dbo.Answer
	WHERE AssessmentOID=@AOID AND NumberOfPrinted=@RLST AND StudentOID>0


END
GO
/****** Object:  StoredProcedure [dbo].[Answer_ByRLSTAndAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_ByRLSTAndAOID]
@RLST int,
@AOID int 

AS
BEGIN
	SELECT AnswerOID, AssessmentOID, StudentOID, NumberOfPrinted, CreatedDate, CreatedBy, BannerStudentIDNumber
	FROM dbo.Answer
	WHERE AssessmentOID=@AOID AND NumberOfPrinted=@RLST

	UPDATE Answer
	SET NumberOfPrinted = NumberOfPrinted + 1
	FROM dbo.Answer
	WHERE AssessmentOID=@AOID AND NumberOfPrinted=@RLST

END
GO
/****** Object:  Table [dbo].[AnswerDetail]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnswerDetail](
	[AnswerDetailOID] [int] IDENTITY(1,1) NOT NULL,
	[AnswerOID] [int] NOT NULL,
	[SectionOID] [int] NOT NULL,
	[QuestionOID] [int] NOT NULL,
	[Response] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[AnswerPoint] [int] NULL,
 CONSTRAINT [PK_AnswerOfQuestion] PRIMARY KEY CLUSTERED 
(
	[AnswerDetailOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Answer_Update_Temp]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Update_Temp]

@StudentOID varchar(20),
@TemID varchar(20) 

AS
BEGIN
	
	UPDATE Answer
	SET BannerStudentIDNumber = @StudentOID

	WHERE BannerStudentIDNumber=@TemID


END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Update_NumberofPrinted]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Update_NumberofPrinted]
@RLST int,
@AOID int,
@StudentOID int 

AS
BEGIN
	
	UPDATE Answer
	SET NumberOfPrinted = NumberOfPrinted + 1
	FROM dbo.Answer
	WHERE AssessmentOID=@AOID AND NumberOfPrinted=@RLST and StudentOID=@StudentOID


END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Update]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Answer_Update]
@StudentOID int ,
@BannerID varchar (100)
AS
                                BEGIN
UPDATE [Answer]   SET BannerStudentIDNumber = @BannerID
WHERE StudentOID = @StudentOID
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_insert]
@AnswerOID int OUTPUT,
@AssessmentOID int, 
@CreatedBy int ,
@NumberOfPrinted int, 
@StudentOID int,
@BannerID char(20),
@CreatedDate  DateTime



AS
BEGIN
	--DECLARE @AnswerOID int

	INSERT INTO Answer( AssessmentOID, StudentOID, NumberOfPrinted, CreatedBy,BannerStudentIDNumber,CreatedDate)
	values( @AssessmentOID, @StudentOID, @NumberOfPrinted, @CreatedBy,@BannerID,@CreatedDate)

	SELECT @AnswerOID=  MAX(AnswerOID) FROM Answer 
	RETURN @AnswerOID
END
GO
/****** Object:  StoredProcedure [dbo].[Intervention_Search]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Intervention_Search]
@PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_interventions]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PrescriptionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PrescriptionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RiskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RiskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN DomainOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN DomainOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InterventionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InterventionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestActionDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestActionDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestContact
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestContact
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Internal
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Internal
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Prescribed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Prescribed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Completed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Completed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Telephone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Telephone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InPerson
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InPerson
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HandOff
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HandOff
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN DomainName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN DomainName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InterventionName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InterventionName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastModifiedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastModifiedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastModifiedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastModifiedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Comment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Comment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Urgent
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Urgent
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Participating
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Participating
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Testing
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Testing
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Unread'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Unread
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Unread'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Unread
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
PrescriptionOID, 
StudentOID, 
RiskOID, 
UserOID, 
DomainOID, 
InterventionOID, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
DomainName, 
InterventionName, 
UserName, 
BannerID,
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing, 
Unread 
   FROM     [vw_interventions] ) 
SELECT
BannerStudentName, 
PrescriptionOID, 
StudentOID, 
RiskOID, 
UserOID, 
DomainOID, 
InterventionOID, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
DomainName, 
InterventionName, 
UserName, 
BannerID,
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing, 
Unread 
 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  
END
GO
/****** Object:  StoredProcedure [dbo].[PendingStudent_SelectjqGrid]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PendingStudent_SelectjqGrid]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_PendingStudents]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, 
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC ,
 CASE   
															  WHEN @SortColumnName = 'BirthDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BirthDate
                                                              END DESC                                                           
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
BirthDate,
Status
   FROM     [vw_PendingStudents] ) 
   
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
BirthDate,
Status
 FROM    CTE
 WHERE     (RN  BETWEEN (@StartRow - @NumberOfRows)   AND     (@StartRow - 1))
 
 END
GO
/****** Object:  Table [dbo].[Question]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionOID] [int] IDENTITY(1,1) NOT NULL,
	[SectionOID] [int] NULL,
	[OrderNo] [int] NULL,
	[Question] [varchar](500) NULL,
	[RespAction] [varchar](50) NULL,
	[MultipleAllow] [int] NULL,
	[Keyword] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
	[Reverse] [int] NULL,
	[PostionAtExell] [int] NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetByAssNamePrint]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetByAssNamePrint]
@soid int,
@riskoid int,
@aoid int 
AS 
BEGIN

	SELECT    distinct dbo.Prescription.PrescriptionOID, dbo.Prescription.StudentOID, dbo.Prescription.RiskOID, dbo.Prescription.UserOID, dbo.Prescription.DomainOID, 
                      dbo.Prescription.InterventionOID, dbo.Prescription.LatestActionDate, dbo.Prescription.LatestContact, dbo.Prescription.Internal, dbo.Prescription.Prescribed, 
                      dbo.Prescription.Completed, dbo.Prescription.Email, dbo.Prescription.Telephone, dbo.Prescription.InPerson, dbo.Prescription.HandOff, dbo.Prescription.CreatedDate, 
                      dbo.Prescription.Comment, dbo.Prescription.Urgent, dbo.Prescription.Participating, dbo.Prescription.Testing, dbo.Intervention.InterventionName, 
                      dbo.Domain.DomainName, dbo.[User].UserName, dbo.Prescription.CreatedBy, dbo.Prescription.LastModifiedDate, dbo.Prescription.LastModifiedBy, 
                      dbo.Assessment.AssessmentName
FROM         dbo.Prescription INNER JOIN
                      dbo.Domain ON dbo.Prescription.DomainOID = dbo.Domain.DomainOID INNER JOIN
                      dbo.[User] ON dbo.Prescription.UserOID = dbo.[User].UserOID INNER JOIN
                      dbo.Intervention ON dbo.Prescription.InterventionOID = dbo.Intervention.InterventionOID INNER JOIN
                      dbo.Answer ON dbo.Prescription.StudentOID = dbo.Answer.StudentOID INNER JOIN
                      dbo.Assessment ON dbo.Prescription.AssessmentOID = dbo.Assessment.AssessmentOID
	
	WHERE Prescription.StudentOID=@soid and dbo.Prescription.RiskOID = @riskoid AND Prescription.AssessmentOID =@aoid 
	
END
GO
/****** Object:  StoredProcedure [dbo].[Prescription_GetByAssName]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Prescription_GetByAssName]
@soid int,
@assName varchar(100)
AS 
BEGIN

	SELECT     dbo.Prescription.PrescriptionOID, dbo.Prescription.StudentOID, dbo.Prescription.RiskOID, dbo.Prescription.UserOID, dbo.Prescription.DomainOID, 
                      dbo.Prescription.InterventionOID, dbo.Prescription.LatestActionDate, dbo.Prescription.LatestContact, dbo.Prescription.Internal, dbo.Prescription.Prescribed, 
                      dbo.Prescription.Completed, dbo.Prescription.Email, dbo.Prescription.Telephone, dbo.Prescription.InPerson, dbo.Prescription.HandOff, dbo.Prescription.CreatedDate, 
                      dbo.Prescription.Comment, dbo.Prescription.Urgent, dbo.Prescription.Participating, dbo.Prescription.Testing, dbo.Intervention.InterventionName, 
                      dbo.Domain.DomainName, dbo.[User].UserName, dbo.Prescription.CreatedBy, dbo.Prescription.LastModifiedDate, dbo.Prescription.LastModifiedBy, 
                      dbo.Assessment.AssessmentName
FROM         dbo.Prescription INNER JOIN
                      dbo.Domain ON dbo.Prescription.DomainOID = dbo.Domain.DomainOID INNER JOIN
                      dbo.[User] ON dbo.Prescription.UserOID = dbo.[User].UserOID INNER JOIN
                      dbo.Intervention ON dbo.Prescription.InterventionOID = dbo.Intervention.InterventionOID INNER JOIN
                      dbo.Answer ON dbo.Prescription.StudentOID = dbo.Answer.StudentOID INNER JOIN
                      dbo.Assessment ON dbo.Answer.AssessmentOID = dbo.Assessment.AssessmentOID
	
	WHERE Prescription.StudentOID=@soid and Assessment.AssessmentName=@assName and dbo.Prescription.RiskOID <> 0 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ReminderEmail_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReminderEmail_Update]
@OID int,
@EmailBody varchar(MAX),
@LastModifiedBy int

AS
BEGIN
	UPDATE dbo.AssessmentReminderEmail
	SET EmailBody=@EmailBody, 
	LastModifiedBy=@LastModifiedBy,
	LastModifiedDate=getDate()
	WHERE AssessmentReminderOID=@OID

END
GO
/****** Object:  StoredProcedure [dbo].[ReminderEmail_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReminderEmail_Insert]

@OID int OUTPUT,
@AssessmentOID int, 
@EmailBody varchar(MAX),
@CreatedBy int, 
@LastModifiedBy int

AS
BEGIN
	
 
	INSERT INTO dbo.AssessmentReminderEmail(AssessmentOID, EmailBody, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy)
	values(@AssessmentOID, @EmailBody, getDate(), @CreatedBy, getDate(), @LastModifiedBy)

	SELECT @OID=  MAX(AssessmentReminderOID) FROM AssessmentReminderEmail 
	RETURN @OID
END
GO
/****** Object:  StoredProcedure [dbo].[ReminderEmail_ByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReminderEmail_ByOID]

@AssessmentReminderOID int 
 
AS
BEGIN	
 
	SELECT AssessmentReminderOID, AssessmentOID, EmailBody, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentReminderEmail
	WHERE AssessmentReminderOID=@AssessmentReminderOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[ReminderEmail_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReminderEmail_ByAOID]

@AOID int 
 
AS
BEGIN	
 
	SELECT AssessmentReminderOID, AssessmentOID, EmailBody, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentReminderEmail
	WHERE AssessmentOID=@AOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionResponse_UpdateTotalQuestion]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionResponse_UpdateTotalQuestion]
@SectionOID as int
AS
BEGIN
	UPDATE dbo.Section
	SET  TotalQuestion=TotalQuestion-1
	WHERE SectionOID=@SectionOID
END
GO
/****** Object:  StoredProcedure [dbo].[Risk_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Risk_Update]
@OID int,
@NumSection int,
@NumFlag int 


AS
BEGIN
	UPDATE dbo.RiskCalculation
	SET NumSection=@Numsection,NumFlag=@Numflag
	WHERE RiskOID=@OID
END
GO
/****** Object:  StoredProcedure [dbo].[Risk_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Risk_insert]
@RiskOID int OUTPUT,
@RiskName varchar(100),
@AssessmentOID int, 
@NumSection int,
@NumFlag int, 
@CreatedBy int 

AS
BEGIN
	--DECLARE @RiskOID int
 
	INSERT INTO RiskCalculation(RiskName,AssessmentOID, NumSection, NumFlag, CreatedBy)
	values( @RiskName,@AssessmentOID, @NumSection, @NumFlag, @CreatedBy)

	SELECT @RiskOID=  MAX(RiskOID) FROM RiskCalculation 
	RETURN @RiskOID
END
GO
/****** Object:  StoredProcedure [dbo].[Risk_GetByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Risk_GetByOID]
	@OID int
AS
BEGIN
	SELECT *
	FROM dbo.RiskCalculation	
	WHERE RiskOID=@OID
END
GO
/****** Object:  StoredProcedure [dbo].[Risk_GetByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[Risk_GetByAOID]
	@AOID int
AS
BEGIN
	SELECT 	RiskOID, RiskName, AssessmentOID, NumSection, NumFlag, CreatedDate, CreatedBy
	FROM dbo.RiskCalculation	
	WHERE AssessmentOID=@AOID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmail_UPDATE]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmail_UPDATE]
@OID int,
@Header varchar(MAX),
@ShowAboveResult varchar(MAX),
@LastModifiedBy int

AS
BEGIN
	UPDATE dbo.AssessmentResultEmail
	SET Header=@Header,ShowAboveResult= @ShowAboveResult,
	LastModifiedBy=@LastModifiedBy,LastModifiedDate=getDate()
	WHERE AssessmentResultOID=@OID

END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmail_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmail_insert]

@OID int OUTPUT,
@AssessmentOID int, 
@Header varchar(MAX),
@ShowAboveResult varchar(MAX),
@CreatedBy int, 
@LastModifiedBy int

AS
BEGIN
	--DECLARE @OID int
 
	INSERT INTO dbo.AssessmentResultEmail(AssessmentOID, Header, ShowAboveResult, CreatedBy, LastModifiedBy)
	values(@AssessmentOID, @Header, @ShowAboveResult, @CreatedBy, @LastModifiedBy)

	SELECT @OID=  MAX(AssessmentResultOID) FROM AssessmentResultEmail 
	RETURN @OID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmail_ByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmail_ByOID]

@AssessmentResultOID int 
 
AS
BEGIN	
 
	SELECT AssessmentResultOID, AssessmentOID, Header, ShowAboveResult, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentResultEmail
	WHERE AssessmentResultOID=@AssessmentResultOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmail_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmail_ByAOID]

@AOID int 
 
AS
BEGIN	
 
	SELECT AssessmentResultOID, AssessmentOID, Header, ShowAboveResult, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentResultEmail
	WHERE AssessmentOID=@AOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetter_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetter_Update]

@OID int, 
@Header varchar(MAX),
@ShowAboveResult varchar(MAX),
@LastModifiedBy int

AS
BEGIN
UPDATE dbo.AssessmentResultLetter
	SET Header=@Header,ShowAboveResult= @ShowAboveResult,
	LastModifiedBy=@LastModifiedBy,LastModifiedDate=getDate()
	WHERE AssessmentResultLetter=@OID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetter_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetter_insert]
@OID int OUTPUT,
@AssessmentOID int, 
@Header varchar(MAX),
@ShowAboveResult varchar(MAX),
@CreatedBy int, 
@LastModifiedBy int

AS
BEGIN
	--DECLARE @OID int
 
	INSERT INTO dbo.AssessmentResultLetter(AssessmentOID, Header, ShowAboveResult, CreatedBy, LastModifiedBy)
	values(@AssessmentOID, @Header, @ShowAboveResult, @CreatedBy, @LastModifiedBy)

	SELECT @OID=  MAX(AssessmentResultLetter) FROM AssessmentResultLetter 
	RETURN @OID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetter_ByOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetter_ByOID]

@LetterOID int 
 
AS
BEGIN	
 
	SELECT AssessmentResultLetter, AssessmentOID, Header, ShowAboveResult, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentResultLetter
	WHERE AssessmentResultLetter=@LetterOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetter_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetter_ByAOID]

@AOID int 
 
AS
BEGIN	
 
	SELECT AssessmentResultLetter, AssessmentOID, Header, ShowAboveResult, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentResultLetter
	WHERE AssessmentOID=@AOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid_Prescription]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid_Prescription]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
												@UserOID int,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_interventions]
													 -- WHERE RiskOID=0 -- and CreatedBy=@UserOID
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PrescriptionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PrescriptionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PrescriptionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RiskOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RiskOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RiskOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN UserOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'UserOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN UserOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN DomainOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DomainOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN DomainOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InterventionOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InterventionOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestActionDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestActionDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestActionDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestContact
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LatestContact'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestContact
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Internal
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Internal'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Internal
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Prescribed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prescribed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Prescribed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Completed
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Completed'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Completed
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Email
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Email
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Telephone
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Telephone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Telephone
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InPerson
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InPerson'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InPerson
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HandOff
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HandOff'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HandOff
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreatedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreatedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreatedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastModifiedDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastModifiedDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LastModifiedBy
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'LastModifiedBy'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LastModifiedBy
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Comment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Comment'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Comment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Urgent
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Urgent'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Urgent
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BannerStudentIDNumber'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Participating
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Participating'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Participating
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN Testing
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Testing'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN Testing
                                                              END DESC 
 ) AS RN ,
PrescriptionOID, 
StudentOID, 
RiskOID, 
UserOID, 
DomainOID, 
InterventionOID, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing 
   FROM     [vw_interventions]
--WHERE --RiskOID=0 --and CreatedBy=@UserOID
 ) 
SELECT
PrescriptionOID, 
CTE.StudentOID, 
RiskOID, 
UserOID, 
DomainOID, 
InterventionOID, 
LatestActionDate, 
LatestContact, 
Internal, 
Prescribed, 
Completed, 
Email, 
Telephone, 
InPerson, 
HandOff, 
CreatedDate, 
CreatedBy, 
LastModifiedDate, 
LastModifiedBy, 
Comment, 
Urgent, 
Participating, 
Testing,
Student.BannerStudentIDNumber as BannerStudentName
 FROM    CTE LEFT JOIN Student

ON CTE.StudentOID=Student.StudentOID
WHERE     RN BETWEEN @StartRow - @NumberOfRows
AND     @StartRow - 1  --AND RiskOID=0 
--and CreatedBy=@UserOID

END
GO
/****** Object:  StoredProcedure [dbo].[SelectjqGrid_Intervention]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectjqGrid_Intervention]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_DomainIntervention]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY

CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN InterventionName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'InterventionName'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN InterventionName
                                                              END DESC 

 ) AS RN ,
InterventionOID, 
DomainName, 
InterventionName

   FROM     [vw_DomainIntervention] ) 
SELECT
InterventionOID,
DomainName, 
InterventionName

 FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[Student_ByStudentOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_ByStudentOID]
@SOID varchar(12)

AS
BEGIN
SELECT *
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT

	FROM dbo.Student
	WHERE BannerStudentIDNumber=@SOID

END
GO
/****** Object:  StoredProcedure [dbo].[Sections_ByAssessmentOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sections_ByAssessmentOID]
@AOID int

AS
BEGIN
SELECT SectionOID, AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag,Low, Medium, High, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
FROM dbo.Section
WHERE AssessmentOID=@AOID
END
GO
/****** Object:  StoredProcedure [dbo].[Section_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Section_Update]
@SectionOID int ,
@SectionName varchar(50), 
@TotalQuestion int, 
@PassingTotal int, 
@TotalFlag int, 
@FlagPointTotal int, 
@Flag int, 
@Low int, 
@Medium int, 
@High int, 
@LastModifiedBy int

AS
BEGIN

	UPDATE 	dbo.Section
	SET SectionName=@SectionName, TotalQuestion=@TotalQuestion, PassingTotal=@PassingTotal, TotalFlag=@TotalFlag, FlagPointTotal=@FlagPointTotal,Flag=@Flag, Low=@Low, Medium=@Medium ,High=@High,LastModifiedBy=@LastModifiedBy
	WHERE SectionOID=@SectionOID	

END
GO
/****** Object:  StoredProcedure [dbo].[Section_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Section_Insert]
@SectionOID int output,
@AssessmentOID int , 
@SectionName varchar(50), 
@TotalQuestion int, 
@PassingTotal int, 
@TotalFlag int, 
@FlagPointTotal int, 
@Flag int, 
@Low int, 
@Medium int, 
@High int, 
@CreatedBy int, 
@LastModifiedBy int


AS
BEGIN

	--DECLARE @SectionOID int

	INSERT INTO dbo.Section(AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag, Low, Medium ,High, CreatedBy,  LastModifiedBy )
	VALUES(@AssessmentOID, @SectionName, @TotalQuestion, @PassingTotal, @TotalFlag, @FlagPointTotal,@Flag, @Low, @Medium ,@High, @CreatedBy,  @LastModifiedBy )

	SELECT @SectionOID=  MAX(SectionOID) FROM Section 
	RETURN @SectionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Section_DeleteBySectionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Section_DeleteBySectionOID]
@SectionOID int
AS

BEGIN

DELETE FROM [Section] 
WHERE SectionOID = @SectionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Section_BySectionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Section_BySectionOID]
@SOID int

AS
BEGIN
	SELECT SectionOID, AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag,Low, Medium, High, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.Section
	WHERE SectionOID=@SOID
END
GO
/****** Object:  StoredProcedure [dbo].[Section_ByAssessmentOID_ResultEmail]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Section_ByAssessmentOID_ResultEmail]
@AOID int

AS
BEGIN
	SELECT SectionOID, AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag,Low, Medium, High, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.Section
	WHERE AssessmentOID=@AOID and SectionName !='NoScore'
END
GO
/****** Object:  StoredProcedure [dbo].[Section_ByAssessmentOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Section_ByAssessmentOID]
@AOID int

AS
BEGIN
	SELECT SectionOID, AssessmentOID, SectionName, TotalQuestion, PassingTotal, TotalFlag, FlagPointTotal,Flag,Low, Medium, High, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.Section
	WHERE AssessmentOID=@AOID
END
GO
/****** Object:  StoredProcedure [dbo].[SectionWithScore_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SectionWithScore_ByAOID]
@AOID int,
@STDOID varchar(20)
AS
BEGIN

SELECT Section.SectionOID,Section.SectionName,Rank,ScoreDetailTable.CreatedDate,NumberOfPrinted
FROM dbo.ScoreDetailTable, Section
WHERE dbo.ScoreDetailTable.SectionOID= Section.SectionOID and dbo.ScoreDetailTable.AssessmentOID=@AOID and BannerID=@STDOID


END
GO
/****** Object:  View [dbo].[vw_Students]    Script Date: 06/12/2012 20:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Students]
AS
SELECT     BannerStudentName, BannerStudentIDNumber, TermCodeofProgramEnrollment, FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, 
                      LatestCompassPrealgebraTestScore, LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, 
                      LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore, LatestACTScienceAssessmentScore, LatestTestingDate, 
                      HighSchoolName, HighSchoolGraduationDate, HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, StateName, 
                      ZipCode, EmailAddress, ImportDateFileCreationDate, PreprogramIndicator, MajorProgramEnrollmentName, StudentOID, FileCreationDate, ResultLetterSentTimes, 
                      Status, FirstName, MiddleName, LastName, BirthDate, PriorCreditQuestion, dbo.ImportDataByBanner(BannerStudentIDNumber, 'NTO') AS NTO, 
                      dbo.ImportDataByBanner(BannerStudentIDNumber, 'MC') AS MC, dbo.ImportDataByBanner(BannerStudentIDNumber, 'PELL') AS PELL, 
                      dbo.ImportDataByBanner(BannerStudentIDNumber, 'RVP') AS RVP, dbo.ImportDataByBanner(BannerStudentIDNumber, 'ALERT') AS ALERT
FROM         dbo.Student
WHERE     (Status IS NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Student"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Students'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Students'
GO
/****** Object:  View [dbo].[vw_Course_report]    Script Date: 06/12/2012 20:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Course_report]
AS
SELECT     dbo.Course.BannerStudentName, dbo.Course.BannerStudentIDNumber, dbo.Course.TermCodeofProgramEnrollment, dbo.Course.CourseNumber, 
                      dbo.Course.CourseTitle, dbo.Course.FinalGrade, dbo.Course.TermCodeOfCourseEnrollment, dbo.Course.MethodOfDelivery, dbo.Course.ImportDate, 
                      dbo.Course.CourseOID, dbo.Course.FileCreationDate, dbo.Student.FullTimeOrPartTimeIndicator, dbo.Student.CumulativeGPA, dbo.Student.CreditsAttempted, 
                      dbo.Student.CreditsEarned, dbo.Student.LatestCompassPrealgebraTestScore, dbo.Student.LatestCompassAlgebraTestScore, 
                      dbo.Student.LatestCompassWritingTestScore, dbo.Student.LatestCompassReadingTestScore, dbo.Student.LatestACTEnglishAssessmentScore, 
                      dbo.Student.LatestACTMathAssessmentScore, dbo.Student.LatestACTReadingAssessmentScore, dbo.Student.LatestACTScienceAssessmentScore, 
                      dbo.Student.LatestTestingDate, dbo.Student.HighSchoolName, dbo.Student.HighSchoolGraduationDate, dbo.Student.HomeTelephoneNumber, 
                      dbo.Student.MailingAddressLineOne, dbo.Student.MailingAddressLineTwo, dbo.Student.MailingAddressLineThree, dbo.Student.City, dbo.Student.StateName, 
                      dbo.Student.ZipCode, dbo.Student.EmailAddress, dbo.Student.ImportDateFileCreationDate, dbo.Student.PreprogramIndicator, 
                      dbo.Student.MajorProgramEnrollmentName, dbo.Student.StudentOID, dbo.Student.FileCreationDate AS Expr1, dbo.Student.ResultLetterSentTimes, dbo.Student.Status, 
                      dbo.Student.FirstName, dbo.Student.MiddleName, dbo.Student.LastName, dbo.Student.BirthDate, dbo.Student.PriorCreditQuestion, 
                      dbo.ImportDataByBanner(dbo.Course.BannerStudentIDNumber, 'NTO') AS NTO, dbo.ImportDataByBanner(dbo.Course.BannerStudentIDNumber, 'MC') AS MC, 
                      dbo.ImportDataByBanner(dbo.Course.BannerStudentIDNumber, 'PELL') AS PELL, dbo.ImportDataByBanner(dbo.Course.BannerStudentIDNumber, 'RVP') AS RVP, 
                      dbo.ImportDataByBanner(dbo.Course.BannerStudentIDNumber, 'ALERT') AS ALERT
FROM         dbo.Course LEFT OUTER JOIN
                      dbo.Student ON dbo.Course.BannerStudentIDNumber = dbo.Student.BannerStudentIDNumber
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Student"
            Begin Extent = 
               Top = 6
               Left = 305
               Bottom = 114
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Course_report'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Course_report'
GO
/****** Object:  StoredProcedure [dbo].[Students_ByAssessmentDate]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Students_ByAssessmentDate]
 @AssessmentDate DATETIME,
 @RowNum INT

AS
BEGIN
SET @AssessmentDate = '02/10/2012'
IF @AssessmentDate IS NULL
BEGIN

		SELECT * FROM 
		(
		SELECT   ROW_NUMBER() OVER (order by  Answer.CreatedDate ) AS RowNum,  Student.BannerStudentName, Student.BannerStudentIDNumber, Answer.CreatedDate
		FROM         Student INNER JOIN
							  Answer ON Student.StudentOID = Answer.StudentOID
		WHERE     Convert(varchar, Answer.CreatedDate,103) = Convert(varchar,@AssessmentDate,103) 
		) AS T WHERE T.RowNum =@RowNum
END
ELSE
BEGIN
	SELECT TOP(1)  ROW_NUMBER() OVER (order by Student.BannerStudentIDNumber ) AS RowNum,  Student.BannerStudentName, Student.BannerStudentIDNumber, Answer.CreatedDate
	FROM  Student INNER JOIN
		Answer ON Student.StudentOID = Answer.StudentOID
	ORDER BY Answer.CreatedDate DESC

END 
END
GO
/****** Object:  StoredProcedure [dbo].[StudentFirstID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentFirstID]
 

AS
BEGIN
	
	SELECT * FROM
	(
	
	SELECT  ROW_NUMBER() OVER (ORDER BY Answer.CreatedDate DESC  ) AS RowNum,Student.BannerStudentName, Student.BannerStudentIDNumber, Answer.CreatedDate 
	
	 FROM         Student INNER JOIN
							  Answer ON Student.StudentOID = Answer.StudentOID
                     
	
	) AS T  ORDER BY  T.RowNum ASC

END
GO
/****** Object:  StoredProcedure [dbo].[StudentByRowID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StudentByRowID]
@RowID int 
AS
BEGIN
	
	SELECT * FROM
	(
	
	SELECT  ROW_NUMBER() OVER (ORDER BY Answer.CreatedDate DESC  ) AS RowNum,Student.BannerStudentName, Student.BannerStudentIDNumber, Answer.CreatedDate,Student.StudentOID
	
	 FROM         Student INNER JOIN
							  Answer ON Student.StudentOID = Answer.StudentOID
                     

	) AS T 
	WHERE T.RowNum=@RowID
	--ORDER BY  T.RowNum ASC
	

END
GO
/****** Object:  StoredProcedure [dbo].[Student_Search_Report]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Search_Report]                                                
	@BannerStudentName varchar(80),
	@BannerStudentIDNumber varchar(12),
	@TermCodeofProgramEnrollment varchar(20),
	@FullTimeOrPartTimeIndicator varchar(10),
	@CumulativeGPA numeric(11,2) ,
	@CumulativeGPA1 numeric(11,2),
	@CreditsAttempted numeric(11,3),
	@CreditsAttempted1 numeric(11,3),
	@CreditsEarned numeric(11,3),
	@CreditsEarned1 numeric(11,3),
	@LatestCompassPrealgebraTestScore numeric(11,3),
	@LatestCompassPrealgebraTestScore1 numeric(11,3),
	@LatestCompassAlgebraTestScore numeric(11,3),
	@LatestCompassAlgebraTestScore1 numeric(11,3),
	@LatestCompassWritingTestScore numeric(11,3),
	@LatestCompassWritingTestScore1 numeric(11,3),
	@LatestCompassReadingTestScore numeric(11,3),
	@LatestCompassReadingTestScore1 numeric(11,3),
	@LatestACTEnglishAssessmentScore numeric(11,3),
	@LatestACTEnglishAssessmentScore1 numeric(11,3),
	@LatestACTMathAssessmentScore numeric(11,3),
	@LatestACTMathAssessmentScore1 numeric(11,3),
	@LatestACTReadingAssessmentScore numeric(11,3),
	@LatestACTReadingAssessmentScore1 numeric(11,3),
	@LatestACTScienceAssessmentScore numeric(11,3),
	@LatestACTScienceAssessmentScore1 numeric(11,3),
	@LatestTestingDate datetime,
	@HighSchoolName varchar(80),
	@HighSchoolGraduationDate datetime,
	@HomeTelephoneNumber varchar(20),
	@MailingAddressLineOne varchar(75),
	@MailingAddressLineTwo varchar(75),
	@MailingAddressLineThree varchar(75),
	@City varchar(50),
	@StateName varchar(20),
	@ZipCode varchar(30),
	@EmailAddress varchar(128),
	@ImportDateFileCreationDate datetime,
	@PreprogramIndicator varchar(5),
	@MajorProgramEnrollmentName varchar(75),
	@PageIndex INT ,
    @SortColumnName VARCHAR(50) ,
    @SortOrderBy VARCHAR(4) ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT
    

 AS
 BEGIN
 
 
 
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
 FROM      [Student]
 WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
 --AND (CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
  AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
 --AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1) 

 AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%') 
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
												 --declare @StartGPA numeric(11,2)
												 --set @StartGPA= @CumulativeGPA1;
												 
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITYCITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate,
BirthDate,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT
   FROM     [Student]
   
WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
--AND (@CumulativeGPA>=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 --AND (@CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 

--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1)  

AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' )
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
BirthDate,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT
 FROM    CTE
 --WHERE     RN BETWEEN @StartRow - @NumberOfRows  AND     @StartRow - 1  and  (Status is null or Status='Approved')
-- AND (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
-- AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
-- AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
-- AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
-- AND (@CumulativeGPA=0 OR CumulativeGPA =@CumulativeGPA ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
--AND (@LatestCompassPrealgebraTestScore = '' OR LatestCompassPrealgebraTestScore LIKE '%'+@LatestCompassPrealgebraTestScore +'%')
-- AND (@LatestCompassAlgebraTestScore = '' OR LatestCompassAlgebraTestScore LIKE '%'+@LatestCompassAlgebraTestScore +'%') 
-- AND (@LatestCompassWritingTestScore = '' OR LatestCompassWritingTestScore LIKE '%'+@LatestCompassWritingTestScore +'%')
-- AND (@LatestCompassReadingTestScore = '' OR LatestCompassReadingTestScore LIKE '%'+@LatestCompassReadingTestScore +'%') 
-- AND (@LatestACTEnglishAssessmentScore = '' OR LatestACTEnglishAssessmentScore LIKE '%'+@LatestACTEnglishAssessmentScore +'%') 
-- AND (@LatestACTMathAssessmentScore = '' OR LatestACTMathAssessmentScore LIKE '%'+@LatestACTMathAssessmentScore +'%') 
-- AND (@LatestACTReadingAssessmentScore = '' OR LatestACTReadingAssessmentScore LIKE '%'+@LatestACTReadingAssessmentScore +'%' )
--AND (@LatestACTScienceAssessmentScore = '' OR LatestACTScienceAssessmentScore LIKE '%'+@LatestACTScienceAssessmentScore +'%' )
--AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
--AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
--AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
--AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
--AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
--AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
--AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
--AND (@City = '' OR City LIKE '%'+@City+'%' )
--AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
--AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' AND EmailAddress LIKE '%'+@EmailAddress +'%' )
--AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
-- AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
-- AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')

END
GO
/****** Object:  StoredProcedure [dbo].[Student_Search]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_Search]                                                
	@BannerStudentName varchar(80),
	@BannerStudentIDNumber varchar(12),
	@TermCodeofProgramEnrollment varchar(20),
	@FullTimeOrPartTimeIndicator varchar(10),
	@CumulativeGPA numeric(11,2) ,
	@CumulativeGPA1 numeric(11,2),
	@CreditsAttempted numeric(11,3),
	@CreditsAttempted1 numeric(11,3),
	@CreditsEarned numeric(11,3),
	@CreditsEarned1 numeric(11,3),
	@LatestCompassPrealgebraTestScore numeric(11,3),
	@LatestCompassPrealgebraTestScore1 numeric(11,3),
	@LatestCompassAlgebraTestScore numeric(11,3),
	@LatestCompassAlgebraTestScore1 numeric(11,3),
	@LatestCompassWritingTestScore numeric(11,3),
	@LatestCompassWritingTestScore1 numeric(11,3),
	@LatestCompassReadingTestScore numeric(11,3),
	@LatestCompassReadingTestScore1 numeric(11,3),
	@LatestACTEnglishAssessmentScore numeric(11,3),
	@LatestACTEnglishAssessmentScore1 numeric(11,3),
	@LatestACTMathAssessmentScore numeric(11,3),
	@LatestACTMathAssessmentScore1 numeric(11,3),
	@LatestACTReadingAssessmentScore numeric(11,3),
	@LatestACTReadingAssessmentScore1 numeric(11,3),
	@LatestACTScienceAssessmentScore numeric(11,3),
	@LatestACTScienceAssessmentScore1 numeric(11,3),
	@LatestTestingDate datetime,
	@HighSchoolName varchar(80),
	@HighSchoolGraduationDate datetime,
	@HomeTelephoneNumber varchar(20),
	@MailingAddressLineOne varchar(75),
	@MailingAddressLineTwo varchar(75),
	@MailingAddressLineThree varchar(75),
	@City varchar(50),
	@StateName varchar(20),
	@ZipCode varchar(30),
	@EmailAddress varchar(128),
	@ImportDateFileCreationDate datetime,
	@PreprogramIndicator varchar(5),
	@MajorProgramEnrollmentName varchar(75),
	@PageIndex INT ,
    @SortColumnName VARCHAR(50) ,
    @SortOrderBy VARCHAR(4) ,
    @NumberOfRows INT ,
    @TotalRecords INT OUTPUT
    

 AS
 BEGIN
 
 
 
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
 FROM      [Student]
 WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
 --AND (CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
  AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
 --AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1) 

 AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%') 
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
												 --declare @StartGPA numeric(11,2)
												 --set @StartGPA= @CumulativeGPA1;
												 
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITYCITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StudentOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StudentOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC 
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate,
BirthDate,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT

   FROM     [Student]
   
WHERE  (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
 AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
 AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
 AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
--AND (@CumulativeGPA>=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 --AND (@CumulativeGPA=@CumulativeGPA1 or CumulativeGPA <=@CumulativeGPA ) 
 AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 

--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1)  

AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' )
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
 ) 
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
BirthDate,
FileCreationDate ,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT
 FROM    CTE
 WHERE     RN BETWEEN @StartRow - @NumberOfRows  AND     @StartRow - 1  and  (Status is null or Status='Approved')
-- AND (@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%') 
-- AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber +'%') 
-- AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%') 
-- AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
-- AND (@CumulativeGPA=0 OR CumulativeGPA =@CumulativeGPA ) 
--AND (@CreditsAttempted=0 OR CreditsAttempted=@CreditsAttempted) 
--AND( @CreditsEarned=0 OR CreditsEarned=@CreditsEarned) 
--AND (@LatestCompassPrealgebraTestScore = '' OR LatestCompassPrealgebraTestScore LIKE '%'+@LatestCompassPrealgebraTestScore +'%')
-- AND (@LatestCompassAlgebraTestScore = '' OR LatestCompassAlgebraTestScore LIKE '%'+@LatestCompassAlgebraTestScore +'%') 
-- AND (@LatestCompassWritingTestScore = '' OR LatestCompassWritingTestScore LIKE '%'+@LatestCompassWritingTestScore +'%')
-- AND (@LatestCompassReadingTestScore = '' OR LatestCompassReadingTestScore LIKE '%'+@LatestCompassReadingTestScore +'%') 
-- AND (@LatestACTEnglishAssessmentScore = '' OR LatestACTEnglishAssessmentScore LIKE '%'+@LatestACTEnglishAssessmentScore +'%') 
-- AND (@LatestACTMathAssessmentScore = '' OR LatestACTMathAssessmentScore LIKE '%'+@LatestACTMathAssessmentScore +'%') 
-- AND (@LatestACTReadingAssessmentScore = '' OR LatestACTReadingAssessmentScore LIKE '%'+@LatestACTReadingAssessmentScore +'%' )
--AND (@LatestACTScienceAssessmentScore = '' OR LatestACTScienceAssessmentScore LIKE '%'+@LatestACTScienceAssessmentScore +'%' )
--AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
--AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
--AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
--AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
--AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
--AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
--AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
--AND (@City = '' OR City LIKE '%'+@City+'%' )
--AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
--AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%' AND EmailAddress LIKE '%'+@EmailAddress +'%' )
--AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
-- AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
-- AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')

END
GO
/****** Object:  StoredProcedure [dbo].[Student_Prev]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Student_Prev]
 @prevISSDate as datetime

AS
BEGIN
	--select top(1) * from student
	--where LatestTestingDate is not null 
	--order by LatestTestingDate desc
	
SELECT DISTINCT TOP (1)  dbo.Answer.BannerStudentIDNumber, dbo.Answer.CreatedDate, dbo.Student.BannerStudentName, dbo.Answer.StudentOID
FROM         dbo.Answer LEFT OUTER JOIN
                      dbo.Student ON dbo.Answer.StudentOID = dbo.Student.StudentOID
                      where dbo.Answer.CreatedDate is not null and  dbo.Student.Status<>'Pending' and dbo.Answer.CreatedDate>@prevISSDate and dbo.Answer.BannerStudentIDNumber<>'0'
                      
ORDER BY dbo.Answer.CreatedDate asc

END
GO
/****** Object:  StoredProcedure [dbo].[Student_Next]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Student_Next]
 @nextISSDate as datetime

AS
BEGIN
	--select top(1) * from student
	--where LatestTestingDate is not null 
	--order by LatestTestingDate desc
	
SELECT DISTINCT TOP (1000)  dbo.Answer.BannerStudentIDNumber, dbo.Answer.CreatedDate, dbo.Student.BannerStudentName, dbo.Answer.StudentOID
FROM         dbo.Answer LEFT OUTER JOIN
                      dbo.Student ON dbo.Answer.StudentOID = dbo.Student.StudentOID
                      where dbo.Answer.CreatedDate is not null and  dbo.Student.Status<>'Pending' and dbo.Answer.CreatedDate<@nextISSDate and dbo.Answer.BannerStudentIDNumber<>'0'
                      
ORDER BY dbo.Answer.CreatedDate desc

END
GO
/****** Object:  StoredProcedure [dbo].[Student_SelectjqGrid]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Student_SelectjqGrid]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_Students]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'StudentOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC ,
--CASE
--                                                              WHEN @SortColumnName = 'StudentOID'
--                                                              AND @SortOrderBy = 'asc'
--                                                              THEN StudentOID
--                                                             END ASC, CASE
--                                                              WHEN @SortColumnName = 'StudentOID'
--                                                              AND @SortOrderBy = 'desc'
--                                                              THEN StudentOID
--                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, 
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC ,
 CASE   
															  WHEN @SortColumnName = 'BirthDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BirthDate
                                                              END DESC,
CASE
                                                              WHEN @SortColumnName = 'NTO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN NTO
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NTO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN NTO
                                                              END DESC ,
 CASE
                                                              WHEN @SortColumnName = 'MC'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MC
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MC'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MC
                                                              END DESC ,  
                                                              
CASE
                                                              WHEN @SortColumnName = 'PELL'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PELL
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PELL'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PELL
                                                              END DESC ,  
                                                              
CASE
                                                              WHEN @SortColumnName = 'RVP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RVP
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RVP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RVP
                                                              END DESC , 
                                                              
CASE
                                                              WHEN @SortColumnName = 'ALERT'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ALERT
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ALERT'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ALERT
                                                              END DESC  
                                                              
                                                                                                              
                                                                                                                      
 ) AS RN ,
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
BirthDate,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT
   FROM     [vw_Students] ) 
   
SELECT
BannerStudentName, 
BannerStudentIDNumber, 
TermCodeofProgramEnrollment, 
FullTimeOrPartTimeIndicator, 
CumulativeGPA, 
CreditsAttempted, 
CreditsEarned, 
LatestCompassPrealgebraTestScore, 
LatestCompassAlgebraTestScore, 
LatestCompassWritingTestScore, 
LatestCompassReadingTestScore, 
LatestACTEnglishAssessmentScore, 
LatestACTMathAssessmentScore, 
LatestACTReadingAssessmentScore, 
LatestACTScienceAssessmentScore, 
LatestTestingDate, 
HighSchoolName, 
HighSchoolGraduationDate, 
HomeTelephoneNumber, 
MailingAddressLineOne, 
MailingAddressLineTwo, 
MailingAddressLineThree, 
City, 
StateName, 
ZipCode, 
EmailAddress, 
ImportDateFileCreationDate, 
PreprogramIndicator, 
MajorProgramEnrollmentName, 
StudentOID, 
FileCreationDate ,
BirthDate,
Status
,dbo.ImportDataByBanner(BannerStudentIDNumber,'NTO') AS NTO
,dbo.ImportDataByBanner(BannerStudentIDNumber,'MC') AS MC
,dbo.ImportDataByBanner(BannerStudentIDNumber,'PELL') AS PELL
,dbo.ImportDataByBanner(BannerStudentIDNumber,'RVP') AS RVP
,dbo.ImportDataByBanner(BannerStudentIDNumber,'ALERT') AS ALERT
 FROM    CTE
 WHERE     (RN  BETWEEN (@StartRow - @NumberOfRows)   AND     (@StartRow - 1)) --and Status is null
 
 END
GO
/****** Object:  StoredProcedure [dbo].[StudentAnswer_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[StudentAnswer_ByAOID]
 @AOID int
AS
BEGIN
	SELECT BannerStudentName AS StudentName,SectionOID,questionOID,Response
	FROM dbo.Answer,dbo.AnswerDetail,dbo.Student
	WHERE AssessmentOID=@AOID AND 
		  dbo.Answer.answerOID=dbo.AnswerDetail.answerOID
		  AND dbo.Answer.StudentOID=dbo.Student.StudentOID
	ORDER BY SectionOID,QuestionOID
END
GO
/****** Object:  View [dbo].[SectionScore]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SectionScore]
AS
SELECT     dbo.Section.AssessmentOID, dbo.Section.SectionName, dbo.Section.Flag, dbo.Answer.StudentOID, dbo.AnswerDetail.SectionOID, CONVERT(DECIMAL(10, 2), 
                      SUM(dbo.AnswerDetail.AnswerPoint) / (COUNT(dbo.AnswerDetail.SectionOID) * 1.0)) AS Score, dbo.Answer.NumberOfPrinted, dbo.Answer.CreatedDate
FROM         dbo.Answer INNER JOIN
                      dbo.AnswerDetail ON dbo.Answer.AnswerOID = dbo.AnswerDetail.AnswerOID INNER JOIN
                      dbo.Section ON dbo.AnswerDetail.SectionOID = dbo.Section.SectionOID
WHERE     (dbo.Section.SectionName <> 'NoScore')
GROUP BY dbo.Section.SectionName, dbo.Section.AssessmentOID, dbo.Answer.StudentOID, dbo.AnswerDetail.SectionOID, dbo.Answer.NumberOfPrinted, 
                      dbo.Answer.CreatedDate, dbo.Section.Flag
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[2] 2[39] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Answer"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AnswerDetail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Section"
            Begin Extent = 
               Top = 126
               Left = 264
               Bottom = 245
               Right = 452
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SectionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SectionScore'
GO
/****** Object:  StoredProcedure [dbo].[ResultLetterDetail_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetterDetail_Update]

@OID int, 
@SectionDefinition varchar(500), 
@LastModifiedBy int
 
AS
BEGIN
	UPDATE dbo.AssResultLetterSectionComment
	SET SectionDefinition=@SectionDefinition,LastModifiedBy=@LastModifiedBy,LastModifiedDate=getDate()
	WHERE ResultLetterSectionCommentOID=@OID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetterDetail_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetterDetail_insert]

@AssessmentLetterOID int, 
@SectionOID int, 
@SectionDefinition varchar(500), 
@CreatedBy int, 
@LastModifiedBy int
 
AS
BEGIN
	DECLARE @AnswerOID int
 
	INSERT INTO dbo.AssResultLetterSectionComment(AssessmentLetterOID, SectionOID, SectionDefinition,  CreatedBy,  LastModifiedBy)
	values(@AssessmentLetterOID, @SectionOID, @SectionDefinition,  @CreatedBy,  @LastModifiedBy)

	SELECT @AnswerOID=  MAX(ResultLetterSectionCommentOID) FROM AssResultLetterSectionComment 
	RETURN @AnswerOID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultLetterDetail_ByLetterOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultLetterDetail_ByLetterOID]

@AssessmentLetterOID int 
 
AS
BEGIN
	DECLARE @AnswerOID int
 
	SELECT  ResultLetterSectionCommentOID, AssessmentLetterOID, SectionOID, SectionDefinition, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssResultLetterSectionComment
	WHERE AssessmentLetterOID=@AssessmentLetterOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmailDetail_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmailDetail_Update]

@OID int, 
--@PositiveResult varchar(500), 
--@NegativeResult varchar(500), 
@LowResult varchar(500), 
@MediumResult varchar(500), 
@HighResult varchar(500), 
@LastModifiedBy int
 
AS
BEGIN
	UPDATE dbo.AssessmentResultSectionComment
	SET LowResult=@LowResult,MediumResult=@MediumResult, HighResult=@HighResult,LastModifiedBy=@LastModifiedBy,LastModifiedDate=getDate()
	WHERE ResultSectionOID=@OID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmailDetail_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmailDetail_insert]

@AssessmentResultOID int, 
@SectionOID int, 
--@PositiveResult varchar(500), 
--@NegativeResult varchar(500), 
@LowResult varchar(500), 
@MediumResult varchar(500), 
@HighResult varchar(500), 
@CreatedBy int, 
@LastModifiedBy int
 
AS
BEGIN
	DECLARE @AnswerOID int
 
	INSERT INTO dbo.AssessmentResultSectionComment(AssessmentResultOID, SectionOID, LowResult,MediumResult, HighResult , CreatedBy,  LastModifiedBy)
	values(@AssessmentResultOID, @SectionOID, @LowResult, @MediumResult,@HighResult, @CreatedBy,  @LastModifiedBy)

	SELECT @AnswerOID=  MAX(ResultSectionOID) FROM AssessmentResultSectionComment 
	RETURN @AnswerOID
END
GO
/****** Object:  StoredProcedure [dbo].[ResultEmailDetail_ByResutEmailOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResultEmailDetail_ByResutEmailOID]

@AssessmentResultOID int 
 
AS
BEGIN	
 
	SELECT  ResultSectionOID, AssessmentResultOID, SectionOID, LowResult,MediumResult, HighResult,PositiveResult, NegativeResult, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.AssessmentResultSectionComment
	WHERE AssessmentResultOID=@AssessmentResultOID
	
END
GO
/****** Object:  Table [dbo].[QuestionResponse]    Script Date: 06/12/2012 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestionResponse](
	[QuestionResponseOID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionOID] [int] NULL,
	[Response] [varchar](500) NULL,
	[FlagRating] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_QuestionResponse] PRIMARY KEY CLUSTERED 
(
	[QuestionResponseOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[NonScore]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NonScore]
AS
SELECT     dbo.Section.AssessmentOID, dbo.AnswerDetail.SectionOID, dbo.Answer.StudentOID, dbo.Question.Keyword, dbo.Section.SectionName, dbo.Question.Question, 
                      dbo.AnswerDetail.Response, dbo.Answer.BannerStudentIDNumber
FROM         dbo.AnswerDetail INNER JOIN
                      dbo.Answer ON dbo.AnswerDetail.AnswerOID = dbo.Answer.AnswerOID INNER JOIN
                      dbo.Question ON dbo.AnswerDetail.QuestionOID = dbo.Question.QuestionOID INNER JOIN
                      dbo.Section ON dbo.AnswerDetail.SectionOID = dbo.Section.SectionOID
WHERE     (dbo.Section.SectionName = 'NoScore')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[62] 4[3] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AnswerDetail"
            Begin Extent = 
               Top = 10
               Left = 0
               Bottom = 319
               Right = 171
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Answer"
            Begin Extent = 
               Top = 1
               Left = 408
               Bottom = 169
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Question"
            Begin Extent = 
               Top = 199
               Left = 709
               Bottom = 471
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Section"
            Begin Extent = 
               Top = 248
               Left = 370
               Bottom = 514
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NonScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NonScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NonScore'
GO
/****** Object:  StoredProcedure [dbo].[Question_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_Update]
@QuestionOID int , 
@Keyword varchar(100), 
@LastModifiedBy int,
@MultipleAllow int, 
@OrderNo int, 
@Question varchar(500), 
@RespAction varchar(50),
@SectionOID int,
@Reverse int


AS
BEGIN

	UPDATE dbo.Question
	SET SectionOID=@SectionOID, OrderNo=@OrderNo, Question=@Question, RespAction=@RespAction, MultipleAllow=@MultipleAllow, Keyword=@Keyword,  LastModifiedBy=@LastModifiedBy,Reverse=@Reverse
	WHERE QuestionOID=@QuestionOID
	

END
GO
/****** Object:  StoredProcedure [dbo].[Question_insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_insert]
@QuestionOID int OUTPUT, 
@CreatedBy int, 
@Keyword varchar(100), 
@LastModifiedBy int,
@MultipleAllow int, 
@OrderNo int, 
@Question varchar(500), 
@RespAction varchar(50),
@SectionOID int,
@Reverse int


AS
BEGIN


	INSERT INTO dbo.Question( SectionOID, OrderNo, Question, RespAction, MultipleAllow, Keyword,  CreatedBy,  LastModifiedBy,Reverse)
	VALUES( @SectionOID, @OrderNo, @Question, @RespAction, @MultipleAllow, @Keyword,  @CreatedBy,  @LastModifiedBy,@Reverse)

	--DECLARE @QuestionOID int 
	SELECT @QuestionOID=  MAX(QuestionOID) FROM Question 
	RETURN @QuestionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Question_DeleteBySectionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_DeleteBySectionOID]
@SectionOID int
AS

BEGIN

DELETE FROM [Question] 
WHERE SectionOID = @SectionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Question_DeleteByQuestionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_DeleteByQuestionOID]
@QuestionOID int
AS

BEGIN

DELETE FROM [Question] 
WHERE QuestionOID = @QuestionOID

END
GO
/****** Object:  StoredProcedure [dbo].[Question_BySectionOID_Noscore]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Question_BySectionOID_Noscore]
@SOID int

AS
BEGIN
	SELECT QuestionOID, SectionOID, OrderNo, Question, RespAction, MultipleAllow, Keyword, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy,Reverse
	FROM dbo.Question
	where SectionOID=@SOID
	order by OrderNo asc
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[Question_BySectionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_BySectionOID]
@SOID int

AS
BEGIN
	SELECT QuestionOID, SectionOID, OrderNo, Question, RespAction, MultipleAllow, Keyword, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy,Reverse
	FROM dbo.Question
	where SectionOID=@SOID
	ORDER BY NewID()
	
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionOID_BySOID_Order]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionOID_BySOID_Order]

@OrderNo int ,
@SectionOID int
 
AS
BEGIN	
 
	SELECT *
	FROM Question
	WHERE OrderNo=@OrderNo AND SectionOID=@SectionOID
	
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_ExistBySOIDAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_ExistBySOIDAOID]
@ReturnValue int OUTPUT,
@AOID int, 
--@SOID int,
@StudentOID int
AS
BEGIN
	--DECLARE @Num int

	SELECT @ReturnValue= COUNT(dbo.Answer.AnswerOID) 
	FROM dbo.Answer,dbo.AnswerDetail
	WHERE dbo.Answer.AnswerOID=dbo.AnswerDetail.AnswerOID
	AND dbo.Answer.AssessmentOID=@AOID
	AND dbo.Answer.StudentOID=@StudentOID
	--AND dbo.AnswerDetail.SectionOID=@SOID


	RETURN @ReturnValue

END
GO
/****** Object:  StoredProcedure [dbo].[Course_SelectjqGrid_Report]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_SelectjqGrid_Report]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT
                                                AS
                                                    BEGIN
 SELECT  @TotalRecords = ( SELECT    COUNT(1)
                                                      FROM      [vw_Course_report]
                                                    )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
         
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseTitle
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseTitle
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FinalGrade
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FinalGrade
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeOfCourseEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeOfCourseEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MethodOfDelivery
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MethodOfDelivery
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC ,
                                                              CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC,
                                                              
                                                              CASE
                                                              WHEN @SortColumnName = 'NTO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN NTO
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NTO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN NTO
                                                              END DESC ,
 CASE
                                                              WHEN @SortColumnName = 'MC'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MC
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MC'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MC
                                                              END DESC ,  
                                                              
CASE
                                                              WHEN @SortColumnName = 'PELL'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PELL
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PELL'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PELL
                                                              END DESC ,  
                                                              
CASE
                                                              WHEN @SortColumnName = 'RVP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN RVP
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'RVP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN RVP
                                                              END DESC , 
                                                              
CASE
                                                              WHEN @SortColumnName = 'ALERT'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ALERT
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ALERT'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ALERT
                                                              END DESC 
                                                              
                                                              
                                                              
 ) AS RN ,

 *  FROM     [vw_Course_report] ) 
SELECT

 * FROM    CTE
                                                   WHERE     RN BETWEEN @StartRow - @NumberOfRows
                                                   AND     @StartRow - 1  END
GO
/****** Object:  StoredProcedure [dbo].[Course_Search_Report]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Course_Search_Report]
                                                @PageIndex INT ,
                                                @SortColumnName VARCHAR(50) ,
                                                @SortOrderBy VARCHAR(4) ,
                                                @NumberOfRows INT ,
                                                @TotalRecords INT OUTPUT,
                                                
                                                @BannerStudentName VARCHAR(80), 
                                                @BannerStudentIDNumber VARCHAR(12), 
                                                @TermCodeofProgramEnrollment VARCHAR(20), 
                                                @CourseNumber VARCHAR(15), 
                                                @CourseTitle VARCHAR(100), 
                                                @FinalGrade VARCHAR(15), 
                                                @TermCodeOfCourseEnrollment VARCHAR(15), 
                                                @MethodOfDelivery VARCHAR(50), 
                                                
                                                @ImportDate DateTime, 
                                                @CourseOID INT,
                                                @FileCreationDate DateTime,
                                                @FullTimeOrPartTimeIndicator varchar(10),
	@CumulativeGPA numeric(11,2) ,
	@CumulativeGPA1 numeric(11,2),
	@CreditsAttempted numeric(11,3),
	@CreditsAttempted1 numeric(11,3),
	@CreditsEarned numeric(11,3),
	@CreditsEarned1 numeric(11,3),
	@LatestCompassPrealgebraTestScore numeric(11,3),
	@LatestCompassPrealgebraTestScore1 numeric(11,3),
	@LatestCompassAlgebraTestScore numeric(11,3),
	@LatestCompassAlgebraTestScore1 numeric(11,3),
	@LatestCompassWritingTestScore numeric(11,3),
	@LatestCompassWritingTestScore1 numeric(11,3),
	@LatestCompassReadingTestScore numeric(11,3),
	@LatestCompassReadingTestScore1 numeric(11,3),
	@LatestACTEnglishAssessmentScore numeric(11,3),
	@LatestACTEnglishAssessmentScore1 numeric(11,3),
	@LatestACTMathAssessmentScore numeric(11,3),
	@LatestACTMathAssessmentScore1 numeric(11,3),
	@LatestACTReadingAssessmentScore numeric(11,3),
	@LatestACTReadingAssessmentScore1 numeric(11,3),
	@LatestACTScienceAssessmentScore numeric(11,3),
	@LatestACTScienceAssessmentScore1 numeric(11,3),
	@LatestTestingDate datetime,
	@HighSchoolName varchar(80),
	@HighSchoolGraduationDate datetime,
	@HomeTelephoneNumber varchar(20),
	@MailingAddressLineOne varchar(75),
	@MailingAddressLineTwo varchar(75),
	@MailingAddressLineThree varchar(75),
	@City varchar(50),
	@StateName varchar(20),
	@ZipCode varchar(30),
	@EmailAddress varchar(128),
	@ImportDateFileCreationDate datetime,
	@PreprogramIndicator varchar(5),
	@MajorProgramEnrollmentName varchar(75)
                                                
                                                
                                                AS
                                                    BEGIN
                                                    
 SELECT  @TotalRecords = ( SELECT    COUNT(BannerStudentName)
        FROM      [vw_Course_report]
		WHERE 
		(@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%' )
		AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber+'%') 
		AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%')
		AND (@CourseNumber = '' OR CourseNumber LIKE '%'+@CourseNumber+'%')
		AND (@CourseTitle = '' OR CourseTitle LIKE '%'+@CourseTitle+'%')
		AND (@FinalGrade = '' OR FinalGrade LIKE '%'+@FinalGrade+'%')
		AND (@TermCodeOfCourseEnrollment = '' OR TermCodeOfCourseEnrollment LIKE '%'+@TermCodeOfCourseEnrollment+'%') 
		AND (@MethodOfDelivery = '' OR MethodOfDelivery LIKE '%'+@MethodOfDelivery+'%')
		AND (@ImportDate='1/1/1900' OR ImportDate = @ImportDate) 
		AND (@CourseOID = 0 OR CourseOID = @CourseOID)
		AND (@FileCreationDate='1/1/1900' OR FileCreationDate = @FileCreationDate)
		AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
 
  AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 

AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1) 

 AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%') 
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')
		
        )
                                                DECLARE @StartRow INT
                                                SET @StartRow = ( @PageIndex * @NumberOfRows ) + 1 ;
          
                                                 WITH    CTE
                                                          AS ( SELECT   ROW_NUMBER() OVER ( ORDER BY
CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'NAME'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN BannerStudentIDNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'BID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN BannerStudentIDNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeofProgramEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TERMEFF'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeofProgramEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSENO'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseTitle
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETITLE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseTitle
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FinalGrade
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FINALGRDE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FinalGrade
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN TermCodeOfCourseEnrollment
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CRSETERM'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN TermCodeOfCourseEnrollment
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MethodOfDelivery
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'DeliveryMethod'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MethodOfDelivery
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CourseOID
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CourseOID'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CourseOID
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FileCreationDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FileCreationDate
                                                              END DESC ,
                                                              CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'FullPart'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN FullTimeOrPartTimeIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CumulativeGPA
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'GPA'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CumulativeGPA
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsAttempted
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CreditAttempted'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsAttempted
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN CreditsEarned
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'EarnedCredit'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN CreditsEarned
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Prealgebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassPrealgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassAlgebraTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Algebra'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassAlgebraTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassWritingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Writting'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassWritingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestCompassReadingTestScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Reading'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestCompassReadingTestScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'English'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTEnglishAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTMathAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Math'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTMathAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTReadingAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ReadingScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTReadingAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestACTScienceAssessmentScore
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ScienceScore'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestACTScienceAssessmentScore
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN LatestTestingDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'TestingDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN LatestTestingDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HighSchool'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HighSchoolGraduationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'HS_GRAD_DATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HighSchoolGraduationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN HomeTelephoneNumber
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Phone'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN HomeTelephoneNumber
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineOne
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR1'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineOne
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineTwo
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR2'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineTwo
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MailingAddressLineThree
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ADDR3'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MailingAddressLineThree
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN City
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'CITY'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN City
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN StateName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'STATE'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN StateName
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ZipCode
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ZIP'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ZipCode
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN EmailAddress
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'Email'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN EmailAddress
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN ImportDateFileCreationDate
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'ImportDate'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN ImportDateFileCreationDate
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN PreprogramIndicator
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'PPGMIND'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN PreprogramIndicator
                                                              END DESC ,
CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'asc'
                                                              THEN MajorProgramEnrollmentName
                                                             END ASC, CASE
                                                              WHEN @SortColumnName = 'MAJOR'
                                                              AND @SortOrderBy = 'desc'
                                                              THEN MajorProgramEnrollmentName
                                                              END DESC 
 ) AS RN ,

 *  FROM     [vw_Course_report] 
   Where
			(@BannerStudentName = '' OR BannerStudentName LIKE '%'+@BannerStudentName+'%' )
		AND (@BannerStudentIDNumber = '' OR BannerStudentIDNumber LIKE '%'+@BannerStudentIDNumber+'%') 
		AND (@TermCodeofProgramEnrollment = '' OR TermCodeofProgramEnrollment LIKE '%'+@TermCodeofProgramEnrollment+'%')
		AND (@CourseNumber = '' OR CourseNumber LIKE '%'+@CourseNumber+'%')
		AND (@CourseTitle = '' OR CourseTitle LIKE '%'+@CourseTitle+'%')
		AND (@FinalGrade = '' OR FinalGrade LIKE '%'+@FinalGrade+'%')
		AND (@TermCodeOfCourseEnrollment = '' OR TermCodeOfCourseEnrollment LIKE '%'+@TermCodeOfCourseEnrollment+'%') 
		AND (@MethodOfDelivery = '' OR MethodOfDelivery LIKE '%'+@MethodOfDelivery+'%')
		AND (@ImportDate='1/1/1900' OR ImportDate = @ImportDate) 
		AND (@CourseOID = 0 OR CourseOID = @CourseOID)
		AND (@FileCreationDate='1/1/1900' OR FileCreationDate = @FileCreationDate)
		AND (@FullTimeOrPartTimeIndicator = '' OR FullTimeOrPartTimeIndicator LIKE '%'+@FullTimeOrPartTimeIndicator+'%') 
 
  AND (CumulativeGPA>=@CumulativeGPA AND CumulativeGPA <=@CumulativeGPA1 ) 
 
AND (CreditsAttempted>=@CreditsAttempted and CreditsAttempted<=@CreditsAttempted1) 

AND( CreditsEarned>=@CreditsEarned and CreditsEarned<=@CreditsEarned1) 

 AND (LatestCompassPrealgebraTestScore >= @LatestCompassPrealgebraTestScore and LatestCompassPrealgebraTestScore <=@LatestCompassPrealgebraTestScore1 )
 AND (LatestCompassAlgebraTestScore >= @LatestCompassAlgebraTestScore and LatestCompassAlgebraTestScore <=@LatestCompassAlgebraTestScore1) 
 AND (LatestCompassWritingTestScore >= @LatestCompassWritingTestScore and LatestCompassWritingTestScore <=@LatestCompassWritingTestScore1)
 AND (LatestCompassReadingTestScore >= @LatestCompassReadingTestScore and LatestCompassReadingTestScore <=@LatestCompassReadingTestScore1) 
 AND (LatestACTEnglishAssessmentScore >= @LatestACTEnglishAssessmentScore and LatestACTEnglishAssessmentScore <=@LatestACTEnglishAssessmentScore1) 
 AND (LatestACTMathAssessmentScore >=@LatestACTMathAssessmentScore and LatestACTMathAssessmentScore <=@LatestACTMathAssessmentScore1) 
 AND (LatestACTReadingAssessmentScore >= @LatestACTReadingAssessmentScore and LatestACTReadingAssessmentScore <=@LatestACTReadingAssessmentScore1)
 AND (LatestACTScienceAssessmentScore >= @LatestACTScienceAssessmentScore and LatestACTScienceAssessmentScore <=@LatestACTScienceAssessmentScore1)

AND (@LatestTestingDate='1/1/1900' OR LatestTestingDate=@LatestTestingDate) 
AND (@HighSchoolName = '' OR HighSchoolName LIKE '%'+@HighSchoolName +'%' )
AND (@HighSchoolGraduationDate ='1/1/1900' OR HighSchoolGraduationDate=@HighSchoolGraduationDate) 
AND (@HomeTelephoneNumber = '' OR HomeTelephoneNumber LIKE '%'+@HomeTelephoneNumber +'%' )
AND (@MailingAddressLineOne = '' OR  MailingAddressLineOne LIKE '%'+@MailingAddressLineOne +'%' )
AND (@MailingAddressLineTwo = '' OR MailingAddressLineTwo LIKE '%'+@MailingAddressLineTwo +'%' )
AND (@MailingAddressLineThree = '' OR MailingAddressLineThree LIKE '%'+@MailingAddressLineThree +'%' )
AND (@City = '' OR City LIKE '%'+@City+'%' )
AND (@StateName = '' OR StateName LIKE '%'+@StateName +'%' )
AND (@ZipCode = '' OR ZipCode LIKE '%'+@ZipCode +'%') 
AND (@EmailAddress = '' OR EmailAddress LIKE '%'+@EmailAddress +'%' )
AND (@ImportDateFileCreationDate='1/1/1900'  OR ImportDateFileCreationDate =@ImportDateFileCreationDate ) 
 AND (@PreprogramIndicator = '' OR PreprogramIndicator LIKE '%'+@PreprogramIndicator +'%' )
 AND (@MajorProgramEnrollmentName = '' OR MajorProgramEnrollmentName LIKE '%'+@MajorProgramEnrollmentName +'%')   
   ) 
SELECT

* FROM    CTE
      --  WHERE    
       -- RN BETWEEN @StartRow - @NumberOfRows  AND  @StartRow - 1 
		                                         
		 END
GO
/****** Object:  StoredProcedure [dbo].[GetNoOfFlagByAOID1_NotUsed]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNoOfFlagByAOID1_NotUsed]
@AOID int

AS
BEGIN
SELECT     AssessmentOID, StudentOID, COUNT(*) AS FlagRating
FROM         (SELECT     dbo.Section.AssessmentOID, dbo.Section.SectionOID, dbo.Answer.StudentOID, dbo.Section.Flag, SUM(dbo.AnswerDetail.AnswerPoint) AS Total
                       FROM          dbo.Answer INNER JOIN
                                              dbo.AnswerDetail ON dbo.Answer.AnswerOID = dbo.AnswerDetail.AnswerOID INNER JOIN
                                              dbo.Section ON dbo.AnswerDetail.SectionOID = dbo.Section.SectionOID
                       WHERE dbo.Section.AssessmentOID = @AOID
                       GROUP BY dbo.Section.AssessmentOID, dbo.Section.SectionOID, dbo.Answer.StudentOID, dbo.Section.Flag
                       HAVING      (SUM(dbo.AnswerDetail.AnswerPoint) < dbo.Section.Flag)) AS A
GROUP BY AssessmentOID, StudentOID
END
GO
/****** Object:  View [dbo].[AnswerEval]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnswerEval]
AS
SELECT     dbo.Answer.AssessmentOID, dbo.AnswerDetail.SectionOID, dbo.AnswerDetail.QuestionOID, dbo.AnswerDetail.Response, 
                      COUNT(dbo.AnswerDetail.SectionOID) AS TotalResponse
FROM         dbo.Answer INNER JOIN
                      dbo.AnswerDetail ON dbo.Answer.AnswerOID = dbo.AnswerDetail.AnswerOID
GROUP BY dbo.Answer.AssessmentOID, dbo.AnswerDetail.SectionOID, dbo.AnswerDetail.QuestionOID, dbo.AnswerDetail.Response
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AnswerDetail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Answer"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 121
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AnswerEval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AnswerEval'
GO
/****** Object:  StoredProcedure [dbo].[AnswerDetail_insert]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AnswerDetail_insert]

@AnswerOID int, 
@SectionOID int,
@QuestionOID int, 
@Response varchar(100),
@AnswerPoint int,
@CreatedBy int 

AS
BEGIN

	INSERT INTO AnswerDetail( AnswerOID, SectionOID, QuestionOID, Response,AnswerPoint, CreatedBy)
	values( @AnswerOID, @SectionOID, @QuestionOID, @Response,@AnswerPoint, @CreatedBy)

END
GO
/****** Object:  StoredProcedure [dbo].[AnswerDetail_DeleteBySectionOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AnswerDetail_DeleteBySectionOID]
@SectionOID int 
AS

BEGIN

DELETE FROM AnswerDetail  
WHERE SectionOID = @SectionOID

END
GO
/****** Object:  StoredProcedure [dbo].[CorrectAnswer_ByAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CorrectAnswer_ByAOID]
@AOID int 
AS
BEGIN
	SELECT *
	FROM AnswerEval as t1
	WHERE assessmentOID=@AOID AND 0=(SELECT COUNT(*) 
				FROM AnswerEval t2 
				WHERE t1.SectionOID=t2.SectionOID 
				and t1.QuestionOID=t2.QuestionOID 
				and t2.TotalResponse>t1.TotalResponse)
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionDetails_DeleteByQuestionOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionDetails_DeleteByQuestionOID]
@QuestionOID int
AS

BEGIN

DELETE FROM QuestionResponse 
WHERE QuestionOID = @QuestionOID

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetRank]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetRank](@AOID int,@SOID int, @Score decimal)
RETURNS int
AS 	
BEGIN
	DECLARE @result decimal
	DECLARE @B int
	DECLARE @E int
	DECLARE @N int

	--SCORE Equal
	SET @E=(SELECT COUNT(SectionOID) AS E
	FROM dbo.SectionScore
	WHERE AssessmentOID=@AOID AND SectionOID=@SOID and Score=@Score)
	--SCORE Less
	SET @B=(SELECT COUNT(SectionOID) AS E
	FROM dbo.SectionScore
	WHERE AssessmentOID=@AOID AND SectionOID=@SOID and Score<@Score)
	--Number OF Score
	SET @N=(SELECT COUNT(SectionOID) AS N
	FROM dbo.SectionScore
	WHERE AssessmentOID=@AOID AND SectionOID=@SOID )
	
	SET @Result=((@B+0.5*@E)*100)/@N
	return @Result
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionResp_ByQOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionResp_ByQOID]
@QOID int

AS
BEGIN
	SELECT QuestionResponseOID, QuestionOID, Response, FlagRating, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
	FROM dbo.QuestionResponse
	WHERE QuestionOID=@QOID
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionResponse_Update]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionResponse_Update]
@QuestionResponseOID int,
@FlagRating int, 
@LastModifiedBy int,
@Response varchar(500)
AS
BEGIN
	UPDATE dbo.QuestionResponse
	SET  Response=@Response, FlagRating=@FlagRating, LastModifiedBy=@LastModifiedBy
	WHERE QuestionResponseOID=@QuestionResponseOID
END
GO
/****** Object:  StoredProcedure [dbo].[QuestionResponse_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionResponse_Insert]

@CreatedBy int, 
@FlagRating int, 
@LastModifiedBy int,
@QuestionOID int, 
@Response varchar(500)
AS
BEGIN
INSERT INTO dbo.QuestionResponse(QuestionOID, Response, FlagRating,  CreatedBy,  LastModifiedBy)
VALUES(@QuestionOID, @Response, @FlagRating,  @CreatedBy,  @LastModifiedBy)

END
GO
/****** Object:  UserDefinedFunction [dbo].[ScoreLess]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[ScoreLess](@AOID int,@SOID int, @Score int)
RETURNS int
AS 	
BEGIN
	DECLARE @result int
	SET @Result=(SELECT COUNT(SectionOID) AS E
	FROM dbo.SectionScore
	WHERE AssessmentOID=@AOID AND
	SectionOID=@SOID and Score<@Score)

	return @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[ScoreEqual]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[ScoreEqual](@AOID int,@SOID int, @Score int)
RETURNS int
AS 	
BEGIN
	DECLARE @result int
	SET @Result=(SELECT COUNT(SectionOID) AS E
	FROM dbo.SectionScore
	WHERE AssessmentOID=@AOID AND
	SectionOID=@SOID and Score=@Score)

	return @Result
END
GO
/****** Object:  StoredProcedure [dbo].[SectionWithNoScore_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SectionWithNoScore_ByAOID]
@AOID int,
@STDOID varchar(20)
AS
BEGIN

	SELECT SectionOID,Response, Keyword,SectionName,Question
	FROM dbo.NonScore
	WHERE AssessmentOID=@AOID and BannerStudentIDNumber=@STDOID

END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SECT_ASS]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UPDATE_SECT_ASS]

AS
BEGIN
	--UPDATE SECTION Table----------
	--Update Total Question
	UPDATE dbo.Section
	SET TotalQuestion=TotalQue
	FROM
	(
	SELECT SectionOID,COUNT(SectionOID) AS TotalQue
	FROM dbo.Question
	GROUP BY SectionOID
	) AS T
	WHERE T.SectionOID=Section.SectionOID


	-----Update Total Flag ------
	UPDATE dbo.Section
	SET TotalFlag=flgQuestion
	FROM
	(
	SELECT SectionOID,COUNT(SectionOID) flgQuestion
	FROM dbo.Question
	WHERE Question.QuestionOID in (SELECT QuestionOID FROM QuestionResponse WHERE FlagRating!=0)
	GROUP BY SectionOID
	)AS T
	WHERE T.SectionOID=Section.SectionOID


	--Update Total Flag POINT----
	UPDATE dbo.Section
	SET FlagPointTotal=TotalFlgPt
	FROM
	(
	SELECT SectionOID,SUM(FlagRating) AS TotalFlgPt
	FROM dbo.Question,QuestionResponse
	WHERE dbo.Question.QuestionOID=QuestionResponse.QuestionOID
	AND FlagRating!=0
	GROUP BY SectionOID
	) AS T
	WHERE T.SectionOID=Section.SectionOID


	------Update Assessment ASSESSMENT TABLE
	--UPDATE TotalSection
	UPDATE dbo.Assessment
	SET TotalSection= SectTotal
	FROM 
	(
	SELECT AssessmentOID,COUNT(AssessmentOID)AS SectTotal
	FROM dbo.Section
	GROUP BY AssessmentOID
	) AS T
	WHERE T.AssessmentOID=Assessment.AssessmentOID

	--TotalQuestion
	UPDATE dbo.Assessment
	SET TotalQuestion= TotalQue
	FROM 
	(
	SELECT AssessmentOID,SUM(TotalQuestion)AS TotalQue
	FROM dbo.Section
	GROUP BY AssessmentOID
	) AS T
	WHERE T.AssessmentOID=Assessment.AssessmentOID

	--TotalFlag
	UPDATE dbo.Assessment
	SET TotalFlag= TotFlg
	FROM 
	(
	SELECT AssessmentOID,SUM(TotalFlag)AS TotFlg
	FROM dbo.Section
	GROUP BY AssessmentOID
	) AS T
	WHERE T.AssessmentOID=Assessment.AssessmentOID

	--TotalFlagPoint
	UPDATE dbo.Assessment
	SET TotalFlagPoint= TotPointFlg
	FROM 
	(
	SELECT AssessmentOID,SUM(FlagPointTotal)AS TotPointFlg
	FROM dbo.Section
	GROUP BY AssessmentOID
	) AS T
	WHERE T.AssessmentOID=Assessment.AssessmentOID
END
GO
/****** Object:  View [dbo].[StudentScoreCount]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentScoreCount]
AS
SELECT     TOP (100) PERCENT AssessmentOID, COUNT(SectionOID) AS cnt, Score, SectionOID
FROM         dbo.SectionScore
GROUP BY AssessmentOID, Score, SectionOID
ORDER BY Score
GO
/****** Object:  View [dbo].[StudentResponseWithCorrectAnswer]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*   ORDER BY StdAnswer.StudentName,StdAnswer.SectionOID,StdAnswer.QuestionOID*/
CREATE VIEW [dbo].[StudentResponseWithCorrectAnswer]
AS
SELECT     StdAnswer.AssessmentOID, StdAnswer.BannerID, StdAnswer.StudentName, StdAnswer.SectionOID, StdAnswer.QuestionOID, StdAnswer.Response, 
                      CASE StdAnswer.Response WHEN CrrtAnswer.Response THEN '1' ELSE '0' END AS IsRight
FROM         (SELECT     dbo.Answer.AssessmentOID, dbo.Student.BannerStudentIDNumber AS BannerID, dbo.Student.BannerStudentName AS StudentName, 
                                              dbo.AnswerDetail.SectionOID, dbo.AnswerDetail.QuestionOID, dbo.AnswerDetail.Response
                       FROM          dbo.Answer INNER JOIN
                                              dbo.AnswerDetail ON dbo.Answer.AnswerOID = dbo.AnswerDetail.AnswerOID INNER JOIN
                                              dbo.Student ON dbo.Answer.StudentOID = dbo.Student.StudentOID) AS StdAnswer INNER JOIN
                          (SELECT     MAX(AssessmentOID) AS assessmentOID, SectionOID, QuestionOID, MAX(Response) AS Response, MAX(TotalResponse) 
                                                   AS TotalResponse
                            FROM          dbo.AnswerEval AS t1
                            WHERE      (0 =
                                                       (SELECT     COUNT(*) AS Expr1
                                                         FROM          dbo.AnswerEval AS t2
                                                         WHERE      (t1.SectionOID = SectionOID) AND (t1.QuestionOID = QuestionOID) AND (TotalResponse > t1.TotalResponse)))
                            GROUP BY SectionOID, QuestionOID) AS CrrtAnswer ON StdAnswer.AssessmentOID = CrrtAnswer.assessmentOID AND 
                      StdAnswer.SectionOID = CrrtAnswer.SectionOID AND StdAnswer.QuestionOID = CrrtAnswer.QuestionOID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CrrtAnswer"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 121
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StdAnswer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentResponseWithCorrectAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentResponseWithCorrectAnswer'
GO
/****** Object:  StoredProcedure [dbo].[StudentRespWithAnswer_ByAOID]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[StudentRespWithAnswer_ByAOID]
@AOID int
AS
BEGIN

SELECT StudentName,BannerID,SectionOID,QuestionOID,isRight,SUBSTRING(Response,0,LEN(Response)) AS Response
FROM 
(
SELECT DISTINCT STUFF( 
(
SELECT  distinct Response+', '
from dbo.StudentResponseWithCorrectAnswer as t 
WHERE  t.StudentName=t1.StudentName AND
t.SectionOID=t1.SectionOID AND
t.QuestionOID=t1.QuestionOID 
--GROUP BY AnswerOID
FOR XML PATH('')),1,0,''

) as Response,StudentName,BannerID,SectionOID,QuestionOID,isRight
FROM StudentResponseWithCorrectAnswer AS t1
WHERE  AssessmentOID=@AOID
) AS TMP
ORDER BY StudentName,SectionOID,QuestionOID


	
	
END
GO
/****** Object:  View [dbo].[SectionScoreResult]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SectionScoreResult]
AS
SELECT     TOP (100) PERCENT T1.AssessmentOID, T1.Score, T1.SectionOID, T.cnt AS N, T1.cnt AS E, T2.B
FROM         (SELECT     AssessmentOID, COUNT(SectionOID) AS cnt, Score, SectionOID
                       FROM          dbo.SectionScore
                       GROUP BY AssessmentOID, Score, SectionOID) AS T1 INNER JOIN
                          (SELECT     AssessmentOID, COUNT(SectionOID) AS cnt, SectionOID
                            FROM          dbo.SectionScore AS SectionScore_1
                            GROUP BY AssessmentOID, SectionOID) AS T ON T1.AssessmentOID = T.AssessmentOID AND T1.SectionOID = T.SectionOID INNER JOIN
                          (SELECT     dbo.StudentScoreCount.AssessmentOID, COUNT(dbo.StudentScoreCount.SectionOID) AS B, dbo.StudentScoreCount.SectionOID, 
                                                   dbo.StudentScoreCount.Score
                            FROM          dbo.SectionScore AS SectionScore_2 INNER JOIN
                                                   dbo.StudentScoreCount ON SectionScore_2.SectionOID = dbo.StudentScoreCount.SectionOID AND 
                                                   SectionScore_2.AssessmentOID = dbo.StudentScoreCount.AssessmentOID AND dbo.StudentScoreCount.Score > SectionScore_2.Score
                            GROUP BY dbo.StudentScoreCount.AssessmentOID, dbo.StudentScoreCount.SectionOID, dbo.StudentScoreCount.Score) AS T2 ON 
                      T2.AssessmentOID = T1.AssessmentOID AND T2.SectionOID = T1.SectionOID AND T2.Score = T1.Score
ORDER BY T1.Score
GO
/****** Object:  StoredProcedure [dbo].[GetStudentRankByOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetStudentRankByOID]
@SOID INT
AS
BEGIN
--	DECLARE @SOID INT
--	SET @SOID=1
	SELECT SScore.*,CASE WHEN SScore.Rank>=High THEN HighResult WHEN SScore.Rank>=Medium THEN MediumResult ELSE LowResult END Comment
	FROM
	(
	SELECT AssessmentOID,SectionOID,SectionName,Score,DBO.GetRank(AssessmentOID,SectionOID,Score) AS Rank
	FROM dbo.SectionScore
	WHERE StudentOID=@SOID
	) AS SScore,
	Section,dbo.AssessmentResultSectionComment
	WHERE SScore.SectionOID=Section.SectionOID AND SScore.SectionOID=AssessmentResultSectionComment.SectionOID


END
GO
/****** Object:  UserDefinedFunction [dbo].[GetRank1]    Script Date: 06/12/2012 20:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetRank1](@AOID int,@SOID int, @Score decimal)
RETURNS int
AS 	
BEGIN
	
 DECLARE @result decimal 
 SET @Result= (SELECT ROUND(CAST(ISNULL((SR.B + 0.5 * SR.E) * 100 / SR.N, 0) AS Decimal(10, 0)), 0) AS Rank FROM SectionScoreResult as SR
				 WHERE AssessmentOID=@AOID AND SectionOID=@SOID and Score=@Score)
return @Result

END
GO
/****** Object:  StoredProcedure [dbo].[GetStudentRankBySOIDandAOID]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetStudentRankBySOIDandAOID]
@SOID INT,
@AOID INT
AS
BEGIN
--	DECLARE @SOID INT
--	SET @SOID=1
	SELECT SScore.*,CASE WHEN SScore.Rank>=High THEN HighResult WHEN SScore.Rank>=Medium THEN MediumResult ELSE LowResult END Comment
	FROM
	(
	SELECT sr.AssessmentOID,sr.SectionOID,SectionName,sr.Score,ROUND(CAST(ISNULL((SR.B + 0.5 * SR.E) * 100 / SR.N, 0) AS Decimal(10, 0)), 0) AS Rank 
	FROM dbo.SectionScore INNER JOIN SectionScoreResult SR ON SectionScore.SectionOID = sr.SectionOID AND SectionScore.AssessmentOID = sr.AssessmentOID
	WHERE (SectionScore.StudentOID=@SOID AND SectionScore.AssessmentOID=@AOID)
	) AS SScore,
	Section,dbo.AssessmentResultSectionComment
	WHERE SScore.SectionOID=Section.SectionOID AND SScore.SectionOID=AssessmentResultSectionComment.SectionOID


END
GO
/****** Object:  View [dbo].[ScoreDetail]    Script Date: 06/12/2012 20:28:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScoreDetail]
AS
SELECT     t.AssessmentOID, t.SectionOID, t.SectionName + '_Score' AS ScoreName, t.SectionName + '_Rank' AS RankName, dbo.Student.StudentOID, 
                      dbo.Student.BannerStudentIDNumber AS BannerID, dbo.Student.BannerStudentName AS StudentName, dbo.Student.MajorProgramEnrollmentName AS Program, 
                      t.Score, ROUND(CAST(ISNULL((SR.B + 0.5 * SR.E) * 100 / SR.N, 0) AS Decimal(10, 0)), 0) AS Rank, t.Flag, t.CreatedDate, t.NumberOfPrinted, 
                      CASE WHEN t .Flag > ROUND(CAST(ISNULL((SR.B + 0.5 * SR.E) * 100 / SR. N, 0) AS Decimal(10, 2)), 0) THEN 1 ELSE 0 END AS NumberOfFlag, 
                      dbo.Student.TermCodeofProgramEnrollment, dbo.Student.FullTimeOrPartTimeIndicator, dbo.Student.CumulativeGPA, dbo.Student.CreditsAttempted, 
                      dbo.Student.CreditsEarned, dbo.Student.LatestCompassPrealgebraTestScore, dbo.Student.LatestCompassAlgebraTestScore, 
                      dbo.Student.LatestCompassWritingTestScore, dbo.Student.LatestCompassReadingTestScore, dbo.Student.LatestACTEnglishAssessmentScore, 
                      dbo.Student.LatestACTMathAssessmentScore, dbo.Student.LatestACTReadingAssessmentScore, dbo.Student.LatestACTScienceAssessmentScore, 
                      dbo.Student.LatestTestingDate, dbo.Student.HighSchoolName, dbo.Student.HighSchoolGraduationDate, dbo.Student.HomeTelephoneNumber, 
                      dbo.Student.MailingAddressLineOne, dbo.Student.MailingAddressLineTwo, dbo.Student.MailingAddressLineThree, dbo.Student.City, dbo.Student.StateName, 
                      dbo.Student.ZipCode, dbo.Student.EmailAddress, dbo.Student.ImportDateFileCreationDate, dbo.Student.PreprogramIndicator, dbo.Student.FileCreationDate, 
                      dbo.Student.ResultLetterSentTimes
FROM         dbo.SectionScore AS t INNER JOIN
                      dbo.Student ON t.StudentOID = dbo.Student.StudentOID LEFT OUTER JOIN
                      dbo.SectionScoreResult AS SR ON t.AssessmentOID = SR.AssessmentOID AND t.SectionOID = SR.SectionOID AND t.Score = SR.Score
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Student"
            Begin Extent = 
               Top = 6
               Left = 241
               Bottom = 309
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 22
         End
         Begin Table = "SR"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScoreDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScoreDetail'
GO
/****** Object:  StoredProcedure [dbo].[ScoreDetailTable_InsertNow]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ScoreDetailTable_InsertNow]
@AOID int
AS
BEGIN
	DELETE from ScoreDetailTable where ScoreDetailTable.AssessmentOID = @AOID;
	INSERT INTO ScoreDetailTable (	AssessmentOID,    SectionOID,    ScoreName,    RankName,   StudentOID,    
	BannerID,    StudentName,    Program,    Score,    [Rank],CreatedDate,NumberOfPrinted,
	NumberOfFlag,FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore,
	 LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, 
	 LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore,
	  LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, 
	  HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, 
	  StateName, ZipCode, EmailAddress)
	SELECT  AssessmentOID,    SectionOID,    ScoreName,    RankName,    StudentOID,    BannerID,    
	StudentName,    Program,    Score,    [Rank], CreatedDate,NumberOfPrinted,NumberOfFlag,
	FullTimeOrPartTimeIndicator, CumulativeGPA, CreditsAttempted, CreditsEarned, LatestCompassPrealgebraTestScore,
	 LatestCompassAlgebraTestScore, LatestCompassWritingTestScore, LatestCompassReadingTestScore, 
	 LatestACTEnglishAssessmentScore, LatestACTMathAssessmentScore, LatestACTReadingAssessmentScore,
	  LatestACTScienceAssessmentScore, LatestTestingDate, HighSchoolName, HighSchoolGraduationDate, 
	  HomeTelephoneNumber, MailingAddressLineOne, MailingAddressLineTwo, MailingAddressLineThree, City, 
	  StateName, ZipCode, EmailAddress
	
	
	FROM ScoreDetail
	WHERE  ScoreDetail.AssessmentOID = @AOID
END
GO
/****** Object:  StoredProcedure [dbo].[ScoreDetailTable_Insert]    Script Date: 06/12/2012 20:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ScoreDetailTable_Insert]

AS
BEGIN
declare @starthr int;
declare @endhr int;
-- set here start and end hours to execute this query 
set @starthr = 4;
set @endhr = 5;
--
declare @tstamp datetime;
declare @tstampstart datetime;
declare @tstampend datetime;
set @tstamp = dateadd(dd, datediff(dd, 0, getdate()), 0);
set @tstampstart =  dateadd(hh, @starthr, @tstamp);
set @tstampend =  dateadd(hh, @endhr, @tstamp);

if(getdate() >= @tstampstart and getdate() < @tstampend)
	BEGIN
	--EXEC [dbo].[ScoreDetailTable_InsertNow]
	DELETE from ScoreDetailTable;
	INSERT INTO ScoreDetailTable (	AssessmentOID,    SectionOID,    ScoreName,    RankName,   StudentOID,    BannerID,    StudentName,    Program,    Score,    [Rank])
	SELECT  AssessmentOID,    SectionOID,    ScoreName,    RankName,    StudentOID,    BannerID,    StudentName,    Program,    Score,    [Rank] FROM ScoreDetail 

	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetStudentRankBySOIDandAOID1_Print]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[GetStudentRankBySOIDandAOID1_Print]
@SOID INT,
@AOID INT
AS
BEGIN
--	DECLARE @SOID INT
--	SET @SOID=1

	SELECT SScore.*,CASE WHEN SScore.Rank>=Medium THEN HighResult WHEN (SScore.Rank>Low AND SScore.Rank<Medium ) THEN MediumResult ELSE LowResult END Comment
	FROM
	(
	SELECT sd.AssessmentOID,sd.SectionOID,SectionName,Score, Rank
	FROM dbo.ScoreDetail sd, Section s 
	WHERE (sd.SectionOID = s.SectionOID and StudentOID=@SOID AND sd.AssessmentOID=@AOID)
	) AS SScore,
	Section,dbo.AssessmentResultSectionComment
	WHERE SScore.SectionOID=Section.SectionOID 
	AND SScore.SectionOID=AssessmentResultSectionComment.SectionOID and SScore.SectionName!='NoScore'


END
GO
/****** Object:  StoredProcedure [dbo].[GetStudentRankBySOIDandAOID1]    Script Date: 06/12/2012 20:29:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetStudentRankBySOIDandAOID1]
@SOID INT,
@AOID INT
AS
BEGIN
--	DECLARE @SOID INT
--	SET @SOID=1

	SELECT SScore.*,CASE WHEN SScore.Rank>=Medium THEN HighResult WHEN (SScore.Rank>Low AND SScore.Rank<Medium ) THEN MediumResult ELSE LowResult END Comment
	FROM
	(
	SELECT sd.AssessmentOID,sd.SectionOID,SectionName,Score, Rank
	FROM dbo.ScoreDetail sd, Section s 
	WHERE (sd.SectionOID = s.SectionOID and StudentOID=@SOID AND sd.AssessmentOID=@AOID)
	) AS SScore,
	Section,dbo.AssessmentResultSectionComment
	WHERE SScore.SectionOID=Section.SectionOID AND SScore.SectionOID=AssessmentResultSectionComment.SectionOID


END
GO
/****** Object:  Default [DF_Answer_NumberOfPrinted]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Answer] ADD  CONSTRAINT [DF_Answer_NumberOfPrinted]  DEFAULT ((0)) FOR [NumberOfPrinted]
GO
/****** Object:  Default [DF_AnswerOfQuestion_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AnswerDetail] ADD  CONSTRAINT [DF_AnswerOfQuestion_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Assessment_TotalQuestion]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_TotalQuestion]  DEFAULT ((0)) FOR [TotalQuestion]
GO
/****** Object:  Default [DF_Assessment_TotalFlag]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_TotalFlag]  DEFAULT ((0)) FOR [TotalFlag]
GO
/****** Object:  Default [DF_Assessment_TotalFlagPoint]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_TotalFlagPoint]  DEFAULT ((0)) FOR [TotalFlagPoint]
GO
/****** Object:  Default [DF_Assessment_TotalSection]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_TotalSection]  DEFAULT ((0)) FOR [TotalSection]
GO
/****** Object:  Default [DF_Assessment_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Assessment_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Assessment_Locked]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_Locked]  DEFAULT ((0)) FOR [Locked]
GO
/****** Object:  Default [DF_Assessment_Status]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Assessment] ADD  CONSTRAINT [DF_Assessment_Status]  DEFAULT ('active') FOR [Status]
GO
/****** Object:  Default [DF_AssessmentResultEmail_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultEmail] ADD  CONSTRAINT [DF_AssessmentResultEmail_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_AssessmentResultEmail_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultEmail] ADD  CONSTRAINT [DF_AssessmentResultEmail_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_AssessmentResultLetter_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultLetter] ADD  CONSTRAINT [DF_AssessmentResultLetter_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_AssessmentResultLetter_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultLetter] ADD  CONSTRAINT [DF_AssessmentResultLetter_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_AssessmentResultSectionComment_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultSectionComment] ADD  CONSTRAINT [DF_AssessmentResultSectionComment_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_AssessmentResultSectionComment_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultSectionComment] ADD  CONSTRAINT [DF_AssessmentResultSectionComment_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_AssResultLetterSectionComment_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssResultLetterSectionComment] ADD  CONSTRAINT [DF_AssResultLetterSectionComment_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_AssResultLetterSectionComment_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssResultLetterSectionComment] ADD  CONSTRAINT [DF_AssResultLetterSectionComment_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Course_FileCreationDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF_Course_FileCreationDate]  DEFAULT (getdate()) FOR [FileCreationDate]
GO
/****** Object:  Default [DF_Domain_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Domain] ADD  CONSTRAINT [DF_Domain_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Domain_CreatedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Domain] ADD  CONSTRAINT [DF_Domain_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
/****** Object:  Default [DF_Domain_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Domain] ADD  CONSTRAINT [DF_Domain_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Domain_LastModifiedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Domain] ADD  CONSTRAINT [DF_Domain_LastModifiedBy]  DEFAULT ((0)) FOR [LastModifiedBy]
GO
/****** Object:  Default [DF_Intervention_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Intervention] ADD  CONSTRAINT [DF_Intervention_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Intervention_CreatedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Intervention] ADD  CONSTRAINT [DF_Intervention_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
/****** Object:  Default [DF_Intervention_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Intervention] ADD  CONSTRAINT [DF_Intervention_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Intervention_LastModifiedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Intervention] ADD  CONSTRAINT [DF_Intervention_LastModifiedBy]  DEFAULT ((0)) FOR [LastModifiedBy]
GO
/****** Object:  Default [DF_Menu_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_MessageCenter_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[MessageCenter] ADD  CONSTRAINT [DF_MessageCenter_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_MessageUser_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[MessageUser] ADD  CONSTRAINT [DF_MessageUser_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_NTO_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[NTO] ADD  CONSTRAINT [DF_NTO_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Prescription_RiskOID]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_RiskOID]  DEFAULT ((0)) FOR [RiskOID]
GO
/****** Object:  Default [DF_Prescription_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Prescription_CreatedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
/****** Object:  Default [DF_Prescription_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Prescription_LastModifiedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_LastModifiedBy]  DEFAULT ((0)) FOR [LastModifiedBy]
GO
/****** Object:  Default [DF_Prescription_Unread]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_Unread]  DEFAULT ('yes') FOR [Unread]
GO
/****** Object:  Default [DF_Prescription_AssessmentOID]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_AssessmentOID]  DEFAULT ((0)) FOR [AssessmentOID]
GO
/****** Object:  Default [DF_PrescriptionStatus_Status]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[PrescriptionStatus] ADD  CONSTRAINT [DF_PrescriptionStatus_Status]  DEFAULT ('Read') FOR [Status]
GO
/****** Object:  Default [DF_PrescriptionStatus_CreatedBy]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[PrescriptionStatus] ADD  CONSTRAINT [DF_PrescriptionStatus_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
/****** Object:  Default [DF_PrescriptionStatus_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[PrescriptionStatus] ADD  CONSTRAINT [DF_PrescriptionStatus_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Question_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Question_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_QuestionResponse_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[QuestionResponse] ADD  CONSTRAINT [DF_QuestionResponse_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_QuestionResponse_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[QuestionResponse] ADD  CONSTRAINT [DF_QuestionResponse_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Report_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Risk_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Risk] ADD  CONSTRAINT [DF_Risk_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Risk_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Risk] ADD  CONSTRAINT [DF_Risk_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_RiskCalculation_NumSection]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[RiskCalculation] ADD  CONSTRAINT [DF_RiskCalculation_NumSection]  DEFAULT ((0)) FOR [NumSection]
GO
/****** Object:  Default [DF_RiskCalculation_NumFlag]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[RiskCalculation] ADD  CONSTRAINT [DF_RiskCalculation_NumFlag]  DEFAULT ((0)) FOR [NumFlag]
GO
/****** Object:  Default [DF_RiskCalculation_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[RiskCalculation] ADD  CONSTRAINT [DF_RiskCalculation_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_ScoreDetailTable_CumulativeGPA]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[ScoreDetailTable] ADD  CONSTRAINT [DF_ScoreDetailTable_CumulativeGPA]  DEFAULT ((0)) FOR [CumulativeGPA]
GO
/****** Object:  Default [DF_ScoreDetailTable_CreditsAttempted]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[ScoreDetailTable] ADD  CONSTRAINT [DF_ScoreDetailTable_CreditsAttempted]  DEFAULT ((0)) FOR [CreditsAttempted]
GO
/****** Object:  Default [DF_ScoreDetailTable_CreditsEarned]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[ScoreDetailTable] ADD  CONSTRAINT [DF_ScoreDetailTable_CreditsEarned]  DEFAULT ((0)) FOR [CreditsEarned]
GO
/****** Object:  Default [DF_Section_TotalQuestion]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_TotalQuestion]  DEFAULT ((0)) FOR [TotalQuestion]
GO
/****** Object:  Default [DF_Section_PassingTotal]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_PassingTotal]  DEFAULT ((0)) FOR [PassingTotal]
GO
/****** Object:  Default [DF_Section_TotalFlag]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_TotalFlag]  DEFAULT ((0)) FOR [TotalFlag]
GO
/****** Object:  Default [DF_Section_FlagPointTotal]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_FlagPointTotal]  DEFAULT ((0)) FOR [FlagPointTotal]
GO
/****** Object:  Default [DF_Section_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_Section_LastModifiedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section] ADD  CONSTRAINT [DF_Section_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF_Student_CumulativeGPA]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_CumulativeGPA]  DEFAULT ((0)) FOR [CumulativeGPA]
GO
/****** Object:  Default [DF_Student_CreditsAttempted]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_CreditsAttempted]  DEFAULT ((0)) FOR [CreditsAttempted]
GO
/****** Object:  Default [DF_Student_CreditsEarned]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_CreditsEarned]  DEFAULT ((0)) FOR [CreditsEarned]
GO
/****** Object:  Default [DF_Student_LatestCompassPrealgebraTestScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestCompassPrealgebraTestScore]  DEFAULT ((0)) FOR [LatestCompassPrealgebraTestScore]
GO
/****** Object:  Default [DF_Student_LatestCompassAlgebraTestScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestCompassAlgebraTestScore]  DEFAULT ((0)) FOR [LatestCompassAlgebraTestScore]
GO
/****** Object:  Default [DF_Student_LatestCompassWritingTestScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestCompassWritingTestScore]  DEFAULT ((0)) FOR [LatestCompassWritingTestScore]
GO
/****** Object:  Default [DF_Student_LatestCompassReadingTestScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestCompassReadingTestScore]  DEFAULT ((0)) FOR [LatestCompassReadingTestScore]
GO
/****** Object:  Default [DF_Student_LatestACTEnglishAssessmentScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestACTEnglishAssessmentScore]  DEFAULT ((0)) FOR [LatestACTEnglishAssessmentScore]
GO
/****** Object:  Default [DF_Student_LatestACTMathAssessmentScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestACTMathAssessmentScore]  DEFAULT ((0)) FOR [LatestACTMathAssessmentScore]
GO
/****** Object:  Default [DF_Student_LatestACTReadingAssessmentScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestACTReadingAssessmentScore]  DEFAULT ((0)) FOR [LatestACTReadingAssessmentScore]
GO
/****** Object:  Default [DF_Student_LatestACTScienceAssessmentScore]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestACTScienceAssessmentScore]  DEFAULT ((0)) FOR [LatestACTScienceAssessmentScore]
GO
/****** Object:  Default [DF_Student_LatestTestingDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_LatestTestingDate]  DEFAULT (getdate()) FOR [LatestTestingDate]
GO
/****** Object:  Default [DF_Student_HighSchoolGraduationDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_HighSchoolGraduationDate]  DEFAULT (getdate()) FOR [HighSchoolGraduationDate]
GO
/****** Object:  Default [DF_Student_ImportDateFileCreationDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_ImportDateFileCreationDate]  DEFAULT (getdate()) FOR [ImportDateFileCreationDate]
GO
/****** Object:  Default [DF__Student__FileCre__4AB81AF0]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF__Student__FileCre__4AB81AF0]  DEFAULT (getdate()) FOR [FileCreationDate]
GO
/****** Object:  Default [DF_Student_BirthDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_BirthDate]  DEFAULT (getdate()) FOR [BirthDate]
GO
/****** Object:  Default [DF_Task_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_TaskUser_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[TaskUser] ADD  CONSTRAINT [DF_TaskUser_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_User_CreatedDate]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  ForeignKey [FK_Answer_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Assessment]
GO
/****** Object:  ForeignKey [FK_AnswerOfQuestion_Answer]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AnswerDetail]  WITH CHECK ADD  CONSTRAINT [FK_AnswerOfQuestion_Answer] FOREIGN KEY([AnswerOID])
REFERENCES [dbo].[Answer] ([AnswerOID])
GO
ALTER TABLE [dbo].[AnswerDetail] CHECK CONSTRAINT [FK_AnswerOfQuestion_Answer]
GO
/****** Object:  ForeignKey [FK_AnswerOfQuestion_Section]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AnswerDetail]  WITH CHECK ADD  CONSTRAINT [FK_AnswerOfQuestion_Section] FOREIGN KEY([SectionOID])
REFERENCES [dbo].[Section] ([SectionOID])
GO
ALTER TABLE [dbo].[AnswerDetail] CHECK CONSTRAINT [FK_AnswerOfQuestion_Section]
GO
/****** Object:  ForeignKey [FK_AssessmentReminderEmail_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentReminderEmail]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentReminderEmail_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[AssessmentReminderEmail] CHECK CONSTRAINT [FK_AssessmentReminderEmail_Assessment]
GO
/****** Object:  ForeignKey [FK_AssessmentResultEmail_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultEmail]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentResultEmail_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[AssessmentResultEmail] CHECK CONSTRAINT [FK_AssessmentResultEmail_Assessment]
GO
/****** Object:  ForeignKey [FK_AssessmentResultLetter_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultLetter]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentResultLetter_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[AssessmentResultLetter] CHECK CONSTRAINT [FK_AssessmentResultLetter_Assessment]
GO
/****** Object:  ForeignKey [FK_AssessmentResultSectionComment_AssessmentResultEmail]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultSectionComment]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentResultSectionComment_AssessmentResultEmail] FOREIGN KEY([AssessmentResultOID])
REFERENCES [dbo].[AssessmentResultEmail] ([AssessmentResultOID])
GO
ALTER TABLE [dbo].[AssessmentResultSectionComment] CHECK CONSTRAINT [FK_AssessmentResultSectionComment_AssessmentResultEmail]
GO
/****** Object:  ForeignKey [FK_AssessmentResultSectionComment_Section]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssessmentResultSectionComment]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentResultSectionComment_Section] FOREIGN KEY([SectionOID])
REFERENCES [dbo].[Section] ([SectionOID])
GO
ALTER TABLE [dbo].[AssessmentResultSectionComment] CHECK CONSTRAINT [FK_AssessmentResultSectionComment_Section]
GO
/****** Object:  ForeignKey [FK_AssResultLetterSectionComment_AssessmentResultLetter]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssResultLetterSectionComment]  WITH CHECK ADD  CONSTRAINT [FK_AssResultLetterSectionComment_AssessmentResultLetter] FOREIGN KEY([AssessmentLetterOID])
REFERENCES [dbo].[AssessmentResultLetter] ([AssessmentResultLetter])
GO
ALTER TABLE [dbo].[AssResultLetterSectionComment] CHECK CONSTRAINT [FK_AssResultLetterSectionComment_AssessmentResultLetter]
GO
/****** Object:  ForeignKey [FK_AssResultLetterSectionComment_Section]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[AssResultLetterSectionComment]  WITH CHECK ADD  CONSTRAINT [FK_AssResultLetterSectionComment_Section] FOREIGN KEY([SectionOID])
REFERENCES [dbo].[Section] ([SectionOID])
GO
ALTER TABLE [dbo].[AssResultLetterSectionComment] CHECK CONSTRAINT [FK_AssResultLetterSectionComment_Section]
GO
/****** Object:  ForeignKey [FK_Question_Section]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Section] FOREIGN KEY([SectionOID])
REFERENCES [dbo].[Section] ([SectionOID])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Section]
GO
/****** Object:  ForeignKey [FK_QuestionResponse_Question]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[QuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_QuestionResponse_Question] FOREIGN KEY([QuestionOID])
REFERENCES [dbo].[Question] ([QuestionOID])
GO
ALTER TABLE [dbo].[QuestionResponse] CHECK CONSTRAINT [FK_QuestionResponse_Question]
GO
/****** Object:  ForeignKey [FK_Risk_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Risk]  WITH CHECK ADD  CONSTRAINT [FK_Risk_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[Risk] CHECK CONSTRAINT [FK_Risk_Assessment]
GO
/****** Object:  ForeignKey [FK_RiskCalculation_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[RiskCalculation]  WITH CHECK ADD  CONSTRAINT [FK_RiskCalculation_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[RiskCalculation] CHECK CONSTRAINT [FK_RiskCalculation_Assessment]
GO
/****** Object:  ForeignKey [FK_Section_Assessment]    Script Date: 06/12/2012 20:28:49 ******/
ALTER TABLE [dbo].[Section]  WITH CHECK ADD  CONSTRAINT [FK_Section_Assessment] FOREIGN KEY([AssessmentOID])
REFERENCES [dbo].[Assessment] ([AssessmentOID])
GO
ALTER TABLE [dbo].[Section] CHECK CONSTRAINT [FK_Section_Assessment]
GO
SET IDENTITY_INSERT [dbo].[Menu] ON
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (1, N'Home', 1, N'home.aspx', 0, 0, 1, 1, CAST(0x00009EE000F313BC AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (2, N'Student/Course Database', 2, N' ', 0, 0, 0, 0, CAST(0x00009EE000F38C70 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (3, N'Student', 3, N'pg/student/student.aspx', 1, 2, 1, 1, CAST(0x00009EE000F44CA0 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (4, N'Course', 4, N'pg/student/course.aspx', 1, 2, 1, 1, CAST(0x00009EE000F483B4 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (5, N'Interventions', 5, N' pg/intervention/ViewIntervention.aspx', 0, 0, 1, 1, CAST(0x00009EE000F542B8 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (6, N'Reports', 6, N'pg/report/BlankReport.aspx', 0, 0, 0, 0, CAST(0x00009EE000F57AF8 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (14, N'Messages', 14, N' ', 0, 0, 0, 0, CAST(0x00009EE000F6C0C0 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (15, N'Task Inbox', 15, N'pg/message/MessageManagement.aspx', 1, 14, 1, 1, CAST(0x00009EE000F6D95C AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (16, N'Sent', 16, N'pg/message/MessageSent.aspx', 1, 14, 1, 1, CAST(0x00009EE000F7164C AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (17, N'Trash', 17, N'pg/message/MessageTrash.aspx', 1, 14, 1, 1, CAST(0x00009EE000F7290C AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (19, N'Tasks', 19, N' ', 0, 0, 0, 0, CAST(0x00009EE000F76AAC AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (20, N'View All', 20, N'pg/task/ViewTask.aspx', 1, 19, 1, 1, CAST(0x00009EE000F78DD4 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (21, N'Sent', 21, N'pg/task/taskSent.aspx', 1, 19, 1, 1, CAST(0x00009EE000F7B354 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (22, N'Completed', 22, N'pg/task/TaskCompleted.aspx', 1, 19, 1, 1, CAST(0x00009EE000F7CF74 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (24, N'Assessments', 24, N' ', 0, 0, 0, 0, CAST(0x00009EE000F83B44 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (25, N'Create or Edit', 25, N'pg/assessment/createAssessment.aspx', 1, 24, 1, 1, CAST(0x00009EE000F86574 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (26, N'Imports', 78, N' ', 0, 0, 0, 0, CAST(0x00009EE000FC0210 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (27, N'MC', 79, N'pg/import/mc.aspx', 1, 78, 1, 1, CAST(0x00009EE000FC3924 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (28, N'NTO', 80, N'pg/import/nto.aspx', 1, 78, 1, 1, CAST(0x00009EE000FC5418 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (29, N'PELL', 81, N'pg/import/pell.aspx', 1, 78, 1, 1, CAST(0x00009EE000FC7D1C AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (30, N'ALLERTS', 82, N'pg/import/allerts.aspx', 1, 78, 1, 1, CAST(0x00009EE000FCA044 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (31, N'RVP', 83, N'pg/import/rvp.aspx', 1, 78, 1, 1, CAST(0x00009EE000FCBFE8 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (32, N'User Management', 84, N'pg/user/User.aspx', 0, 0, 1, 1, CAST(0x00009EE000FCE310 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (34, N'Calendar', 86, N'pg/calendar/calendar.aspx', 0, 0, 1, 1, CAST(0x00009EE000FD41FC AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (36, N'View Prescription Choices', 88, N'pg/intervention/AddIntervention.aspx', 0, 0, 1, 1, CAST(0x00009EE000FD41FC AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (89, N'Add/Edit Prescription Choices', 100, N'pg/intervention/AddDomainIntervention.aspx', 0, 0, 1, 1, CAST(0x00009F81001FDAF8 AS DateTime))
INSERT [dbo].[Menu] ([OID], [NameMenu], [MenuID], [URL], [MenuLevel], [Parent], [IsLeave], [IsExpanded], [CreatedDate]) VALUES (454, N'Pending Student', 101, N'pg/student/Pendingstudent.aspx', 0, 0, 1, 0, CAST(0x00009FEC007FD0C5 AS DateTime))
SET IDENTITY_INSERT [dbo].[Menu] OFF
go
SET IDENTITY_INSERT [dbo].[User] ON
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (1, N'admin', N'admin', N'admin', N'admin', N'512-454-1000', N'admin@yahoo.com', N'No', CAST(0x00009EBB0117BFA0 AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (2, N'rcbryantii', N'password', N'Bryant', N'Richard', N'512-454-1000', N'rbryant@ict-consultants.com', N'Yes', CAST(0x00009F7B00BEFDB2 AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (7, N'norm', N'norm', N'Postell', N'Norm', N'830-5584', N'npostell@cvtc.edu', N'Yes', CAST(0x00009FAB00A0323F AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (8, N'pcampbell4', N'admin', N'Campbell', N'Trish', N'716-833-6341', N'pcampbell4@cvtc.edu', N'Yes', CAST(0x00009FEC00B8A614 AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (9, N'Kim', N'admin', N'Nimsgern', N'Kim', N'715-831-7221', N'knimsgern@cvtc.edu', N'Yes', CAST(0x00009FEC00B8F81A AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (13, N'richard', N'cujodog', N'Bryant', N'Richard', N'512-454-1000', N'rbryant@ict-consultants.com', N'Yes', CAST(0x0000A03200F1C47F AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (14, N'sumon', N'sumon', N'', N'', N'', N'sa@yahoo.com', N'No', CAST(0x0000A044008F18D9 AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (15, N'ppalser', N'green1', N'Palser', N'Phil', N'', N'ppalser@cvtc.edu', N'Yes', CAST(0x0000A04E00847205 AS DateTime), N'Yes', NULL)
INSERT [dbo].[User] ([UserOID], [UserName], [Password], [LastName], [FirstName], [Phone], [Email], [Advocacy], [CreatedDate], [Freez], [Status]) VALUES (16, N'mominul', N'mominul', N'Islam', N'Mominul', N'+8801913051196', N'mominul@sure-soft.com', N'Yes', CAST(0x0000A05300AF0F59 AS DateTime), N'Yes', NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
go
