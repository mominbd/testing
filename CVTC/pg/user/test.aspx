﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="pg_user_test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head id="Head1" runat="server">
    <title>User Management</title>
    

<link rel="stylesheet" type="text/css" media="screen" href="../../themes/redmond/jquery-ui-1.8.1.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../themes/ui.jqgrid.css" />


    <script src="../../js/jquery.js" type="text/javascript"></script>
 
    <script src="../../js/grid.locale-en.js" type="text/javascript"></script>
 
    <script src="../../js/jquery.jqGrid.min.js" type="text/javascript"></script>
 
    <script type="text/javascript">
        var colNames = ['UserOID', 'User Name', 'Password', 'First Name', 'Last Name', 'Phone']; //, 'Email'
    var colMod=[
                        { name: 'UserOID', index: 'UserID', width: 100, hidden:true,sortable: false },
                        { name: 'UserName', width: 100, editable: true },
                        { name: 'Password', width: 100, editable: true, editrules: {edithidden:true},  hidden: true, edittype:'password' },
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
                editurl: 'UserHandler.ashx',
                caption: 'User Management '
            });

            $("#UsersGrid").jqGrid('navGrid', '#UsersGridPager', { edit: true, add: true, del: true  });

            options = { autosearch: true };
            $("#UsersGrid").filterToolbar(options);



            var sgrid = $("#UsersGrid")[0];
             sgrid.triggerToolbar();

          
             //$("#myButton").click(function () {
             //$("#UsersGrid").setColumns({ 'UserOID': '', 'UserName': '' });
               //  return false;
             //});


        });




        function Button1_onclick() {

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
            //{ name: 'UserOID', index: 'UserID', width: 100, hidden:true,sortable: false },
//            var rows = jQuery("#UsersGrid").jqGrid('getRowData');
//            var paras = new Array();
//            for (var i = 0; i < rows.length; i++) {
//                var row = rows[i];
//                paras.push($.param(row));
//                alert(row[0]);
//            }
//            $.ajax({
//                type: "POST",
//                url: "User.aspx/ServerSideMethod",
//                data: paras.join('and'),
//                success: function(msg) {
//                    //alert(msg);
//                }
            //            });
            //var tmp;
            //tmp = $('#UsersGrid').jqGrid('getGridParam', 'rowNum')
//            alert(tmp);
//            tmp = $('#UsersGrid').jqGrid('getGridParam', 'sortname');
//            alert(tmp);
//            tmp = $('#UsersGrid').jqGrid('getGridParam', 'sortorder');
//            alert(tmp);
//            tmp = $('#UsersGrid').jqGrid('getGridParam', 'page');
//            alert(tmp);

            //tmp = $('#UsersGrid').jqGrid('getGridParam', 'colNames');
//            tmp = $('#UsersGrid').jqGrid('getDataIDs');
//            alert(tmp);
//            var i=0;
//            for (i = 0; i < tmp.length; i++) {
//                alert(tmp[i]);
//                         }
//            var savedata = $("#UsersGrid").jqGrid('jqGridExport', { exptype: "jsonstring" });
            //            //alert(savedata);
//            var savedata = "";
//            var t = "{ 'str': '" + savedata + "'} ";
//            $.ajax({
//                type: "POST",
//                url: "test.aspx/ServerSideMethod",
//                //data: "{}",
//                data: t,
//                contentType: "application/json; charset=utf-8",
//                dataType: "json",
//                async: true,
//                cache: false,
//                success: function(msg) {
//                    //alert(msg.d);
//                    savedata = msg.d;
//                    alert(savedata);
//                    //$('#myDiv').text(msg.d);
//                    $("#UsersGrid").GridUnload();
//                    $("#UsersGrid").jqGrid('jqGridImport', { imptype: "json", impstring: savedata })


//                }

//            })
//            var savedata;
//            $("#UsersGrid").GridUnload();
//            $("#UsersGrid").jqGrid('jqGridImport', { imptype: "json", impstring: savedata })
        }

    </script>
 
 
 
 
</head>
<body>
    <form id="HtmlForm" runat="server">
    <table id="UsersGrid" cellpadding="0" cellspacing="0">
      
        <div id="UsersGridPager">
        </div>       
      
        
    </table>  
    <input id="Button1" type="button" value="button" onclick="return Button1_onclick()" />
    <input id="Text1" type="text" /></form>
</body>
</html>
