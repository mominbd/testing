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
using System.Collections.ObjectModel;

public partial class pg_assessment_prescription : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                string oid = Request.QueryString["OID"];
                // Response.Write(oid);
                ViewState["riskOID"] = oid;
                Initialize();
                LabelStatus.Text = "";
            }
        }
        catch (Exception ex)
        { }
    }

    private void Initialize()
    {
        try
        {
            int roid = Convert.ToInt32(ViewState["riskOID"].ToString());
            Interventions interventions = new Interventions();
            interventions = interventions.GetInterventionByRiskOID(roid);
            if (interventions != null)
            {
                CheckBoxListLeft.Items[0].Selected = (interventions.Urgent == 1) ? true : false;
                CheckBoxListLeft.Items[1].Selected = (interventions.Internal == 1) ? true : false;
                CheckBoxListLeft.Items[2].Selected = (interventions.Prescribed == 1) ? true : false;
                CheckBoxListLeft.Items[3].Selected = (interventions.Participating == 1) ? true : false;
                CheckBoxListLeft.Items[4].Selected = (interventions.Completed == 1) ? true : false;

                //Right CheckboxList
                CheckBoxListRight.Items[0].Selected = (interventions.Email == 1) ? true : false;
                CheckBoxListRight.Items[1].Selected = (interventions.Telephone == 1) ? true : false;
                CheckBoxListRight.Items[2].Selected = (interventions.InPerson == 1) ? true : false;
                CheckBoxListRight.Items[3].Selected = (interventions.HandOff == 1) ? true : false;
                CheckBoxTesting.Checked = (interventions.Testing == 1) ? true : false;
                
                
                TextBoxContactNotes.Text=interventions.Comment ;
                TextBoxLatestAction.Value = interventions.LatestActionDate.ToString();
                TextBoxLatestContact.Value = interventions.LatestContact.ToString();
                DropDownListDomain.Text=interventions.DomainName;                
                DropDownListIntervention.Text = interventions.InterventionName;
                DropDownListAdvocate.Text = interventions.UserName;
            }

        }
        catch (Exception ex)
        { }
    }

    protected void ButtonSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if((string.IsNullOrEmpty(TextBoxLatestAction.Value)) || (string.IsNullOrEmpty(TextBoxLatestContact.Value)))
            {
                LabelStatus.Text = "Please Enter Action and Contact Date";
                return;
            }

            int studentid = 0;
            bool isNew = false;
            int roid = Convert.ToInt32(ViewState["riskOID"].ToString());
            RiskCalculation rcal = new RiskCalculation();
            Interventions interventions = new Interventions();
            interventions = interventions.GetInterventionByRiskOID(roid);
            rcal = rcal.GetAssessmentOIDByRiskOID(roid);
           
            if (interventions == null)
            {
                isNew = true;
                interventions = new Interventions();
            }
            int aoid = rcal.AssessmentOID;
            interventions.AssessmentOID = aoid;
            int strInterventionOID = interventions.GetInterventionOIDByInterventionName(DropDownListIntervention.SelectedItem.ToString());
            interventions.InterventionOID = strInterventionOID;
            Domain domain = new Domain();
            int DomainIOD = domain.GetDomainOIDByDomainName(DropDownListDomain.SelectedItem.ToString());
            interventions.DomainOID = DomainIOD;
            User user = new User();
            int UserIOD = user.GetUserOIDByUserName(DropDownListAdvocate.SelectedItem.ToString());
            //int UserIOD = 1;
            interventions.UserOID = UserIOD;
            interventions.RiskOID = roid;
            //Student student = new Student();
            //int StudentOID = student.GetStudentOIDByStudentBannerID(studentid);
            interventions.StudentOID = studentid;
            interventions.LatestActionDate = TextBoxLatestAction.Value.ToString();
            interventions.LatestContact = TextBoxLatestContact.Value.ToString();
            
            interventions.CreatedBy = (Session["CurrentUser"] != null) ? ((User)Session["CurrentUser"]).UserOID : 0;

            if (CheckBoxListLeft.Items[0].Selected)
            {
                interventions.Urgent = 1;

            }
            else
            {
                interventions.Urgent = 0;
            }
            if (CheckBoxListLeft.Items[1].Selected)
            {
                interventions.Internal = 1;
            }
            else
            {
                interventions.Internal = 0;
            }

            if (CheckBoxListLeft.Items[2].Selected)
            {
                interventions.Prescribed = 1;
            }
            else
            {
                interventions.Prescribed = 0;
            }

            if (CheckBoxListLeft.Items[3].Selected)
            {
                interventions.Participating = 1;
            }
            else
            {
                interventions.Participating = 0;
            }
            if (CheckBoxListLeft.Items[4].Selected)
            {
                interventions.Completed = 1;
            }
            else
            {
                interventions.Completed = 0;
            }


            if (CheckBoxListRight.Items[0].Selected)
            {
                interventions.Email = 1;
            }
            else
            {
                interventions.Email = 0;
            }
            if (CheckBoxListRight.Items[1].Selected)
            {
                interventions.Telephone = 1;
            }
            else
            {
                interventions.Telephone = 0;
            }
            if (CheckBoxListRight.Items[2].Selected)
            {
                interventions.InPerson = 1;
            }
            else
            {
                interventions.InPerson = 0;
            }
            if (CheckBoxListRight.Items[3].Selected)
            {
                interventions.HandOff = 1;
            }
            else
            {
                interventions.HandOff = 0;
            }
            if (CheckBoxTesting.Checked == true)
            {
                interventions.Testing = 1;
            }
            else
            {
                interventions.Testing = 0;
            }
            interventions.Comment = TextBoxContactNotes.Text.Trim();
            if (isNew)
            {
                if (interventions.AddInterventions() > 0)
                {
                    LabelStatus.Text = "Saved Successfully.";
                }
                else
                {
                    LabelStatus.Text = "Save Failed.";
                }
            }
            else
            {
                if (interventions.UpdateInterventions())
                {
                    LabelStatus.Text = "Update Successfully.";
                }
                else
                {
                    LabelStatus.Text = "Update Failed.";
                }
            }


        }


        catch (Exception ex)
        {
            LabelStatus.Text = "Not Saved";
        }
    }

    protected void DropDownListDomain_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListIntervention.Items.Clear();
        Interventions iv;
        if (DropDownListDomain.Text != null)
        {
            iv = new Interventions();
            Collection<Interventions> inList = new Collection<Interventions>();
            inList = iv.GetInterventionByDomainName(DropDownListDomain.Text);
            //DropDownListIntervention.Items.Clear();
            foreach (Interventions inter in inList)
            {
                DropDownListIntervention.Items.Add(inter.InterventionName);
            }
        }
    }
}
