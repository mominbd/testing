﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamHome.aspx.cs" Inherits="ExamHome" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CVTC</title>

<script src="../../js/thickbox.js" type="text/javascript"></script>
<link href="../../themes/thickbox.css" rel="stylesheet" type="text/css" />
  
<link rel="stylesheet" type="text/css" media="screen" href="../../themes/redmond/jquery-ui-1.8.1.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../themes/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../themes/ui.multiselect.css" />
<style type="text/css">
html, body {
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */	
    font-size: 75%;
}
/*Splitter style */


#LeftPane {
	/* optional, initial splitbar position */
	overflow: auto;
}
/*
 * Right-side element of the splitter.
*/

#RightPane {
	padding: 2px;
	overflow: auto;
}
.ui-tabs-nav li {position: relative;}
.ui-tabs-selected a span {padding-right: 10px;}
.ui-tabs-close {display: none;position: absolute;top: 3px;right: 0px;z-index: 800;width: 16px;height: 14px;font-size: 10px; font-style: normal;cursor: pointer;}
.ui-tabs-selected .ui-tabs-close {display: block;}
.ui-layout-west .ui-jqgrid tr.jqgrow td { font-size:0.7em; border-bottom: 0px none;}
.ui-datepicker {z-index:1200;}
.rotate
    {
        /* for Safari */
        -webkit-transform: rotate(-90deg);

        /* for Firefox */
        -moz-transform: rotate(-90deg);

        /* for Internet Explorer */
        filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
    }

</style>

<script src="../../js/CustomJScript.js" type="text/javascript"></script>
<script src="../../js/jquery.js" type="text/javascript"></script>
<script src="../../js/jquery-ui-1.8.1.custom.min.js" type="text/javascript"></script>

<script src="../../js/jquery.layout.js" type="text/javascript"></script>
<script src="../../js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script type="text/javascript">
    $.jgrid.no_legacy_api = true;
    $.jgrid.useJSON = true;
</script>
<script src="../../js/ui.multiselect.js" type="text/javascript"></script>
<script src="../../js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../js/jquery.tablednd.js" type="text/javascript"></script>
<script src="../../js/jquery.contextmenu.js" type="text/javascript"></script>
<script type="text/javascript">

    jQuery(document).ready(function() {
        //$('#switcher').themeswitcher();

        $('body').layout({
            resizerClass: 'ui-state-default',
            west__onresize: function(pane, $Pane) {
                jQuery("#west-grid").jqGrid('setGridWidth', $Pane.innerWidth() - 2);
            }
        });
        $.jgrid.defaults = $.extend($.jgrid.defaults, { loadui: "enable" });
        var maintab = jQuery('#tabs', '#RightPane').tabs({
            add: function(e, ui) {
                // append close thingy
                $(ui.tab).parents('li:first')
                .append('<span class="ui-tabs-close ui-icon ui-icon-close" title="Close Tab"></span>')
                .find('span.ui-tabs-close')
                .click(function() {
                    maintab.tabs('remove', $('li', maintab).index($(this).parents('li:first')[0]));
                });
                // select just added tab
                maintab.tabs('select', '#' + ui.panel.id);
            }
        });
        
        //Added By Anisuzzaman on 15 June, 2011
        var aid=$("#HiddenAOID").val();
        //alert(aid);
        aid="MenuHandlerAssessment.ashx?aid="+aid;
        //alert(aid);
        jQuery("#west-grid").jqGrid({
      //      url: "tree.xml",
        url: aid,            //url: "pg/user/MyHandler.ashx", //,<a href="pg/user/MyHandler.ashx">pg/user/MyHandler.ashx</a>

            datatype: "xml",
            //datatype: "json",
            height: "auto",
            pager: false,
            loadui: "disable",
            colNames: ["id", " ", "url"],
            colModel: [
            { name: "id", width: 1, hidden: true, key: true },
            { name: "menu", width: 150, resizable: false, sortable: false },
            { name: "url", width: 1, hidden: true }
        ],
            treeGrid: true,
            caption: "CVTC ",
            ExpandColumn: "menu",
            autowidth: true,
            //width: 180,
            rowNum: 200,
            ExpandColClick: true,
            treedatatype: "xml",
            treeGridModel: 'adjacency',
            treeIcons: { leaf: 'ui-icon-document-b' },
            onSelectRow: function(rowid) {
            
                var treedata = $("#west-grid").jqGrid('getRowData', rowid);
                if (treedata.isLeaf == "true") {
                    //treedata.url
                    //alert(treedata.url);
                    
                    var st = "#t" + treedata.id;
                    if ($(st).html() != null) {
                        maintab.tabs('select', st);
                    } else {
                        maintab.tabs('add', st, treedata.menu);
                        //$(st,"#tabs").load(treedata.url);
                        $.ajax({
                            url: treedata.url,
                            type: "GET",
                            dataType: "html",
                            complete: function(req, err) {
                                //alert(treedata.url);

                                //                                if (treedata.url = 'pg/message/NewMessage.aspx') {
                                //                                    $("#hiddenPopup").click();                                    
                                //                                }

                                $(st, "#tabs").append('<iframe src="' + treedata.url + '" style="width:100%; min-height:800px;" scrolling="auto" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>');

                                //                                $(st, "#tabs").append(req.responseText);
                                //                                try { var pageTracker = _gat._getTracker("UA-5463047-4"); pageTracker._trackPageview(); } catch (err) { };
                                //                                var clck = '<p style="border: 1px solid; background-color: lemonchiffon; width:654px;height:25px;margin-bottom: 8px;padding-top: 8px;text-align: center">';
                                //                                clck += '<b>Please, support the jqGrid project by clicking on our sponsors ad! </b></p>';

                                //                                var fs = '<iframe src="adds.html" style="width:336px; height:290px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>\
                                //									&nbsp;&nbsp;&nbsp;&nbsp;<iframe src="adds3.html" style="width:336px; height:290px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>\
                                //									<br/><iframe src="adds2.html" style="width:336px; height:290px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>\
                                //									&nbsp;&nbsp;&nbsp;&nbsp;<iframe src="adds4.html" style="width:336px; height:290px;"scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>\
                                //							';
                                //                                //$(st,"#tabs").append(clck);
                                //                                //$(st,"#tabs").append(fs);
                            }
                        });
                    }
                }
            }
        });

        // end splitter

    });
</script>

<script type="text/javascript">

 jQuery(document).ready(function() {
    $('#btnRefresh').click(function() {
            //$('#west-grid').trigger("reloadGrid");
            //$('#west-grid').setGridParam({ url: 'MenuHandler.ashx' });
            //$("#west-grid").trigger("reloadGrid");
            
            $('#west-grid').trigger("reloadGrid");
            });
 });
</script>
</head>

<body>
    <input id="HiddenAOID" runat="server" name="HiddenAOID" type="hidden" value="0" />
  	<%--<div id="LeftPane" class="ui-layout-west ui-widget ui-widget-content">
  	<div style=" font-weight:bold; position:absolute; top:24px; left:20px;  height:25px; width:100px; z-index:999;"> 
          <asp:Label ID="LabelAsssessment" runat="server" Text="" Font-Bold="True" Font-Size="Medium" ForeColor="Black"></asp:Label></div>
		<table id="west-grid"></table>
		
		<div style="position:absolute;bottom:0px;padding-bottom:10px;padding-left:20px;"> 
            <asp:Label ID="LabelUserName" runat="server" Text=""></asp:Label></div>
	</div>--%> <!-- #LeftPane -->
	<div id="RightPane" class="ui-layout-center ui-helper-reset ui-widget-content" ><!-- Tabs pane -->
    <div style=" position:absolute; top:10px; right:10px;  height:25px; width:50px; z-index:999;"></div>
    <div id="switcher"></div>
		<div id="tabs" class="jqgtabs">
			<%--<ul>
				<li><a href="#tabs-1">Assessment Question  </a></li>

			</ul>--%>
			<div id="tabs-1" style="font-size:12px; font-weight:bold;"> &nbsp;<br/>
			<iframe src="QuestionSheet.aspx" style="width:100%; height:1200px; " scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>
			</div>
		</div>
	</div> <!-- #RightPane -->
</body>
</html>
