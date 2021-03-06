﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prescription.aspx.cs" Inherits="pg_intervention_Prescription" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

 
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.1.custom.min.js"></script>
    <link href="../../css/global-style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-ui-timepicker-addon.js"></script>
<link href="../../themes/jquery-ui-1.7.2.custom.css" rel='stylesheet' type='text/css' />
<link href="../../themes/jquery.ui.datepicker.css" rel='stylesheet' type='text/css' />

    
    <script type="text/javascript">
    $(function() {
        $('#TextBoxLatestAction').datetimepicker({
            ampm: true,
            showTime: true,
            timeFormat: 'hh:mm TT'
            
        });
        
        $('#TextBoxLatestContact').datetimepicker({
            ampm: true,
            showTime: true,
            timeFormat: 'hh:mm TT'            
        });
    });
    
</script>

 <script type ="text/javascript" >
  function printDiv() {
    // $(document).ready(function printDiv() {
         var divToPrint = document.getElementById('print_div1');
         var newWin = window.open('', 'Print Intervention', 'width=800,height=810,scrollbars=1');
         newWin.document.open();
         newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
         newWin.document.close();

     }
     //);
  
  </script>
  
    <style type="text/css">
        .style1
        {
            width: 145px;
        }
    </style>
  
</head>
<body>
<div id="print_div1" runat="server" style="display:none;">
  
    </div>
    <form id="form1" runat="server">
    <table style="width: 60%;">
    <tr>
    <td colspan="3" align ="right" >
    
                    <asp:Label ID="LabelStatus" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
    
    </td>
    </tr>
        <tr ><td colspan="2">Success Prescription</td>
            <td>Advocate&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="DropDownListAdvocate" runat="server" 
                    DataSourceID="SqlDataSourceUser" DataTextField="UserName" Width="150px" 
                    DataValueField="UserName">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:cvtcConnectionString %>" 
                    SelectCommand="SELECT [UserName] FROM [User] WHERE ([Advocacy] = @Advocacy)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Yes" Name="Advocacy" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
            </td>
        </tr>
        <tr>
        <td colspan="2">Domain &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <%--   <asp:DropDownList ID="DropDownListDomain" runat="server" 
                DataSourceID="SqlDataSourceDomain" DataTextField="DomainName" Width="150px"
                DataValueField="DomainName" 
                OnSelectedIndexChanged="DropDownListDomain_SelectedIndexChanged" 
                AutoPostBack="true"  >
                </asp:DropDownList>--%>
            <%--<asp:SqlDataSource ID="SqlDataSourceDomain" runat="server" 
                ConnectionString="<%$ ConnectionStrings:cvtcConnectionString %>" 
                SelectCommand="SELECT [DomainName] FROM [Domain]">
                </asp:SqlDataSource>--%>
                
                <asp:DropDownList ID="DropDownListDomain" runat="server" 
               Width="150px"   OnSelectedIndexChanged="DropDownListDomain_SelectedIndexChanged"  AutoPostBack="true"  ></asp:DropDownList>
                           
                </td>
                
                
        <td>Intervention &nbsp;&nbsp; &nbsp;&nbsp;
            <asp:DropDownList ID="DropDownListIntervention" runat="server" Width="150px"
                >
                </asp:DropDownList>
     <%--       <asp:SqlDataSource ID="SqlDataSourceInterventions" runat="server" 
                ConnectionString="<%$ ConnectionStrings:cvtcConnectionString %>" 
                
                SelectCommand="SELECT Intervention.InterventionName FROM Domain INNER JOIN Intervention ON Domain.DomainOID = Intervention.DomainID">
            </asp:SqlDataSource>--%>
                </td>
        </tr>
        <tr><td colspan="2">latest Action &nbsp;&nbsp;<input runat="server" id="TextBoxLatestAction" style="width:150px;"/><%--<asp:TextBox ID="TextBoxLatestAction" runat="server"></asp:TextBox>--%>
        <asp:Label 
                ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                </td>
            <td>Latest Contact&nbsp;&nbsp; &nbsp;<input runat="server" id="TextBoxLatestContact" style="width:130px;"/><%--<asp:TextBox ID="TextBoxLatestContact" runat="server"></asp:TextBox>--%> 
                <asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
            </td></tr>
        <tr><td colspan="2"><br /></td><td>Assesment(s):&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList 
                ID="ddlAssessment" runat="server" Height="20px" Width="130px">
            </asp:DropDownList>
                </td></tr>
        <tr >
        <td align="left" valign="top">    <asp:CheckBoxList ID="CheckBoxListLeft" 
                runat="server" Width="184px">
                <asp:ListItem>Urgent</asp:ListItem>
                <asp:ListItem>Internal</asp:ListItem>
                <asp:ListItem>Prescribed</asp:ListItem>
                <asp:ListItem>Participating</asp:ListItem>
                <asp:ListItem>Completed</asp:ListItem>
            </asp:CheckBoxList></td>
        <td align="left" valign="top" class="style1">  
            <asp:CheckBoxList ID="CheckBoxListRight" runat="server" Width="156px">
                <asp:ListItem>Email</asp:ListItem>
                <asp:ListItem>Telephone</asp:ListItem>
                <asp:ListItem>In Person</asp:ListItem>
                <asp:ListItem>Hand-Off</asp:ListItem>
                </asp:CheckBoxList>
                <asp:CheckBox ID="CheckBoxTesting" runat="server" Text="Testing" />  &nbsp;</td>
            <td align="right" valign="bottom">
                <%--<a href="#null" onclick="printContent('print_div1')"><img alt="printer" src="../../images/Actions-document-print-icon.png" /></a>--%>
               <%-- <a href="#null" onclick="printContent('print_div1')"><img alt="printer" src="../../images/Actions-document-print-icon.png" /></a>
                <br />
                <asp:Button ID="Button1" runat="server"  onclick="Button1_Click" Text="Print" />
                <br />--%>
                
                <%--<asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Print" 
                    ImageAlign="Middle" ImageUrl="~/images/Actions-document-print-icon.png" 
                    onclick="ImageButton1_Click" Height="91px" Width="81px" />--%>
                <br />
               <%--<asp:Label ID="Label3" runat="server" Text="Print"></asp:Label>--%>
               <br />
                <asp:HyperLink ID="HyperLink1" Height="91px" Width="81px" runat="server" Target ="_blank" ImageUrl ="~/images/Actions-document-print-icon.png">Print</asp:HyperLink>
              
                </td> 
                    </tr>
        <tr><td colspan="3">Contact Notes<br />
            <asp:TextBox ID="TextBoxContactNotes" runat="server" Height="100px" 
                Width="500px" TextMode="MultiLine"></asp:TextBox></td></tr>
        <tr><td align="right" colspan="2">
            <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" 
                onclick="ButtonSubmit_Click" Width="80px" /></td>
                <td>
                    &nbsp;</td></tr>
        
    </table>
    </form>
    <script type="text/javascript">
<!--
function printContent(id){
str=document.getElementById(id).innerHTML
newwin=window.open('','printwin','left=100,top=100,width=850,height=900')
newwin.document.write('<HTML>\n<HEAD>\n')
newwin.document.write('<TITLE>Print Page</TITLE>\n')
newwin.document.write('<script>\n')
newwin.document.write('function chkstate(){\n')
newwin.document.write('if(document.readyState=="complete"){\n')
newwin.document.write('window.close()\n')
newwin.document.write('}\n')
newwin.document.write('else{\n')
newwin.document.write('setTimeout("chkstate()",2000)\n')
newwin.document.write('}\n')
newwin.document.write('}\n')
newwin.document.write('function print_win(){\n')
newwin.document.write('window.print();\n')
newwin.document.write('chkstate();\n')
newwin.document.write('}\n')
newwin.document.write('<\/script>\n')
newwin.document.write('</HEAD>\n')
newwin.document.write('<BODY onload="print_win()">\n')
newwin.document.write(str)
newwin.document.write('</BODY>\n')
newwin.document.write('</HTML>\n')
newwin.document.close()
}
//-->
</script>
</body>
</html>
