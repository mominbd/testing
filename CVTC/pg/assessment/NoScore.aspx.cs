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
using System.Web.Services;

public partial class pg_assessment_Section : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int sectOID;
        if (!Page.IsPostBack)
        {
            LabelMessage.Text = "";
            sectOID = Convert.ToInt32(Request.QueryString["soid"].ToString());
            Session["soid"] = sectOID;
            HiddenSectionID.Value = sectOID.ToString();
            InitializeQuestion(sectOID);
            Sections sec = new Sections();
            Assessment ass = new Assessment();
            int AssOID = sec.GetAssessmentOIDBySectionOID(sectOID);
            if (ass.GetAssessmentStatusByOID(Convert.ToInt32(AssOID)) == 1)
            {
                HiddenAssessmentLocked.Value = "1";
            }
            else
            {
                HiddenAssessmentLocked.Value = "0";
            }
        }
        else
        {
           // sectOID=Convert.ToInt32(Session["soid"]);
            //InitializeQuestion(sectOID);
        }

    }


    private string AddFullRow(string i, string question, string response, string k,  string responseAction, string keyword)
    {
        
        string optionRespAct = "";

       
        if (responseAction == "Radio Button")
        {            
            optionRespAct += "<option selected='true'>Radio Button</option>";
            optionRespAct += "<option>Drop Down</option>";
        }
        else if (responseAction == "Drop Down")
        {         
            optionRespAct += "<option>Radio Button</option>";
            optionRespAct += "<option selected='true'>Drop Down</option>";
        }

        
        string str="";// = " <table>";
        str += "<tr id='Row" + i + "'>";
        str += "<td ><input id='TextOrderNumber" + i + "' name='TextOrderNumber" + i + "' type='text' value='"+i+"' class='orderNo' /></td>";
        str += "<td><input id='TextQuestion" + i + "' name='TextQuestion" + i + "'  type='text' class='question' value='" + question + "' /></td>";
        str += "<td style='Display:none'><select id='SelectResponseAction" + i + "' name='SelectResponseAction" + i + "' style ='width:120px'  value='"+responseAction+"'>";
        str += optionRespAct;       
        str += "</select></td>";       
        str += "<td><input id='TextResponse" + i + "' type='text'  name='TextResponse" + i + "' class='response' value='" + response + "'/></td>";       
        str += "<td><input id='TextKeyword" + i + "' type='text' name='TextKeyword" + i + "' class='keyword' value='" + keyword + "' /></td>";
        str += "<td>";
        str += "<button id='ButtonAdd' type='button' class='ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all' ><span class='ui-button-text'>Add Response</span></button></td>";
        str += "<td>";
        str += " <input id='btnDeleteQuestion" + i + "' type='button' value='Delete this question' style=' width:150px' onclick= \"DeleteQuestion(" + i + ")\"/>";
        str += "</td>";     
        str += "</tr>";
        
        
        return str;
    }

    private string AddSubRow(string i,string j,string response)
    {
        
        string str = "";

        str += "<tr id='" + i + '_' + j + "' >&nbsp;</td>    <td>&nbsp;</td><td> &nbsp;</td><td><input id='TextResponse" + i + '_' + j + "' type='text' name='TextResponse" + i + '_' + j + "' class='response' value='" + response + "'/></td>           <td>&nbsp;</td><td>&nbsp;</td> </tr>";

        return str;
    }


    private void InitializeQuestion(int SOID)
    {
        string str = " <table>";
        str += "<tr>       <td class='style2' >Order# &nbsp;</td> <td>Enter Question&nbsp;&nbsp;</td> <td style='Display:none'>Response Action&nbsp;&nbsp;</td>             <td>Responses&nbsp;&nbsp; </td>       <td>Keyword&nbsp;&nbsp;</td>              <td>&nbsp;</td>       </tr>";
          try
            {
                Section s = new Section();
                s = s.GetSectionByOID(SOID);
                if (s != null)
                {
                    //TextBoxPassingTotal.Text = s.PassingTotal.ToString();
                    //TextBoxSectionName.Text = s.SectionName;
                    TextBoxTotalQuestion.Text = s.TotalQuestion.ToString();
                    //TextBoxFlag.Text = s.Flag.ToString();
                    //TextBoxLow.Text = s.Low.ToString();
                    //TextBoxMedium.Text = s.Medium.ToString();
                    //TextBoxhi.Text = s.High.ToString();
                    if (s.QuestionList.Count == 0)
                        str += AddFullRow("1", " ", " ", " ", "Radio Button", " ");

                    int i = 1;
                    int k=1;
                    foreach (Question q in s.QuestionList)
                    {
                        
                        //Code for question
                        int j = 1;
                        foreach (QuestionResponse qr in q.QuestionRespList)
                        { 
                            //Code for Question Response
                            if (j == 1)
                            {
                                k=q.QuestionRespList.Count;
                                str += AddFullRow(i.ToString(), q.QuestionText,  qr.Response,k.ToString(),q.RespAction,q.Keyword);
                            }
                            else
                            {
                                str += AddSubRow(i.ToString(), j.ToString(), qr.Response);
                            }

                            j++;

                        }
                        i++;
                    }
                    if (i == 1) i++;
                    HiddenRowId.Value = (i - 1).ToString();
                }
            }
            catch (Exception ex)
            { }

          str += "<tr id='Row_Ind'><td colspan='8'>&nbsp;</td></tr>";
        str += "</table>";
        Div1.InnerHtml = str;
    }

    protected void ButtonSaveMyWork_Click(object sender, EventArgs e)
    {
        string ordNum, ques, RespAct, Multi, Resp, Flag, Key;
        int assessmentOID,sectionOID,totalQuestion=0;
        assessmentOID = (Session["aid"] != null) ? Convert.ToInt32(Session["aid"]) : -1;
        sectionOID = (Session["soid"] != null) ? Convert.ToInt32(Session["soid"]) : -1;

        Section sectionExiting = null;
        Collection<Question> quesList = new Collection<Question>(); ;
        Collection<QuestionResponse> respList;//=new Collection<QuestionResponse>();
        Question questn;
        QuestionResponse quesResp;
        Section section = new Section();
        sectionExiting = section.GetSectionByOID(sectionOID);

        section.SectionOID = sectionExiting != null ? sectionExiting.SectionOID : 0;
        section.SectionName = "NoScore";
        section.AssessmentOID = assessmentOID;
        section.LastModifiedBy = 1;
        section.CreatedBy = 1;
        section.FlagPointTotal = 0;
        section.PassingTotal = 0;
        //section.SectionOID = 0;
        section.TotalFlag = 0;
        section.TotalQuestion = 0;
        section.PassingTotal = 0;
        section.Flag = 0;
        section.Low = 0;
        section.Medium = 0;        
        section.High = 67;

        totalQuestion = sectionExiting != null ? sectionExiting.QuestionList.Count : 0;
        
         
        #region Question

        for (int i = 1; ; i++)
        {
            ordNum = "TextOrderNumber" + i.ToString();
            ques = "TextQuestion" + i.ToString();
            RespAct = "SelectResponseAction" + i.ToString();
            //Multi = "CheckboxMultiple" + i.ToString();
            Resp = "TextResponse" + i.ToString();
            Flag = "SelectFalgRating" + i.ToString();
            Key = "TextKeyword" + i.ToString();

            ordNum = Request.Form[ordNum];
            if (ordNum == null) break;
            ques = Request.Form[ques];
            RespAct = Request.Form[RespAct];
            //Multi = Request.Form[Multi];
            Resp = Request.Form[Resp];
            Flag = Request.Form[Flag];
            Key = Request.Form[Key];

            //Assign Values to question
            questn = new Question();
            if (i > totalQuestion)
            {                
                questn.QuestionOID = 0;
            }
            else
            {
                questn.QuestionOID = sectionExiting.QuestionList[i-1].QuestionOID;
            }
            questn.SectionOID = section.SectionOID;
            questn.CreatedBy = 1;//Set current user
            questn.LastModifiedBy = 1;//Set current user
            questn.Keyword = Key;
            questn.MultipleAllow = 1;
            questn.OrderNo = Convert.ToInt32(ordNum);
            questn.QuestionText = ques;
            questn.RespAction = RespAct;
            quesList.Add(questn);


            //Assign values Question Response
            respList = new Collection<QuestionResponse>();
            quesResp = new QuestionResponse();  
            if( questn.QuestionOID !=0)
            {
                quesResp.QuestionResponseOID = sectionExiting.QuestionList[i - 1].QuestionRespList[0].QuestionResponseOID;
            }
            quesResp.CreatedBy = 1;
            quesResp.LastModifiedBy = 1;
            quesResp.FlagRating = Convert.ToInt32(Flag);
            quesResp.Response = Resp;
            respList.Add(quesResp);

            //Process
            for (int j = 2; ; j++)
            {
                Resp = "TextResponse" + i.ToString() + "_" + j.ToString();
                Flag = "SelectFalgRating" + i.ToString() + "_" + j.ToString();

                Resp = Request.Form[Resp];
                Flag = Request.Form[Flag];
                if (Resp == null) break;

                //Assign values Question Response
                quesResp = new QuestionResponse();
                if (i > totalQuestion)
                {
                    quesResp.QuestionResponseOID = 0;
                }
                else
                {
                    if (j > sectionExiting.QuestionList[i-1].QuestionRespList.Count)
                    {
                        quesResp.QuestionResponseOID = 0;
                    }
                    else
                    {
                        quesResp.QuestionResponseOID = sectionExiting.QuestionList[i-1].QuestionRespList[j-1].QuestionResponseOID;
                    }
                }
                
                //quesResp.QuestionResponseOID = sectionExiting.QuestionList[i].QuestionRespList
                quesResp.CreatedBy = 1;
                quesResp.LastModifiedBy = 1;
                quesResp.FlagRating = Convert.ToInt32(Flag);
                quesResp.Response = Resp;
                respList.Add(quesResp);
            }

            questn.QuestionRespList = respList;

        }
        #endregion

        section.QuestionList = quesList;
        section.UpdateSection();
        section.UpdateAssessmentSection();

        this.InitializeQuestion(sectionOID);
        LabelMessage.Text = "Saved Successfully.";
    }

    #region OLD
    //private void InitializeQuestion(int soid)
    //{
    //    try
    //    {
    //        Section s = new Section();
    //        s = s.GetSectionByOID(soid);
    //        Label lblSect;
    //        Label lineBreak = new Label();
    //        lineBreak.Text = "<br />";
    //        lblSect = new Label();

    //        //Section
    //        //lblSect.Text = s.SectionName;
    //        // PlaceHolderMain.Controls.Add(lblSect);

    //        PlaceHolderMain.Controls.Add(InsertLineBreaks(1));
    //        //Each Question
    //        foreach (Question q in s.QuestionList)
    //        {
    //            // PlaceHolderMain.Controls.Add(InsertLineBreaks(1));
    //            lblSect = new Label();
    //            lblSect.Text = q.OrderNo + ". " + q.QuestionText;
    //            PlaceHolderMain.Controls.Add(lblSect);

    //            if (q.RespAction == "Radio Button")
    //            {
    //                //Panel p = new Panel();

    //                RadioButtonList rblist = new RadioButtonList();
    //                rblist.ID = q.QuestionOID.ToString();


    //                //Each Question Response
    //                foreach (QuestionResponse resp in q.QuestionRespList)
    //                {
    //                    rblist.Items.Add(resp.Response);
    //                }
    //                //p.Controls.Add(rblist);
    //                ///PlaceHolderMain.Controls.Add(InsertLineBreaks(1));
    //                PlaceHolderMain.Controls.Add(rblist);
    //            }
    //            else if (q.RespAction == "Check Box")
    //            {
    //                //Panel p = new Panel();
    //                CheckBoxList chlist = new CheckBoxList();
    //                chlist.ID = q.QuestionOID.ToString();

    //                //Each Question Response
    //                foreach (QuestionResponse resp in q.QuestionRespList)
    //                {
    //                    chlist.Items.Add(resp.Response);
    //                }
    //                //p.Controls.Add(chlist);
    //                //PlaceHolderMain.Controls.Add(InsertLineBreaks(1));
    //                PlaceHolderMain.Controls.Add(chlist);
    //            }

    //            else if (q.RespAction == "Drop Down")
    //            {
    //                //Panel p = new Panel();
    //                DropDownList ddl = new DropDownList();
    //                ddl.ID = q.QuestionOID.ToString();


    //                //Each Question Response
    //                foreach (QuestionResponse resp in q.QuestionRespList)
    //                {
    //                    ddl.Items.Add(resp.Response);
    //                }
    //                //p.Controls.Add(ddl);
    //                PlaceHolderMain.Controls.Add(ddl);
    //            }


    //        }
    //        PlaceHolderMain.Controls.Add(InsertLineBreaks(2));
    //    }
    //    catch (Exception ex)
    //    { }
    //}
    //private static Label InsertLineBreaks(int breaks)
    //{
    //    Label lblLineBreak = new Label();

    //    for (int i = 0; i < breaks; i++)
    //    {
    //        lblLineBreak.Text += "<br/>";
    //    }
    //    return lblLineBreak;
    //}
    //private string GetCharByInterger(int i)
    //{
    //    return Char.ConvertFromUtf32(i + 97);
    //}
    #endregion

    public System.Boolean IsNumeric(System.Object Expression)
    {
        if (Expression == null || Expression is DateTime)
            return false;

        if (Expression is Int16 || Expression is Int32 || Expression is Int64 || Expression is Decimal || Expression is Single || Expression is Double || Expression is Boolean)
            return true;

        try
        {
            if (Expression is string)
                Double.Parse(Expression as string);
            else
                Double.Parse(Expression.ToString());
            return true;
        }
        catch { } // just dismiss errors but return false
        return false;
    }

    protected void ButtonRefresh_Click(object sender, EventArgs e)
    {
        int sectOID = Convert.ToInt32(Session["soid"]);
        InitializeQuestion(sectOID);
        LabelMessage.Text = "";
    }
    [WebMethod]
    public static void DeleteQuestion(string OrderNo, string SectionID)
    {
        Question qu = new Question();
        QuestionResponse qr = new QuestionResponse();
        int OrderNumber = Convert.ToInt32(OrderNo);
        int secID = Convert.ToInt32(SectionID);
        int QuestionOID = qu.GetQuestionOIDBySectionIDAndOrderNo(OrderNumber, secID);
        qr.DeleteQuestionBySectionOID(QuestionOID);
        if (qu.DeleteQuestionByQuestionOID(QuestionOID))
        {
            qr.UpdateQuestionResponseTotalQuestion(secID);
            Alert.Show("Successfully Deleted this question..");
            return;
        }
        else
        {

            Alert.Show("Not Deleted .try again..");
            return;
        }
    }
}
