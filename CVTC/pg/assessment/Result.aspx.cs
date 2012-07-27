﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.Odbc;

public partial class pg_assessment_Result : System.Web.UI.Page
{
    string connectionString;
    string aid;
    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
        if (!IsPostBack)
        {
            //User user = new User();
            //user = Session["CurrentUser"] as User;
            //if (user != null)
            //{
                //lblErorr.Text = "";
                //if (user.UserName != "admin")
                //{
                //    ButtonViewResult.Visible = false;
                //}
                //else 
                //{
                    ButtonViewResult.Visible = true ;
                                     
                //}
            //}
            //else
            //{
            //    lblErorr.Text = "Session Out !! Please Login again";
            //   // Response.Redirect("~/login.aspx");
            //}
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            aid = Request.QueryString["aid"].ToString();
            //this.Page.ClientScript.RegisterHiddenField("HiddenAOID", aid);
            HiddenAOID.Value = aid;

            //Assessment ass = new Assessment();
            //ass = ass.GetAssessmentByOID(Convert.ToInt32(aid));
            //if (ass != null)
            //{
            //    LabelAsssessment.Text = ass.AssessmentName;
            //}
        }
        catch (Exception ex)
        { }

    }

    [System.Web.Services.WebMethod]
    public static string GetColumnNameList(int aoid)
    {
        Assessment ass = new Assessment();
        return ass.GetColumnNameList(aoid);
    }

    //public static string GetAssessmentResult(int aoid)
    //{
    //    Assessment ass = new Assessment();
    //    string tmp="";
    //    return ass.GetAssessmentResult(aoid,out tmp);
    //}

    protected void ButtonViewResult_Click(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL ScoreDetailTable_InsertNow(?)}";
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = 999;
                command.Parameters.AddWithValue("@AOID", aid);

                try
                {
                    if (connection.State == ConnectionState.Closed)
                    { 
                        connection.Open(); 
                    }

                    int n = command.ExecuteNonQuery();
                }
                catch (Exception ex)
                { }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                    }
                }
            }
        }

    }
}
