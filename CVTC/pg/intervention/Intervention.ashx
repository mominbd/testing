﻿<%@ WebHandler Language="C#" Class="Intervention" %>

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Data.Odbc;
using System.Web.SessionState;

public class Intervention : IHttpHandler, IReadOnlySessionState
{
    string connectionString = "";
    public void ProcessRequest(HttpContext context)
    {
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();

        HttpRequest request = context.Request;
        HttpResponse response = context.Response;

        string _search = request["_search"];
        string numberOfRows = request["rows"];
        string pageIndex = request["page"];
        string sortColumnName = request["sidx"];
        string sortOrderBy = request["sord"];
        string operation = request["oper"];
        string field = request["searchField"];
        string val = request["searchString"];


        string reportname = request["reportname"];
        string hiddenfields = request["hiddenfields"];
        string spparams = request.RawUrl.ToString();
        //string gridcolumns = request["gridcolumns"];
        string isreport = request["isreport"];
        if (isreport == "yes")
        {
            _search = "true";
        }


        if ((!string.IsNullOrEmpty(reportname)) && (reportname != ""))
        {
            string[] stringSeparatorsasc = new string[] { "&sord=asc" };
            string[] stringSeparatorsdesc = new string[] { "&sord=desc" };

            if (spparams.Contains("&sord=asc"))
            {
                spparams = spparams.Split(stringSeparatorsasc, StringSplitOptions.None)[1];
            }
            else if (spparams.Contains("&sord=desc"))
            {
                spparams = spparams.Split(stringSeparatorsdesc, StringSplitOptions.None)[1];
            }
            else
            {
                spparams = "";
            }

            bool status = InsertSearchStudentReport(reportname, spparams, hiddenfields);
        }
        else if (_search == "true")
        {
            context.Session["reportname"] = reportname;
            context.Session["numberOfRows"] = numberOfRows;
            context.Session["pageIndex"] = pageIndex;
            context.Session["sortColumnName"] = sortColumnName;
            context.Session["datestamp"] = Convert.ToDateTime(request["Datestamp"]);
            context.Session["bannerId"] = request["BannerId"];
            context.Session["participating"] = request["Participating"];
            context.Session["actionDate"] = Convert.ToDateTime(request["ActionDate"]);
            context.Session["sponsor"] = request["Sponsor"];
            context.Session["criteriaType"] = request["CriteriaType"];
            context.Session["outcomeType"] = request["OutcomeType"];
            context.Session["urgent"] = request["Urgent"];
            context.Session["Internal"] = request["Internal"];
            context.Session["prescribed"] = request["Prescribed"];
            context.Session["completed"] = request["Completed"];
            context.Session["email"] = request["Email"];
            context.Session["telephone"] = request["Telephone"];
            context.Session["inPerson"] = request["InPerson"];
            context.Session["handoff"] = request["Hand off"];
            context.Session["contactDate"] = Convert.ToDateTime(request["ContactDate"]);
            context.Session["comment"] = request["Comment"];
            int totalRecords;
        
            Interventions inv = new Interventions();
            Collection<Interventions> invList = inv.SearchIntervention(numberOfRows, pageIndex, sortColumnName, sortOrderBy, out totalRecords, Convert.ToDateTime(request["LatestContact"]), request["BannerStudentIDNumber"], request["Participating"], Convert.ToDateTime(request["LatestActionDate"]), request["UserName"], request["DomainName"], request["InterventionName"], request["Urgent"], request["Internal"], request["Prescribed"], request["Completed"], request["Email"], request["Telephone"], request["InPerson"], request["Handoff"], Convert.ToDateTime(request["LatestContact"]), request["Comment"]);
            string output = BuildJQGridResults(invList, Convert.ToInt32(numberOfRows), Convert.ToInt32(pageIndex), Convert.ToInt32(totalRecords));
            response.Write(output);

            //Add data to Session variable
            context.Session["InterventionReportDt"] = this.ConvertListToDataTable(invList);            
        }
        else
        {
            int totalRecords;
            Interventions inv = new Interventions();
            Collection<Interventions> invList = inv.GetAllIntervention(numberOfRows, pageIndex, sortColumnName, sortOrderBy, out totalRecords);

            string output = BuildJQGridResults(invList, Convert.ToInt32(numberOfRows), Convert.ToInt32(pageIndex), Convert.ToInt32(totalRecords));
            response.Write(output);
        }

    }

    private DataTable ConvertListToDataTable(Collection<Interventions> interventions)
    {
        DataTable dt = new DataTable();
        try
        {
            dt.Columns.Add("PrescriptionOID");
            dt.Columns.Add("Datestamp");
            dt.Columns.Add("BannerId");
            dt.Columns.Add("Participating");
            dt.Columns.Add("ActionDate");
            dt.Columns.Add("Sponsor");
            dt.Columns.Add("CriteriaType");
            dt.Columns.Add("OutcomeType");
            dt.Columns.Add("Urgent");
            dt.Columns.Add("Internal");
            dt.Columns.Add("Prescribed");
            dt.Columns.Add("Completed");
            dt.Columns.Add("Email");
            dt.Columns.Add("Telephone");
            dt.Columns.Add("In Person");
            dt.Columns.Add("Hand off");
            dt.Columns.Add("ContactDate");
            dt.Columns.Add("Comment");


            foreach (Interventions intervention in interventions)
            {
                DataRow row = dt.NewRow();
                row["PrescriptionOID"] = intervention.PrescriptionOID.ToString();
                row["Datestamp"] = intervention.LatestContact;
                row["BannerId"] = intervention.BannerID;
                row["Participating"] = (intervention.Participating == 1) ? "yes" : "no";
                row["Action Date"] = intervention.LatestActionDate;
                row["Sponsor"] = intervention.UserName;
                row["CriteriaType"] = intervention.DomainName;
                row["OutcomeType"] = intervention.InterventionName;
                row["Urgent"] = (intervention.Urgent == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Internal"] = (intervention.Internal == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Prescribed"] = (intervention.Prescribed == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Completed"] = (intervention.Completed == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Email"] = (intervention.Email == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Telephone"] = (intervention.Telephone == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["InPerson"] = (intervention.InPerson == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["Handoff"] = (intervention.HandOff == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
                row["ContactDate"] = intervention.LatestContact;
                row["Comment"] = intervention.Comment;                
                dt.Rows.Add(row);
            }
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    
    
    private bool InsertSearchStudentReport(string reportname, string spparams, string gridcolumns)//, string numberOfRows, string pageIndex, string sortColumnName, string sortOrderBy, out int totalRecords, int StudentOID, string NAME, string ID, string TERM, string PFIND, double GPA, double ATMPCR, double EARNCR, string C1, string C2, string CW, string CR, string AE, string AM, string AR, string SA, DateTime SDATE, string HSDESC, DateTime HS_GRAD_DATE, string ADDR1, string ADDR2, string ADDR3, string CITY, string STATE, string ZIP, DateTime FILEDATE, string PPGMIND, string MAJOR, string Email, string Phone)
    {
        bool result = false;

        int reportOID = 0;
        String ReportName = (reportname == null) ? "" : reportname;
        String SPName = "";
        String SPParams = (spparams == null) ? "" : spparams;
        String GridColumns = (gridcolumns == null) ? "" : gridcolumns;
        DateTime CreatedDate = System.DateTime.Now;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                command.Connection = connection;
                command.CommandText = "{CALL Reports_Insert(?,?,?,?,?,?)}";
                command.CommandType = CommandType.StoredProcedure;

                OdbcParameter returnParam = command.Parameters.Add("@ReportOID", OdbcType.Int);
                returnParam.Direction = ParameterDirection.ReturnValue;

                //command.Parameters.AddWithValue("@ReportOID",0);
                command.Parameters.AddWithValue("@ReportName", ReportName);
                command.Parameters.AddWithValue("@SPName", SPName);
                command.Parameters.AddWithValue("@SPParams", SPParams);
                command.Parameters.AddWithValue("@GridColumns", GridColumns);
                command.Parameters.AddWithValue("@CreatedDate", CreatedDate);

                connection.Open();
                int n = command.ExecuteNonQuery();
                if (n == 1)
                    result = true;
                else
                    result = false;
                if (result)
                {
                    reportOID = (int)command.Parameters["@ReportOID"].Value;

                    //To Insert menu
                    CVTCMenu menu = new CVTCMenu();
                    menu.NameMenu = ReportName;
                    int menuId = new CVTCMenu().GetMaxMenuID();
                    menuId += 1;
                    menu.MenuID = menuId;
                    menu.URL = "pg/intervention/ViewInterventionReport.aspx?ReportOID=" + reportOID;
                    menu.MenuLevel = 1;
                    menu.Parent = 6;
                    menu.IsExpanded = "true";
                    menu.IsLeave = "true";
                    menu.SaveAssessmentMenuItem(menu);
                }
                else
                {
                    reportOID = 0;
                }
            }
        }
        return true;
    }    
    
    private string BuildJQGridResults(Collection<Interventions> Tasks, int numberOfRows, int pageIndex, int totalRecords)
    {

        JQGridResults result = new JQGridResults();
        List<JQGridRow> rows = new List<JQGridRow>();
        foreach (Interventions Task in Tasks)
        {
            JQGridRow row = new JQGridRow();
            row.id = Task.PrescriptionOID;
            row.cell = new string[18];
            row.cell[0] = Task.PrescriptionOID.ToString();
            row.cell[1] = Task.LatestContact;
            row.cell[2] = Task.BannerID;
            row.cell[3] = (Task.Participating == 1) ? "yes" : "no";
            row.cell[4] = Task.LatestActionDate;
            row.cell[5] = Task.UserName;
            row.cell[6] = Task.DomainName;
            row.cell[7] = Task.InterventionName;
            row.cell[8] = (Task.Urgent == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[9] = (Task.Internal == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[10] = (Task.Prescribed == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[11] = (Task.Completed == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[12] = (Task.Email == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[13] = (Task.Telephone == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[14] = (Task.InPerson == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[15] = (Task.HandOff == 1) ? "yes" : "no";//"<img border='0' src='~/images/Actions-dialog-ok-icon.png' alt='' />" : "<img border='0' src='~/images/X-Au-Blu-icon.png' alt='' />";
            row.cell[16] = Task.LatestContact;
            row.cell[17] = Task.Comment;
            

            rows.Add(row);
        }
        result.rows = rows.ToArray();
        result.page = pageIndex;
        result.total = totalRecords / numberOfRows;
        if (totalRecords % numberOfRows != 0) result.total += 1;
        result.records = totalRecords;
        return new JavaScriptSerializer().Serialize(result);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}