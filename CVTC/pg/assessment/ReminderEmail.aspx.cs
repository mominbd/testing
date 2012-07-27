﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Data.Odbc;
using System.Net.Mail;
using System.Configuration;

public partial class pg_assessment_ReminderEmail : System.Web.UI.Page
{
    public string EMailBodyHtml
    {
        get { return HttpUtility.HtmlDecode(TextBoxEMail.Text); }
        set { TextBoxEMail.Text = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int assessmentOID = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["aid"]))
            {
                assessmentOID = Convert.ToInt32(Request.QueryString["aid"]);
                ViewState["AssessmentOID"] = assessmentOID;
            }
            this.Initialize(assessmentOID);
            
        }
    }

    private void Initialize(int assessmentOID)
    {
        LabelMessage.Text = "";
        LabelStatus.Text = "";
        Collection<TermCode> termCodeList = new TermCode().GetTermCodeByAssessmentOID(assessmentOID);

        ViewState["TermCodeList"] = termCodeList;
        foreach (TermCode termCode in termCodeList)
        {
            CheckBoxListTermCode.Items.Add(termCode.TermCodeName);
        }

        this.ShowEmailBody(assessmentOID);
    }

    private void ShowEmailBody(int assessmentOID)
    {
        ReminderEmail reminderEmail = new ReminderEmail();
        reminderEmail = reminderEmail.GetReminderEmailByAOID(assessmentOID);
        if (reminderEmail == null)
        {
            //TextBoxEMail.Text = "";
            this.EMailBodyHtml = "";
        }
        else
        {
            //TextBoxEMail.Text = reminderEmail.EmailBody;
            //TextBoxEMail.Text = Server.HtmlDecode(reminderEmail.EmailBody);
            this.EMailBodyHtml = reminderEmail.EmailBody;
        }
    }

    protected void ButtonSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            User user = (User)Session["CurrentUser"];
            if (user == null) return;

            int aid = (ViewState["AssessmentOID"] != null) ? (Convert.ToInt32(ViewState["AssessmentOID"])) : 0;

            Assessment ass = new Assessment();
            ass = ass.GetAssessmentByOID(aid);

            ReminderEmail reminderEmail = new ReminderEmail();
            
            //reminderEmail.EmailBody = TextBoxEMail.Text;
            //reminderEmail.EmailBody = Server.HtmlEncode(TextBoxEMail.Text);
            reminderEmail.EmailBody = EMailBodyHtml;

            reminderEmail.AssessmentOID = aid;
            reminderEmail.CreatedBy = user.UserOID;
            reminderEmail.LastModifiedBy = user.UserOID;

            //Result Detail
            ReminderEmail rEmail = reminderEmail.GetReminderEmailByAOID(aid);
            bool status = false;
            if (rEmail == null)
            {
                status = reminderEmail.AddReminderEmail();
            }
            else
            {
                reminderEmail.AssessmentReminderOID = rEmail.AssessmentReminderOID;
                status = reminderEmail.UpdateReminderEmail();
            }

            if (status)
            {
                LabelMessage.Text = "Saved Successfully.";
                this.ShowEmailBody(aid);
            }
            else
            {
                LabelMessage.Text = "Not Saved.";
            }
        }
        catch (Exception ex)
        {
            LabelMessage.Text = "Not Saved.";
        }
    }
    protected void ButtonSendEMails_Click(object sender, EventArgs e)
    {
        bool status = false;
        for (int i = 0; i < CheckBoxListTermCode.Items.Count; i++)
        {
            if (CheckBoxListTermCode.Items[i].Selected)
            {
                status = true;
            }
        }
        if (!status)
        {
            LabelStatus.Text = "Please select term code first.";
            return;
        }

        int aid = (ViewState["AssessmentOID"] != null) ? (Convert.ToInt32(ViewState["AssessmentOID"])) : 0;

        if (aid == 0)
        {
            LabelStatus.Text = "Assessment ID is null.";
            return;
        }

        Assessment ass = new Assessment();
        ass = ass.GetAssessmentByOID(aid);


        List<string> mailAddressList = new List<string>();
        int counterTotal = 0, counterSuccess = 0;
        bool mailsendStatus = false;
        for (int i = 0; i < CheckBoxListTermCode.Items.Count; i++)
        {
            
            if (CheckBoxListTermCode.Items[i].Selected)
            {
                string termCode = CheckBoxListTermCode.Items[i].Value;
                Collection<Student> studentList = new Student().GetAllStudentByTermCodeofProgramEnrollment(termCode);
                foreach (Student student in studentList)
                {
                    string mailAddress = Convert.ToString(student.EmailAddress);
                    
                    if (!mailAddressList.Contains(mailAddress))
                    {
                        mailAddressList.Add(mailAddress);
                        //if(CheckMailFormat(mailAddress))
                        //{
                            counterTotal++;
                            string toEmail = null;
                            if (ConfigurationManager.AppSettings["productionMode"].ToString() == "OFF")
                            {
                               toEmail = ConfigurationManager.AppSettings["toEmail"].ToString();
                            }
                            else if (ConfigurationManager.AppSettings["productionMode"].ToString() == "ON")
                            {
                                toEmail = mailAddress;
                            }
                            mailsendStatus = this.SendMail(toEmail, "Reminder for " + ass.AssessmentName, EMailBodyHtml);
                            //mailsendStatus = this.SendMail("babulrajbd@gmail.com", "Reminder for " + ass.AssessmentName, EMailBodyHtml);
                            if (mailsendStatus)
                            {
                                counterSuccess++;
                            }
                        //}
                    }
                }
            }
            mailAddressList.Clear();
        }

        ShowEmailBody(aid);
        LabelStatus.Text = "Mail sent success " + counterSuccess.ToString() + " of " + counterTotal.ToString() + ".";
    }
    private string RemoveComma(string str)
    {
        if (string.IsNullOrEmpty(str))
            return "";

        string[] strArr = str.Split(',');
        return strArr[0];
    }

    //private bool CheckMailFormat(string mailAddress)
    //{
    //    string[] str = mailAddress.Split('@');
    //    if ((str.Length == 2) && (!string.IsNullOrEmpty(str[0])))
    //    {
    //        string[] str2 = str[1].Split('.');
    //        if ((str2.Length == 2) && (!string.IsNullOrEmpty(str2[0])) && (!string.IsNullOrEmpty(str2[1])))
    //        {
    //            return true;
    //        }
    //        else
    //        {
    //            return false;
    //        }
    //    }
    //    else
    //    {
    //        return false;
    //    }        
    //}

    private bool SendMail_(string toAddress, string subject, string body)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("hitauthority@gmail.com");
            //mail.From = new MailAddress("studentperformance@cvtc.edu");
            mail.To.Add(toAddress);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = true;
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Host = "smtp.gmail.com";
            smtpClient.Credentials = new System.Net.NetworkCredential("hitauthority", "hit@authority");
            smtpClient.EnableSsl = bool.Parse("True");
            smtpClient.Port = Int32.Parse("587");
            smtpClient.Send(mail);
            return true;
        }
        catch
        {
            return false;
        }
    }

    private bool SendMail(string toAddress, string subject, string body)
    {

        string fromEmail = ConfigurationManager.AppSettings["fromEmail"].ToString();
        string smtpServer = ConfigurationManager.AppSettings["smtpServer"].ToString();
        string Subject = ConfigurationManager.AppSettings["Subjectheader"].ToString();
        string displayName = ConfigurationManager.AppSettings["displayName"].ToString();
        string Body = ConfigurationManager.AppSettings["body"].ToString();
        try
        {
            using (var message = new MailMessage())
            {
                message.From = new MailAddress(fromEmail, displayName);
                message.To.Add(toAddress);
                message.Subject = subject;
                message.IsBodyHtml =true ;
                message.Body = body;
                var client = new SmtpClient(smtpServer);
                client.Send(message);
            }
            return true;
        }
        catch (Exception ex)
        {
            
            return false;
        }

        #region Dummy
        //try
        //{
        //    MailMessage mail = new MailMessage();
        //    mail.From = new MailAddress("hitauthority@gmail.com");
        //    mail.To.Add(toAddress);
        //    mail.Subject = subject;
        //    mail.Body = body;
        //    mail.IsBodyHtml = true;
        //    SmtpClient smtpClient = new SmtpClient();
        //    smtpClient.Host = "smtp.gmail.com";
        //    smtpClient.Credentials = new System.Net.NetworkCredential
        //         ("hitauthority", "hit@authority");
        //    smtpClient.EnableSsl = bool.Parse("True");
        //    smtpClient.Port = Int32.Parse("587");
        //    smtpClient.Send(mail);
        //    return true;
        //}
        //catch
        //{
        //    return false;
        //}
        #endregion
    }
}
