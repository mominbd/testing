﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisplayMessage.aspx.cs" Inherits="pg_message_DisplayMessage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 1060px;">
       
        <tr>
            <td>
              <span style="color:Navy; font-weight:bold;" >  Date: </span><asp:Label ID="LabelDate" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;&nbsp;
               <span style="color:Navy; font-weight:bold;" > Time:</span> <asp:Label ID="LabelTime" runat="server" Text="Label"></asp:Label>
            </td>
            
        </tr>
        <tr>
            <td>
               <span style="color:Navy; font-weight:bold;" > From: </span><asp:Label ID="LabelFrom" runat="server" Text="Label"></asp:Label>
            </td>
            
        </tr>
        <tr>
            <td>
             <span style="color:Navy; font-weight:bold;" >   Subject: </span><asp:Label ID="LabelSubject" runat="server" Text="Label"></asp:Label>
            </td>
            
        </tr>
          <tr>
            <td>
              <span style="color:Navy; font-weight:bold;" >  Message: </span>
            </td>
            
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelMessage" runat="server" Text="Label"></asp:Label>
            </td>
            
        </tr>
        
    </table>
    </form>
</body>
</html>
