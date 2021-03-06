﻿<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="ResultEmail.aspx.cs" Inherits="pg_assessment_ResultEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/global-style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
 .alt-color { margin-top:2px; margin-bottom:2px; border-bottom:1px solid #999; width:100%;}
 </style>   
 <link href="../../css/global-style.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" src="../../js/jquery.js"></script>
 <script language="javascript" type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>      
        <script type="text/javascript">
            tinyMCE.init({
            // General options
                encoding: "xml",
                 //mode: "exact",
                mode: "textareas",
                theme: "advanced",
                //MyTextBox
                
                plugins: "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

                // Theme options
                theme_advanced_buttons1: "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
                theme_advanced_buttons2: "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
                theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage",
                theme_advanced_toolbar_location: "top",
                theme_advanced_toolbar_align: "left",
                theme_advanced_statusbar_location: "bottom",
                theme_advanced_resizing: true,

                // Skin options
                skin: "o2k7",
                skin_variant: "silver",

                // Example content CSS (should be your site CSS)
                content_css: "css/example.css",

                // Drop lists for link/image/media/template dialogs
                template_external_list_url: "js/template_list.js",
                external_link_list_url: "js/link_list.js",
                external_image_list_url: "js/image_list.js",
                media_external_list_url: "js/media_list.js",

                // Replace values for the template plugin
                template_replace_values: {
                    username: "Some User",
                    staffid: "991234"
                }
            });
</script>




</head>
<body>
    <form id="form1" runat="server">
    <table style ="width :1000px">
    <tr><td><span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text">
        <asp:Button ID="ButtonRefresh" runat="server" Text="Refresh"  onclick="ButtonRefresh_Click" Font-Bold="True" /></span>
        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
        </td></tr>
    <tr>
    <td>
        <asp:TextBox ID="TextBoxHeader" runat="server" TextMode="MultiLine" Rows="5" Width="780" Height="200"></asp:TextBox>
        </td>
        <td>
        
        </td>
        </tr>
        
    </table>
    <table>
    <tr>
    <td >
        <%--<asp:PlaceHolder ID="PlaceHolderResult" runat="server"></asp:PlaceHolder>--%>
        <div id="ResultHolder" runat="server"></div>
    </td>
    </tr>
    <tr>
    <td>
    <asp:TextBox ID="TextBoxShowAboveResult" runat="server" TextMode="MultiLine" Rows="5" Width="780" Height="200"></asp:TextBox>
    </td>
    </tr>
    <tr><td>
        <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" 
            onclick="ButtonSubmit_Click" />
            <%--<a href="#null" onclick="printContent('print_div1')"><img alt="printer" src="../../images/Actions-document-print-icon.png" /></a>--%>
<%--            <div id="print_div1" runat="server" style="display:none;"></div>
--%>            </td></tr>
    <%--<tr><td> Positive Result<br />
            <asp:TextBox ID="TextBoxPositiveResult" runat="server"></asp:TextBox></td><td>Negative Result<br /><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td></tr>--%>
    </table>
    

    
    
    </form>
<%--<script type="text/javascript">
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
</script>--%>

</body>
</html>
