﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TaskCompleted.aspx.cs" Inherits="pg_TaskCompleted" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>    
    <link href="../../css/global-style.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.js" type="text/javascript"></script>
    <script src="../../js/jquery.ui.core.js" type="text/javascript"></script>
    <script src="../../js/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="../../js/jquery.ui.tabs.js" type="text/javascript"></script>
    <link href="../../themes/jquery.ui.tabs.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/jquery.ui.all.css" rel="stylesheet" type="text/css" />
     <script src="../../js/thickbox.js" type="text/javascript"></script>
    <link href="../../themes/thickbox.css" rel="stylesheet" type="text/css" />
    <link href="../../css/global-style-cvtc.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../themes/redmond/jquery-ui-1.8.1.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../themes/ui.jqgrid.css" />


    <script src="../../js/jquery.js" type="text/javascript"></script>
 
    <script src="../../js/grid.locale-en.js" type="text/javascript"></script>
 
    <script src="../../js/jquery.jqGrid.min.js" type="text/javascript"></script>
    
 
  <%--  <script type="text/javascript">
        $(function() {
            $("#TasksGrid").jqGrid({
                url: 'TaskHandler.ashx',
                datatype: 'json',
                height: 250,
                colNames: ['<input type="checkbox" name="All" value="All"/>', 'TaskOID', '<img src="../../images/flag_icon.jpg"/>', '<img src="../../images/StarIconGold.png"/>', 'Subject', 'Recipient', 'Date', 'Time'],
                colModel: [
                        { name: 'Check', width: 25, editable: true, edittype: 'radio', editoptions: { value: "True:False" }, formatter: "checkbox", formatoptions: { disabled: false} },
                        { name: 'UserOID', index: 'UserID', width: 100, hidden: true, sortable: false },
                        { name: 'Flag', width: 25},
                        { name: 'Star', width: 25},
                        { name: 'Subject', width: 300, sortable: true, editable: true },
                        { name: 'Recipient', width: 200, sortable: true, editable: true },
                        { name: 'Date', width: 80, sortable: true, editable: true },
                        { name: 'Time', width: 80, sortable: true, editable: true }
                    ],
                rowNum: 10,
                rowList: [10, 20, 30],
                pager: '#TasksGridPager',
                sortname: 'TaskOID',
                viewrecords: true,
                sortorder: 'asc',
                editurl: 'UserHandler.ashx',
                caption: 'Message Center '
            });

            $("#TasksGrid").jqGrid('navGrid', '#TasksGridPager', { edit: false, add: false, del: true });

//            options = { autosearch: true };
//            $("#UsersGrid").filterToolbar(options);



//            var sgrid = $("#UsersGrid")[0];
//            sgrid.triggerToolbar();


            //$("#myButton").click(function () {
            //$("#UsersGrid").setColumns({ 'UserOID': '', 'UserName': '' });
            //  return false;
            //});


        });


        
        
    </script>--%>
   
   
</head>
<body>
    
    <form id="HtmlForm" runat="server">
    <table width="1060px">
    <tr><td align="left" style=" padding:0px; margin:0px;" >
                <ul style=" padding-left:10px; margin:0px;">
                <li> <span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text"><a href="ViewTask.aspx" style="font-weight:bold; padding:2px 10px 2px 10px; margin-right:5px; ">Task </a></span></li>
                <li><span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text"> <a href="taskSent.aspx" style="font-weight:bold; padding:2px 10px 2px 10px; margin-right:5px; ">Sent </a></span></li>
                <li><span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text"> <a href="#" style="font-weight:bold; padding:2px 10px 2px 10px; margin-right:5px; " >Completed </a></span></li>
                <li><span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text"> <a href="newTask.aspx?keepThis=true&TB_iframe=true&height=460&width=800" style="font-weight:bold; padding:2px 10px 2px 10px; margin-right:5px; " class="thickbox" onunload="AfterClick();">New Task </a></span></li>                
                </ul> </td></tr>
    <tr><td> </td></tr>
    <tr><td> 
        <span class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all ui-button-text">
        <asp:Button ID="ButtonRefresh" runat="server" Text="Refresh" 
            onclick="ButtonRefresh_Click" Font-Bold="True" /></span>
        </td></tr>
    <tr><td>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <asp:Label id="lblProgress" runat="server" Text="Loading...." Width="200px" BackColor="#85B5D9" ForeColor="Maroon" Font-Bold="True" Style="padding: 5px"></asp:Label>
                </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="ContentHolder">
                  <div class="title-style-bar">
                    <h2> View Task</h2>
                    
                    
                      &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="ButtonDelete" runat="server" Text="Delete" 
                          onclick="ButtonDelete_Click"  OnClientClick="javascript:return confirm(&quot;Are you sure you want to delete?&quot;);" />
                      <%--onChange="javascript:return confirm(&quot;Are you sure you want to change status?&quot;);"--%>
                      <asp:DropDownList ID="DropDownListMark" runat="server" Width="80px" AutoPostBack="true" 
                          onselectedindexchanged="DropDownListMark_SelectedIndexChanged">
                        <asp:ListItem>Mark</asp:ListItem>
                        <asp:ListItem>Read</asp:ListItem>
                        <asp:ListItem>Unread</asp:ListItem>
                        <asp:ListItem>Completed</asp:ListItem>
                        <asp:ListItem>Star</asp:ListItem>
                        </asp:DropDownList>                    
                    
                    
                  </div>
                  <div class="title-style-bar-body skyblue">
        <asp:GridView ID="GridViewTask" runat="server" AutoGenerateColumns="False" CssClass="datagrid" Width="100%"
            onpageindexchanging="GridViewTask_PageIndexChanging" AllowPaging="True" RowStyle-Height="10px" SelectedRowStyle-Height="10px">
        
            <RowStyle Height="10px" />
        
            <Columns>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:TextBox ID="CheckBoxTask" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                    
                    <asp:CheckBox ID="CheckBoxTask" runat="server" />
                    <asp:HiddenField ID="HiddenFieldTask" runat="server" Value='<%# Bind("TaskUserOID") %>' />                    
                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Priority" HeaderText="Priority" />
                <asp:TemplateField HeaderImageUrl="~/images/flag_icon.png" >
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="ImageFlg1" runat="server" ImageUrl='<%# Eval("FlagURL") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                
                        <asp:TemplateField HeaderImageUrl="~/images/StarIconGold.png">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>                                                        
                                <asp:Image ID="ImageFlg2" runat="server" ImageUrl='<%# Eval("MarkURL") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>                    
                
                <asp:TemplateField HeaderText="Tittle">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Subject") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <a href='DisplayTask.aspx?taskOID=<%# Eval("taskOID")%>&keepThis=true&TB_iframe=true&height=460&width=600'
                            class="thickbox" id="insidegrid"><asp:Label ID="Label3" runat="server" Text='<%# Bind("Subject") %>' Font-Underline="True"></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TaskFrom" HeaderText="From" />
                <asp:BoundField HeaderText="Assigned" />
                <asp:BoundField DataField="CompletionDate" 
                    DataFormatString="{0:d}" HeaderText="Completed Date" />
                <asp:BoundField DataField="CompletionDate" 
                    DataFormatString="{0:T}" HeaderText="Completed Time" />
            </Columns>
        
         <HeaderStyle  />
            <SelectedRowStyle Height="10px" />
          <AlternatingRowStyle CssClass="altrow" />
        </asp:GridView> 
        </div>
                </div>
        </ContentTemplate>
                </asp:UpdatePanel>
        </td></tr>
    <tr><td> </td></tr>
    </table>
      
    
    <%--<table id="TasksGrid" cellpadding="0" cellspacing="0">
      
        <div id="TasksGridPager">
        </div>       
      
        
    </table>  --%>  
    </form>
    
</body>

</html>
