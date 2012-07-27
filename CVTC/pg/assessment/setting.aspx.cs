﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pg_assessment_setting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string aid=Request.QueryString["aid"].ToString();
          
            ResultEmail resultEmail = new ResultEmail();
            resultEmail = resultEmail.GetResultEmailByAOID(Convert.ToInt32(aid));

            if (resultEmail == null)
            {
                lblULR.Text = "Please Fill up Contents for Result Email First.";
                lblULR.ForeColor = System.Drawing.Color.Red;

            }
            else
            {
                string asseeementURL = System.Web.Configuration.WebConfigurationManager.AppSettings["asseeementURL"].ToString();	
                //lblULR.Text = "http://localhost/CVTC/Exam.aspx?aid=" + aid;
                //lblULR.Text = "http://iss.cvtc.edu/CVTC/Exam.aspx?aid=" + aid;
                lblULR.Text = asseeementURL+"CVTC/Exam.aspx?aid=" + aid;
                lblULR.ForeColor = System.Drawing.Color.Green;
            }
        
            //LabelAssessmentName.Text
            Session["aid"] = aid;
            HiddenFieldAOID.Value = aid;
            Initialize(Convert.ToInt32(aid));

            if (Session["CurrentUser"] != null)
            {
                User u = (User)Session["CurrentUser"];
                HiddenFieldCurrentUser.Value = u.UserOID.ToString();
            }

            
            
            
        }
    }

    private void Initialize(int aid)
    {
        try
        {
            Assessment ass = new Assessment();
            //Get Assessment by OID
            ass = ass.GetAssessmentByOID(aid);
            //Assign it
            LabelAssessmentName.Text = ass.AssessmentName;
            LabelSection.Text = ass.TotalSection.ToString();
            //LabelFlaggedPoint.Text = ass.TotalFlagPoint.ToString();
            //LabelTotalFlagged.Text = ass.TotalFlag.ToString();
            LabelTotalQuestion.Text = ass.TotalQuestion.ToString();

            //Section Detail
            LabelSectionDetails.Text = "";
            string sectionDetails = "";
            if (ass.SectionList.Count > 0)
            {
                foreach (Section s in ass.SectionList)
                {
                    sectionDetails += "<br/>";
                    sectionDetails += "<br/>";
                    sectionDetails += "\t" + "<span style='font-weight:bold;font-size:medium;'>" + s.SectionName + "</span>";
                    sectionDetails += "<br/>";
                    sectionDetails += "Total Question :&nbsp;&nbsp;&nbsp;  " + s.TotalQuestion.ToString();
                    sectionDetails += "<br/>";

                    if (s.SectionName == "NoScore") continue;
                    sectionDetails += "Total Points :&nbsp;&nbsp;&nbsp; " + s.FlagPointTotal.ToString();

                }
            }
            LabelSectionDetails.Text = sectionDetails;

            //Add Existing RiskCalculation//style='border-style: solid; border-width: thin'
            string str = "<table id='tblRisk' >  <tr><td style='font-weight:bold;font-size:medium;'>At Risk Calculation</td></tr>   <tr><td>Current Calculation(s): <input id='ButtonAddRisk' type='button' value='+' /> <span id='AddRiskSpan' style='display:none;'>Name <input id='TextRiskName' type='text' />  <input id='ButtonSaveRisk' type='button' value='Save' /></span></td></tr>";            
            RiskCalculation risk = new RiskCalculation();
            System.Collections.ObjectModel.Collection<RiskCalculation> list;
            list = risk.GetRiskCalulationByAOID(aid);

            foreach (RiskCalculation r in list)
            {
                
                ///
                str += "<tr id='" + r.RiskOID + "'><td><span>" + r.RiskName + "</span><span id='SpanMain" + r.RiskOID + "'> :" + r.NumFlag + " Flagged Point  " + " </span><input id='ButtonEdit' type='button' value='Edit' />  <input id='ButtonPrescription' type='button' value='Prescription' /> <span id='SpanInner" + r.RiskOID + "' style='display:none;' > Flagged Point &nbsp;&nbsp;&nbsp;<input id='Flagged" + r.RiskOID + "' style='width:20px' type='text' /> &nbsp;  &nbsp;<input id='ButtonSave' type='button' value='Save' /> </span></td></tr>";
            }

            
              //str+=  "<tr id='1' style='display:none;'><td><span id='SpanMain1'>At Risk : 4pts flagged + 2 Section Failed </span><input id='ButtonEdit' type='button' value='Edit' />  <input id='ButtonPrescription' type='button' value='Prescription' /> <span id='SpanInner1' style='display:none;'> Flagged &nbsp;<input id='Flagged1' style='width:20px' type='text' /> &nbsp; Section Failed &nbsp;<input id='SectionFailed1' type='text' style='width:20px' /><input id='ButtonSave' type='button' value='Save' /> </span></td></tr>";
              str += " <tr id='RowLast'><td>&nbsp;</td></tr>";
              str+="</table>";
              LabelRisk.Text = str;

        }
        catch (Exception ex)
        { }
    }

    [System.Web.Services.WebMethod]
    public static int InsertRiskCalculation(string RiskName,int aoid, int userid)
    {
        try
        {
            //User user=(User)Session["CurrentUser"];
            RiskCalculation risk=new RiskCalculation();
            risk.AssessmentOID = aoid;//Convert.ToInt32(Session["aid"].ToString());
            risk.RiskName = RiskName;
            risk.NumFlag = 0;
            risk.NumSection = 0;
            risk.CreatedBy = userid;//user.UserOID;
            risk.AddRiskCalculation();
            return risk.RiskOID;
        }
        catch (Exception ex)
        { }
        return 0;
    }
    [System.Web.Services.WebMethod]
    public static void EditRiskCalculation(int oid, int flag, int section)
    {
        try
        {
            RiskCalculation risk = new RiskCalculation();
            risk.EditRiskCalculation(oid, section, flag);
            
        }
        catch (Exception ex)
        { }
    }

    [System.Web.Services.WebMethod]
    public static string GetDate()
    {
        return DateTime.Now.ToString();
    }

}
