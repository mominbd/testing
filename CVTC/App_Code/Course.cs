﻿using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Data.Odbc;

/// <summary>
/// Summary description for Course
/// </summary>
public class Course
{
    string connectionString;
	public Course()
	{
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
	}
     #region Public Properties for Course
    public int CourseOID
    { get; set; }

    public string BannerStudentName
    { get; set; }

    public string BannerStudentIDNumber
    { get; set; }

    public string TermCodeofProgramEnrollment
    { get; set; }

    public string CourseNumber
    { get; set; }

    public string CourseTitle
    { get; set; }

    public string FinalGrade
    { get; set; }

     public string TermCodeOfCourseEnrollment
    { get; set; }

    public string MethodOfDelivery
    { get; set; }
       
    public DateTime ImportDate
    { get; set; }

    public DateTime FileCreationDate
    { get; set; }
      #endregion

     #region Public Properties for Student

    public int RowID
    { get; set; }

    public int StudentOID
    { get; set; }



    public string FullName
    { get; set; }

    public string StudentID
    { get; set; }

    public string ProgramEnrollment
    { get; set; }

    public string TimeIndicator
    { get; set; }

    public double CumulativeGPA
    { get; set; }

    public double CreditAttempted
    { get; set; }

    public double CreditEarned
    { get; set; }

    public string PrealgebraTestScore
    { get; set; }

    public string CompassalgebraTestScore
    { get; set; }

    public string CompassWrittingTestScore
    { get; set; }

    public string CompassReadingTestScore
    { get; set; }

    public string EnglishAssessmentScore
    { get; set; }

    public string MathAssessmentScore
    { get; set; }

    public string ReadingAssessmentScore
    { get; set; }

    public string ScienceAssessmentScore
    { get; set; }

    public DateTime LatestTestingDate
    { get; set; }

    public string HighSchoolName
    { get; set; }

    public DateTime HighSchoolGraduationDate
    { get; set; }

    public string HomeTelephoneNumber
    { get; set; }

    public string AddressOne
    { get; set; }

    public string AddressTwo
    { get; set; }

    public string AddressThree
    { get; set; }

    public string City
    { get; set; }

    public string State
    { get; set; }

    public string ZIPCode
    { get; set; }

    public string EmailAddress
    { get; set; }

    public DateTime ImportDate_Student
    { get; set; }

    public string PreprogramIndicator
    { get; set; }

    public string MajorProgramEnrollment
    { get; set; }

    public DateTime FileCreatedDate
    { get; set; }
    public string NTO
    { get; set; }

    public string MC
    { get; set; }

    public string PELL
    { get; set; }

    public string RVP
    { get; set; }

    public string ALLERT
    { get; set; }

    public int ResultLetterSentTimes
    { get; set; }

    public string Status
    { get; set; }

    public string LastName
    { get; set; }

    public string FirstName
    {
        get;
        set;
    }

    public string MiddleName
    {
        get;
        set;
    }

    public Nullable<DateTime> BirthDate
    {
        get;
        set;
    }

    public string PriorCreditQuestion
    {
        get;
        set;
    }
    #endregion

     public Collection<Course> GetCourseByCourseOID(int COID)
    {
        Collection<Course> courseList = new Collection<Course>();
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Course_ByCourseOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@COID", COID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    //Question q = new Question();
                    Course  course;
                    while (dataReader.Read())
                    {
                        course = new Course();
                        course.CourseOID = Convert.ToInt32(dataReader["CourseOID"]);
                        course .BannerStudentName = Convert.ToString(dataReader["BannerStudentName"]);
                        course .BannerStudentIDNumber = Convert.ToString(dataReader["BannerStudentIDNumber"]);
                        course .TermCodeofProgramEnrollment = Convert.ToString(dataReader["TermCodeofProgramEnrollment"]);
                        course .CourseNumber = Convert.ToString(dataReader["CourseNumber"]);
                        course .CourseTitle = Convert.ToString(dataReader["CourseTitle"]);
                        course .FinalGrade = Convert.ToString(dataReader["FinalGrade"]);
                        course .TermCodeOfCourseEnrollment = Convert.ToString(dataReader["TermCodeOfCourseEnrollment"]);
                        course .MethodOfDelivery = Convert.ToString(dataReader["MethodOfDelivery"]);
                        course .ImportDate= Convert.ToDateTime(dataReader["ImportDate"]);
                        course.FileCreationDate = Convert.ToDateTime(dataReader["FileCreationDate"]);
                        courseList.Add(course);
                         
                    }
                }

            }
        }
        return courseList;
    }

     public Collection<Course> GetCourseByStudentOID(string SOID)
     {
         //Course course;
         Collection<Course> courseList = new Collection<Course>();
         using (OdbcConnection connection = new OdbcConnection(connectionString))
         {
             using (OdbcCommand command = new OdbcCommand())
             {

                 command.Connection = connection;
                 command.CommandText = "{CALL Course_ByStudentOID(?)}";
                 command.CommandType = CommandType.StoredProcedure;

                 //Set Parameter Value
                 command.Parameters.AddWithValue("@SOID", SOID);

                 //OdbcParameter paramPageIndex = new OdbcParameter("@PageIndex", OdbcType.Int);
                 //paramPageIndex.Value = Convert.ToInt32(pageIndex);
                 //command.Parameters.Add(paramPageIndex);

                 //OdbcParameter paramNumberOfRows = new OdbcParameter("@NumberOfRows", OdbcType.Int);
                 //paramNumberOfRows.Value = Convert.ToInt32(numberOfRows);
                 //command.Parameters.Add(paramNumberOfRows);

                 //Open connection
                 connection.Open();
                 //Read using reader
                 using (OdbcDataReader dataReader = command.ExecuteReader())
                 {
                     //Question q = new Question();
                     Course course;
                     while (dataReader.Read())
                     {
                         course = new Course();
                         course.CourseOID = Convert.ToInt32(dataReader["CourseOID"]);
                         course.BannerStudentName = Convert.ToString(dataReader["BannerStudentName"]);
                         course.BannerStudentIDNumber = Convert.ToString(dataReader["BannerStudentIDNumber"]);
                         course.TermCodeofProgramEnrollment = Convert.ToString(dataReader["TermCodeofProgramEnrollment"]);
                         course.CourseNumber = Convert.ToString(dataReader["CourseNumber"]);
                         course.CourseTitle = Convert.ToString(dataReader["CourseTitle"]);
                         course.FinalGrade = Convert.ToString(dataReader["FinalGrade"]);
                         course.TermCodeOfCourseEnrollment = Convert.ToString(dataReader["TermCodeOfCourseEnrollment"]);
                         course.MethodOfDelivery = Convert.ToString(dataReader["MethodOfDelivery"]);
                         course.ImportDate = Convert.ToDateTime(dataReader["ImportDate"]);
                         course.FileCreationDate = Convert.ToDateTime(dataReader["FileCreationDate"]);
                         courseList.Add(course);

                     }
                 }

             }
         }
         return courseList;
     }

     public Collection<Course> GetAllCourseByCourseOID()
     {
         Collection<Course> courseList = new Collection<Course>();
         using (OdbcConnection connection = new OdbcConnection(connectionString))
         {
             using (OdbcCommand command = new OdbcCommand())
             {

                 command.Connection = connection;
                 command.CommandText = "AllCourse_ByCourseOID";
                 command.CommandType = CommandType.StoredProcedure;

                 //Set Parameter Value
                 //command.Parameters.AddWithValue("@COID", COID);
                 //Open connection
                 connection.Open();
                 //Read using reader
                 using (OdbcDataReader dataReader = command.ExecuteReader())
                 {
                     //Question q = new Question();
                     Course course;
                     while (dataReader.Read())
                     {
                         course = new Course();
                         course.CourseOID = Convert.ToInt32(dataReader["CourseOID"]);
                         course.BannerStudentName = Convert.ToString(dataReader["BannerStudentName"]);
                         course.BannerStudentIDNumber = Convert.ToString(dataReader["BannerStudentIDNumber"]);
                         course.TermCodeofProgramEnrollment = Convert.ToString(dataReader["TermCodeofProgramEnrollment"]);
                         course.CourseNumber = Convert.ToString(dataReader["CourseNumber"]);
                         course.CourseTitle = Convert.ToString(dataReader["CourseTitle"]);
                         course.FinalGrade = Convert.ToString(dataReader["FinalGrade"]);
                         course.TermCodeOfCourseEnrollment = Convert.ToString(dataReader["TermCodeOfCourseEnrollment"]);
                         course.MethodOfDelivery = Convert.ToString(dataReader["MethodOfDelivery"]);
                         course.ImportDate = Convert.ToDateTime(dataReader["ImportDate"]);
                         course.FileCreationDate = Convert.ToDateTime(dataReader["FileCreationDate"]);
                         courseList.Add(course);

                     }
                 }

             }
         }
         return courseList;
     }

     public bool UpdateCourse(Course course)
     { 
     bool result = false;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                //command.Connection = connection;
                ////command.CommandText = "UPDATE dbo.Users SET " + "UserName='" + userName + "', " + " FirstName='" + firstName + "', " + " MiddleName='" + middleName + "'," + "LastName='" + lastName + "'," + "EmailID='" + emailID + "'" + " where UserID='" + userid + "' ";
                //command.CommandText = "INSERT INTO Users (UserName, FirstName, LastName, MiddleName, EmailID) VALUES (" + "'" + userName + "','" + firstName + "','" + lastName + "','" + middleName + "','" + emailID + "')";
                //connection.Open();
                //command.ExecuteNonQuery();

                command.Connection = connection;
                command.CommandText = "{CALL Course_Update(?,?,?,?,?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;


                command.Parameters.AddWithValue("@CourseOID", course.CourseOID);
                command.Parameters.AddWithValue("@BannerStudentName", course.BannerStudentName);
                command.Parameters.AddWithValue("@BannerStudentIDNumber", course.BannerStudentIDNumber);
                command.Parameters.AddWithValue("@TermCodeofProgramEnrollment", course.TermCodeofProgramEnrollment);
                command.Parameters.AddWithValue("@CourseNumber", course.CourseNumber);
                command.Parameters.AddWithValue("@CourseTitle", course.CourseTitle);
                command.Parameters.AddWithValue("@FinalGrade", course.FinalGrade);
                command.Parameters.AddWithValue("@TermCodeOfCourseEnrollment", course.TermCodeOfCourseEnrollment);
                command.Parameters.AddWithValue("@MethodOfDelivery", course.MethodOfDelivery);
                command.Parameters.AddWithValue("@ImportDate", course.ImportDate);

                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
            }
        }

        return result;
     }

         
}
