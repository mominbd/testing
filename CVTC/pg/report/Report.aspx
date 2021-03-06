﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="pg_Report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report</title>
    <link rel="stylesheet" type="text/css" media="screen" href="../../themes/redmond/jquery-ui-1.8.1.custom.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../themes/ui.jqgrid.css" />

    <script src="../../js/jquery.js" type="text/javascript"></script> 
    <script src="../../js/grid.locale-en.js" type="text/javascript"></script> 
    <script src="../../js/jquery.jqGrid.min.js" type="text/javascript"></script>
      <script type="text/javascript">
          var colNames = ['UserOID', 'User Name', 'Password', 'First Name', 'Last Name', 'Phone']; //, 'Email'
          var colMod = [
                        { name: 'UserOID', index: 'UserID', width: 100, hidden: true, sortable: false },
                        { name: 'UserName', width: 100, editable: true },
                        { name: 'Password', width: 80, editable: true, editrules: { edithidden: true }, hidden: true, edittype: 'password' },
                        { name: 'FirstName', width: 100, sortable: true, editable: true },
                        { name: 'LastName', width: 100, sortable: true, editable: true },
                        { name: 'Phone', width: 100, sortable: true, editable: true },
          //{ name: 'Email', width: 150, sortable: true, editable: true }
                    ];
          $(function() {
              $("#UsersGrid").jqGrid({
                  url: 'UserHandler.ashx',
                  datatype: 'json',
                  height: 250,
                  colNames: colNames,
                  colModel: colMod,
                  rowNum: 10,
                  rowList: [10, 20, 30],
                  pager: '#UsersGridPager',
                  sortname: 'UserOID',
                  viewrecords: true,
                  sortorder: 'asc',
                  altRows: true,
                  editurl: '',
                  caption: 'User Management '
              });

              $("#UsersGrid").jqGrid('navGrid', '#UsersGridPager', { edit: false, add: false, del: false });

              options = { autosearch: true };
              $("#UsersGrid").filterToolbar(options);



              var sgrid = $("#UsersGrid")[0];
              sgrid.triggerToolbar();

              $("#myButton").click(function() {
                  //                 $("#toolbar").setColumns({'CourseOID':'', 'Year':'',});
                  $("#UsersGrid").setColumns({ 'UserName': '' })
                  return false;
              });
              //$("#myButton").click(function () {
              //$("#UsersGrid").setColumns({ 'UserOID': '', 'UserName': '' });
              //  return false;
              //});


          });




          function SaveToDatabase() {

              var tmp = jQuery("#UsersGrid").jqGrid('getGridParam', 'colModel');
              var colModel = '[';
              for (i = 0; i < tmp.length; i++) {
                  //alert(tmp[i].serialize());
                  colModel += "{ name:'" + tmp[i].name + "', index:'" + tmp[i].width + "', hidden:'" + tmp[i].hidden + "',sortable:'" + tmp[i].sortable + "'}";
                  if (i < tmp.length - 1) {
                      colModel += ",";
                  }
                  else {
                      colModel += "]";
                  }
              }
              alert(colModel);

              var currentData = $('#UsersGrid').jqGrid('getDataIDs');
              alert(currentData);
              var colNames = $('#UsersGrid').jqGrid('getGridParam', 'colNames');
              alert(colNames);
             
             
          }

          

    </script>
 
    
</head>
<body>
   <form id="HtmlForm" runat="server">
    <table id="UsersGrid" cellpadding="0" cellspacing="0">
      
        <div id="UsersGridPager">
        </div>       
      
        
    </table>  
     <input id="myButton" type="button" value="Show/Hide column" />
     <input id="Button1" type="button" value="button" onclick="return SaveToDatabase();" />
    </form>
    
</body>
</html>
