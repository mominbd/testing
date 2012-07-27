﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editTermCodes.aspx.cs" Inherits="pg_assessment_editTermCodes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Term Code</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div style ="width :1040px">
        <div>
        This page adds term codes to the database. The term codes are used to send reminder email to students that have not taken an assesment. This system will check the banner input and if student has a term code that matches any in this list, they will not receive the remainder email to take the test. If the student's term code is not listed  here, they will receive the email.
        Make sure to enter the term codes of students you don't want to receive the email, otherwise they will receive the email you created.
            
        </div>
        <br />
        <div>
             Enter Term Code<asp:TextBox ID="TextBoxTermCode" runat="server"></asp:TextBox>
            <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" 
                 onclick="ButtonSubmit_Click" />
             
             <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please input Term Code." 
                ControlToValidate="TextBoxTermCode"></asp:RequiredFieldValidator>
             
             
             
        </div>
        <hr />
        <div>
        
        <asp:GridView ID="GridViewLocations" runat="server" CssClass="rowgrid-new" GridLines="None"
                 CellPadding="0"  AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Name" SortExpression="LocationName">
                        <ItemTemplate>
                            <asp:Label ID="LabelLocationName" runat="server" Text='<%# Bind("TermCodeName") %>'></asp:Label>
                            <asp:HiddenField ID="HiddenFieldLocationOID" runat="server" 
                                Value='<%# Bind("TermCodeOID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButtonEditLocation" runat="server" ImageUrl="~/Images/edit-icon.png"
                                OnClick="ImageButtonEditLocation_Click" ToolTip="Edit" />
                            <asp:ImageButton ID="ImageButtonDeleteLocation" runat="server" ImageUrl="~/Images/delete-icon.png"
                                OnClick="ImageButtonDeleteLocation_Click" ToolTip="Delete" OnClientClick="javascript:return confirm(&quot;Are you sure you want to delete?&quot;);" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle CssClass="altrow" />
            </asp:GridView>
        </div>
    
    </div>
    </form>
</body>
</html>
