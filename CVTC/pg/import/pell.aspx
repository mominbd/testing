﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pell.aspx.cs" Inherits="pg_import_pell" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <table style="width: 100%;">
         <tr>
            <td>
                &nbsp;
            </td>
            
        </tr>
         <tr>
            <td>
                Upload .csv File&nbsp;&nbsp;<input id="uplTheFile" type=file runat="server"  /> &nbsp;&nbsp;&nbsp;<asp:Button 
                    ID="Button1" runat="server" Text="Import" Height="24px" onclick="Button1_Click" 
                    Width="80px" />
                <asp:Label ID="Label1" runat="server" ForeColor="#FF5050"></asp:Label>
            </td>
            
        </tr>
        
         <tr>
            <td>
                Uploaded file will not replace students in database, it will add to students on file.
                       <asp:LinkButton ID="LinkButtonNTO" runat="server" onclick="LinkButtonNTO_Click">Download Sample file</asp:LinkButton>   </td>
            
        </tr>
         <tr>
            <td>
                &nbsp;
            </td>
            
        </tr>
         <tr>
            <td>
                <asp:GridView ID="GridViewNTO" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Col_0" HeaderText="Banner ID" />
                        <asp:BoundField DataField="Col_1" HeaderText="PELL" />
                    </Columns>
                    <HeaderStyle BackColor="#85B5D9" />
                </asp:GridView>
            </td>
            
        </tr>
        
    </table>
    </form>
</body>
</html>
