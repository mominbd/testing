﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections.ObjectModel;

public partial class pg_intervention_AddDomainIntervention : System.Web.UI.Page
{
    private string studentid = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           

            try
            {
                
            }
            catch (Exception ex)
            { }
        }
    }

  

    protected void ButtonSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Interventions interventions = new Interventions();
            Domain domain = new Domain();
            int DomainIOD = domain.GetDomainOIDByDomainName(DropDownListDomain.SelectedItem.ToString());
            interventions.DomainOID = DomainIOD;
                      
          //int  strInterventionOID = interventions.GetInterventionOIDByInterventionName(DropDownListIntervention .SelectedItem .ToString ());
            interventions.InterventionName = txtIntervention .Text;
            if (DomainIOD != null && txtIntervention.Text != null&&txtIntervention.Text !="")
            {
                interventions.AddDomainInterventions();
                Label1.Text = "Successfuly Saved";
            }
            else
            {
                Label1.Text = "Not Saved";
            }
        }
            

        catch (Exception ex)
        { 
        
        }
    }

    protected void DropDownListDomain_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Interventions iv;
        //if (DropDownListDomain.Text != null)
        //{
        //    iv = new Interventions();
        //    Collection<Interventions> inList = new Collection<Interventions>();
        //    inList = iv.GetInterventionByDomainName(DropDownListDomain.Text);
        //    DropDownListIntervention.Items.Clear();
        //    foreach (Interventions inter in inList)
        //    {
        //        DropDownListIntervention.Items.Add(inter.ToString());
        //    }
        //}
    }
    protected void DropDownListDomain_Load(object sender, EventArgs e)
    {

    }
    protected void lbtnAddDomain_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddDomain.aspx");
    }
}
