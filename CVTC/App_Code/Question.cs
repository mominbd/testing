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
using System.Data;
using System.Data.SqlClient;
using System.Data.Odbc;


/// <summary>
/// Summary description for Question
/// </summary>
    #region Section Class
    public class Section
{
    string connectionString;
    public Section()
    {
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
    }

    #region Public Properties
    
    public int SectionOID
    { get; set; }

    public int AssessmentOID
    { get; set; }

    public string SectionName
    { get; set; }

    public int TotalQuestion
    { get; set; }

    public int PassingTotal
    { get; set; }

    public int TotalFlag
    { get; set; }

    public int FlagPointTotal
    { get; set; }

    public int Flag
    { get; set; }

    public int Low
    { get; set; }

    public int Medium
    { get; set; }

    public int High
    { get; set; }

    public DateTime CreatedDate
    { get; set; }

    public int CreatedBy
    { get; set; }

    public DateTime LastModifiedDate
    { get; set; }

    public int LastModifiedBy
    { get; set; }


   

   
    public Collection<Question> QuestionList
    { get; set; }

    #endregion


    public bool AddSection()
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
                command.CommandText = "{CALL Section_Insert(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;


                OdbcParameter returnParam = command.Parameters.Add("@SectionOID", OdbcType.Int);
                // set the direction flag so that it will be filled with the return value
                returnParam.Direction = ParameterDirection.ReturnValue;

                //command.Parameters.AddWithValue("@SectionOID",this.SectionOID);
                command.Parameters.AddWithValue("@AssessmentOID", this.AssessmentOID);
                command.Parameters.AddWithValue("@SectionName", this.SectionName);
                command.Parameters.AddWithValue("@TotalQuestion", this.TotalQuestion);
                command.Parameters.AddWithValue("@PassingTotal", this.PassingTotal);
                command.Parameters.AddWithValue("@TotalFlag", this.TotalFlag);
                command.Parameters.AddWithValue("@FlagPointTotal", this.FlagPointTotal);
                command.Parameters.AddWithValue("@Flag", this.Flag);
                command.Parameters.AddWithValue("@Low", this.Low);
                command.Parameters.AddWithValue("@Medium", this.Medium);
                command.Parameters.AddWithValue("@High", this.High);
                command.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
                command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);
                

                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
                SectionOID = (int)command.Parameters["@SectionOID"].Value;
                if (QuestionList != null)
                {
                    foreach (Question q in QuestionList)
                    {
                        q.SectionOID = SectionOID;
                        q.AddQuestion();

                    }
                }

                
            }
        }

        return result;
    }

    public bool UpdateSection()
    { 
        bool result = false;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {               

                command.Connection = connection;
                command.CommandText = "{CALL Section_Update(?,?,?,?,?,?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@SectionOID", this.SectionOID);
                command.Parameters.AddWithValue("@SectionName", this.SectionName);                
                command.Parameters.AddWithValue("@TotalQuestion", this.TotalQuestion);
                command.Parameters.AddWithValue("@PassingTotal", this.PassingTotal);
                command.Parameters.AddWithValue("@TotalFlag", this.TotalFlag);
                command.Parameters.AddWithValue("@FlagPointTotal", this.FlagPointTotal);
                command.Parameters.AddWithValue("@Flag", this.Flag);
                command.Parameters.AddWithValue("@Low", this.Low);
                command.Parameters.AddWithValue("@Medium", this.Medium);
                command.Parameters.AddWithValue("@High", this.High);                
                command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);


                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
                

                foreach (Question q in QuestionList)
                {
                    if (q.QuestionOID == 0)
                    {
                        q.SectionOID = SectionOID;
                        q.AddQuestion();
                    }
                    else
                    {
                        q.SectionOID = SectionOID;
                        q.UpdateQuestion();
                    }

                }
            }
        }

        return result;
    }

public Collection<Section> GetSectionByAssessmentOID(int AOID)
    {
        Collection<Section> sectionList = new Collection<Section>();
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {                

                command.Connection = connection;
                command.CommandText = "{CALL Section_ByAssessmentOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@AOID",AOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    Question q = new Question();
                    Section section;
                    while (dataReader.Read())
                    {
                        section=new Section();
                        section.SectionOID=Convert.ToInt32(dataReader["SectionOID"]);
                        section.AssessmentOID=Convert.ToInt32(dataReader["AssessmentOID"]);
                        section.CreatedBy=Convert.ToInt32(dataReader["CreatedBy"]);
                        section.CreatedDate=Convert.ToDateTime(dataReader["CreatedDate"]);
                        section.FlagPointTotal=Convert.ToInt32(dataReader["FlagPointTotal"]);
                        section.LastModifiedBy=Convert.ToInt32(dataReader["LastModifiedBy"]);
                        section.LastModifiedDate=Convert.ToDateTime(dataReader["LastModifiedDate"]);
                        section.PassingTotal=Convert.ToInt32(dataReader["PassingTotal"]);
                        section.SectionName=Convert.ToString(dataReader["SectionName"]);
                        section.TotalFlag=Convert.ToInt32(dataReader["TotalFlag"]);
                        section.TotalQuestion=Convert.ToInt32(dataReader["TotalQuestion"]);
                        section.Flag = (dataReader["Flag"]==null)?0:Convert.ToInt32(dataReader["Flag"]);
                        section.Low = (dataReader["Low"] == null) ? 0 : Convert.ToInt32(dataReader["Low"]);
                        section.Medium = (dataReader["Medium"] == null) ? 0 : Convert.ToInt32(dataReader["Medium"]);
                        section.High = (dataReader["High"] == null) ? 0 : Convert.ToInt32(dataReader["High"]);
                        //Get Question By SectionOID
                        section.QuestionList = q.GetQuestionBySectionOID(section.SectionOID);
                        sectionList.Add(section);
                        
                    }
                }
         
            }
        }
        return sectionList;
    }

    public Collection<Section> GetSectionByAssessmentOID_ResultEmail(int AOID)
    {
        Collection<Section> sectionList = new Collection<Section>();
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {                

                command.Connection = connection;
                command.CommandText = "{CALL Section_ByAssessmentOID_ResultEmail(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@AOID",AOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    Question q = new Question();
                    Section section;
                    while (dataReader.Read())
                    {
                        section=new Section();
                        section.SectionOID=Convert.ToInt32(dataReader["SectionOID"]);
                        section.AssessmentOID=Convert.ToInt32(dataReader["AssessmentOID"]);
                        section.CreatedBy=Convert.ToInt32(dataReader["CreatedBy"]);
                        section.CreatedDate=Convert.ToDateTime(dataReader["CreatedDate"]);
                        section.FlagPointTotal=Convert.ToInt32(dataReader["FlagPointTotal"]);
                        section.LastModifiedBy=Convert.ToInt32(dataReader["LastModifiedBy"]);
                        section.LastModifiedDate=Convert.ToDateTime(dataReader["LastModifiedDate"]);
                        section.PassingTotal=Convert.ToInt32(dataReader["PassingTotal"]);
                        section.SectionName=Convert.ToString(dataReader["SectionName"]);
                        section.TotalFlag=Convert.ToInt32(dataReader["TotalFlag"]);
                        section.TotalQuestion=Convert.ToInt32(dataReader["TotalQuestion"]);
                        section.Flag = (dataReader["Flag"]==null)?0:Convert.ToInt32(dataReader["Flag"]);
                        section.Low = (dataReader["Low"] == null) ? 0 : Convert.ToInt32(dataReader["Low"]);
                        section.Medium = (dataReader["Medium"] == null) ? 0 : Convert.ToInt32(dataReader["Medium"]);
                        section.High = (dataReader["High"] == null) ? 0 : Convert.ToInt32(dataReader["High"]);
                        //Get Question By SectionOID
                        section.QuestionList = q.GetQuestionBySectionOID(section.SectionOID);
                        sectionList.Add(section);
                        
                    }
                }
         
            }
        }
        return sectionList;
    }

    public Section GetSectionByOID(int SOID)
    {
        Section section = null;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Section_BySectionOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@SOID", SOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    Question q = new Question();
                    //Section section;
                    if (dataReader.Read())
                    {
                        section = new Section();
                        section.SectionOID = Convert.ToInt32(dataReader["SectionOID"]);
                        section.AssessmentOID = Convert.ToInt32(dataReader["AssessmentOID"]);
                        section.CreatedBy = Convert.ToInt32(dataReader["CreatedBy"]);
                        section.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]);
                        section.FlagPointTotal = Convert.ToInt32(dataReader["FlagPointTotal"]);
                        section.LastModifiedBy = Convert.ToInt32(dataReader["LastModifiedBy"]);
                        section.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]);
                        section.PassingTotal = Convert.ToInt32(dataReader["PassingTotal"]);
                        section.SectionName = Convert.ToString(dataReader["SectionName"]);
                        section.TotalFlag = Convert.ToInt32(dataReader["TotalFlag"]);
                        section.TotalQuestion = Convert.ToInt32(dataReader["TotalQuestion"]);
                        section.Flag = (dataReader["Flag"]==null)?0:Convert.ToInt32(dataReader["Flag"]);
                        section.Low = (dataReader["Low"] == null) ? 0 : Convert.ToInt32(dataReader["Low"]);
                        section.Medium = (dataReader["Medium"] == null) ? 0 : Convert.ToInt32(dataReader["Medium"]);
                        section.High = (dataReader["High"] == null) ? 0 : Convert.ToInt32(dataReader["High"]);
                        
                        //Get Question By SectionOID
                        section.QuestionList = q.GetQuestionBySectionOID(section.SectionOID);
                    }
                }

            }
        }
        return section;
    }

    public void UpdateAssessmentSection()
    { 
    
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {                

                command.Connection = connection;
                command.CommandText = "UPDATE_SECT_ASS";
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

}
#endregion





    #region Question Class
    public class Question
{
    string connectionString;

    public Question()
    {
        //
        // TODO: Add constructor logic here
        //
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
        QuestionRespList = null;
    }

    #region Public Properties

    public int QuestionOID
    { get; set; }

    public int SectionOID
    { get; set; }

    public int OrderNo
    { get; set; }

    public string QuestionText
    { get; set; }

    public string RespAction
    { get; set; }

    public int MultipleAllow
    { get; set; }

    public string Keyword
    { get; set; }

    public DateTime CreatedDate
    { get; set; }

    public int CreatedBy
    { get; set; }

    public DateTime LastModifiedDate
    { get; set; }

    public int LastModifiedBy
    { get; set; }

    public int Reverse
    { get; set; }

    public Collection<QuestionResponse> QuestionRespList
    { get; set; }
    #endregion

    public bool AddQuestion()
    {
        bool result = false;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                command.Connection = connection;
                command.CommandText = "{CALL Question_insert(?,?,?,?,?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;

                OdbcParameter returnParam = command.Parameters.Add("@QuestionOID", OdbcType.Int);
                returnParam.Direction = ParameterDirection.ReturnValue;

                command.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
                command.Parameters.AddWithValue("@Keyword", this.Keyword);
                command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);
                command.Parameters.AddWithValue("@MultipleAllow", this.MultipleAllow);
                command.Parameters.AddWithValue("@OrderNo", this.OrderNo);
                command.Parameters.AddWithValue("@Question", this.QuestionText);
                command.Parameters.AddWithValue("@RespAction", this.RespAction);
                command.Parameters.AddWithValue("@SectionOID", this.SectionOID);
                command.Parameters.AddWithValue("@Reverse", this.Reverse);
                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
                QuestionOID = (int)command.Parameters["@QuestionOID"].Value;
                foreach (QuestionResponse qr in QuestionRespList)
                {
                    qr.QuestionOID = QuestionOID;
                    qr.AddQuestionResp();

                }

            }
        }

        return result;
    }

    public bool UpdateQuestion()
    {
        bool result = false;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                command.Connection = connection;
                command.CommandText = "{CALL Question_Update(?,?,?,?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;
                                
                command.Parameters.AddWithValue("@QuestionOID", this.QuestionOID);
                command.Parameters.AddWithValue("@Keyword", this.Keyword);
                command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);
                command.Parameters.AddWithValue("@MultipleAllow", this.MultipleAllow);
                command.Parameters.AddWithValue("@OrderNo", this.OrderNo);
                command.Parameters.AddWithValue("@Question", this.QuestionText);
                command.Parameters.AddWithValue("@RespAction", this.RespAction);
                command.Parameters.AddWithValue("@SectionOID", this.SectionOID);
                command.Parameters.AddWithValue("@Reverse", this.Reverse);
                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
                
                foreach (QuestionResponse qr in QuestionRespList)
                {
                    if (qr.QuestionResponseOID == 0)
                    {
                        qr.QuestionOID = QuestionOID;
                        qr.AddQuestionResp();
                    }
                    else
                    {
                        qr.QuestionOID = QuestionOID;
                        qr.UpdateQuestionResponse();
                    }

                }

            }
        }
        return result;
    }

    public Collection<Question> GetQuestionBySectionOID(int SOID)
    {
        Collection<Question> qList = new Collection<Question>();
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Question_BySectionOID_NoScore(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@SOID", SOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    QuestionResponse qr = new QuestionResponse();
                    Question question;
                    while (dataReader.Read())
                    {
                        question = new Question();
                        question.QuestionOID = Convert.ToInt32(dataReader["QuestionOID"]);
                        question.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]);
                        question.CreatedBy = Convert.ToInt32(dataReader["CreatedBy"]);
                        question.Keyword = Convert.ToString(dataReader["Keyword"]);
                        question.LastModifiedBy = Convert.ToInt32(dataReader["LastModifiedBy"]);
                        question.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]);
                        question.MultipleAllow = Convert.ToInt32(dataReader["MultipleAllow"]);
                        question.OrderNo = Convert.ToInt32(dataReader["OrderNo"]);
                        question.QuestionText = Convert.ToString(dataReader["Question"]);
                        question.RespAction = Convert.ToString(dataReader["RespAction"]);
                        question.SectionOID = Convert.ToInt32(dataReader["SectionOID"]);
                        question .Reverse = Convert.ToInt32(dataReader["Reverse"]);
                        question.QuestionRespList = qr.GetQuestionRespByQOID(question.QuestionOID);
                        qList.Add(question);


                    }
                }

            }
        }
        return qList;
    }


    public Collection<Question> GetQuestionOIDBySectionOID(int SOID)
    {
        Collection<Question> qList = new Collection<Question>();
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Question_BySectionOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@SOID", SOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    QuestionResponse qr = new QuestionResponse();
                    Question question;
                    while (dataReader.Read())
                    {
                        question = new Question();
                        question.QuestionOID = Convert.ToInt32(dataReader["QuestionOID"]);
                        question.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]);
                        question.CreatedBy = Convert.ToInt32(dataReader["CreatedBy"]);
                        question.Keyword = Convert.ToString(dataReader["Keyword"]);
                        question.LastModifiedBy = Convert.ToInt32(dataReader["LastModifiedBy"]);
                        question.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]);
                        question.MultipleAllow = Convert.ToInt32(dataReader["MultipleAllow"]);
                        question.OrderNo = Convert.ToInt32(dataReader["OrderNo"]);
                        question.QuestionText = Convert.ToString(dataReader["Question"]);
                        question.RespAction = Convert.ToString(dataReader["RespAction"]);
                        question.SectionOID = Convert.ToInt32(dataReader["SectionOID"]);
                        question.Reverse = Convert.ToInt32(dataReader["Reverse"]);
                        question.QuestionRespList = qr.GetQuestionRespByQOID(question.QuestionOID);
                        qList.Add(question);


                    }
                }

            }
        }
        return qList;
    }

    public bool DeleteQuestionBySectionOID(int SectionOID)
    {
        bool result = false;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Question_DeleteBySectionOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@SectionOID", SectionOID);

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


    public bool DeleteQuestionByQuestionOID(int QuestionOID)
    {
        bool result = false;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Question_DeleteByQuestionOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@QuestionOID", QuestionOID);

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

    public int GetQuestionOIDBySectionIDAndOrderNo(int OrderNo, int SectionOID)
    {
        int questioid = 0;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL QuestionOID_BySOID_Order(?,?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@OrderNo", OrderNo);
                command.Parameters.AddWithValue("@SectionOID", SectionOID);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    //QuestionResponse qr;

                    while (dataReader.Read())
                    {
                        //qr = new QuestionResponse();

                        questioid = Convert.ToInt32(dataReader["QuestionOID"]);



                    }
                }

            }
        }
        return questioid;
    }
}
    #endregion

    #region QuestionResponse Class

    [Serializable]
    public class QuestionResponse
    {
        string connectionString;

        public QuestionResponse()
        {
            connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
        }
        #region Public Properties

        public int QuestionResponseOID
        { get; set; }

        public int QuestionOID
        { get; set; }

        public string Response
        { get; set; }

        public int FlagRating
        { get; set; }

        public DateTime CreatedDate
        { get; set; }

        public int CreatedBy
        { get; set; }

        public DateTime LastModifiedDate
        { get; set; }

        public int LastModifiedBy
        { get; set; }
        #endregion
        public bool AddQuestionResp()
        {
            bool result = false;

            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionResponse_Insert(?,?,?,?,?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
                    command.Parameters.AddWithValue("@FlagRating", this.FlagRating);
                    command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);
                    command.Parameters.AddWithValue("@QuestionOID", this.QuestionOID);
                    command.Parameters.AddWithValue("@Response", this.Response);


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

        public Collection<QuestionResponse> GetQuestionRespByQOID(int QOID)
        {
            Collection<QuestionResponse> respList = new Collection<QuestionResponse>();
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {

                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionResp_ByQOID(?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    //Set Parameter Value
                    command.Parameters.AddWithValue("@QOID", QOID);
                    //Open connection
                    connection.Open();
                    //Read using reader
                    using (OdbcDataReader dataReader = command.ExecuteReader())
                    {
                        QuestionResponse qr;
                        
                        while (dataReader.Read())
                        {
                            qr = new QuestionResponse();
                            qr.CreatedBy = Convert.ToInt32(dataReader["CreatedBy"]);
                            qr.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]);
                            qr.FlagRating = Convert.ToInt32(dataReader["FlagRating"]);
                            qr.LastModifiedBy = Convert.ToInt32(dataReader["LastModifiedBy"]);
                            qr.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]);
                            qr.QuestionOID = Convert.ToInt32(dataReader["QuestionOID"]);
                            qr.QuestionResponseOID = Convert.ToInt32(dataReader["QuestionResponseOID"]);
                            qr.Response = Convert.ToString(dataReader["Response"]);
                                                        
                            respList.Add(qr);


                        }
                    }

                }
            }
            return respList;
        }

        public QuestionResponse GetQuestionRespByQOIDANDFlag(int QOID, string flag)
        {
            QuestionResponse qr=null;
            try
            {
                using (OdbcConnection connection = new OdbcConnection(connectionString))
                {
                    using (OdbcCommand command = new OdbcCommand())
                    {

                        command.Connection = connection;
                        command.CommandText = "{CALL QuestionResponse__ByQOID_Flag(?,?)}";
                        command.CommandType = CommandType.StoredProcedure;

                        //Set Parameter Value
                        command.Parameters.AddWithValue("@QOID", QOID);
                        command.Parameters.AddWithValue("@Flag", flag);
                        //Open connection
                        connection.Open();
                        //Read using reader
                        using (OdbcDataReader dataReader = command.ExecuteReader())
                        {


                            if (dataReader.Read())
                            {
                                qr = new QuestionResponse();
                                qr.CreatedBy = Convert.ToInt32(dataReader["CreatedBy"]);
                                qr.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]);
                                qr.FlagRating = Convert.ToInt32(dataReader["FlagRating"]);
                                qr.LastModifiedBy = Convert.ToInt32(dataReader["LastModifiedBy"]);
                                qr.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]);
                                qr.QuestionOID = Convert.ToInt32(dataReader["QuestionOID"]);
                                qr.QuestionResponseOID = Convert.ToInt32(dataReader["QuestionResponseOID"]);
                                qr.Response = Convert.ToString(dataReader["Response"]);

                                //respList.Add(qr);


                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
            
            }
            return qr;
        }

        public int  GetQuestionFlagPointByQOIDAndResponse(int QOID,string response)
        {
            int flagpoint = 0;
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {

                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionResp_ByQOIDAndResponse(?,?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    //Set Parameter Value
                    command.Parameters.AddWithValue("@QOID", QOID);
                    command.Parameters.AddWithValue("@Response", response);
                    //Open connection
                    connection.Open();
                    //Read using reader
                    using (OdbcDataReader dataReader = command.ExecuteReader())
                    {
                        //QuestionResponse qr;

                        while (dataReader.Read())
                        {
                            //qr = new QuestionResponse();
                            
                            flagpoint = Convert.ToInt32(dataReader["FlagRating"]);
                           


                        }
                    }

                }
            }
            return flagpoint;
        }

        public bool UpdateQuestionResponse()
        {
            bool result = false;
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionResponse_Update(?,?,?,?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@QuestionResponseOID", this.QuestionResponseOID);
                    command.Parameters.AddWithValue("@FlagRating", this.FlagRating);
                    command.Parameters.AddWithValue("@LastModifiedBy", this.LastModifiedBy);                    
                    command.Parameters.AddWithValue("@Response", this.Response);


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

        public bool DeleteQuestionBySectionOID(int QuestionOID)
        {
            bool result = false;
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {

                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionDetails_DeleteByQuestionOID(?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@QuestionOID", QuestionOID);

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

        public bool UpdateQuestionResponseTotalQuestion(int SectionOID)
        {
            bool result = false;
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "{CALL QuestionResponse_UpdateTotalQuestion(?)}";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@SectionOID", SectionOID);
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
    #endregion


