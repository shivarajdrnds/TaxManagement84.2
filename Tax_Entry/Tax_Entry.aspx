﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tax_Entry.aspx.cs" Inherits="Gls_Tax" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="~/OKMessageBox.ascx" TagName="M1" TagPrefix="M1ok" %>

<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TaxEntry</title>
  <link href="../Styles/ControlsStyle.css" rel="Stylesheet" type="text/css" />
<link href="../Styles/popmodal.css" rel="Stylesheet" type="text/css" />
 <link href="../AdminStyle/WebHRStyleSheet.css" rel="stylesheet" type="text/css" />
<link href="../AdminStyle/stylesheet.css" type="text/css" rel="stylesheet" />
<link href="../AdminStyle/WebHRSprites.css" type="text/css" rel="stylesheet" />
<link href="../AdminStyle/WebHRButtons.css" type="text/css" rel="stylesheet" />
<link href="../AdminStyle/style.css" rel="stylesheet" type="text/css" />
    <link href="../AdminStyle/Fonts.css" rel="stylesheet" type="text/css" />
     <link href="../AdminStyle/Calcender.css" rel="stylesheet" type="text/css" />

        <link href="../AdminStyle/JqueryCalender.css" rel="stylesheet" type="text/css" />
           <script src="../AdminJs/jquery-1.3.2.min.js" type="text/javascript"></script>
           <script src="../AdminJs/jquery-ui-1.7.1.custom.min.js" type="text/javascript"></script>
    <script src="../AdminJs/script_color.js" type="text/javascript"></script>
    <script src="../AdminJs/search_script.js" type="text/javascript"></script>
<link rel="stylesheet" href="../AdminStyle/jQueryUI.css" />
<link media="screen" rel="stylesheet" href="../AdminStyle/jQueryColorbox.css" />
<link type="text/css" rel="stylesheet" href="../AdminStyle/cssWebHR.css" />
   <link href="../AdminStyle/ScrollBar.css" rel="stylesheet" type="text/css" />
 <script src="../AdminJs/jQuery.js" type="text/javascript"></script>
    <link href="../AdminStyle/DashboardStyle.css" rel="stylesheet" type="text/css" />
<script type="text/jscript" src="../AdminJs/jQueryUI.js"></script>
<script language="JavaScript" type="text/javascript" src="../AdminJs/jsWebHR.js"></script>
<script type="text/jscript" src="../AdminJs/jsHRMS.js"></script>
	<script src="../AdminJs/Backtotop.js" type="text/jscript"></script>
      <script>
          $(document).ready(function () { $("[data-slidepanel]").slidepanel({ orientation: "right", mode: "push" }); });
</script>


   <style type="text/css">

		.column { width: 33.3%; float: left; padding-bottom: 100px; }
		.portlet { margin: 0 1em 1em 0; }
		.portlet-header {  font-family:'ProximaNova-Light',Arial; font-size:20px; font-weight:normal; margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
		.portlet-header .ui-icon { display:none; float: right; }
		.portlet-content { padding: 0.4em; }
		.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
		.ui-sortable-placeholder * { visibility: hidden; }
		</style>
		<script type="text/javascript">
		    var cols = jQuery.parseJSON('{"prtColumn1":["prt1","prt2","prt3"],"prtColumn2":["prt4","prt5","prt6","prt7"],"prtColumn3":["prt8"]}');
		    $(function () {
		        $(".column").sortable({
		            connectWith: ".column",
		            //change: function(event, ui) { },
		            //update: function () {  }
		            create: function () { var colid = this.id; var col = cols[colid]; $.each(col, function (index, value) { $("#" + value).appendTo($("#" + colid)); }); },
		            update: function () {
		                $.get("../home/pages.php?page=Dashboard_Portlets", { col: this.id, sort: $(this).sortable("toArray").toString() });
		            }
		        });

		        $(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ")
		        //.find(".portlet-header")
		        //.addClass("ui-widget-header") 
		        //.prepend('<span class="ui-icon ui-icon-minus"></span>')
		        //.end()
				.find(".portlet-content");

		        //$(".portlet-header .ui-icon").click(function() {
		        //	$(this).toggleClass("ui-icon-minus").toggleClass("ui-icon-plus");
		        //	$(this).parents(".portlet:first").find(".portlet-content").toggle();
		        //});

		    });
		</script>
		
		<script>
		    var aEmployeeInfo = Array();
		    $(function () {
		        aEmployeeInfo["Inbox_NewMessages"] = 0;
		        aEmployeeInfo["Notifications"] = 0;

		        if (aEmployeeInfo["Inbox_NewMessages"] > 0) {
		            $("#divInboxBubble").show();
		            $("#divInboxBubble").html(aEmployeeInfo["Inbox_NewMessages"]);
		        }

		        if (aEmployeeInfo["Notifications"] > 0) {
		            $("#divNotificationsBubble").show();
		            $("#divNotificationsBubble").html(aEmployeeInfo["Notifications"]);
		        }

		        //setTimeout(function(){ alert(0); }, 20000);
		    });
		</script>
        <style type="text/css" >
 div#menu li { background: url() 98% 4px no-repeat; }
 .WebHRMenu 
 {
     width:100%;
      height:41px;   
            background: #008853;
  background-image: -webkit-linear-gradient(top, #008853, #007749);
  background-image: -moz-linear-gradient(top, #008853, #007749);
  background-image: -ms-linear-gradient(top, #008853, #007749);
  background-image: -o-linear-gradient(top, #008853, #007749);
  background-image: linear-gradient(to bottom, #008853, #007749);
  
  }
 .WebHRSearch { font-family:Trebuchet MS, Arial; font-size:11px; color:#ffffff; padding-left:5px; width:100px; margin-top:8px; height:19px; border:0px; background:url(../images/Template/Blue/search_left.png); outline:none; }
            .style3
            {
                width: 172px;
            }
            .style4
            {
                width: 380px;
            }
            .style5
            {
                width: 467px;
            }
        </style>
<script type="text/javascript">
    function SetTarget() {
        document.forms[0].target = "_blank";
    }
    </script>

<%--<script type="text/javascript">
    function PostToNewWindow() {
        originalTarget = document.forms[0].target;
        document.forms[0].target = '_blank';
        window.setTimeout("document.forms[0].target=originalTarget;", 300);
        return true;
    }
</script>
<script type="text/jscript">
    $("#txt_Tax_Comments, #txt_Client_Name").on("keypress", function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode == '13') {
           
            }
            $("#btn_Update").click();
        }
    });
</script>
<script  type="text/javascript">
    function btnreturn() {
        return confirm('Are You Proceed?');
    }
   
    
</script>

<script language="javascript" type="text/javascript">

    function openNewWin(url) {
        var x = window.open(url, 'mynewwin', 'width=600,height=600,toolbar=1');

        x.focus();

    }

</script>


<script type="text/javascript" language="javascript">
    function controlEnter(obj, event) {
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        if (keyCode == 13) {
            document.getElementById(obj).focus();
            return false;
        }
        else {
            return true;
        }
    }
</script>

    <script language="javascript" type="text/javascript">
        function ShowEditModal(ExpanseID) {
            var frame = $get('IframeEdit');
            frame.src = "EditExpanse.aspx?UIMODE=EDIT&EID=" + ExpanseID;
            $find('EditModalPopup').show();
        }
        function EditCancelScript() {
            var frame = $get('IframeEdit');
            frame.src = "DemoLoading.aspx";
        }
        function EditOkayScript() {
            RefreshDataGrid();
            EditCancelScript();
        }
        function RefreshDataGrid() {
            $get('btnSearch').click();
        }
        function NewExpanseOkay() {
            $get('btnSearch').click();
        }
</script>--%>

</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data" method="post">
    <div style="padding-bottom:60px;width:100%;">
  <div class="WebHRMenu">

 <div style="width:95%;">
  <div style="float:left; width:600px;">
   
   <div id="menu">
    <ul class="menu">
     <li class="current">
     <a>
     <asp:LinkButton ID="lnk_Home" runat="server" CssClass="linkLabel"  onclick="lnk_Home_Click"><span >Home
         </span></asp:LinkButton>
     </a>
     </li>
         <%--<li class="limasters">
     <a>
     <asp:LinkButton ID="LinkMydashboard"  CssClass="linkLabel" runat="server" 
              onclick="LinkMydashboard_Click" ><span>DashBoard</span></asp:LinkButton>
     </a>
     </li>--%>
  
     <li id="limasters" runat="server"><a class="linkLabel" href="#" ><span>Masters</span></a>
	
        <ul style="width:450px; height:140px; background:url(../AdminImage/menulist.jpg);">
      <li>
      <div style="margin-top:5px; clear:both;"></div>
	    <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_Company.aspx">Company</a></div>
	    <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_Branch.aspx">Branch</a></div>
    	<div style="margin-top:34px; clear:both;"></div>
	    <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_Client.aspx">Client Name</a></div>
	    <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_Order_Type.aspx">Order Type</a></div>
    	<div style="margin-top:64px; clear:both;"></div>
      <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_SubProcess.aspx">Sub Process</a></div>
	    <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_Order_Status.aspx">Order Status</a></div>
         <div style="margin-top:94px; clear:both;"></div>
         <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Tax_AssesmentLink.aspx">TaxAssesment</a></div>
   <div style="margin-top:124px; clear:both;"></div>
      </li>
	  </ul>
     </li>
     <li id="li_users" runat="server" ><a class="linkLabel" href="../Admin/User_Create.aspx"><span>Users</span></a>
	  <ul style="width:450px; height:65px; background:url(../AdminImage/menulist.jpg);">
        
      <li>
		

	    <div style="margin-top:5px; clear:both;"></div>
	    <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/User_Create.aspx">Create Users</a></div>
	    <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/ActiveInactiveusers.aspx">Deactive Users</a></div>
    	<div style="margin-top:34px; clear:both;"></div>
      <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Create_UserRole.aspx">Create User Role</a></div>
	       <div style="margin-top:64px; clear:both;"></div>
      </li>
	  </ul>
	 </li>
	    <li id="liTax_Masters" runat="server" ><a class="linkLabel" href="../Admin/Tax_Info.aspx"><span>Tax Masters</span></a>
	  <ul style="width:450px; height:45px; background:url(../AdminImage/menulist.jpg);">
      <li>
		

	    <div style="margin-top:5px; clear:both;"></div>
	    <div class="iemployeetrainings" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Import_County_Database_Information.aspx">Import County Database</a></div>
	    <div class="itrainingevents" style="float:left; margin-left:10px;"></div><div style="width:180px; float:left;"><a class="hrefLabel" href="../Admin/Tax_Info.aspx">Tax Master</a></div>
    	<div style="margin-top:34px; clear:both;"></div>
    
      </li>
	  </ul>
	 </li>
      <li id="liReports" runat="server" class="parent"><a class="linkLabel" href="Admin/User_Production_Report.aspx"><span>Reports</span></a>
                    	  <ul style="width:270px; height:85px; background:url(AdminImage/menulist_1.jpg);">
                          <li>

                    		<div style="margin-top:5px; clear:both;"></div>

                               <div class="ireports-hr" style="float:left; margin-left:10px;"></div><div style="width:200px; float:left;"><a class="hrefLabel" href="../Reports/Client_Prod_Report.aspx">Client Production Reports</a></div>
                                  <div style="margin-top:5px; clear:both;"></div>
                    		<div class="ireports-hr" style="float:left; margin-left:10px;"></div><div style="width:200px; float:left;"><a class="hrefLabel" href="../Reports/Tax_Violation_Report.aspx">Client Tax and Violation Reports</a></div>

                          </li>
                          
                    	  </ul>
                	   </li>
    
    </ul>
   </div>
  </div>

  <div style="float:right;">
   <div id="menu2">
    <ul class="menu2">
	 
	   <li class="last parent" style="padding-top:6px;"><span><asp:Label ID="Label13" runat="server" Text="Last Login:" CssClass="menuLabel" Font-Size="Small" ForeColor="White"></asp:Label></span></li>
       <li class="last parent" style="padding-top:6px;"><span><asp:Label ID="lastlogin" Font-Size="Small" runat="server" CssClass="menuLabel"  ForeColor="White"></asp:Label></span></li>
       <li class="last parent"><asp:Image ID="Img_User" Width="40px" Height="40px" CssClass="User-img" runat="server" /></li>
     <li class="last parent"><a href="#"><span><asp:Label ID="lblusername" CssClass="menuLabel" runat="server"></asp:Label></span></a><ul style="width:250px; height:90px; background:url(../AdminImage/menulist.jpg);">
         
      <li>
         
	  <table border="0" style="padding-left:0px;" cellspacing="0" cellpadding="4" width="100%">
	   <tr><td><a style="padding-left:0px;color: #000000;" href="../Admin/User_Profile.aspx">My Profile</a></td></tr>
	   <tr><td>
          <span> <a style="padding-left:0px; color: #000000;"  href="../Admin/Change_Password.aspx">Settings</a></span></td></tr>
             <tr><td>
          <span> <a style="padding-left:0px; color: #000000;"  href="../Login.aspx">Log Out</a></span></td></tr>
	  
	  </table>
      </li>
	  </ul>
	 </li>
      </ul>
    </div>
    
    
   </div></div>

 </div>
 </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="Divcreate" runat="server"  align="center" class="DivContentBody" style="height:100%; width:98%;margin:0 auto">


                 <table align="center" style=" width:98%; " >

                 <tr> <td ><br /></td></tr>
                   <tr >
                                        <td align="left" style="height:20px"
                                            valign="top">
                                        
                                            <asp:Button ID="tbpnluser" runat="server" Text="Web Info"  style="color:#FFFFFF;"
                                                CssClass="TabButton" onclick="tbpnluser_Click"  />
                                    <asp:Button ID="tabitcomplent" runat="server" Text="IT Complaints"  style="color:#FFFFFF;"
                                                CssClass="TabButton" onclick="tabitcomplent_Click" />

                                    <asp:Button ID="tbpnlusrdetails" runat="server"   Text="Order KB" CssClass="TabButton"  style="color:#FFFFFF;"
                                                onclick="tbpnlusrdetails_Click" />

                                      <asp:Button ID="tbpnljobdetails" runat="server" Text="Agency KB" style="color:#FFFFFF;" 
                                                CssClass="TabButton" onclick="tbpnljobdetails_Click" />

                                    <asp:Button ID="taboutputpreview" runat="server" Text="Out Put Preview" 
                                                CssClass="TabButton" onclick="taboutputpreview_Click" Visible="False" />
                                   
                                    <asp:Button ID="tabcountycmt" runat="server" Text="County Comments"  style="color:#FFFFFF;"
                                                CssClass="TabButton" onclick="tabcountycmt_Click" />

                                    <asp:Button ID="tabcounty" runat="server" Text="County DataBase" style="color:#FFFFFF;"  CssClass="TabButton" onclick="tabcounty_Click" />

                                      </td>
                                      
                            </tr>       
            
<tr id="td_row" style="height:100px"  runat="server">
<td  style="border:1px solid #003366" >

<table style="width:98%;height:100px;" id="Web_info" runat="server" visible="true" >
<tr>
<td>
 <asp:GridView ID="Grd_Tax_County_Link" runat="server" 
                                     AutoGenerateColumns="False" CellPadding="4" CssClass="name" 
                                  
                                    PageSize="1" 
                                     Width="100%" 
                                       GridLines="None" 
        onrowcommand="Grd_Tax_County_Link_RowCommand">
                                       
                                     <Columns>
                                        <asp:TemplateField Visible="false">
                                                          <ItemTemplate>
                                                          <asp:Label ID="lbl_County_Assement_Link_Id" runat="server" Visible="false"  Text='<%#Eval("County_Assement_Link_Id") %>'></asp:Label>
                                                          </ItemTemplate>
                                                          </asp:TemplateField>
                                                              <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="State">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblState" runat="server" CssClass="Label" 
                                                                    Text='<%#Eval("State") %>' ></asp:Label>
                                                                    <asp:Label ID="lbl_State_Id" runat="server" Visible="false" CssClass="Label" 
                                                                    Text='<%#Eval("State_ID") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>
                                                            <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="County">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCounty" runat="server" CssClass="Label" 
                                                                    Text='<%#Eval("County") %>' ></asp:Label>
                                                                    <asp:Label ID="lbl_county_Id" runat="server" Visible="false" CssClass="Label" 
                                                                    Text='<%#Eval("County_ID") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>
                                                            <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="County Taxes Link">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblCountyTax_Link" OnClientClick="SetTarget();" CommandName="Tax_Link" runat="server"
                                                                    Text='<%#Eval("CountyTax_Link") %>' ></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>
                                                            <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="Tax Office Phone No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax_PhoneNo" runat="server"  CssClass="Label"  
                                                                    Text='<%#Eval("Tax_PhoneNo") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>

                                                      <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="Property Assessor Link">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblAssessor_Link" OnClientClick="SetTarget();"   CommandName="Ass_link" runat="server" 
                                                                    Text='<%#Eval("Assessor_Link") %>' ></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>
                                                              <asp:TemplateField  HeaderStyle-CssClass="head-label" HeaderText="Assessor Phone No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAssessor_PhoneNo" runat="server" CssClass="Label" 
                                                                    Text='<%#Eval("Assessor_PhoneNo") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="admin_headstyle"  Height="30px"  HorizontalAlign="Center"  />
                                                            <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                                                        </asp:TemplateField>
                                                          
                                        
                                      
                                     </Columns>
                                       <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

                                 </asp:GridView>
                            </td>
                               </tr>
</table>



<table id="IT_comp" runat="server" 
        style="width:98%; " valign="top" visible="false" 
        align="center">

        <tr >
<td colspan="3" valign="top">

<div class="div_toprow" >
IT Complaint Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddITInfo" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddITInfo_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="3"  valign="top">
<div style="background-color:#fff;margin-top:-6px;">


   <asp:GridView ID="Grid_Order_IT_Error" runat="server" 
       AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True"   CssClass="name" CellPadding="4" Height="30px" PageSize="4" Width="100%"
        ShowHeaderWhenEmpty="True" Font-Bold="False" Font-Names="Segoe UI" 
        Font-Size="16px" onrowcommand="Grid_Order_IT_Error_RowCommand" 
        onpageindexchanging="Grid_Order_IT_Error_PageIndexChanging" >
                                      
                            <Columns>
                            
                            <asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
  <ItemTemplate>
    <asp:Label ID="lblITOrder_Kb_Id" runat="server" CssClass="Label" Text='<%#Eval("IT_Error_Id") %>' Visible="false"></asp:Label>
    </ItemTemplate>
     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item"   Height="20px" Width="30px" /> 
</asp:TemplateField>

<asp:TemplateField  HeaderText="S.No" SortExpression="Order_Number"  HeaderStyle-CssClass="head-label"><ItemTemplate>
<asp:Label     ID="lblsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label></ItemTemplate>
  <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"    CssClass="grid-item" Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="Complaint Name" SortExpression="Document_Name" HeaderStyle-Font-Bold="true"  
                                    HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblErrorDocument_Name" runat="server"  Text='<%#Eval("Error_Name") %>'></asp:Label>
</ItemTemplate>
  <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
  <ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"  Height="20px" Width="30px"  CssClass="grid-item" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="File" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtndoc" ImageUrl="~/Admin/MsgImage/Download.png" runat="server"   CommandName="ViewDocument" Height="30px"   Width="30px" />

<asp:Label    ID="lbl_ITorderkb_doc_path" runat="server" CssClass="Label" Text='<%#Eval("Error_Path") %>' Visible="false"></asp:Label>
</ItemTemplate>
 <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"  Height="20px" Width="30px"  CssClass="grid-item" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="Username" SortExpression="Comments" HeaderStyle-Font-Bold="true"  
                                    HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label    ID="lblitusername" runat="server"  Text='<%#Eval("User_Name") %>'></asp:Label>
</ItemTemplate>
 <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  CssClass="grid-item"  VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField  HeaderText="Date" SortExpression="Loan_Number" HeaderStyle-Font-Bold="true"  
                                    HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label     ID="lblUser_date" runat="server" Text='<%#Eval("Inserted_date") %>'></asp:Label>
</ItemTemplate>
 <HeaderStyle CssClass="head_style"  HorizontalAlign="Center" VerticalAlign="Middle"    Height="30px"  />
<ItemStyle CssClass="grid-item" VerticalAlign="Middle" HorizontalAlign="Center"    Height="20px" Width="30px"  />
</asp:TemplateField>
<asp:TemplateField HeaderText="Delete" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamDelete" runat="server" CommandName="DeleteRecord" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
Width="20px" />
</ItemTemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"    Height="20px" Width="30px" CssClass="grid-item"  />
</asp:TemplateField>


                                
                            </Columns>
                            <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView> 
                      
</div>
</td>
</tr>

<tr id="tr_ITcomp" runat="server" visible="false" >


<td  style="width: 627px"  >
<asp:Label Width="100px" ID="Label30" runat="server" CssClass="Label" 
        Text="IT Complaints:"></asp:Label>
</td>
<td style="width: 300px"    >
                                                       
<asp:Label Width="100px" ID="Label53" runat="server" CssClass="Label" 
        Text="Upload File"></asp:Label>
</td>
<td rowspan="2" width="625px" valign="middle" align="left">
    <asp:Button ID="btn_Error_Submit" runat="server" CssClass="WebButton" 
                    OnClick="btn_Error_Submit_Click" 
                    OnClientClick="return alert('Are You Sure ?');return true;" Text="Save" 
                    Width="75px" TabIndex="3" />&nbsp;
    <asp:Button ID="btn_Cancel_Complaint" runat="server" CssClass="WebButton" 
                    OnClick="btn_Cancel_Complaint_Click" 
                  Text="Cancel" 
                    Width="75px" TabIndex="4" />
</td>    
             
                
</tr>


<tr id="tr_ITcomp1" runat="server" visible="false" >
   <td valign="top" style="width: 627px" >
<asp:TextBox ID="txt_Error" runat="server" CssClass="textbox" 
           Height="25px" Width="588px" TabIndex="1" 
          ></asp:TextBox>
                
            </td>
            <td valign="middle" style="width: 300px">
            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                    <ContentTemplate>
                        <asp:FileUpload ID="fileupload3" runat="server" CssClass="textbox" 
                            TabIndex="2" />
                            </ContentTemplate>
                            <Triggers>
                        <asp:PostBackTrigger ControlID="btn_Error_Submit" />
                    
                    </Triggers>
                    </asp:UpdatePanel>
                
            </td>

     
    </tr>

</table>

<table id="Order_Kb" runat="server" style="width:98%;height:80px;vertical-align: top;" visible="false" align="center">
<tr >
<td colspan="4" valign="top">

<div class="div_toprow" >
Order Kb Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddOrder" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddOrder_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="4"  valign="top">
<div style="background-color:#fff;margin-top:-6px;">

   <asp:GridView ID="grd_order_kb" runat="server" 
       AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True"   CssClass="name" CellPadding="4" Height="30px" PageSize="4" Width="100%" 
        onrowdatabound="grd_order_kb_RowDataBound"
        ShowHeaderWhenEmpty="True" Font-Bold="False" Font-Names="Segoe UI" 
        Font-Size="16px" onrowcommand="grd_order_kb_RowCommand" 
        onpageindexchanging="grd_order_kb_PageIndexChanging" >
                                      
                            <Columns>
                            
                            <asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
  <ItemTemplate>
    <asp:Label ID="lblOrder_Kb_Id" runat="server" CssClass="Label" Text='<%#Eval("Order_Kb_Id") %>' Visible="false"></asp:Label>
    </ItemTemplate>
     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item"   Height="20px" Width="30px" /> 
</asp:TemplateField>

<asp:TemplateField  HeaderText="S.No" SortExpression="Order_Number"  HeaderStyle-CssClass="head-label"><ItemTemplate>
<asp:Label     ID="lblsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label></ItemTemplate>
  <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"    CssClass="grid-item" Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="Documents" SortExpression="Document_Name" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblDocument_Name" runat="server"  Text='<%#Eval("Document_Name") %>'></asp:Label>
</ItemTemplate>
  <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
  <ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"  Height="20px" Width="30px"  CssClass="grid-item" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="File" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtndoc" ImageUrl="~/Admin/MsgImage/Download.png" runat="server"   CommandName="ViewDocument" Height="30px"  Visible="false" Width="30px" />
<asp:Label       ID="lbl_Order_Kb_File_Type" runat="server" CssClass="Label"  Text='<%#Eval("Order_kb_File_Type") %>' Visible="false"></asp:Label>
<asp:Label    ID="lbl_orderkb_doc_path" runat="server" CssClass="Label" Text='<%#Eval("Order_Kb_Path") %>' Visible="false"></asp:Label>
</ItemTemplate>
 <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"  Height="20px" Width="30px"  CssClass="grid-item" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="Comments" SortExpression="Comments" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label    ID="lblComments" runat="server"  Text='<%#Eval("Comments") %>'></asp:Label>
</ItemTemplate>
 <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  CssClass="grid-item"  VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField  HeaderText="Updated By" SortExpression="Loan_Number" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label     ID="lblUser_Name" runat="server" Text='<%#Eval("User_Name") %>'></asp:Label>
</ItemTemplate>
 <HeaderStyle CssClass="head_style"  HorizontalAlign="Center" VerticalAlign="Middle"    Height="30px"  />
<ItemStyle CssClass="grid-item" VerticalAlign="Middle" HorizontalAlign="Center"    Height="20px" Width="30px"  />
</asp:TemplateField>
<asp:TemplateField HeaderText="Updated When" SortExpression="Date" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblModified_Date" runat="server" Text='<%#Eval("Modified_Date") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  CssClass="grid-item"  VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="View" HeaderStyle-CssClass="head-label" HeaderStyle-Font-Bold="true" >
<ItemTemplate>
<asp:ImageButton  ID="imgbtnEdit" runat="server" CommandName="EditRecord" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" /></ItemTemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"   Height="30px" Font-Bold="True"  />
<ItemStyle  CssClass="grid-item"  VerticalAlign="Middle" HorizontalAlign="Center" Width="16px">
</ItemStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="Delete" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamDelete" runat="server" CommandName="DeleteRecord" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
Width="20px" />
</ItemTemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="head_style"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" HorizontalAlign="Center"    Height="20px" Width="30px" CssClass="grid-item"  />
</asp:TemplateField>


                                
                            </Columns>
                            <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView> 
</div>
</td>
</tr>


<tr><td style="width: 160px"><br /></td></tr>
<tr id="tr_OrderKb" runat="server" visible="false" >
<td valign="top" style="width: 160px" ><asp:Label ID="Label8" runat="server" CssClass="Label" Text="Document"></asp:Label></td>
<td style="width: 243px" ><asp:Label ID="Label9" runat="server" CssClass="Label" Text="Comments"></asp:Label></td>
<td style="width: 328px"><asp:Label ID="Label27" runat="server" CssClass="Label" Text="Upload Document"></asp:Label></td>
<td rowspan="2" width="600px">
<asp:Button ID="img_btn_order_kb_add" runat="server" CssClass="WebButton" 
                    OnClick="img_btn_order_kb_add_Click" 
                    Text="Save" 
                    Width="75px" TabIndex="4" />

<asp:Button ID="img_btn_order_kb_Cancel" runat="server" CssClass="WebButton" 
                    OnClick="img_btn_order_kb_Cancel_Click" 
                    Text="Cancel" 
                    Width="75px" TabIndex="5" />

</td>
</tr>

<tr id="tr_OrderKb1" runat="server" visible="false">
<td valign="top" style="width: 160px">
<asp:TextBox ID="txt_order_Kb_Document" runat="server" CssClass="textbox" 
        style="text-transform:uppercase;" Width="150px" TabIndex="1"></asp:TextBox>
</td>
<td valign="top" style="width: 243px">
    <asp:TextBox ID="txt_order_Kb_Comment" runat="server" CssClass="textbox" 
        placeholder="Type Comments here"  Width="647px" Height="25px" TabIndex="2"></asp:TextBox>
    </td>
<td valign="top" style="width: 328px"><asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:FileUpload ID="fileupload1" runat="server" CssClass="textbox" 
            TabIndex="3" />
    </ContentTemplate>
    <triggers>
<asp:PostBackTrigger ControlID="img_btn_order_kb_add"></asp:PostBackTrigger></triggers></asp:UpdatePanel>
</td>

</tr>

</table>

<table id="Agency_Kb" runat="server" style="width:98%;height:80px;vertical-align: top;" visible="false" align="center">

<tr>
<td colspan="3" valign="top">
<div class="div_toprow">
Agency Kb Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddAgency" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddAgency_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="3" valign="top">
<div style="background-color:#fff;margin-top:-6px;">
<asp:GridView ID="grd_Agency" runat="server" AutoGenerateColumns="False"   
          HorizontalAlign="Center" 
   AllowPaging="True"   CssClass="name" CellPadding="4" Height="30px" PageSize="4" Width="100%" 
        ShowHeaderWhenEmpty="True"  onrowcommand="grd_Agency_RowCommand" 
        onpageindexchanging="grd_Agency_PageIndexChanging" >
                                      
                        <Columns>

<asp:TemplateField HeaderText="id" Visible="False"  HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label"><ItemTemplate>
<asp:Label ID="lbl_Agency_Order_Kb_Id" runat="server"  Text='<%#Eval("Order_Agency_Kb_Id") %>' Visible="false"></asp:Label>
</ItemTemplate>

<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" CssClass="grid-item"  Height="20px" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="S.No" SortExpression="Order_Number"  HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblagnsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="Comments" SortExpression="Comments" HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Agency_Comments" runat="server"  Text='<%#Eval("Comments") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" CssClass="grid-item"   Height="20px" Width="30px" />
</asp:TemplateField>
<asp:TemplateField  HeaderText="Updated By" SortExpression="Loan_Number"  HeaderStyle-Font-Bold="true"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Agency_User_Name" runat="server"  Text='<%#Eval("User_Name") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" CssClass="grid-item"   Height="20px" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Updated When" SortExpression="Date" HeaderStyle-Font-Bold="true"   HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Agency_Modified_Date" runat="server"  Text='<%#Eval("Modified_Date") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  VerticalAlign="Middle" CssClass="grid-item"   Height="20px" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="View" HeaderStyle-CssClass="head-label" HeaderStyle-Font-Bold="true" >
<ItemTemplate>
<asp:ImageButton  ID="imgbtnExamEdit" runat="server" CommandName="EditRecord" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>

<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="16px" /> 

</asp:TemplateField>
<asp:TemplateField HeaderText="Delete"  HeaderStyle-CssClass="head-label" HeaderStyle-Font-Bold="true" >
<ItemTemplate>
<asp:ImageButton   ID="imgbtnExamDelete" runat="server" CommandName="DeleteRecord" 
Height="20px"  ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="16px" /> 
</asp:TemplateField>

</Columns>
    
<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
</div>
</td></tr>



<tr><td><br /></td></tr>

<tr id="tr_Agency" runat="server" visible="false">
<td width="100px" align="left"><asp:Label ID="Label2" runat="server" CssClass="Label"  Text="Comments:" /></td>
<td width="300px" align="left" ><asp:TextBox ID="txt_Agency_Comment" runat="server" 
        CssClass="textbox" Width="500px" TabIndex="1"></asp:TextBox>
</td>
<td width="500px">
<asp:Button ID="imgbtn_agency_Add" runat="server" CssClass="WebButton" 
                    OnClick="imgbtn_agency_Add_Click" 
                    Text="Save" 
                    Width="75px" TabIndex="2" />

    <%--<asp:LinkButton ID="lbl_Deliquent_Tax_Type" runat="server" CommandName="Select" Text='<%#Eval("Tax_Type") %>'></asp:LinkButton>--%>
<asp:Button ID="imgbtn_agency_Cancel" runat="server" CssClass="WebButton" 
                    OnClick="imgbtn_agency_Cancel_Click" 
                    Text="Cancel" 
                    Width="75px" TabIndex="3" />

    </td>
</tr>

</table>

<table id="Out_Put_Preview" runat="server" style="width:98%;height:100px;"  visible="false">
</table>

<table id="County_Comm" runat="server" style="width:98%;height:80px;vertical-align: top;" visible="false" align="center">
<tr>
<td colspan="3" valign="top">
<div class="div_toprow" >
County Comment Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddCountyCmt" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddCountyCmt_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="3" valign="top">
<div style="background-color:#fff;margin-top:-6px;">
<asp:GridView ID="Grd_Tax_Type_Comments" runat="server" 
        AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True"  CellPadding="4"  CssClass="name" 
         BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" Width="100%" 
        ShowHeaderWhenEmpty="True" onrowdeleting="Grd_Tax_Type_Comments_RowDeleting" 
        onselectedindexchanged="Grd_Tax_Type_Comments_SelectedIndexChanged" 
        DataKeyNames="Note_Id" 
        onpageindexchanging="Grd_Tax_Type_Comments_PageIndexChanging" >
    <Columns>
<asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblTax_Id" runat="server" CssClass="Label" Text='<%#Eval("Tax_Id") %>' Visible="false"></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>
<asp:TemplateField HeaderText="id" Visible="False"  HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label  ID="lblNote_Id" runat="server"  Text='<%#Eval("Note_Id") %>'   Visible="false"></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 
</asp:TemplateField>

<asp:TemplateField HeaderText="S.No" SortExpression="Order_Number" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblagnsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  VerticalAlign="Middle" Height="30px" Font-Bold="True"  />
<ItemStyle  HorizontalAlign="Center"  VerticalAlign="Middle" CssClass="grid-item" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Tax Type" SortExpression="Loan_Number" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Tax_Type_User_Name" runat="server" Text='<%#Eval("Tax_Type") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  VerticalAlign="Middle"  Height="30px" Font-Bold="True"  />
<ItemStyle  HorizontalAlign="Center"  VerticalAlign="Middle" CssClass="grid-item" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Comments" SortExpression="Note" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Taxtype_Comments" runat="server"  Text='<%#Eval("Note") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  VerticalAlign="Middle" Height="30px" Font-Bold="True"  />
<ItemStyle  HorizontalAlign="Center"  VerticalAlign="Middle" CssClass="grid-item" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="View">
<ItemTemplate>
<asp:ImageButton ID="imgbtnCommentsEdit" runat="server" CommandName="Select" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  VerticalAlign="Middle" Height="30px" Font-Bold="True"  />
<ItemStyle  HorizontalAlign="Center"  VerticalAlign="Middle" CssClass="grid-item" Width="30px" />
</asp:TemplateField>
                                                             
<asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnCommentsDelete" runat="server" CommandName="Delete" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" VerticalAlign="Middle" Width="16px" />
</asp:TemplateField>
</Columns>
<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />
</asp:GridView>
</div>
</td></tr>


<tr><td style="width: 176px"><br /></td></tr>
<tr id="tr_CountyData" runat="server" visible="false">
<td style="width: 176px" ><asp:Label ID="Label35" runat="server" CssClass="Label" Text="Tax Type"></asp:Label></td>
<td  style="width: 443px" ><asp:Label ID="Label26" runat="server" CssClass="Label"  Text="Comments:"></asp:Label></td>
<td rowspan="2" valign="middle" width="500">
<asp:Button ID="ImageButton3" runat="server" CssClass="WebButton" 
                    OnClick="imgbtn_Taxtype_Note_Add_Click" 
                    Text="Save" 
                    Width="75px" TabIndex="3" />


    <%--<asp:LinkButton ID="lbl_Deliquent_Tax_Type" runat="server" CommandName="Select" Text='<%#Eval("Tax_Type") %>'></asp:LinkButton>--%>
<asp:Button ID="btn_County_Database_cacnel" runat="server" CssClass="WebButton" 
                    OnClick="btn_County_Database_cacnel_Click" 
                    Text="Cancel" 
                    Width="75px" TabIndex="4" />


</td>

</tr>
<tr id="tr_CountyData1" runat="server" visible="false">
<td style="width: 176px"><asp:DropDownList ID="ddl_TaxType_Commts" runat="server" CssClass="DropDown" TabIndex="1" Width="175px" ></asp:DropDownList></td>
<td style="width: 443px">
    <asp:TextBox ID="Txt_taxtype_Comments" runat="server" 
        CssClass="textbox" Height="20px" Width="496px" TabIndex="2" ></asp:TextBox></td>

</tr>

</table>



</td>
</tr>
  
<tr id="tr_county" runat="server" visible="false" valign="top" >
<td >

<table id="County_Db" runat="server" visible="false"  style="height:20px;width:98%;" 
        align="left">
<tr valign="top">
<td><asp:Button ID="btn_CountyDB" runat="server" Text="County Database" 
        CssClass="TabButton" onclick="btn_CountyDB_Click"  />
    <asp:Button ID="btn_DelequentDb" runat="server" Text="Delequent Database" 
        CssClass="TabButton" onclick="btn_DelequentDb_Click"  />
</td>

</tr>

</table>

</td>
</tr>




<tr id="tr_countydb" runat="server" visible="false" valign="top" >
<td style="border:1px solid #003366">
<table id="btn_lnkCountyDb" runat="server" style="height:100px;width:100%;" visible="false" >
<tr ><td colspan="5" valign="top">
<div class="div_toprow" >
County Database Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddCountyDb" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddCountyDb_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="5" valign="top">
 <div style="background-color:#fff;margin-top:-6px;">
<asp:GridView ID="grd_Tax_County_Database" runat="server" 
        AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" Width="100%" 
        ShowHeaderWhenEmpty="True" 
         onrowcommand="grd_Tax_County_Database_RowCommand1" 
         onpageindexchanging="grd_Tax_County_Database_PageIndexChanging">

<Columns>
<asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Conty_Database_Id" runat="server" Text='<%#Eval("Conty_Database_Id") %>' Visible="false"></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="S.No" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
</ItemTemplate>
<HeaderStyle   CssClass="head_style" HorizontalAlign="Center"  Height="30px" Font-Bold="True" />
<ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item"  Width="30px"/>
</asp:TemplateField>
<asp:TemplateField HeaderText="Tax Type" SortExpression="Tax_Type" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_County_Tax_Type" runat="server"  Text='<%#Eval("Tax_Type") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
</asp:TemplateField>

<asp:TemplateField HeaderText="Phone No" SortExpression="Ph_No" HeaderStyle-CssClass="head-label">

<ItemTemplate>
<asp:Label ID="lbl_Ph_No" runat="server"  Text='<%#Eval("Ph_No") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Make Changes Payable To" SortExpression="Make_Changes_Payable_to" HeaderStyle-CssClass="head-label">

<ItemTemplate>
<asp:Label ID="lbl_Make_Changes_Payable_to" runat="server"  Text='<%#Eval("Make_Changes_Payable_to") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center"  Height="30px"  Font-Bold="True" />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="300px" /></asp:TemplateField>
<asp:TemplateField HeaderText="Payee Address" SortExpression="Make_Changes_Payable_to" HeaderStyle-CssClass="head-label">

<ItemTemplate>
<asp:Label  ID="lbl_Payee_Address" runat="server"   Text='<%#Eval("Payee_Address") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
<ItemStyle  HorizontalAlign="Center" CssClass="grid-item" Width="300px" />
</asp:TemplateField>
<asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="Delete">
<ItemTemplate>
<asp:ImageButton ID="imgbntaxdel" runat="server" CommandName="DeleteRecord" Height="20px" 
                                                                ImageUrl="~/images/Gridview/Remove-icon.png" 
                                                               OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                                                Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="16px"></ItemStyle>
</asp:TemplateField>
</Columns>
<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

</asp:GridView>

    </div>
</td>
</tr>

<tr id="tr_CountyDbInfo" runat="server" visible="false">
<td style="width: 188px">
<asp:Label ID="Label5" runat="server" CssClass="Label" Text="Tax Type:"></asp:Label>
</td>
<td style="width: 199px">
<asp:Label ID="Label100" runat="server" CssClass="Label" Text="Agency Type:"></asp:Label>
</td>
<td style="width: 495px">
    &nbsp;</td>
<td style="width: 441px">
    &nbsp;</td>
<td rowspan="4" width="100">
<asp:Button ID="btn_AddCountyTax" runat="server" CssClass="WebButton" 
                    OnClick="btn_AddCountyTax_Click" 
                    Text="Submit" 
                    Width="75px" TabIndex="5" />
    <%--<asp:LinkButton ID="lbl_Deliquent_Tax_Type" runat="server" CommandName="Select" Text='<%#Eval("Tax_Type") %>'></asp:LinkButton>--%>
</td>
</tr>

<tr id="tr_CountyDbInfo1" runat="server" visible="false">
<td style="width: 188px">
<asp:DropDownList ID="ddl_CountyTaxtype" runat="server" CssClass="DropDown" 
        TabIndex="1" Width="184px"></asp:DropDownList>
</td>
<td colspan="2">
<asp:DropDownList ID="ddl_Agency_Type" runat="server" CssClass="DropDown" 
        TabIndex="1" Width="250px" AutoPostBack="True" 
        onselectedindexchanged="ddl_Agency_Type_SelectedIndexChanged"></asp:DropDownList>
</td>
<td style="width: 441px">
    &nbsp;</td>
</tr>

<tr id="tr_CountyDbInfo2" runat="server" visible="false">
<td style="width: 188px">
<asp:Label ID="Label6" runat="server" CssClass="Label" Text="Phone No:"></asp:Label>
</td>
<td style="width: 199px">
    &nbsp;</td>
<td style="width: 495px">
<asp:Label ID="Label7" runat="server" CssClass="Label" Text="Make Changes Payble To"></asp:Label>
</td>
<td style="width: 441px">
<asp:Label ID="Label10" runat="server" CssClass="Label" Text="Payee Address:"></asp:Label>
</td>
</tr>
<tr id="tr_CountyDbInfo3" runat="server" visible="false">
<td valign="top" colspan="2">
<asp:TextBox ID="txt_CountyPhno" runat="server" CssClass="textbox" TabIndex="2" 
        Width="240px"></asp:TextBox>
</td>
<td style="width: 495px" valign="top">
<asp:TextBox ID="txt_CountyPayto" runat="server" 
        CssClass="textMultiline" TabIndex="3" 
        Width="328px"></asp:TextBox>
</td>
<td style="width: 651px" valign="top">
<asp:TextBox ID="txt_CountyTaxPayeeadd" runat="server" 
        CssClass="textMultiline" TabIndex="4" 
        Width="451px"></asp:TextBox>
</td>
</tr>
</table>



<table id="btnlnkDelequentDb" style="height:100px;width:100%;"  runat="server" visible="false" >
<tr>
<td colspan="5" valign="top">
<div class="div_toprow" >
Delequent Database Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddDelequent" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddDelequent_Click" />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="5" valign="top">
<div style="background-color:#fff;margin-top:-6px;">
<asp:GridView ID="Grid_Delequent_Data" runat="server" AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" PageSize="4" Width="100%" 
        ShowHeaderWhenEmpty="True" 
      
        onrowdeleting="Grid_Delequent_Data_RowDeleting" 
        onselectedindexchanged="Grid_Delequent_Data_SelectedIndexChanged" 
        onpageindexchanging="Grid_Delequent_Data_PageIndexChanging">

<Columns>

<asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Delequent_Database_Id" runat="server" CssClass="Label" Text='<%#Eval("Delequent_Database_Id") %>' Visible="false"></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center" Height="30px" Font-Bold="True"   />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="S.No" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblsi" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Tax Type" SortExpression="Tax_Type" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<%--<asp:LinkButton ID="lbl_Deliquent_Tax_Type" runat="server" CommandName="Select" Text='<%#Eval("Tax_Type") %>'></asp:LinkButton>--%>
<asp:Label ID="lbl_Deliquent_Tax_Type" runat="server" Text='<%#Eval("Tax_Type") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Phone No" SortExpression="Ph_No" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Deliquent_Ph_No" runat="server"  Text='<%#Eval("Ph_No") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Make Changes Payable To" SortExpression="Make_Changes_Payable_to" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Deliquent_Make_Changes_Payable_to" runat="server"  Text='<%#Eval("Make_Changes_Payable_to") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center" Height="30px" Font-Bold="True"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="300px" />
</asp:TemplateField>
<asp:TemplateField  HeaderText="Payee Address" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label  ID="lbl_Deliquent_Payee_Address" runat="server"  Text='<%#Eval("Payee_Address") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle  CssClass="head_style"  HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
<ItemStyle  HorizontalAlign="Center" CssClass="grid-item"  Width="300px" />
</asp:TemplateField>
<asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="Delete">
<ItemTemplate>
<asp:ImageButton ID="imgbntaxdel" runat="server" CommandName="Delete" Height="20px" 
                                                                ImageUrl="~/images/Gridview/Remove-icon.png" 
                                                               OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                                                Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="16px"></ItemStyle>
</asp:TemplateField>
</Columns>
<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />
</asp:GridView>
                                                        
</div>
</td></tr>


<tr><td style="width: 188px"><br /></td></tr>
<tr id="tr_DelequentDb" runat="server" visible="false">
<td style="width: 188px">
<asp:Label ID="Label46" runat="server" CssClass="Label" Text="Tax Type:"></asp:Label>
</td>
<td style="width: 199px">
<asp:Label ID="Label49" runat="server" CssClass="Label" Text="Phone No:"></asp:Label>
</td>
<td style="width: 495px">
<asp:Label ID="Label48" runat="server" CssClass="Label" Text="Make Changes Payble To"></asp:Label>
</td>
<td style="width: 400px">
<asp:Label ID="Label50" runat="server" CssClass="Label" Text="Payee Address:"></asp:Label>
</td>
<td rowspan="2" width="100">
<asp:Button ID="imgbtn_Delequent_Tax_Add" runat="server" CssClass="WebButton" 
                    OnClick="imgbtn_Delequent_Tax_Add_Click" 
                    Text="Save" 
                    Width="75px" />
                    <asp:Button ID="imgbtn_Delequent_Tax_Cancel" runat="server" CssClass="WebButton" 
                    OnClick="imgbtn_Delequent_Tax_Cancel_Click" 
                    Text="Cancel" 
                    Width="75px" />
  
</td>
</tr>
<tr id="tr_DelequentDb1" runat="server" visible="false">
<td style="width: 188px" valign="top">
<asp:DropDownList ID="ddl_Tax_Delquent_Tax_type" runat="server" CssClass="DropDown" 
        TabIndex="1" Width="184px" 
        onselectedindexchanged="ddl_Tax_Delquent_Tax_type_SelectedIndexChanged"></asp:DropDownList>
</td>
<td style="width: 199px" valign="top">
<asp:TextBox ID="txt_delequent_phno" runat="server" CssClass="textbox" TabIndex="2" 
        Width="197px"></asp:TextBox>
</td>
<td valign="top" class="style5">
<asp:TextBox ID="txt_Delequent_Make_Changes" runat="server" 
        CssClass="textMultiline" TabIndex="3" 
        Width="328px"></asp:TextBox>
</td>
<td valign="top" class="style4">
<asp:TextBox ID="txt_Delequent_Payee_addres" runat="server" 
        CssClass="textMultiline" TabIndex="4" 
        Width="400px"></asp:TextBox>
</td>
</tr>




</table>
</td>
</tr>






</table>



          <table align="center" style="width:98%; " >
          <tr>
          <td>
<asp:Button ID="btn_Preview" runat="server"  OnClientClick="SetTarget();"  CssClass="TabButton" 
                                                            onclick="btn_Preview_Click" Text="Preview" />
<asp:Button ID="btn_Complete" runat="server" CssClass="TabButton" 
                  onclick="btn_Complete_Click"   
                  OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                  Text="Submit" />
<asp:Button ID="btn_Send" runat="server" CssClass="TabButton" Text="Send" onclick="btn_Send_Click" />
<asp:Button ID="btn_PreviewMail" runat="server" CssClass="TabButton" OnClientClick="SetTarget();"  Text="Template 1" 
                  onclick="btn_PreviewMail_Click" />
<asp:Button ID="btn_PreviewFax" runat="server" CssClass="TabButton" OnClientClick="SetTarget();"  Text="Template 2" 
                  onclick="btn_PreviewFax_Click" />
<asp:Button ID="btn_PreviewEfax" runat="server" CssClass="TabButton" Text="Export to Excel" 
                  onclick="btn_PreviewEfax_Click" />
<asp:Button ID="btn_Update" runat="server" Visible="false" CssClass="TabButton" onclick="btn_Update_Click" Text="Update Order Info" Width="100px" />
<asp:TextBox ID="txt_Date" Visible="False" runat="server" CssClass="textbox" 
                  style="text-transform:uppercase;"   TabIndex="19" Enabled="False" Width="70px" 
                  Wrap="False"></asp:TextBox>
<asp:filteredtextboxextender ID="filter_Date" runat="server" Enabled="True" FilterType="Custom, Numbers" TargetControlID="txt_Date" ValidChars="_/">
</asp:filteredtextboxextender>

<asp:calendarextender ID="txt_Date_CalendarExtender" runat="server" Enabled="True" Format="MM/dd/yyyy" TargetControlID="txt_Date"></asp:calendarextender>
<asp:TextBox ID="txt_ETA_date" Visible="false" runat="server" CssClass="textbox" style="text-transform:uppercase;"   TabIndex="18" AutoPostBack="True" ontextchanged="txt_ETA_date_TextChanged" Width="70px"></asp:TextBox>
<asp:filteredtextboxextender ID="txt_ETA_date_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Custom, Numbers" TargetControlID="txt_ETA_date" ValidChars="_/"></asp:filteredtextboxextender>
 <asp:calendarextender ID="txt_ETA_date_CalendarExtender" runat="server" Enabled="True" Format="MM/dd/yyyy" TargetControlID="txt_ETA_date">
</asp:calendarextender>

</td>
          </tr>
          </table>
 


<table align="center"  style="border: thin solid #003366; width:98%;">
                                                  <tr>
                                                      <td style="width: 200px">
                                                        <asp:Label ID="Labelorderno" runat="server" CssClass="Label" Text="Order #"></asp:Label>
                                                                </td>
                                                      <td style="width:162px;">
                                                        <asp:TextBox ID="txt_Order_Number" runat="server" CssClass="textbox" 
                                                              Width="150px" Enabled="False" ReadOnly="True"></asp:TextBox>
                                                                </td>
                                                      <td style="width:85px;">

                                                        <asp:Label ID="Label34" runat="server" CssClass="Label" Text="Parcel #"></asp:Label>
                                                       
                                                        </td>
                                                        <td style="width:150px;">
                                                        
                                                        <asp:TextBox ID="txt_Parcel_Number" runat="server" CssClass="textbox" 
                                                            ontextchanged="txt_Parcel_Number_TextChanged" Width="150px" Enabled="False" 
                                                                ReadOnly="True"></asp:TextBox>
                                                                                                           




                                                             </td>   

                                                      <td style="width:85px;">
                                                          
                                                      <asp:Label ID="Label11" runat="server" CssClass="Label" 
                                                            Text="First Name"></asp:Label>
                                                       
                                                            </td>                                               
                                                        <td style="width:150px;" valign="middle">

                                                        
                                                      
                                                         <asp:TextBox ID="txt_Barrower_Name" runat="server" 
                                                            CssClass="textbox" 
                                                            ontextchanged="txt_Barrower_Last_Name_TextChanged" Width="150px" 
                                                                Enabled="False" ReadOnly="True"></asp:TextBox>





                                                                </td>
                                                      <td align="left" style="width: 91px" >

                                               <asp:Label ID="Label29" runat="server" CssClass="Label" 
                                                            Text="Last Name"></asp:Label>

                                                                </td>
<td style="width: 183px">
                                                        
                                               <asp:TextBox ID="txt_Barrower_Last_Name0" runat="server" 
                                                            CssClass="textbox" 
                                                            ontextchanged="txt_Barrower_Last_Name_TextChanged" Width="150px" 
                                                   Enabled="False" ReadOnly="True"></asp:TextBox>
                                               
</td>
<td>

                                                                

                                               <asp:Label ID="Label20" runat="server" CssClass="Label" Text="State  "></asp:Label>
                                               
                                                                

</td>
<td>

                                                        
                                                                                                            
                                                    
                                               <asp:DropDownList ID="ddl_Barrower_State" runat="server" CssClass="DropDown" 
                                                            Width="160px" 
                                                            onselectedindexchanged="ddl_Barrower_State_SelectedIndexChanged" 
                                                   Enabled="False">
                                                        </asp:DropDownList>
                                               
                                                        
                                                                                                            
                                                    
</td>
                                                  </tr>
                                                  <tr>
                                                      <td style="width: 200px">

                                                                

                                                         <asp:Label ID="Label17" runat="server" CssClass="Label" Text="County"></asp:Label>

                                                                

                                                                </td>
                                                      <td style="width: 162px">
                                                        
                                                        
                                                                                                            
                                                    
                                                      <asp:DropDownList ID="ddl_Barrower_County" runat="server" CssClass="DropDown" 
                                                            Width="160px" Enabled="False">
                                                        </asp:DropDownList>
                                               
                                                        
                                                                                                            
                                                    
                                                                </td>
                                                      <td style="width: 85px">

                                                                

                                                        <asp:Label ID="Label38" runat="server" CssClass="Label" Text="City"></asp:Label>
                                               
                                                                

                                                      </td>
                                                                <td>
                                                    
                                                        
                                                                                                            
                                                    
<asp:TextBox ID="txt_Barrower_City" runat="server" CssClass="textbox" ontextchanged="txt_Barrower_City_TextChanged" Width="150px" Enabled="False" 
                                                                        ReadOnly="True"></asp:TextBox>
                                               
                                                        
                                                                                                            
                                                    
                                                                </td>
                                                                <td style="width: 85px">

                                                                

                                               <asp:Label ID="Label1" runat="server" CssClass="Label" Text="Zip"></asp:Label>
                                               
                                                                

                                                                </td>
                                                               
                                                      <td >
                                                    
                                                        
                                                                                                            
                                                    
                                               <asp:TextBox ID="txt_Barrower_Zip" runat="server" CssClass="textbox" 
                                                            Width="150px" 
                                                            ontextchanged="txt_Barrower_Zip_TextChanged" Enabled="False" ReadOnly="True"></asp:TextBox>
                                               
                                                        
                                                                                                            
                                                    
                                                                </td>
                                                      <td style="width: 91px" >
                                                     
                                                        
                                                       <asp:Label ID="Label18" runat="server" CssClass="Label" Text="Address"></asp:Label>
                                                       
                                                      </td>
                                                     <td colspan="3">
                                                        
                                                        
                                                      
                                                        <asp:TextBox ID="txt_Barrower_Address" runat="server" 
                                                            CssClass="textbox" ontextchanged="txt_Barrower_Address_TextChanged" 
                                                             Width="384px" Enabled="False" ReadOnly="True"></asp:TextBox>
                                                                                                           




                                                     </td>
                                                    
                                                  </tr>
                                                  <tr>
                                                  <td style="width: 200px">

                                                                

                                                         <asp:Label ID="Label97" runat="server" CssClass="Label" 
                                                          Text="Production Date"></asp:Label>

                                                                

                                                  </td>
                                                  <td>
                                               
                                               

                                                        <asp:TextBox ID="txt_Production_Date" runat="server" CssClass="textbox"  
                                                            Width="150px"></asp:TextBox>
<asp:FilteredTextBoxExtender ID="ddl_ProductionDt_FilteredTextBoxExtender" runat="server" 
                                                              Enabled="True" FilterType="Custom, Numbers" TargetControlID="txt_Production_Date" 
                                                              ValidChars="_/">
                                                          </asp:FilteredTextBoxExtender>

<asp:CalendarExtender ID="ddl_ProductionDt_CalendarExtender" runat="server" CssClass="sample"
                                                               Enabled="True" Format="MM/dd/yyyy" 
                                                              TargetControlID="txt_Production_Date">
                                                          </asp:CalendarExtender>



                       
                                                  
                                                                                                            
                                                    
                                                  </td>
                                                  <td>
                                                  
                                                                

                                                         <asp:Label ID="Label98" runat="server" CssClass="Label" Text="Status"></asp:Label>

                                                                

                                                  </td>
                                                  <td>

                                                        
                                                                                                            
                                                    
                                                      <asp:DropDownList ID="ddl_Status" runat="server" CssClass="DropDown" 
                                                            Width="160px">
                                                        </asp:DropDownList>
                                               
                                                        
                                                                                                            
                                                    
                                                  </td>
                                                  <td>

                                                        
                                                       <asp:Label ID="Label99"  runat="server" CssClass="Label" Text="Comments"></asp:Label>
                                                       
                                                  </td>
                                                  <td colspan="5">

                                                        
                                                      
                                                        <asp:TextBox ID="txt_Comments" runat="server" 
                                                            CssClass="textbox" ontextchanged="txt_Barrower_Address_TextChanged" 
                                                            Width="630px"></asp:TextBox>
                                                                                                           




                                                  </td>
                                                  </tr>
                                                
                                                  <tr>
                                                  <td style="width: 200px">

                                                                

                                                       <asp:Label ID="Label101" runat="server" CssClass="Label" Text="Loan No"></asp:Label>
                                                       
                                                                

                                                  </td>
                                                  <td>
                                               
                                               

                                                    
                                               <asp:TextBox ID="txt_Loan_no" runat="server" CssClass="textbox" 
                                                            Width="150px" 
                                                            ontextchanged="txt_Barrower_Zip_TextChanged" Enabled="False" 
                                                            ReadOnly="True"></asp:TextBox>
                                               
                                                        
                                                                                                            
                                                    
                                                  
                                                                                                            
                                                    
                                                  </td>
                                                  <td>
                                                  
                                                                

                                                         &nbsp;</td>
                                                  <td>

                                                        
                                                                                                            
                                                    
                                                      &nbsp;</td>
                                                  <td>

                                                        
                                                       &nbsp;</td>
                                                  <td colspan="5">

                                                        
                                                      
                                                        &nbsp;</td>
                                                  </tr>
                                                
                                              </table>

<asp:UpdatePanel ID="UpdatePanel3" runat="server" ><ContentTemplate>     


<table align="center"  style=" width:98%;">
<tr><td>
<asp:Button ID="Tab_TaxDetails" runat="server" Text="Tax Details"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_TaxDetails_Click" />
<asp:Button ID="Tab_AssedVal" runat="server" Text="Assesed Values"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_AssedVal_Click" />
<asp:Button ID="Tab_SalDetail" runat="server" Text="Tax Sales Details"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_SalDetail_Click" />
    
<asp:Button ID="Tab_BankruptyDet" runat="server" Text="Bankrupty Details"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_BankruptyDet_Click" />
<asp:Button ID="Tab_SourceUpload" runat="server" Text="Source Upload"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_SourceUpload_Click" />
<asp:Button ID="Tab_ErrorInfo" runat="server" Text="Error Detail"  style="color:#FFFFFF;"
        CssClass="TabButton" onclick="Tab_ErrorInfo_Click" />
</td></tr>

<tr id="Tr1" style="height:100px"  runat="server">
<td   style="border: 1px solid #003366;">


<table id="Tax_Detail" runat="server"  style="width:98%;height:100px;"  
        visible="true" align="center" >
<tr valign="top" >
<td colspan="8" valign="top">

<div class="div_toprow" >
Tax Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddTaxDet" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" onclick="btn_AddTaxDet_Click" 
        />
        </span>
        </div>
        </td>
        </tr>
<tr>
<td colspan="8" valign="top">
<div style="background-color:#fff;margin-top:-6px;">

<asp:UpdatePanel ID="UpdatePanel4" runat="server">
<ContentTemplate>
<asp:GridView  ID="gvTaxDetails"  runat="server" AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" Width="100%" Font-Bold="False"
        ShowHeaderWhenEmpty="True" 
       
        onrowcommand="gvTaxDetails_RowCommand" DataKeyNames="Tax_Id" 
        onpageindexchanging="gvTaxDetails_PageIndexChanging">
        <Columns>
        <asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
        <ItemTemplate>
        <asp:Label ID="lblTax_Id" runat="server"  Text='<%#Eval("Tax_Id") %>' Visible="false"></asp:Label>
        </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
        <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="90px" />
        </asp:TemplateField>
        
        <asp:TemplateField HeaderText="Tax Type" HeaderStyle-CssClass="head-label">
        
        <ItemTemplate>
        <asp:Label ID="lbl_Tax_Type" Width="90px" runat="server" Text='<%#Eval("Tax_Type") %>'/>
        </ItemTemplate>
       <HeaderStyle CssClass="head_style" HorizontalAlign="Center" Height="30px" Font-Bold="True"   />
       <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="90px" />
       </asp:TemplateField>
                                                              
     
        <asp:TemplateField HeaderText="Tax Year" HeaderStyle-CssClass="head-label">
     
        <ItemTemplate>
        <asp:Label ID="lbl_Tax_Year" Width="40px"  runat="server" Text='<%#Eval("Tax_Year") %>'/></ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" Font-Bold="True" />
        <ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="70px" />
        </asp:TemplateField>
         <asp:TemplateField HeaderText="Period" HeaderStyle-CssClass="head-label">
     
         <ItemTemplate>
         <asp:Label ID="lbl_Tax_Period" Width="90px"  runat="server" Text='<%#Eval("Tax_Period") %>'/>
         </ItemTemplate>
         <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 

        </asp:TemplateField>
        <asp:TemplateField HeaderText="Base Amt" HeaderStyle-CssClass="head-label">
  
        <ItemTemplate>
        <asp:Label ID="lbl_Tax_Amount" Width="50px"   runat="server" Text='<%#Eval("Tax_Base_Amount") %>'/>
        </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  HorizontalAlign="Center" CssClass="grid-item" Width="130px" />

        </asp:TemplateField>
                                                              
        <asp:TemplateField HeaderText="Due Dt" HeaderStyle-CssClass="head-label">
     
        <ItemTemplate>
        <asp:Label ID="lbl_Tax_Due_Date" Width="60px"   runat="server" Text='<%#Eval("Tax_Due_Date") %>'/>
        </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  HorizontalAlign="Center" CssClass="grid-item" Width="100px" />

        </asp:TemplateField>
                                                       
                                                 
                                                       
    <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="head-label">
   
    <ItemTemplate>
    <asp:Label ID="lbl_Tax_Status" Width="90px"  runat="server" Text='<%#Eval("Tax_Status") %>'/>
    </ItemTemplate>
    
    <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 

    </asp:TemplateField>
                                                       
                                                       
    <asp:TemplateField HeaderText="Paid Amt" HeaderStyle-CssClass="head-label">
 
    <ItemTemplate>
    <asp:Label ID="lbl_Tax_Paid_Amount" Width="50px"  runat="server" Text='<%#Eval("Tax_Paid_Amount") %>'/>
    </ItemTemplate>
    <HeaderStyle CssClass="head_style" Height="30px" Font-Bold="True"   HorizontalAlign="Center" />
    <ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="130px" />
    </asp:TemplateField>
                                                           
    <asp:TemplateField HeaderText="Paid Dt" HeaderStyle-CssClass="head-label" >
    
    <ItemTemplate>
    <asp:Label ID="lbl_Tax_Paid_Date" Width="60px"  runat="server" Text='<%#Eval("Paid_Date") %>'/>
    </ItemTemplate>
    <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" Font-Bold="True"   />
    <ItemStyle  HorizontalAlign="Center" CssClass="grid-item" Width="130px" />
    </asp:TemplateField >

    <asp:TemplateField HeaderText="View" HeaderStyle-CssClass="head-label" >
    
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamEdit" runat="server" CommandName="EditRecord" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center"  Height="30px" Font-Bold="True"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"   Width="50px" />
    </asp:TemplateField>
            

    <asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="Delete">
    
    <ItemTemplate>
    <%--<asp:ImageButton ID="imgbtnEdit" CommandName="Edit" runat="server" ImageUrl="~/images/Gridview/edit.png"  ToolTip="Edit" Height="20px" Width="20px" />--%>
    <asp:ImageButton ID="imgbtnDelete" CommandName="DeleteRecord" Text="Edit" runat="server" ImageUrl="~/images/Gridview/Remove-icon.png"  OnClientClick="javascript:return confirm('Are you sure to proceed?');" ToolTip="Delete" Height="20px" Width="20px" />
    </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  CssClass="grid-item"      VerticalAlign="Middle"    Height="20px" Width="30px" /> 

    </asp:TemplateField>
                                                       </Columns>
    <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

    </asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>
</div>
</td>
</tr>

<tr><td colspan="8"><br/></td></tr>
<tr id="tr_TaxDataRow" runat="server" visible="false">
<td style="width: 189px"><asp:Label ID="Label83" runat="server"  CssClass="Label" Text="Tax Type"></asp:Label></td>
<td style="width: 163px">
    <asp:DropDownList ID="ddl_Tax_Type_Entry" runat="server" CssClass="textbox" 
        Width="150px" TabIndex="1"></asp:DropDownList></td>
<td style="width: 212px"><asp:Label ID="Label84" runat="server"  CssClass="Label" Text="Municipality"></asp:Label></td>
<td style="width: 166px">
    <asp:TextBox ID="txt_TaxMunciplename_Entry" runat="server" CssClass="textbox" 
        Width="140px" TabIndex="2"></asp:TextBox></td>
<td class="style3"><asp:Label ID="Label85" runat="server"  CssClass="Label" Text="Year"></asp:Label></td>
<td style="width: 169px">
    <asp:TextBox ID="txt_Tax_Year" runat="server" 
        CssClass="textbox" Width="140px" TabIndex="3" /></td>
<td style="width: 171px"><asp:Label ID="Label86" runat="server"  CssClass="Label" Text="Period"></asp:Label></td>
<td style="width: 210px">
    <asp:DropDownList ID="ddl_Tax_Period_Entry" runat="server" CssClass="textbox" 
        Width="150px" TabIndex="4"></asp:DropDownList></td>
</tr>
<tr id="tr_TaxDataRow1" runat="server" visible="false">
<td style="width: 189px"><asp:Label ID="Label87" runat="server"  CssClass="Label" Text="Base Amount" /></td>
<td style="width: 163px">
    <asp:TextBox ID="txt_Tax_Amount_Entry" runat="server" 
        CssClass="AmountText" Width="140px" TabIndex="5" /></td>
<td style="width: 212px"><asp:Label ID="Label88" runat="server"  CssClass="Label" Text="Due Date" /></td>
<td style="width: 166px"><asp:TextBox ID="txt_Tax_Due_Date_Entry" runat="server" 
        CssClass="textbox"  TabIndex="6" 
        style="text-transform:uppercase;" Width="140px" 
                                                              
        meta:resourcekey="txt_DueDateResource1"></asp:TextBox>
                                                               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender13" runat="server" 
                                                              Enabled="True" 
        FilterType="Custom, Numbers" TargetControlID="txt_Tax_Due_Date_Entry" 
                                                              ValidChars="_/">
                                                          </asp:FilteredTextBoxExtender>
                                                          <asp:CalendarExtender ID="CalendarExtender9" runat="server" 
                                                              CssClass="sample" 
        Enabled="True" Format="MM/dd/yyyy" 
                                                              
        TargetControlID="txt_Tax_Due_Date_Entry">
                                                          </asp:CalendarExtender></td>
<td class="style3"><asp:Label ID="Label89" runat="server"  CssClass="Label" Text="Disc Y/N" /></td>
<td style="width: 169px">
    <asp:DropDownList ID="ddl_Discount_Entry" runat="server" CssClass="textbox" 
        Width="150px" TabIndex="7" AutoPostBack="True" 
        onselectedindexchanged="ddl_Discount_Entry_SelectedIndexChanged1"></asp:DropDownList></td>
<td style="width: 171px"><asp:Label ID="Label90" runat="server"  CssClass="Label" Text="Disc Amount" /></td>
<td style="width: 210px">
    <asp:TextBox ID="txt_Tax_Discount_Amount_Amount_Entry" 
        runat="server" CssClass="AmountText" Width="140px" TabIndex="8" /></td>
</tr>
<tr id="tr_TaxDataRow2" runat="server" visible="false">
    
<td style="width: 189px"><asp:Label ID="Label91" runat="server"  CssClass="Label" Text="Disc Date" /></td>
<td style="width: 163px">
<asp:TextBox ID="txt_Tax_Entry_Discount_Date" runat="server" CssClass="textbox"  
        Width="140px" TabIndex="9" />
<asp:FilteredTextBoxExtender ID="txt_Tax_Entry_Discount_Date_FilteredTextBoxExtender" runat="server" 
 Enabled="True" FilterType="Custom, Numbers" TargetControlID="txt_Tax_Entry_Discount_Date" ValidChars="_/">
                                                          </asp:FilteredTextBoxExtender>
<asp:CalendarExtender ID="txt_Tax_Entry_Discount_Date_CalendarExtender" runat="server" CssClass="sample"
                                                               Enabled="True" Format="dd/MM/yyyy" 
                                                              TargetControlID="txt_Tax_Entry_Discount_Date">
                                                          </asp:CalendarExtender>
        </td>
<td style="width: 212px"><asp:Label ID="Label92" runat="server"  CssClass="Label" Text="Status" /></td>
<td style="width: 166px">
    <asp:DropDownList ID="ddl_Tax_Status_Entry" runat="server" CssClass="textbox" 
        Width="150px" TabIndex="10" AutoPostBack="True" 
        onselectedindexchanged="ddl_Tax_Status_Entry_SelectedIndexChanged" /></td>
<td class="style3"><asp:Label ID="Label93" runat="server"  CssClass="Label" Text="Paid Amount" /></td>
<td style="width: 169px">
    <asp:TextBox ID="txt_Tax_Paid_Amount_Amount_Entry" 
        runat="server" CssClass="AmountText" Width="140px" TabIndex="11" /></td>
<td style="width: 171px"><asp:Label ID="Label94" runat="server"  CssClass="Label" Text="Paid Date" /></td>
<td style="width: 210px">
    <asp:TextBox ID="txt_Tax_Entry_Paid_Date" runat="server" 
        CssClass="textbox"  TabIndex="12" 
        style="text-transform:uppercase;" Width="140px" 
                                                              
        meta:resourcekey="txt_PaidDateResource1"></asp:TextBox>
                                                               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender14" runat="server" 
                                                              Enabled="True" 
        FilterType="Custom, Numbers" TargetControlID="txt_Tax_Entry_Paid_Date" 
                                                              ValidChars="_/">
                                                          </asp:FilteredTextBoxExtender>
                                                          <asp:CalendarExtender ID="CalendarExtender10" runat="server" 
                                                              CssClass="sample" 
        Enabled="True" Format="MM/dd/yyyy" 
                                                              
        TargetControlID="txt_Tax_Entry_Paid_Date">
                                                          </asp:CalendarExtender></td>

</tr>

<tr id="tr_TaxDataRow3" runat="server" visible="false">
<td style="width: 189px"><asp:Label ID="Label95" runat="server"  CssClass="Label" Text="Payoff Amount" /></td>
<td style="width: 163px">
    <asp:TextBox ID="txt_Tax_Payoff_Amount_Amount_Entry" 
        runat="server" CssClass="AmountText" 
        Width="140px" TabIndex="13" /></td>
<td style="width: 212px"><asp:Label ID="Label96" runat="server"  CssClass="Label" Text="G.T Date" /></td>
<td style="width: 166px">
    <asp:TextBox ID="txt_Tax_Entry_Good_Through_Date" 
        runat="server" CssClass="textbox"  TabIndex="14" 
        style="text-transform:uppercase;" Width="140px" 
                                                              
        meta:resourcekey="txt_GTDtResource1"></asp:TextBox>
                                                               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender15" runat="server" 
                                                              Enabled="True" 
        FilterType="Custom, Numbers" TargetControlID="txt_Tax_Entry_Good_Through_Date" 
                                                              ValidChars="_/">
                                                          </asp:FilteredTextBoxExtender>
                                                          <asp:CalendarExtender ID="CalendarExtender11" runat="server" 
                                                              CssClass="sample" 
        Enabled="True" Format="MM/dd/yyyy" 
                                                              
        TargetControlID="txt_Tax_Entry_Good_Through_Date">
                                                          </asp:CalendarExtender></td>
</tr>
<tr id="tr_TaxDataRow4" runat="server" visible="false">
<td align="right" colspan="7">
    &nbsp;</td>
<td align="center" style="width: 210px" >
<asp:Button ID="btn_TaxSubmit" runat="server" CssClass="WebButton" 
                    OnClick="btn_TaxSubmit_Click" 
                    Text="Save" 
                    Width="75px" TabIndex="14" />
    &nbsp;
<asp:Button ID="btn_Cancel" runat="server" CssClass="WebButton" 
                    Text="Cancel" 
                    Width="75px" onclick="btn_Cancel_Click" TabIndex="15" />
    </td>
</tr>
</table>



<table id="Assed_Val" runat="server"  style="width:98%;height:100px;"  
        visible="false" align="center" >
<tr><td colspan="10" valign="top">
<div class="div_toprow" >
Assesed Value Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddAssessed" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" onclick="btn_AddAssessed_Click" 
        />
        </span>
        </div>
        </td>
        </tr>
<tr>
<td colspan="10" valign="top">
<div style="background-color:#fff;margin-top:-6px;">
   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
<ContentTemplate> 
    <asp:GridView ID="grd_Assesed" runat="server" DataKeyNames="Tax_Assessed_Id" 
                                                          onrowdeleting="grd_Assesed_RowDeleting" 
                                                          onselectedindexchanged="grd_Assesed_SelectedIndexChanged" 
                                                          
        AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" Font-Bold="false"
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" PageSize="4" Width="100%" 
        ShowHeaderWhenEmpty="True" Font-Names="Segoe UI" 
        Font-Size="16px" onpageindexchanging="grd_Assesed_PageIndexChanging">
        <Columns>
        <asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
        <ItemTemplate>
        <asp:Label  ID="lblTax_Assessed_Id" runat="server" CssClass="Label" Text='<%#Eval("Tax_Assessed_Id") %>' Visible="false"></asp:Label></ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
        <ItemStyle HorizontalAlign="Center"  Width="100px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="S.No" SortExpression="Order_Number" HeaderStyle-CssClass="head-label">
        <ItemTemplate>
        <asp:Label ID="lblsi_Assesid" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
        </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="30px">
        </ItemStyle>
        </asp:TemplateField>
<asp:TemplateField  HeaderText="Tax Year" SortExpression="Tax_Year" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label    ID="lblTax_Year" runat="server"  Text='<%#Eval("Tax_Year") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Land"   SortExpression="Land_Cost" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblLand_Cost"  runat="server"  Text='<%#Eval("Land_Cost") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField   HeaderText="Building" SortExpression="Building_Cost" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label  ID="lblBuilding_Cost" runat="server" Text='<%#Eval("Building_Cost") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField   HeaderText="Excemption" SortExpression="Excemption" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblExcemption_Cost" runat="server"  Text='<%#Eval("Excemption") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle  HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Total" SortExpression="Total" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblTotal" runat="server"  Text='<%#Eval("Total") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle  CssClass="head_style" HorizontalAlign="Center" Height="30px" Font-Bold="True" />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="View">
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamEdit" runat="server" CommandName="Select" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item"  Width="16px" />
</asp:TemplateField>
<asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="Delete">
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamDelete" runat="server" CommandName="Delete" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                                                      Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item"  Width="16px" />
</asp:TemplateField>

</Columns>
<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

</asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>
</div>
</td>
</tr>


<tr id="tr_AssedVal" runat="server" visible="false">
<td style="width: 79px" ><asp:Label  ID="lbl_Tax_Year" runat="server" CssClass="Label" Text="Tax Year"></asp:Label></asp:Label></td>
<td style="width: 175px">

<asp:DropDownList ID="ddl_Assesed_Tax_Year" runat="server" 
                                                                  
        CssClass="DropDown" TabIndex="1" Width="160px"></asp:DropDownList>
       
        </td>
<td style="width: 64px"><asp:Label ID="Label3" runat="server" CssClass="Label" 
                                                                  Text="Land"></asp:Label></td>
<td style="width: 171px">

<asp:TextBox                                                      ID="txt_Land" runat="server" AutoPostBack="True" CssClass="AmountText" 
                                                                  ontextchanged="txt_Land_TextChanged" style="text-transform:uppercase;" 
                                                                  TabIndex="2" Width="150px"></asp:TextBox>
                        <asp:FilteredTextBoxExtender 
                                                                  ID="txt_Land_FilteredTextBoxExtender" runat="server" Enabled="True" 
                                                                  FilterType="Custom, Numbers" TargetControlID="txt_Land" ValidChars="."></asp:FilteredTextBoxExtender>
</td>
<td style="width: 72px"><asp:Label ID="Label4" runat="server" CssClass="Label" 
                                                                  Text="Building"></asp:Label></td>
<td><asp:TextBox 
                                                                  ID="txt_Building" runat="server" AutoPostBack="True" CssClass="AmountText" 
                                                                  ontextchanged="txt_Building_TextChanged" style="text-transform:uppercase;" 
                                                                  TabIndex="3" Width="150px"></asp:TextBox><asp:FilteredTextBoxExtender 
                                                                  ID="txt_Building_FilteredTextBoxExtender" runat="server" Enabled="True" 
                                                                  FilterType="Custom, Numbers" TargetControlID="txt_Building" ValidChars="."></asp:FilteredTextBoxExtender>
</td>
<td>
<asp:Label 
                                                                  ID="Label52" runat="server" CssClass="Label" Text="Excemption"></asp:Label>
</td>
<td>
<asp:TextBox ID="txt_Excemption" runat="server" CssClass="AmountText" 
                                                                  
        style="text-transform:uppercase;" TabIndex="4" Width="150px" 
        AutoPostBack="True" ontextchanged="txt_Excemption_TextChanged"></asp:TextBox><asp:FilteredTextBoxExtender 
                                                                  ID="txt_Excemption_FilteredTextBoxExtender" runat="server" Enabled="True" 
                                                                  FilterType="Custom, Numbers" TargetControlID="txt_Excemption" ValidChars="."></asp:FilteredTextBoxExtender>
</td>
<td>
<asp:Label 
                                                                  ID="Label25" runat="server" CssClass="Label" Text="Total"></asp:Label>
</td>
<td>
<asp:TextBox 
                                                                  ID="txt_total" 
        runat="server" CssClass="AmountText" Enabled="False" 
                                                                  
        style="text-transform:uppercase;" TabIndex="5" Width="150px"></asp:TextBox><asp:FilteredTextBoxExtender 
                                                                  ID="txt_total_FilteredTextBoxExtender" runat="server" Enabled="True" 
                                                                  FilterType="Custom, Numbers" TargetControlID="txt_total" ValidChars="."></asp:FilteredTextBoxExtender>
</td>

</tr>
<tr id="tr_AssedVal1" runat="server" visible="false">
<td align="right" colspan="9">
    &nbsp;</td>
<td align="center" style="width: 210px" >
<asp:Button ID="btn_Assesd_Add" runat="server" CssClass="WebButton" 
                    OnClick="btn_Assesd_Add_Click" 
                    Text="Save" 
                    Width="75px" TabIndex="6" />
    &nbsp;
<asp:Button ID="btn_ClearAssed" runat="server" CssClass="WebButton" 
                    OnClick="btn_ClearAssed_Click" 
                    Text="Cancel" 
                    Width="75px" TabIndex="7" />
    </td>

</tr>

    
</table>



<table id="Tax_SalDet" runat="server"  style="width:98%;height:100px;"  
        visible="false" align="center" >
<tr><td colspan="8" valign="top">
<div class="div_toprow" >
Tax Sales Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddTaxSal" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" onclick="btn_AddTaxSal_Click" 
        />
        </span>
</div>
</td>
</tr>
<tr>
<td colspan="8" valign="top">
<div style="background-color:#fff;margin-top:-6px;">    
            
        <asp:GridView ID="grd_Tax_Sold" runat="server"
                DataKeyNames="Tax_Sale_Id" 
                AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" PageSize="4" Width="100%" 
        ShowHeaderWhenEmpty="True" 
            onrowcommand="grd_Tax_Sold_RowCommand" 
            onpageindexchanging="grd_Tax_Sold_PageIndexChanging">
            
            <Columns>
            <asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
            <ItemTemplate><asp:Label ID="lblTax_Sale_Id" runat="server" CssClass="Label" 
                                Text='<%#Eval("Tax_Sale_Id") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
        <ItemStyle HorizontalAlign="Center" CssClass="grid-item" Width="100px" />
        </asp:TemplateField>
          <asp:TemplateField HeaderText="S.No" SortExpression="Order_Number" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblSiTax_Sale_Id" runat="server"  Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle  HorizontalAlign="Center"  CssClass="grid-item"  Width="30px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Tax Year" SortExpression="Tax_Year" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          
          <asp:Label ID="lblTax_Sold" runat="server" Text='<%#Eval("Taxes_Sold") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" /></asp:TemplateField>
          <asp:TemplateField HeaderText="Tax Sale Date" SortExpression="Land_Cost" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblSold_Date" runat="server"  Text='<%#Eval("Tax_Sold_Date") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Redemption Amount" SortExpression="Total" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblSold_TaxAmt" runat="server"  Text='<%#Eval("Sold_Tax_Amount") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Good Thru Date" SortExpression="Total" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblRedemption_Good_Thru_Date" runat="server"   Text='<%#Eval("Redemption_Good_Through_Date") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Last Date to Redemption" SortExpression="Total" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblLast_Redemption_Loss_Date" runat="server"   Text='<%#Eval("Last_Redemption") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Next Critical Date" SortExpression="Building_Cost" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lbl_Next_Critical_Date" runat="server"  Text='<%#Eval("Next_Critical_Date") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Next Critical Action" SortExpression="Total" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblNext_Critical_Action" runat="server"  Text='<%#Eval("Next_Critical_Action") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Comments" SortExpression="Total" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:Label ID="lblTax_Sale_Comments" runat="server"  Text='<%#Eval("Comments") %>'></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
          <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
          </asp:TemplateField>
             <asp:TemplateField HeaderText="Edit" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:ImageButton ID="imgbtnTaxSoldEdit" runat="server" CommandName="EditRecord" 
                                Height="20px" ImageUrl="~/images/Gridview/View.png"
                              
                                Width="20px" />
       </ItemTemplate>
       <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
       <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  VerticalAlign="Middle" Width="16px" />
       </asp:TemplateField>
          <asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="head-label">
          <ItemTemplate>
          <asp:ImageButton ID="imgbtnTaxSoldDelete" runat="server" CommandName="DeleteRecord" 
                                Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" 
                              OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                Width="20px" />
       </ItemTemplate>
       <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
       <ItemStyle HorizontalAlign="Center" CssClass="grid-item"  VerticalAlign="Middle" Width="16px" />
       </asp:TemplateField>
       </Columns>
       <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

       </asp:GridView>
                  
                </div>
</td></tr>    

                
<tr id="tr_SalDetail" runat="server" visible="false">
<td ><asp:Label ID="Label44" runat="server" CssClass="Label" Text="Taxes Sold" /></td>
<td><asp:DropDownList ID="ddl_Tax_Sold" CssClass="DropDown" runat="server" 
        Width="160px" TabIndex="1">
    </asp:DropDownList></td>
<td><asp:Label ID="Label45" runat="server" CssClass="Label" Text="Tax Sale Date" /></td>
<td> <asp:TextBox ID="txt_Sold_Date" runat="server" CssClass="textbox" 
                                                      
        style="text-transform:uppercase;" TabIndex="2" Width="150px"></asp:TextBox>
                                                  <asp:FilteredTextBoxExtender ID="txt_Sold_Date_FilteredTextBoxExtender" 
                                                      runat="server" Enabled="True" FilterType="Custom, Numbers" 
                                                      TargetControlID="txt_Sold_Date" ValidChars="_/">
                                                  </asp:FilteredTextBoxExtender>
                                                  <asp:CalendarExtender ID="txt_Sold_Date_CalendarExtender" runat="server" 
                                              CssClass="sample"        Enabled="True" Format="MM/dd/yyyy" TargetControlID="txt_Sold_Date">
                                                  </asp:CalendarExtender></td>
<td><asp:Label ID="Label47" runat="server" CssClass="Label" Text="Redemption Amount" /></td>
<td><asp:TextBox ID="txt_sold_Tax_AMount" runat="server" CssClass="textbox" 
        style="text-transform:uppercase;" TabIndex="3" Width="150px"></asp:TextBox></td>
<td><asp:Label ID="Label51" runat="server" CssClass="Label" Text="Good Thru Date" /></td>
<td> <asp:TextBox ID="txt_Redemption_Good_Through_Date" runat="server" 
                                                 CssClass="textbox" 
        style="text-transform:uppercase;" TabIndex="4" Width="150px" 
                                                             AutoPostBack="True" 
                                                             
        ontextchanged="txt_Redemption_Good_Through_Date_TextChanged"></asp:TextBox>
                                             <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" 
                                                 runat="server" Enabled="True" FilterType="Custom, Numbers" 
                                                 TargetControlID="txt_Redemption_Good_Through_Date" ValidChars="_/">
                                             </asp:FilteredTextBoxExtender>
                                             <asp:CalendarExtender ID="CalendarExtender2" CssClass="sample"
                                                 runat="server" Enabled="True" Format="MM/dd/yyyy" 
                                                 TargetControlID="txt_Redemption_Good_Through_Date">
                                             </asp:CalendarExtender></td>
</tr>

<tr id="tr_SalDetail1" runat="server" visible="false">
<td><asp:Label ID="Label55" runat="server" CssClass="Label" Text="Last Date to Redemption" /></td>
<td>   <asp:TextBox ID="txt_Last_Redemption_Date" runat="server" CssClass="textbox" 
                                                        
        style="text-transform:uppercase;" TabIndex="5" Width="150px"></asp:TextBox>
                                                    <asp:FilteredTextBoxExtender ID="txt_Last_Redemption_Date_FilteredTextBoxExtender" 
                                                        runat="server" Enabled="True" FilterType="Custom, Numbers" 
                                                        TargetControlID="txt_Last_Redemption_Date" ValidChars="_/">
                                                    </asp:FilteredTextBoxExtender>
                                                    <asp:CalendarExtender ID="txt_Last_Redemption_Date_CalendarExtender" 
                                               CssClass="sample"   runat="server" Enabled="True" Format="MM/dd/yyyy" 
                                                        TargetControlID="txt_Last_Redemption_Date">
                                                    </asp:CalendarExtender>      </td>
<td><asp:Label ID="Label56" runat="server" CssClass="Label" Text="Next Critical Action" /></td>
<td><asp:TextBox ID="txt_Next_Critical_Action" runat="server" CssClass="textbox" 
        style="text-transform:uppercase;" TabIndex="6" Width="150px"></asp:TextBox></td>
<td><asp:Label ID="Label57" runat="server" CssClass="Label" Text="Next Critical Date" /></td>
<td>   <asp:TextBox ID="txt_Next_Critical_date" runat="server" CssClass="textbox" 
                                                      
        style="text-transform:uppercase;" TabIndex="7" Width="150px"></asp:TextBox>
                                                  <asp:FilteredTextBoxExtender ID="txt_Next_Critical_date_FilteredTextBoxExtender" 
                                                      runat="server" Enabled="True" FilterType="Custom, Numbers" 
                                                      TargetControlID="txt_Next_Critical_date" ValidChars="_/">
                                                  </asp:FilteredTextBoxExtender>
                                                  <asp:CalendarExtender ID="txt_Next_Critical_date_CalendarExtender" runat="server" 
                                                 CssClass="sample"   Enabled="True" Format="MM/dd/yyyy" TargetControlID="txt_Next_Critical_date">
                                                  </asp:CalendarExtender></td>
<td><asp:Label ID="Label58" runat="server" CssClass="Label" Text="Comments" /></td>
<td><asp:TextBox ID="txt_Tax_Sale_Comments" runat="server" CssClass="textbox" 
        style="text-transform:uppercase;" TabIndex="8" Width="150px"></asp:TextBox></td>
</tr>

<tr id="tr_SalDetail2" runat="server" visible="false">
<td align="right" colspan="7">
    &nbsp;</td>
<td align="center" style="width: 210px" >
<asp:Button ID="btn_Add_Tax_Sale" runat="server" CssClass="WebButton" 
                    
                    Text="Save" 
                    Width="75px" onclick="btn_AddSalInfo_Click" TabIndex="9" />
    &nbsp;
<asp:Button ID="btn_ClearSalInfo" runat="server" CssClass="WebButton" 
                    
                    Text="Cancel" 
                    Width="75px" onclick="btn_ClearSalInfo_Click" TabIndex="10" />
    </td>


</tr>
</table>
    


<table id="Bankrupty_Det" runat="server"  style="width:98%;height:100px;"  
        visible="false" align="center" >
<tr>
<td valign="top" colspan="10">
<div class="div_toprow" >
Tax Bankrupty Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddTaxBankrupty" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" onclick="btn_AddTaxBankrupty_Click" 
        />
        </span>
        </div>
        </td>
        </tr>
<tr>
<td colspan="10" valign="top">
<div style="background-color:#fff;margin-top:-6px;">  
<asp:GridView ID="grid_Banckrupty" runat="server" 
        AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" PageSize="4" Width="100%" 
        ShowHeaderWhenEmpty="True" 
                                                          onrowdeleting="grid_Banckrupty_RowDeleting" 
                                                          
        onselectedindexchanged="grid_Banckrupty_SelectedIndexChanged" 
        onpageindexchanging="grid_Banckrupty_PageIndexChanging" 
        DataKeyNames="Bankruptcy_Id" >
                                                          
<Columns>
<asp:TemplateField HeaderText="id" Visible="False" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblBankruptcy_Id" runat="server" Text='<%#Eval("Bankruptcy_Id") %>' Visible="false"></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" Width="100px"  CssClass="grid-item"/>
</asp:TemplateField>
<asp:TemplateField HeaderText="S.No" SortExpression="Order_Number" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblSiMunciplene_Id" runat="server" Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="30px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Bankcrupty" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblBankcrupty_Type" runat="server" Text='<%#Eval("Bankcrupty") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Chapter No" SortExpression="Tax_Type" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lblChapter_No" runat="server" Text='<%#Eval("Chapter_No") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Case No" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Case_No" runat="server"  Text='<%#Eval("Case_No") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" CssClass="grid-item"  Width="100px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Bk Date" SortExpression="Bk_Date" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Bk_Date" runat="server" Text='<%#Eval("Bk_Date") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" Width="100px" CssClass="grid-item" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Comments" SortExpression="Comments" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_bankcruptComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label>
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px"  />
<ItemStyle HorizontalAlign="Center" Width="100px" CssClass="grid-item" />
</asp:TemplateField>
<asp:TemplateField  HeaderText="View" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnBankCruptEdit" runat="server" CommandName="Select" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center" VerticalAlign="Middle"   Height="30px" Width="16px" Font-Bold="True"  />
<ItemStyle HorizontalAlign="Center" Width="100px" CssClass="grid-item" />
</asp:TemplateField>
<asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnBankCruptDelete" runat="server" CommandName="Delete" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                                                  Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center" VerticalAlign="Middle"   Height="30px" Width="16px"   />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="grid-item" Width="16px" />
</asp:TemplateField>
</Columns>

<EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                      
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

</asp:GridView>

</div>
</td>
</tr>


    
       <tr id="tr_Bankrupty" runat="server" visible="false">
       <td style="width: 114px"> 
       
       <asp:Label ID="Label12" runat="server" CssClass="Label" Text="Bankrupty"></asp:Label>
       </td>
       <td style="width:122px;">
       <asp:DropDownList ID="ddl_Bankruptcy_Yes_No" runat="server" 
                                                                  AutoPostBack="True" CssClass="DropDown" 
                                                                  onselectedindexchanged="ddl_Bankruptcy_Yes_No_SelectedIndexChanged" 
                                                                  TabIndex="1" Width="100px"><asp:ListItem Value="YES">YES</asp:ListItem><asp:ListItem 
                                                                      Value="NO">NO</asp:ListItem></asp:DropDownList>
       </td>
       <td style="width:109px;">
       <asp:Label ID="Label14" runat="server" CssClass="Label" Text="Chapter # "></asp:Label>
       </td>
       <td style=" width:37px;">
       <asp:TextBox ID="txt_Bankruptcy_ChapterNo" runat="server" CssClass="textbox" 
               TabIndex="2"></asp:TextBox>
       </td>
       <td style="width:75px;">
       <asp:Label ID="Label16" runat="server" CssClass="Label" Text="Case# "></asp:Label>
       </td>
       <td style="width:138px;">
       <asp:TextBox ID="txt_Bankruptcy_Case_No" runat="server" CssClass="textbox" 
               TabIndex="3"></asp:TextBox>
       </td>
       <td><asp:Label ID="Label21" runat="server" CssClass="Label" Text="BK Date"></asp:Label>
       </td>
       <td><asp:TextBox ID="txt_Bankruptcy_Date" runat="server" CssClass="textbox" style="text-transform:uppercase;" TabIndex="4" Width="150px"></asp:TextBox>
           <asp:FilteredTextBoxExtender ID="txt_Bankruptcy_Date_filter_Date" runat="server" Enabled="True" FilterType="Custom, Numbers" TargetControlID="txt_Bankruptcy_Date" 
                                                                  ValidChars="_/"></asp:FilteredTextBoxExtender>
          <asp:CalendarExtender ID="txt_Bankruptcy_Date_CalendarExtender" runat="server" CssClass="sample" Enabled="True" Format="MM/dd/yyyy" TargetControlID="txt_Bankruptcy_Date"></asp:CalendarExtender>
       </td>
       <td>
       <asp:Label ID="Label28" runat="server" CssClass="Label" Text="Comments"></asp:Label>
       </td>
       <td>
       <asp:TextBox ID="txt_Bankcrupt_Comments" runat="server" CssClass="textbox" 
               TabIndex="5" Width="200px"></asp:TextBox>
       <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender5" runat="server" Enabled="True" TargetControlID="txt_Bankcrupt_Comments" WatermarkCssClass="watermarked" 
                                                                  WatermarkText="Type Comment Here" />
        </td>
       
        </tr>

         <tr id="tr_Bankrupty1" runat="server" visible="false">
     <td align="right" colspan="9">
         &nbsp;</td>
<td align="center" style="width: 210px" >
<asp:Button ID="btn_Brancrupty" runat="server" CssClass="WebButton" 
                   
                    Text="Save" 
                    Width="75px" onclick="btn_BrancruptyAdd_Click" TabIndex="6" />
    &nbsp;
<asp:Button ID="btn_ClearBankrupty" runat="server" CssClass="WebButton" 
                 
                    Text="Cancel" 
                    Width="75px" onclick="btn_ClearBankrupty_Click" TabIndex="7" />
    </td>
     </tr>
   
</table>

<table id="Source_Upload" runat="server"  style="width:98%;height:100px;"  
        visible="false" align="center" >

<tr><td colspan="6">
<div class="div_toprow" >
Source Upload Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddSrcUpld" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" onclick="btn_AddSrcUpld_Click" 
        />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="6">
<div style="background-color:#fff;margin-top:-6px;">  


<asp:GridView ID="Tax_Voice_Upload" runat="server" AutoGenerateColumns="false" 
        AllowPaging="True" ForeColor="Black"  CellPadding="4"  CssClass="name" 
        BackColor="White" BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px"
       Height="30px" Width="100%" 
        Font-Names="Segoe UI" Font-Bold="false"
        Font-Size="16px" DataKeyNames="Id" 
        onpageindexchanging="Tax_Voice_Upload_PageIndexChanging" 
        onrowdeleting="Tax_Voice_Upload_RowDeleting" 
        onrowdatabound="Tax_Voice_Upload_RowDataBound" 
        onrowcommand="Tax_Voice_Upload_RowCommand">
        <Columns>
            <asp:BoundField DataField="Tax_Type"  HeaderText="Tax Type"   HeaderStyle-CssClass="head-label head_style"  />
                 <asp:BoundField DataField="Source_Details" HeaderText="File Name" HeaderStyle-CssClass="head-label head_style" />
                   <asp:BoundField DataField="Name" HeaderText="File Type" HeaderStyle-CssClass="head-label head_style" />
            <asp:TemplateField  HeaderText="Record Info"  HeaderStyle-CssClass="head-label head_style">

                <ItemTemplate>
                <table>
                <tr>
                <td id="tdPlayer" runat="server">
                    <object  type="application/x-shockwave-flash" data='../dewplayer-vol.swf?mp3=../FileCS.ashx?Id=<%# Eval("Id") %>'
                        width="240" height="20" id="dewplayer">
                        <param name="wmode" value="transparent" />
                        <param name="movie" value='../dewplayer-vol.swf?mp3=../FileCS.ashx?Id=<%# Eval("Id") %>'/>
                    </object>
                    </td>
                    <td id="tdfile" runat="server">

                    <asp:ImageButton ID="imgbtndoc12" ImageUrl="../ImagesFiles/File_Img.png" runat="server"   ToolTip="File"   Height="30px"   Width="30px" />
                    </td>
                    <td>
                    <asp:Label ID="lbl_Path" runat="server" Text='<%#Eval("Tax_Type_Source_upload_Path") %>' Visible="false"></asp:Label>
             <%--   <asp:ImageButton ID="imgbtndocRec" ImageUrl="~/Admin/MsgImage/Download.png" runat="server"   CommandName="ViewDocument" Height="30px"   Width="30px" />
                    
                  <asp:HyperLink DataNavigateUrlFields="Id" runat="server"  Text = "Download" DataNavigateUrlFormatString = "../FileCS.ashx?Id={0}" HeaderText="Download" HeaderStyle-CssClass="head-label head_style"></asp:HyperLink>
                  <asp:LinkButton  DataNavigateUrlFields="Id" runat="server"  Text = "Download" DataNavigateUrlFormatString = "../FileCS.ashx?Id={0}" HeaderText="Download" HeaderStyle-CssClass="head-label head_style"></asp:LinkButton>--%>

                    </td>
                    </tr>
                    
                    </table>
                 
                        
                </ItemTemplate>
              
            </asp:TemplateField>

                <asp:HyperLinkField DataNavigateUrlFields="Id" runat="server"  Text = "Download" DataNavigateUrlFormatString = "../FileCS.ashx?Id={0}" HeaderText="Download" HeaderStyle-CssClass="head-label head_style" />
         
            
           
             <asp:BoundField DataField="User_Name" HeaderText="Updated By" HeaderStyle-CssClass="head-label head_style" />
             <asp:BoundField DataField="Date_of_Upload" HeaderText="Date" HeaderStyle-CssClass="head-label head_style" />
              <asp:TemplateField   HeaderText="dd" Visible="false" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:Label ID="lbl_Source_Type" runat="server" Text='<%#Eval("Tax_Type_Source_upload_File_Type") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
             <asp:TemplateField   HeaderText="Delete" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnExamDelete" runat="server" CommandName="Delete" Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" OnClientClick="javascript:return confirm('Are you sure to proceed?');" />
</ItemTemplate>
<HeaderStyle CssClass="head_style"  HorizontalAlign="Center" Height="30px" Font-Bold="True"></HeaderStyle>
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"  CssClass="grid-item" Width="16px"></ItemStyle>
</asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
  
</td>
</tr>

<tr><td align="right" colspan="6">  
    
</td></tr>

<tr id="tr_SrcUpld" runat="server" visible="false">
<td style="width:75px;"><asp:Label ID="Label31" runat="server" CssClass="Label" Text="Tax Type"></asp:Label>
</td>
<td    style=" width:189px;">
<asp:DropDownList ID="ddl_Source_upload_Taxtype"   runat="server" CssClass="DropDown" TabIndex="1" Width="175px"></asp:DropDownList>
</td>
<td style="width: 110px">
<asp:Label   ID="Label32" runat="server" CssClass="Label" Text="Source Details"></asp:Label>
</td>
<td style="width: 480px">
<asp:TextBox   ID="txt_Source_upload_Details" runat="server" CssClass="textbox"   placeholder="Type Source upload details.."
         Width="454px" TabIndex="2"></asp:TextBox>

</td>
<td style="width: 136px">
<asp:Label   ID="Label33" runat="server" CssClass="Label" Text="Upload Document"></asp:Label>
</td>
<td>



                 

                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
    <ContentTemplate>
        <asp:FileUpload ID="fileupload22" runat="server" CssClass="textbox" 
            TabIndex="3" />
    </ContentTemplate>
    <triggers>
<asp:PostBackTrigger ControlID="btn_AddSrcUpload"></asp:PostBackTrigger></triggers></asp:UpdatePanel>
</td>

</tr>
    
        <tr id="tr_SrcUpld1" runat="server" visible="false">
            <td align="right" colspan="5">
                &nbsp;</td>
            <td align="center" style="width: 210px">
     
                    
                <asp:Button ID="btn_AddSrcUpload" runat="server" CssClass="WebButton" 
                    onclick="btn_AddSrcUpload_Click" Text="Save" Width="75px" TabIndex="4" />
                   
                &nbsp;
                <asp:Button ID="btn_ClearSrcUpload" runat="server" CssClass="WebButton" 
                    onclick="btn_ClearSrcUpload_Click" Text="Cancel" Width="75px" 
                    TabIndex="5" />
            </td>
        </tr>
    


</table>


<table id="Error_Detail" runat="server"  style="width:98%;height:100px;"  
        visible="false" align="center" >

<tr><td colspan="5">
<div class="div_toprow" >
Error Info Details
<span class="div_topplus" >
<asp:ImageButton ID="btn_AddErrorInfo" runat="server" 
        ImageUrl="~/images/Gridview/plus-32.png" Width="16px" Height="16px" 
        onclick="btn_AddErrorInfo_Click"  />
</span>
</div>
</td>
</tr>
<tr>
<td colspan="5">
<div style="background-color:#fff;margin-top:-6px;">  
<asp:GridView ID="grd_Error_Details" runat="server" AutoGenerateColumns="False"   HorizontalAlign="Center" 
   AllowPaging="True"   CssClass="name" CellPadding="4" Height="30px" PageSize="4" Width="100%" 

                ShowHeaderWhenEmpty="True" 
                onrowcommand="grd_Error_Details_RowCommand" 
                onrowdeleting="grd_Error_Details_RowDeleting" 
        onpageindexchanging="grd_Error_Details_PageIndexChanging">
                
                <Columns>
                    <asp:TemplateField HeaderText="S.No" SortExpression="Order_Number" HeaderStyle-CssClass="head-label">
                        <ItemTemplate>
                            <asp:Label ID="lblErrorsino" runat="server" 
                                Text="<%# Container.DataItemIndex + 1 %>"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="30px" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Error_Id" Visible="False" HeaderStyle-CssClass="head-label"
                        SortExpression="State">
                        <ItemTemplate>
                            <asp:Label ID="lblError_Id" runat="server" Visible="false"
                                Text='<%#Eval("Error_Id") %>'></asp:Label>
                        </ItemTemplate>
                         <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="ErrorCat_Id" Visible="False" HeaderStyle-CssClass="head-label"
                        SortExpression="State">
                        <ItemTemplate>
                            <asp:Label ID="lblErorr_Category_Id" runat="server" Visible="false" 
                                Text='<%#Eval("Erorr_Category_Id") %>'></asp:Label>
                        </ItemTemplate>
                         <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Error Category" SortExpression="State" HeaderStyle-CssClass="head-label">
                        <ItemTemplate>
                            <asp:Label ID="lblError_Category_Name" runat="server" 
                                Text='<%#Eval("Error_Category_Name") %>'></asp:Label>
                        </ItemTemplate>
                         <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Error Description" SortExpression="Tax_Period" HeaderStyle-CssClass="head-label">
                        <ItemTemplate>
                        <asp:Label ID="lblError_Description" runat="server" CommandName="ErrorDetails" Text='<%#Eval("Error_Description") %>'>
                        </asp:Label>
                        
                        </ItemTemplate>
                        <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText="View" HeaderStyle-CssClass="head-label">
<ItemTemplate>
<asp:ImageButton ID="imgbtnerrorEdit" runat="server" CommandName="EditRecord" Height="20px" ImageUrl="~/images/Gridview/View.png" Width="20px" />
</ItemTemplate>
<HeaderStyle CssClass="head_style" HorizontalAlign="Center" VerticalAlign="Middle"   Height="30px" Width="16px" Font-Bold="True"  />
<ItemStyle HorizontalAlign="Center" Width="100px" CssClass="grid-item" />
</asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head-label" HeaderText="Delete">
                        <ItemTemplate>
                            <asp:ImageButton ID="imgbtnErrorDelete" runat="server" CommandName="Delete" 
                                Height="20px" ImageUrl="~/images/Gridview/Remove-icon.png" 
                                OnClientClick="javascript:return confirm('Are you sure to proceed?');" 
                                Width="20px" />
                        </ItemTemplate>
                         <HeaderStyle CssClass="head_style" HorizontalAlign="Center"  Height="30px" />
                        <ItemStyle CssClass="grid-item" HorizontalAlign="Center" Width="16px" />
                        
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle BorderColor="#D9D9D9" BorderStyle="Solid" BorderWidth="1px" BackColor="#f9f9f9" ForeColor="#333333" ></EmptyDataRowStyle>
                                       <FooterStyle BackColor="#cccccc"  ForeColor="White" Font-Bold="True"/>
                                       <PagerStyle CssClass="PagerStyle" HorizontalAlign="Center" />
                                       <SelectedRowStyle CssClass="SelectedRowStyle" Font-Bold="True" ForeColor="White" />
                                       <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                       <SortedAscendingHeaderStyle BackColor="#808080" />
                                       <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                       <SortedDescendingHeaderStyle BackColor="#383838" />

            </asp:GridView>
</div>
</td>
</tr>

<tr><td align="right" colspan="5">  
    
</td></tr>

<tr id="tr_ErrorDet" runat="server" visible="false">
<td><asp:Label ID="Label59" runat="server" CssClass="Label" Text="Error Category:"></asp:Label></td>
<td><asp:DropDownList ID="ddl_Error_Category" runat="server" CssClass="DropDown" 
            TabIndex="1" Width="160px">
        </asp:DropDownList></td>
<td><asp:Label ID="Label60" runat="server" CssClass="Label" 
        Text="Error Description:"></asp:Label></td>
<td><asp:TextBox ID="txt_Error_Description" runat="server" 
        CssClass="textbox" TabIndex="2" 
        Width="300px"></asp:TextBox></td>

</tr>

  <tr id="tr_ErrorDet1" runat="server" visible="false">
     <td align="right" colspan="4">
         &nbsp;</td>
<td align="center" style="width: 210px" >
<asp:Button ID="Imgbtn_Error" runat="server" CssClass="WebButton" 
                   
                    Text="Save" 
                    Width="75px" onclick="Imgbtn_Error_Click" TabIndex="3" />
    &nbsp;
<asp:Button ID="btn_ClearError" runat="server" CssClass="WebButton" 
                    Text="Cancel" Width="75px" onclick="btn_ClearError_Click" TabIndex="4" />
    </td>
     </tr>

     

</table>

</td>
</tr>
<tr><td><br /><Br /></td></tr>
</table>
 <div>
      <M1ok:M1  ID="omb" runat="server"/>
     
      </div>
</ContentTemplate></asp:UpdatePanel>
</div>


    
    <div class="WebHRBottom">
 <div class="WebHRMain" align="right">
  <div style="height:10px;"></div>
  

  <div align="center" class="WebHRBottomText" style="height:199px">
 

 &copy;&nbsp;2013 - 2018 Developed by <a href="http://www.drnds.com" target="_blank">DRN Definite Solutions</a>
</div>
  </div>
 </div>

    </form>
</body>
</html>
    
   
    







