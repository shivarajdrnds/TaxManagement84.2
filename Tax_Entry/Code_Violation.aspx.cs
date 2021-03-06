﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Web.UI.HtmlControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.ReportSource;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System.Text;
using System.Drawing;
using ClosedXML.Excel;
public partial class Code_Violation : System.Web.UI.Page
{
    Commonclass commnclass = new Commonclass();
    CustomerBowser browser = new CustomerBowser();
    DataAccess dataaccess = new DataAccess();
    DropDownistBindClass dbc = new DropDownistBindClass();

    int tabweb = 0, tabit = 0, taborder = 0, tabagency = 0, tabout = 0, tabcmt = 0, tabcountydb = 0, btncountydb = 0, btndeldb = 0;
    int tabtax = 0, tabassed = 0, tabsaldet = 0, tabmunicple = 0, tabbankrupty = 0, tabsrcupload = 0, taberror = 0;
    string User_Role_Id;
    int userid;
    string Empname;
    int Count;
    Hashtable htselect = new Hashtable();
    DataTable dtselect = new DataTable();
    Genral gen = new Genral();
    int BRANCH_ID;
    int Order_Id;
    string Operation;
    decimal Land, Building, Total, sold_Tax_AMount, Munciplene_Amount;
    string path, View_File_Path;
    string extension;
    string Order_Kbpath;
    string Tax_Type_Source_Upload__path;
    string Doctype;
    string docpath;
    int Maximum;
    string Order_Type = "";
    decimal Tax_Amount, Excemption;
    int Orderpath_Count;
    int Check_County;
    int Status_Id;
    object Tax_Inserted_Id;
    int Production_Check;
    int Check_Status;
    ReportDocument rptDoc = new ReportDocument();
    ReportDocument subRepDoc = new ReportDocument();
    public string Connection = ConfigurationManager.ConnectionStrings["TaxManagementConnectionString"].ConnectionString.ToString();
    int client_Id, Subprocess_id;
    decimal tax_Base_Amount, tax_Pay_Off_Amount, tax_Paid_Amount, tax_due_Amount, tax_Discount_Amount;
    DateTime date2;
    string Template;
    DataTable dtgrid = new DataTable("Grid");
    protected void Page_Load(object sender, EventArgs e)
    {
        //Tab_AssedVal.Enabled = false;
        //Tab_SalDetail.Enabled = false;
        ////Tab_MuncipleDet.Enabled = false;
        //Tab_BankruptyDet.Enabled = false;
        //Tab_SourceUpload.Enabled = false;

        //Color bgcr = ColorTranslator.FromHtml("#12B61F");
        //Color focr = ColorTranslator.FromHtml("#ffffff");
        //Tab_TaxDetails.ForeColor = focr;
        //Tab_TaxDetails.BackColor = bgcr;

        if (tabweb == 0 && tabit == 0 && taborder == 0 && tabagency == 0 && tabout == 0 && tabcmt == 0 && tabcountydb == 0 && btncountydb == 0 && btndeldb == 0 && tabassed == 0 &&
            tabsaldet == 0 && tabmunicple == 0 && tabbankrupty == 0 && tabsrcupload == 0)
        {
            Color bgcr = ColorTranslator.FromHtml("#12B61F");
            Color focr = ColorTranslator.FromHtml("#ffffff");
          

            Color bgclr = ColorTranslator.FromHtml("#33CCFF");
            Color foclr = ColorTranslator.FromHtml("#303030");

        



        
        }

        if (Session["client_Id"] != "" && Session["subProcess_id"] != "")
        {

            client_Id = int.Parse(Session["client_Id"].ToString());
            Subprocess_id = int.Parse(Session["subProcess_id"].ToString());
            User_Role_Id = Session["Role_Id"].ToString();
        }

        if (Session["userid"] == null)
        {

            Response.Redirect("~/Login.aspx");

        }
        else
        {

            userid = int.Parse(Session["userid"].ToString());
            Empname = Session["Empname"].ToString();
            BRANCH_ID = int.Parse(Session["Branch_id"].ToString());
             lblusername.Text = Empname.ToString();
        }
        Order_Id = int.Parse(Session["order_id"].ToString());
        Order_Type = Session["Order_Type"].ToString();
        if (Session["LastLogin"] != "")
        {

          //  lastlogin.Text = Session["LastLogin"].ToString();

        }
        else
        {

            //lastlogin.Text = DateTime.Now.ToString();
        }
        if (!IsPostBack)
        {
            Img_User.ImageUrl = "~/Admin/UserHandler.ashx?User_id=" + userid;
        

            dbc.BindState(ddl_Barrower_State);


            dbc.BindDeliquentTax_Type(ddl_Tax_Delquent_Tax_type, Order_Id);
            dbc.BindTax_Type_By_Order_Id(ddl_CountyTaxtype,Order_Id);
            dbc.BindSourceUploadTax_Type(ddl_Source_upload_Taxtype, Order_Id);
            dbc.BindSourceUploadTax_Type(ddl_TaxType_Commts, Order_Id);
            dbc.BindTax_Violation_Status(ddl_Tax_Staus);
            dbc.BindOrderStatus_ForEnter(ddl_Status);
          
        
            if (ddl_Barrower_County.SelectedValue != "")
            {

                dbc.BindCounty(ddl_Barrower_County, int.Parse(ddl_Barrower_State.SelectedValue));

            }
            Get_Order_Details();
            Bind_Tax_Violation_Details();
             dbc.Bind_Agency_Type(ddl_Agency_Type,int.Parse(ddl_Barrower_State.SelectedValue.ToString()));
            Page.MaintainScrollPositionOnPostBack = true;
            Gridview_Bind_Order_Kb_Data();
            Gridview_Bind_Order_Agency_Kb_Data();
         
            Gridview_Bind_IT_Error_Data();
           
            Gridview_Bind_CountyDatabaseInformation();

            Gridview_Bind_Tax_Type_Comments();
            Gridview_Bind_Order_Deliquent_Data();
           
          
            Gridview_Bind_Tax_type_Source_Upload_Data();
           
            Grdiview_Bind_Tax_County_Link();
          

        }
    }
   
    protected void Grdiview_Bind_Tax_County_Link()
    {
        Hashtable htselect = new Hashtable();
        DataTable dtselect = new DataTable();



        htselect.Add("@Trans", "SELECT_BY_STATE_COUNTY");
        htselect.Add("@State", ddl_Barrower_State.SelectedValue);
        htselect.Add("@County", ddl_Barrower_County.SelectedValue);

        dtselect = dataaccess.ExecuteSP("Sp_County_Tax_Assesment_Link", htselect);
        if (dtselect.Rows.Count > 0)
        {

            Grd_Tax_County_Link.DataSource = dtselect;
            Grd_Tax_County_Link.DataBind();


        }
        else
        {
            Grd_Tax_County_Link.DataSource = null;
            Grd_Tax_County_Link.DataBind();


        }

    }
    protected void Get_Order_Details()
    {

        Hashtable htorder = new Hashtable();
        DataTable dtorder = new System.Data.DataTable();

        htorder.Add("@Trans", "SELECT_ORDER_WISE");
        htorder.Add("@Order_Id", Order_Id);
        dtorder = dataaccess.ExecuteSP("Sp_Order", htorder);
        if (dtorder.Rows.Count > 0)
        {

            txt_Order_Number.Text = dtorder.Rows[0]["Client_Order_Number"].ToString();

            // txt_Loan_Number.Text = dtorder.Rows[0]["Loan_Number"].ToString();

            Session["Sub_processID"] = dtorder.Rows[0]["Sub_ProcessId"].ToString();


            txt_Barrower_Name.Text = dtorder.Rows[0]["Borrower_Name"].ToString();
            txt_Barrower_Name.Text = dtorder.Rows[0]["Last_Name"].ToString();
            txt_Barrower_Address.Text = dtorder.Rows[0]["Barrower_Address"].ToString();
            txt_Barrower_City.Text = dtorder.Rows[0]["Barrower_City"].ToString();
            txt_Barrower_Zip.Text = dtorder.Rows[0]["Barrower_Zip"].ToString();
            txt_Loan_no.Text = dtorder.Rows[0]["Loan_Number"].ToString();

            ddl_Barrower_State.SelectedValue = dtorder.Rows[0]["Barrower_State"].ToString();

            dbc.BindCounty(ddl_Barrower_County, int.Parse(ddl_Barrower_State.SelectedValue));
            ddl_Barrower_County.SelectedValue = dtorder.Rows[0]["Barrower_County"].ToString();

            txt_Date.Text = dtorder.Rows[0]["date"].ToString();
            txt_Parcel_Number.Text = dtorder.Rows[0]["Parecel_Id"].ToString();
            //txt_Tax_Comments.Text = dtorder.Rows[0]["Comments"].ToString();
            // txt_Order_Notes.Text = dtorder.Rows[0]["Notes"].ToString();
           
            ViewState["County_Id"] = dtorder.Rows[0]["Barrower_County"].ToString();
            ViewState["State_Id"] = dtorder.Rows[0]["Barrower_State"].ToString();
            if (txt_Barrower_City.Text != "")
            {
                ViewState["City"] = txt_Barrower_City.Text;
            }
            else
            {
                ViewState["City"] = "";


            }
            ViewState["Order_Number"] = dtorder.Rows[0]["Client_Order_Number"].ToString();
            ViewState["Order_Status"] = dtorder.Rows[0]["Order_Status"].ToString();
            ViewState["Order_Task"] = dtorder.Rows[0]["Order_Task_Id"].ToString();

        }


    }
    
    protected void Gridview_Bind_Tax_Type_Comments()
    {
        Hashtable ht_Comments = new Hashtable();
        DataTable dt_Comments = new System.Data.DataTable();
        ht_Comments.Add("@Trans", "SELECT");
        ht_Comments.Add("@Order_Id", Order_Id);
        dt_Comments = dataaccess.ExecuteSP("Sp_Orders_Tax_County_Comments", ht_Comments);
        if (dt_Comments.Rows.Count > 0)
        {
            //ex2.Visible = true;
            Grd_Tax_Type_Comments.Visible = true;
            Grd_Tax_Type_Comments.DataSource = dt_Comments;
            Grd_Tax_Type_Comments.DataBind();

        }
        else
        {
            Grd_Tax_Type_Comments.Visible = true;
            Grd_Tax_Type_Comments.DataSource = null;
            Grd_Tax_Type_Comments.EmptyDataText = "No Orders Added";
            Grd_Tax_Type_Comments.DataBind();
        }

    }

    protected void Gridview_Bind_Order_Agency_Kb_Data()
    {
        Hashtable htselorderkb = new Hashtable();
        DataTable dtuser = new System.Data.DataTable();

        htselorderkb.Add("@Trans", "SELECT");
        htselorderkb.Add("@County_Id", ViewState["County_Id"]);
        dtuser = dataaccess.ExecuteSP("Sp_Orders_Agency_Knowledge_Base", htselorderkb);
        if (dtuser.Rows.Count > 0)
        {
            //ex2.Visible = true;
            grd_Agency.Visible = true;
            grd_Agency.DataSource = dtuser;
            grd_Agency.DataBind();

        }
        else
        {

            grd_Agency.DataSource = null;
            grd_Agency.EmptyDataText = "No Records Are Avilable";
            grd_Agency.DataBind();

        }
    }



    protected void Gridview_Bind_CountyDatabaseInformation()
    {

        Hashtable htselCountyDdata = new Hashtable();
        DataTable dtCountyData = new System.Data.DataTable();

        htselCountyDdata.Add("@Trans", "SELECT_COUNTYDB_TAXTYPE");
        htselCountyDdata.Add("@Order_Id", Order_Id);
        dtCountyData = dataaccess.ExecuteSP("Sp_Orders_Tax_County_DataBase", htselCountyDdata);
        if (dtCountyData.Rows.Count > 0)
        {
            //ex2.Visible = true;
            grd_Tax_County_Database.Visible = true;
            grd_Tax_County_Database.DataSource = dtCountyData;
            grd_Tax_County_Database.DataBind();

        }
        else
        {

            grd_Tax_County_Database.DataSource = null;
            grd_Tax_County_Database.EmptyDataText = "No Records Are Avilable";
            grd_Tax_County_Database.DataBind();

        }

    }
    protected void Gridview_Bind_Tax_type_Source_Upload_Data()
    {
     
        Hashtable htselSourceuploadkb = new Hashtable();
        DataTable dtselSourceuploadkb = new System.Data.DataTable();

        htselSourceuploadkb.Add("@Trans", "SELECT");
        htselSourceuploadkb.Add("@Order_Id", Order_Id);
        // htselSourceuploadkb.Add("@Tax_Type_Id", Tax_Type_Id);
        dtselSourceuploadkb = dataaccess.ExecuteSP("Sp_Orders_Tax_Source_Upload", htselSourceuploadkb);
        if (dtselSourceuploadkb.Rows.Count > 0)
        {
         
            Tax_Voice_Upload.Visible = true;
            Tax_Voice_Upload.DataSource = dtselSourceuploadkb;
            Tax_Voice_Upload.DataBind();
        
        }
        else
        {

            Tax_Voice_Upload.DataSource = null;
            Tax_Voice_Upload.EmptyDataText = "No Records Are Avilable";
            Tax_Voice_Upload.DataBind();


        }
    }
    protected void Gridview_Bind_Order_Deliquent_Data()
    {
        Hashtable htselorderkb = new Hashtable();
        DataTable dtuser = new System.Data.DataTable();

        htselorderkb.Add("@Trans", "SELECT");
        htselorderkb.Add("@Order_Id", Order_Id);
        dtuser = dataaccess.ExecuteSP("Sp_Orders_Tax_Deliquent_County_Data", htselorderkb);
        if (dtuser.Rows.Count > 0)
        {
            //ex2.Visible = true;
            Grid_Delequent_Data.Visible = true;
            Grid_Delequent_Data.DataSource = dtuser;
            Grid_Delequent_Data.DataBind();

        }
        else
        {

            Grid_Delequent_Data.DataSource = null;
            Grid_Delequent_Data.EmptyDataText = "No Records Are Avilable";
            Grid_Delequent_Data.DataBind();

        }
    }
    protected void tbpnluser_Click(object sender, EventArgs e)
    {
        Web_info.Visible = true;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        td_row.Visible = true;
        tr_county.Visible = false;
        tr_countydb.Visible = false;

        tabweb = 1;

        if (tabweb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tbpnluser.ForeColor = foclr;
            tbpnluser.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
        
        }
        //     tr_btnCounty.Visible = false;
    }
    protected void tabitcomplent_Click(object sender, EventArgs e)
    {
        Web_info.Visible = false;
        IT_comp.Visible = true;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabit = 1;

        if (tabit == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tabitcomplent.ForeColor = foclr;
            tabitcomplent.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
           
        }
        tr_ITcomp.Visible = false;
        tr_ITcomp1.Visible = false;
    }
    private void Clear_ITcomp()
    {
        txt_Error.Text = "";
        fileupload3.Attributes.Clear();
    }
    private void table_ITComp()
    {
        Web_info.Visible = false;
        IT_comp.Visible = true;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabit = 1;

        if (tabit == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tabitcomplent.ForeColor = foclr;
            tabitcomplent.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
         
        }
    }
    protected void tbpnlusrdetails_Click(object sender, EventArgs e)
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = true;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        taborder = 1;

        if (taborder == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tbpnlusrdetails.ForeColor = foclr;
            tbpnlusrdetails.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
           
        }
        tr_OrderKb.Visible = false;
        tr_OrderKb1.Visible = false;
        //tr_btnCounty.Visible = false;
    }
    private void Clear_OrderKb()
    {
        txt_order_Kb_Document.Text = "";
        txt_order_Kb_Comment.Text = "";
        fileupload1.Attributes.Clear();
    }
    private void table_OrderKb()
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = true;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        taborder = 1;

        if (taborder == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tbpnlusrdetails.ForeColor = foclr;
            tbpnlusrdetails.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
          
        }
    }
    protected void tbpnljobdetails_Click(object sender, EventArgs e)
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = true;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabagency = 1;

        if (tabagency == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tbpnljobdetails.ForeColor = foclr;
            tbpnljobdetails.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
            
        }

        tr_Agency.Visible = false;
    }
    private void table_AgencyKb()
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = true;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabagency = 1;

        if (tabagency == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tbpnljobdetails.ForeColor = foclr;
            tbpnljobdetails.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
            
        }
    }
    protected void taboutputpreview_Click(object sender, EventArgs e)
    {
        
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = true;
        County_Comm.Visible = false;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabout = 1;

        if (tabout == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            taboutputpreview.ForeColor = foclr;
            taboutputpreview.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
          
        }

        //  tr_btnCounty.Visible = false;
    }
    protected void tabcountycmt_Click(object sender, EventArgs e)
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = true;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabcmt = 1;

        if (tabcmt == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tabcountycmt.ForeColor = foclr;
            tabcountycmt.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
            
        }
        tr_CountyData.Visible = false;
        tr_CountyData1.Visible = false;
    }
    private void Clear_County()
    {
        ddl_TaxType_Commts.SelectedIndex = 0;
        Txt_taxtype_Comments.Text = "";
    }
    private void table_countyCmt()
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = true;
        County_Db.Visible = false;
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = false;
        tr_county.Visible = false;
        tr_countydb.Visible = false;
        td_row.Visible = true;
        tabcmt = 1;

        if (tabcmt == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tabcountycmt.ForeColor = foclr;
            tabcountycmt.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
          
        }
    }
    protected void tabcounty_Click(object sender, EventArgs e)
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = true;
        tr_county.Visible = true;
        tr_countydb.Visible = true;
        td_row.Visible = false;


        btn_lnkCountyDb.Visible = true;
        btnlnkDelequentDb.Visible = false;
        tabcountydb = 1;
        btncountydb = 1;

        if (tabcountydb == 1 && btncountydb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");

            btn_CountyDB.ForeColor = foclr;
            btn_CountyDB.BackColor = bgclr;
            tabcounty.ForeColor = foclr;
            tabcounty.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
         
        }
        tr_CountyData.Visible = false;
        tr_CountyData1.Visible = false;

    }
    private void table_countyDB()
    {
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        County_Db.Visible = true;
        tr_county.Visible = true;
        tr_countydb.Visible = true;
        td_row.Visible = false;


        //tr_btnCounty.Visible = true;
        btn_lnkCountyDb.Visible = true;
        btnlnkDelequentDb.Visible = false;
        tabcountydb = 1;
        btncountydb = 1;

        if (tabcountydb == 1 && btncountydb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");

            btn_CountyDB.ForeColor = foclr;
            btn_CountyDB.BackColor = bgclr;
            tabcounty.ForeColor = foclr;
            tabcounty.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
          
        }
    }
    protected void btn_CountyDB_Click(object sender, EventArgs e)
    {
        btn_lnkCountyDb.Visible = true;
        btnlnkDelequentDb.Visible = false;
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        tr_county.Visible = true;
        tr_countydb.Visible = true;
        tabcountydb = 1;
        btncountydb = 1;

        if (btncountydb == 1 && tabcountydb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            tabcounty.ForeColor = foclr;
            tabcounty.BackColor = bgclr;
            btn_CountyDB.ForeColor = foclr;
            btn_CountyDB.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
            
        }
        tr_CountyDbInfo.Visible = false;
        tr_CountyDbInfo1.Visible = false;
    }
    private void Clear_CountyDb()
    {
        ddl_CountyTaxtype.SelectedIndex = 0;
        txt_CountyPhno.Text = ""; txt_CountyPayto.Text = ""; txt_CountyTaxPayeeadd.Text = "";
    }
    protected void btn_DelequentDb_Click(object sender, EventArgs e)
    {
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = true;
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        tr_county.Visible = true;
        tr_countydb.Visible = true;
        btndeldb = 1;
        tabcountydb = 1;

        if (btndeldb == 1 && tabcountydb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            btn_DelequentDb.ForeColor = foclr;
            btn_DelequentDb.BackColor = bgclr;
            tabcounty.ForeColor = foclr;
            tabcounty.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
            
        }
        tr_DelequentDb.Visible = false;
        tr_DelequentDb1.Visible = false;
    }
    private void table_DelequentDB()
    {
        btn_lnkCountyDb.Visible = false;
        btnlnkDelequentDb.Visible = true;
        Web_info.Visible = false;
        IT_comp.Visible = false;
        Order_Kb.Visible = false;
        Agency_Kb.Visible = false;
        Out_Put_Preview.Visible = false;
        County_Comm.Visible = false;
        tr_county.Visible = true;
        tr_countydb.Visible = true;
        btndeldb = 1;
        tabcountydb = 1;

        if (btndeldb == 1 && tabcountydb == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            btn_DelequentDb.ForeColor = foclr;
            btn_DelequentDb.BackColor = bgclr;
            tabcounty.ForeColor = foclr;
            tabcounty.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
          
        }
    }
    protected void btn_Error_Submit_Click(object sender, EventArgs e)
    {
        tr_ITcomp.Visible = false;
        tr_ITcomp1.Visible = false;
        table_ITComp();
    


       
        if (txt_Error.Text != "")
        {
            Hashtable htorderkb = new Hashtable();
            DataTable dtorderkb = new System.Data.DataTable();

            string Uploadpath = @"\\192.168.12.33\TAXPLORER\IT COMPLIANTS\" + txt_Order_Number.Text;
            DirectoryInfo di = new DirectoryInfo(Uploadpath);

            if (di.Exists)
            {
                di.Delete(true);


                Directory.CreateDirectory(@"\\192.168.12.33\TAXPLORER\IT COMPLIANTS\" + txt_Order_Number.Text);
            }
            else if (!di.Exists)
            {
                Directory.CreateDirectory(@"\\192.168.12.33\TAXPLORER\IT COMPLIANTS\" + txt_Order_Number.Text);
            }
            HttpFileCollection uploads = HttpContext.Current.Request.Files;
            if (uploads != null)
            {
                string c = Path.GetFileName(fileupload3.PostedFile.FileName);
                string fileName = c;
                if (fileName != "")
                {
                    string dest_path1 = @"\\192.168.12.33\TAXPLORER\IT COMPLIANTS\" + txt_Order_Number.Text + @"\" + fileName;
                    fileupload3.PostedFile.SaveAs(dest_path1);

                    ViewState["Path"] = dest_path1;

                    path = ViewState["Path"].ToString();
                }
            }
            else
            {

                path = null;
            }




            DateTime date = new DateTime();
            date = DateTime.Now;
            string dateeval = date.ToString("dd/MM/yyyy");
            string time = date.ToString("hh:mm tt");

            htorderkb.Add("@Trans", "INSERT");
            htorderkb.Add("@Order_Id", Order_Id);
            htorderkb.Add("@Error_Name", txt_Error.Text);
            htorderkb.Add("@Error_Path", path);
            htorderkb.Add("@Inserted_By", userid);
            htorderkb.Add("@Inserted_date", date);
            htorderkb.Add("@status", "True");
            dtorderkb = dataaccess.ExecuteSP("Sp_Orders_IT_Error", htorderkb);
            Gridview_Bind_IT_Error_Data();
            txt_Error.Text = "";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Your request has Sent to IT Team,We Will Response You Soon')</script>", false);
            //fileuploadError.FileName = null;


        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Please Enter Error Name')</script>", false);
        }

    }
    private bool Validate_Order_Kb()
    {


        if (txt_order_Kb_Comment.Text == "")
        {
            txt_order_Kb_Comment.Focus();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Enter Comment')</script>", false);
            return false;


        }
        return true;
    }
    protected void img_btn_order_kb_add_Click(object sender, EventArgs e)
    {

        tr_OrderKb.Visible = false;
        tr_OrderKb1.Visible = false;
        table_OrderKb();
       
        if (Validate_Order_Kb() != false && img_btn_order_kb_add.Text == "Save")
        {
            //  model1.Show();
            tr_OrderKb.Visible = false;
            tr_OrderKb1.Visible = false;

            Hashtable htorderkb = new Hashtable();
            DataTable dtorderkb = new System.Data.DataTable();

            string Uploadpath = @"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text;
            DirectoryInfo di = new DirectoryInfo(Uploadpath);


            if (!di.Exists)
            {
                Directory.CreateDirectory(@"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text);
            }
            HttpFileCollection uploads = HttpContext.Current.Request.Files;
            if (uploads != null)
            {
                string c = Path.GetFileName(fileupload1.PostedFile.FileName);
                string fileName = c;
                extension = Path.GetExtension(fileupload1.FileName);
                if (fileName != "")
                {
                    string dest_path1 = @"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text + @"\" + fileName;
                    fileupload1.PostedFile.SaveAs(dest_path1);
                    ViewState["FPath"] = dest_path1;

                    Order_Kbpath = ViewState["FPath"].ToString();
                }
            }
            else
            {

                Order_Kbpath = null;
            }
            DateTime date = new DateTime();
            date = DateTime.Now;
            htorderkb.Add("@Trans", "INSERT");
            htorderkb.Add("@Subprocess_Id", int.Parse(Session["Sub_processID"].ToString()));
            htorderkb.Add("@Order_Id", Order_Id);
            htorderkb.Add("@Document_Name", txt_order_Kb_Document.Text);
            htorderkb.Add("@Comments", txt_order_Kb_Comment.Text);
            htorderkb.Add("@Order_kb_File_Type", extension);
            if (Order_Kbpath != null)
            {
                htorderkb.Add("@Order_Kb_Path", Order_Kbpath);
            }
            htorderkb.Add("@Inserted_By", userid);
            htorderkb.Add("@Inserted_date", date);
            htorderkb.Add("@Modified_By", userid);
            htorderkb.Add("@Modified_Date", date);
            htorderkb.Add("@status", "True");
            dtorderkb = dataaccess.ExecuteSP("Sp_Order_Knowledge_Base", htorderkb);
            Gridview_Bind_Order_Kb_Data();

            ClearOrderandAgency();

        }
        else if (img_btn_order_kb_add.Text == "UPDATE" && Validate_Order_Kb() != false)
        {
            // model1.Show();

            Hashtable htorderkb = new Hashtable();
            DataTable dtorderkb = new System.Data.DataTable();

            string Uploadpath = @"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text;
            DirectoryInfo di = new DirectoryInfo(Uploadpath);


            if (!di.Exists)
            {
                Directory.CreateDirectory(@"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text);
            }
            HttpFileCollection uploads = HttpContext.Current.Request.Files;
            if (uploads != null)
            {
                string c = Path.GetFileName(fileupload1.PostedFile.FileName);
                string fileName = c;
                extension = Path.GetExtension(fileupload1.FileName);
                if (fileName != "")
                {
                    string dest_path1 = @"\\192.168.12.33\TAXPLORER\ORDER KB\" + txt_Order_Number.Text + @"\" + fileName;
                    fileupload1.PostedFile.SaveAs(dest_path1);

                    ViewState["FPath"] = dest_path1;

                    Order_Kbpath = ViewState["FPath"].ToString();
                }
            }
            else
            {

                Order_Kbpath = null;
            }
            DateTime date = new DateTime();
            date = DateTime.Now;
            htorderkb.Add("@Trans", "UPDATE");
            htorderkb.Add("@Order_Kb_Id", ViewState["Order_Kb_Id"]);
            htorderkb.Add("@Subprocess_Id", userid);
            htorderkb.Add("@Order_Id", Order_Id);
            htorderkb.Add("@Document_Name", txt_order_Kb_Document.Text);
            htorderkb.Add("@Comments", txt_order_Kb_Comment.Text);
            htorderkb.Add("@Order_kb_File_Type", extension);
            htorderkb.Add("@Order_Kb_Path", Order_Kbpath);
            htorderkb.Add("@Modified_By", userid);
            htorderkb.Add("@Modified_Date", date);
            htorderkb.Add("@status", "True");
            dtorderkb = dataaccess.ExecuteSP("Sp_Order_Knowledge_Base", htorderkb);

            img_btn_order_kb_add.Text = "Add";
            ClearOrderandAgency();
            Gridview_Bind_Order_Kb_Data();
            tr_OrderKb.Visible = false;
            tr_OrderKb1.Visible = false;
        }

        //model1.Hide();
    }
    protected void ClearOrderandAgency()
    {

        txt_order_Kb_Comment.Text = "";
        txt_order_Kb_Document.Text = "";
        txt_Agency_Comment.Text = "";


    }
    protected void imgbtn_agency_Add_Click(object sender, EventArgs e)
    {
        tr_Agency.Visible = false;
        table_AgencyKb();
        if (Validate_Order_Agency_Kb() != false && imgbtn_agency_Add.Text != "UPDATE")
        {

            Hashtable htagencykb = new Hashtable();
            DataTable agencykb = new System.Data.DataTable();

            DateTime date = new DateTime();
            date = DateTime.Now;
            string dateeval = date.ToString("dd/MM/yyyy");
            string time = date.ToString("hh:mm tt");

            htagencykb.Add("@Trans", "INSERT");
            htagencykb.Add("@County_Id", ViewState["County_Id"]);
            htagencykb.Add("@Comments", txt_Agency_Comment.Text);
            htagencykb.Add("@Inserted_By", userid);
            htagencykb.Add("@Inserted_date", date);
            htagencykb.Add("@Modified_By", userid);
            htagencykb.Add("@Modified_Date", date);
            htagencykb.Add("@status", "True");
            agencykb = dataaccess.ExecuteSP("Sp_Orders_Agency_Knowledge_Base", htagencykb);

            Gridview_Bind_Order_Agency_Kb_Data();
            ClearOrderandAgency();
        }
        else if (imgbtn_agency_Add.Text == "UPDATE")
        {

            Hashtable htagencykb = new Hashtable();
            DataTable agencykb = new System.Data.DataTable();

            DateTime date = new DateTime();
            date = DateTime.Now;
            string dateeval = date.ToString("dd/MM/yyyy");
            string time = date.ToString("hh:mm tt");
            string Chanesto = txt_Agency_Comment.Text;
            htagencykb.Add("@Trans", "UPDATE");  //Keep User Tracking
            htagencykb.Add("@Order_Agency_Kb_Id", ViewState["Agency_Order_Kb_Id"]);
            htagencykb.Add("@County_Id", ViewState["County_Id"]);
            htagencykb.Add("@Comments", Chanesto.ToString());
            htagencykb.Add("@Modified_By", userid);
            htagencykb.Add("@Modified_Date", date);
            htagencykb.Add("@status", "True");


            agencykb = dataaccess.ExecuteSP("Sp_Orders_Agency_Knowledge_Base", htagencykb);

            ClearOrderandAgency();
            imgbtn_agency_Add.Text = "Add";
            Gridview_Bind_Order_Agency_Kb_Data();

        }
        txt_Agency_Comment.Text = "";
    }
    private bool Validate_Order_Agency_Kb()
    {

        if (txt_Agency_Comment.Text == "")
        {
            txt_Agency_Comment.Focus();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Enter Comment')</script>", false);
            return false;


        }
        return true;
    }
    protected void imgbtn_Taxtype_Note_Add_Click(object sender, EventArgs e)
    {
        tr_CountyData.Visible = false;
        tr_CountyData1.Visible = false;
        table_countyCmt();
        Hashtable httaxnotes = new Hashtable();
        DataTable dtcountytaxnotes = new System.Data.DataTable();
        if (ImageButton3.Text == "Save")
        {
            DateTime datecountynote = new DateTime();
            datecountynote = DateTime.Now;
            //    dbc.BindComments_Tax_Type(ddl_TaxType_Commts, Order_Id);
            httaxnotes.Add("@Trans", "INSERT");
            httaxnotes.Add("@Order_Id", Order_Id);
            httaxnotes.Add("@Tax_Id", int.Parse(ddl_TaxType_Commts.SelectedValue.ToString()));

            httaxnotes.Add("@Note", Txt_taxtype_Comments.Text);
            httaxnotes.Add("@Inserted_By", userid);
            httaxnotes.Add("@Inserted_date", DateTime.Now);
            httaxnotes.Add("@Status", "True");
            dtcountytaxnotes = dataaccess.ExecuteSP("Sp_Orders_Tax_County_Comments", httaxnotes);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Comment add successfully')</script>", false);
        }
        else if (ImageButton3.Text == "Update")
        {
            httaxnotes.Add("@Trans", "UPDATE");
            httaxnotes.Add("@Tax_Id", int.Parse(ddl_TaxType_Commts.SelectedValue.ToString()));
            httaxnotes.Add("@Note_Id", int.Parse(ViewState["lbl_Note_Id"].ToString()));
            httaxnotes.Add("@Note", Txt_taxtype_Comments.Text);
            httaxnotes.Add("@Modified_By", userid);
            httaxnotes.Add("@Modified_Date", DateTime.Now);
            dtcountytaxnotes = dataaccess.ExecuteSP("Sp_Orders_Tax_County_Comments", httaxnotes);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Comment update successfully')</script>", false);
        }
        ddl_TaxType_Commts.SelectedValue = "SELECT";
        Clear_County();
        
        Gridview_Bind_Tax_Type_Comments();
    }
    protected void imgbtn_Delequent_Tax_Add_Click(object sender, EventArgs e)
    {
        tr_DelequentDb.Visible = false;
        tr_DelequentDb1.Visible = false;
        table_DelequentDB();
        if (imgbtn_Delequent_Tax_Add.Text == "Add")
        {

            Hashtable htcountydata = new Hashtable();
            DataTable dtcountydata = new System.Data.DataTable();
            DateTime datecounty = new DateTime();
            datecounty = DateTime.Now;

            htcountydata.Add("@Trans", "INSERT");
            htcountydata.Add("@Order_Id", Order_Id);
            htcountydata.Add("@Tax_Type_Id", int.Parse(ddl_Tax_Delquent_Tax_type.SelectedValue.ToString()));
            htcountydata.Add("@Ph_No", txt_delequent_phno.Text);
            htcountydata.Add("@Make_Changes_Payable_to", txt_Delequent_Make_Changes.Text);
            htcountydata.Add("@Payee_Address", txt_Delequent_Payee_addres.Text);
            htcountydata.Add("@Inserted_By", userid);
            htcountydata.Add("@Inserted_date", datecounty);
            htcountydata.Add("@Status", "True");
            dtcountydata = dataaccess.ExecuteSP("Sp_Orders_Tax_Deliquent_County_Data", htcountydata);

            Gridview_Bind_Order_Deliquent_Data();
            ClearDeliquent();

        }
        else if (imgbtn_Delequent_Tax_Add.Text == "Update")
        {

            Hashtable htcountydata = new Hashtable();
            DataTable dtcountydata = new System.Data.DataTable();
            DateTime datecounty = new DateTime();
            datecounty = DateTime.Now;

            htcountydata.Add("@Trans", "UPDATE");
            htcountydata.Add("@Order_Id", Order_Id);
            htcountydata.Add("@Delequent_Database_Id", ViewState["Delequent_Database_Id"]);
            htcountydata.Add("@Tax_Type_Id", int.Parse(ddl_Tax_Delquent_Tax_type.SelectedValue.ToString()));
            htcountydata.Add("@Ph_No", txt_delequent_phno.Text);
            htcountydata.Add("@Make_Changes_Payable_to", txt_Delequent_Make_Changes.Text);
            htcountydata.Add("@Payee_Address", txt_Delequent_Payee_addres.Text);
            htcountydata.Add("@Inserted_By", userid);
            htcountydata.Add("@Inserted_date", datecounty);
            htcountydata.Add("@Status", "True");
            dtcountydata = dataaccess.ExecuteSP("Sp_Orders_Tax_Deliquent_County_Data", htcountydata);


            imgbtn_Delequent_Tax_Add.Text = "Add";
            Gridview_Bind_Order_Deliquent_Data();

            ClearDeliquent();

        }
    }
    protected void ClearDeliquent()
    {

        ddl_Tax_Delquent_Tax_type.SelectedIndex = 0;
        txt_Delequent_Make_Changes.Text = "";
        txt_Delequent_Payee_addres.Text = "";
        txt_delequent_phno.Text = "";


    }

    
    protected void ddl_Tax_Delquent_Tax_type_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Check_TAx_Accesed_values()
    {



        Hashtable htselorderkb = new Hashtable();
        DataTable dtuser = new System.Data.DataTable();

        htselorderkb.Add("@Trans", "SELECT");
        htselorderkb.Add("@Order_Id", Order_Id);
        dtuser = dataaccess.ExecuteSP("Sp_Order_Tax_Asessed_Entry", htselorderkb);
        if (dtuser.Rows.Count > 0)
        {

        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Assesed Value Not Entered Do You Want To Preview')</script>", false);

        }


    }
    protected void btn_Preview_Click(object sender, EventArgs e)
    {
        Save_Tax_Violation();
        Hashtable htget = new Hashtable();
        DataTable dtget = new DataTable();
        htget.Add("@Trans", "CODE");
        htget.Add("@Order_Id", Order_Id);
        dtget = dataaccess.ExecuteSP("Sp_Order_Excel_Export", htget);
        ViewState["Data"] = dtget;
        if (dtget.Rows.Count > 0)
        {


            dtgrid = (DataTable)ViewState["Data"];

            dtgrid.TableName = "DataGrid";
            using (XLWorkbook wb = new XLWorkbook())
            {

                wb.Worksheets.Add(dtgrid);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=OrderReport.xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }
     
      
    }
    private bool Validate_Order_Info()
    {

        if (txt_Production_Date.Text == "")
        {
            txt_Production_Date.Focus();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Enter Production Date')</script>", false);

            return false;


        }
        else if (ddl_Status.SelectedIndex <= 0)
        {
            ddl_Status.Focus();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Select Order Status')</script>", false);
            return false;

        }
        if (ddl_Status.SelectedIndex > 0)
        {
            Check_Status = int.Parse(ddl_Status.SelectedValue.ToString());

            if (Check_Status == 10 || Check_Status == 11 || Check_Status == 12 || Check_Status == 9)
            {

                if (txt_Comments.Text == "")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Please Enter Comments')</script>", false);
                    txt_Comments.Focus();
                    return false;
                }
                else
                {

                    return true;
                }

            }

        }




        return true;
 
    }
    protected void btn_Complete_Click(object sender, EventArgs e)
    {
        if (Validate_Order_Info() != false)
        {
            if (Order_Type == "Web/Call" || Order_Type == "Mail/Fax")
            {
                if (ddl_Status.SelectedValue == "6")
                {
                    DateTime date = new DateTime();
                    date = DateTime.Now;
                    string dateeval = date.ToString("dd/MM/yyyy");
                    string time = date.ToString("hh:mm tt");




                    Hashtable htcheckproducion = new Hashtable();
                    DataTable dtcheckproduction = new System.Data.DataTable();
                    htcheckproducion.Add("@Trans", "Sp_Order_Production");
                    htcheckproducion.Add("@Order_ID", Order_Id);
                    htcheckproducion.Add("@Order_Status_Id", ViewState["Order_Status"]);
                    htcheckproducion.Add("@Order_Task_Id", ViewState["Order_Task"]);
                    dtcheckproduction = dataaccess.ExecuteSP("Sp_Order_Production", htcheckproducion);

                    if (dtcheckproduction.Rows.Count > 0)
                    {

                        Production_Check = int.Parse(dtcheckproduction.Rows[0]["count"].ToString());
                    }
                    else
                    {

                        Production_Check = 0;
                    }

                    if (Production_Check == 0)
                    {
                        Hashtable htinsertproducion = new Hashtable();
                        DataTable dtinsertproduction = new System.Data.DataTable();
                        htinsertproducion.Add("@Trans", "INSERT");
                        htinsertproducion.Add("@Order_ID", Order_Id);
                        htinsertproducion.Add("@Order_Status_Id", 6);
                        htinsertproducion.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htinsertproducion.Add("@User_Id", userid);
                        htinsertproducion.Add("@Production_Date", txt_Production_Date.Text);
                        htinsertproducion.Add("@Inserted_By", userid);
                        htinsertproducion.Add("@Instered_Date", dateeval);
                        htinsertproducion.Add("@Status", "True");

                        dtinsertproduction = dataaccess.ExecuteSP("Sp_Order_Production", htinsertproducion);

                    }

                    if (txt_Comments.Text != "")
                    {

                        Hashtable htagencykb = new Hashtable();
                        DataTable agencykb = new System.Data.DataTable();



                        htagencykb.Add("@Trans", "INSERT");
                        htagencykb.Add("@Order_Id", Order_Id);
                        htagencykb.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htagencykb.Add("@Order_Status_Id", int.Parse(ddl_Status.SelectedValue));
                        htagencykb.Add("@Comment", txt_Comments.Text);
                        htagencykb.Add("@Inserted_By", userid);
                        htagencykb.Add("@Inserted_date", date);
                        htagencykb.Add("@Modified_By", userid);
                        htagencykb.Add("@Modified_Date", date);
                        htagencykb.Add("@status", "True");
                        agencykb = dataaccess.ExecuteSP("Sp_Order_Comments", htagencykb);




                    }


                    Hashtable htupdate = new Hashtable();
                    DataTable dtupdate = new System.Data.DataTable();
                    htupdate.Add("@Trans", "UPDATE_STATUS");
                    htupdate.Add("@Order_ID", Order_Id);
                    htupdate.Add("@Order_Status", 1);
                    htupdate.Add("@Modified_By", userid);
                    htupdate.Add("@Modified_Date", dateeval);

                    dtupdate = dataaccess.ExecuteSP("Sp_Order", htupdate);

                    Hashtable htupdatestatus = new Hashtable();
                    DataTable dtupdatestatus = new System.Data.DataTable();
                    htupdatestatus.Add("@Trans", "UPDATE_TASK");
                    htupdatestatus.Add("@Order_ID", Order_Id);
                    htupdatestatus.Add("@Order_Task", 5);
                    htupdatestatus.Add("@Modified_By", userid);
                    htupdatestatus.Add("@Modified_Date", dateeval);

                    dtupdatestatus = dataaccess.ExecuteSP("Sp_Order", htupdatestatus);
                    Hashtable htorderAllocate = new Hashtable();
                    DataTable dtorderallocate = new System.Data.DataTable();
                    htorderAllocate.Add("@Trans", "DELETE");
                    htorderAllocate.Add("@Order_ID", Order_Id);
                    htorderAllocate.Add("@Modified_By", userid);
                    htorderAllocate.Add("@Modified_Date", date);
                    dtorderallocate = dataaccess.ExecuteSP("Sp_Order_Assignment", htorderAllocate);



                    Hashtable htstatecounty = new Hashtable();
                    DataTable dtstatecounty = new System.Data.DataTable();
                    htstatecounty.Add("@Trans", "UPDATE_STATE_COUNTY");
                    htstatecounty.Add("@Order_ID", Order_Id);
                    htstatecounty.Add("@Barrower_State", int.Parse(ddl_Barrower_State.SelectedValue.ToString()));
                    htstatecounty.Add("@Barrower_County", int.Parse(ddl_Barrower_County.SelectedValue.ToString()));
                    dtstatecounty = dataaccess.ExecuteSP("Sp_Order", htstatecounty);
                    Save_Tax_Violation();

                    omb.ShowMessage("Order Submitted Successfully", "Success");
                    //string url = "~/Admin/Admin.aspx";
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Order submitted Sucessfully')</script>", false);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "callfunction", "alert('Order Submitted Sucessfully');window.location.href = '" + url + "';", true);

                }
                else if (ddl_Status.SelectedValue == "9" || ddl_Status.SelectedValue == "10" || ddl_Status.SelectedValue == "11" || ddl_Status.SelectedValue == "12")
                {
                    DateTime date = new DateTime();
                    date = DateTime.Now;
                    string dateeval = date.ToString("dd/MM/yyyy");
                    string time = date.ToString("hh:mm tt");
                    Hashtable htupdate = new Hashtable();
                    DataTable dtupdate = new System.Data.DataTable();
                    htupdate.Add("@Trans", "UPDATE_STATUS");
                    htupdate.Add("@Order_ID", Order_Id);
                    htupdate.Add("@Order_Status", ddl_Status.SelectedValue);
                    htupdate.Add("@Modified_By", userid);
                    htupdate.Add("@Modified_Date", dateeval);

                    dtupdate = dataaccess.ExecuteSP("Sp_Order", htupdate);

                    if (ddl_Status.SelectedValue != "9")
                    {
                        Hashtable htupdateorderassign = new Hashtable();
                        DataTable dtupdateorderassign = new System.Data.DataTable();
                        htupdateorderassign.Add("@Trans", "UPDATE_STATUS");
                        htupdateorderassign.Add("@Order_Id", Order_Id);
                        htupdateorderassign.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htupdateorderassign.Add("@Modified_By", userid);
                        htupdateorderassign.Add("@Modified_Date", dateeval);

                        dtupdateorderassign = dataaccess.ExecuteSP("Sp_Order_Assignment", htupdateorderassign);

                    }
                    if (txt_Comments.Text != "")
                    {

                        Hashtable htagencykb = new Hashtable();
                        DataTable agencykb = new System.Data.DataTable();



                        htagencykb.Add("@Trans", "INSERT");
                        htagencykb.Add("@Order_Id", Order_Id);
                        htagencykb.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htagencykb.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htagencykb.Add("@Comment", txt_Comments.Text);
                        htagencykb.Add("@Inserted_By", userid);
                        htagencykb.Add("@Inserted_date", date);
                        htagencykb.Add("@Modified_By", userid);
                        htagencykb.Add("@Modified_Date", date);
                        htagencykb.Add("@status", "True");
                        agencykb = dataaccess.ExecuteSP("Sp_Order_Comments", htagencykb);




                    }

                    Hashtable htcheckproducion = new Hashtable();
                    DataTable dtcheckproduction = new System.Data.DataTable();
                    htcheckproducion.Add("@Trans", "Sp_Order_Production");
                    htcheckproducion.Add("@Order_ID", Order_Id);
                    htcheckproducion.Add("@Order_Status_Id", ViewState["Order_Status"]);
                    htcheckproducion.Add("@Order_Task_Id", ViewState["Order_Task"]);
                    dtcheckproduction = dataaccess.ExecuteSP("Sp_Order_Production", htcheckproducion);

                    if (dtcheckproduction.Rows.Count > 0)
                    {

                        Production_Check = int.Parse(dtcheckproduction.Rows[0]["count"].ToString());
                    }
                    else
                    {

                        Production_Check = 0;
                    }

                    if (Production_Check == 0)
                    {
                        Hashtable htinsertproducion = new Hashtable();
                        DataTable dtinsertproduction = new System.Data.DataTable();
                        htinsertproducion.Add("@Trans", "INSERT");
                        htinsertproducion.Add("@Order_ID", Order_Id);
                        htinsertproducion.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htinsertproducion.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htinsertproducion.Add("@User_Id", userid);
                        htinsertproducion.Add("@Production_Date", txt_Production_Date.Text);
                        htinsertproducion.Add("@Inserted_By", userid);
                        htinsertproducion.Add("@Instered_Date", dateeval);
                        htinsertproducion.Add("@Status", "True");

                        dtinsertproduction = dataaccess.ExecuteSP("Sp_Order_Production", htinsertproducion);

                    }


                    Hashtable htstatecounty = new Hashtable();
                    DataTable dtstatecounty = new System.Data.DataTable();
                    htstatecounty.Add("@Trans", "UPDATE_STATE_COUNTY");
                    htstatecounty.Add("@Order_ID", Order_Id);
                    htstatecounty.Add("@Barrower_State", int.Parse(ddl_Barrower_State.SelectedValue.ToString()));
                    htstatecounty.Add("@Barrower_County", int.Parse(ddl_Barrower_County.SelectedValue.ToString()));
                    dtstatecounty = dataaccess.ExecuteSP("Sp_Order", htstatecounty);
                    // ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Order submitted Sucessfully')</script>", false);
                    //  string url = "~/Admin/Admin.aspx";
                    Save_Tax_Violation();
                    omb.ShowMessage("Order Submitted Successfully", "Success");
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Order submitted Sucessfully')</script>", false);
                    // ScriptManager.RegisterStartupScript(Page, Page.GetType(), "callfunction", "alert('Order Submitted Sucessfully');window.location.href = '" + url + "';", true);

                }
            }
            else if (Order_Type == "QC" && Validate_Order_Info() != false)
            {
                if (ddl_Status.SelectedValue == "6")
                {

                    DateTime date = new DateTime();
                    date = DateTime.Now;
                    string dateeval = date.ToString("dd/MM/yyyy");
                    string time = date.ToString("hh:mm tt");

                 







                    Hashtable htcheckproducion = new Hashtable();
                    DataTable dtcheckproduction = new System.Data.DataTable();
                    htcheckproducion.Add("@Trans", "Sp_Order_Production");
                    htcheckproducion.Add("@Order_ID", Order_Id);
                    htcheckproducion.Add("@Order_Status_Id", ViewState["Order_Status"]);
                    htcheckproducion.Add("@Order_Task_Id", ViewState["Order_Task"]);
                    dtcheckproduction = dataaccess.ExecuteSP("Sp_Order_Production", htcheckproducion);

                    if (dtcheckproduction.Rows.Count > 0)
                    {

                        Production_Check = int.Parse(dtcheckproduction.Rows[0]["count"].ToString());
                    }
                    else
                    {

                        Production_Check = 0;
                    }

                    if (Production_Check == 0)
                    {
                        Hashtable htinsertproducion = new Hashtable();
                        DataTable dtinsertproduction = new System.Data.DataTable();
                        htinsertproducion.Add("@Trans", "INSERT");
                        htinsertproducion.Add("@Order_ID", Order_Id);
                        htinsertproducion.Add("@Order_Status_Id", 6);
                        htinsertproducion.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htinsertproducion.Add("@User_Id", userid);
                        htinsertproducion.Add("@Production_Date", txt_Production_Date.Text);
                        htinsertproducion.Add("@Inserted_By", userid);
                        htinsertproducion.Add("@Instered_Date", dateeval);
                        htinsertproducion.Add("@Status", "True");

                        dtinsertproduction = dataaccess.ExecuteSP("Sp_Order_Production", htinsertproducion);

                    }

                    Hashtable htupdatetask = new Hashtable();
                    DataTable dtupdatetask = new System.Data.DataTable();
                    htupdatetask.Add("@Trans", "UPDATE_TASK");
                    htupdatetask.Add("@Order_ID", Order_Id);
                    htupdatetask.Add("@Order_Task", 6);
                    htupdatetask.Add("@Modified_By", userid);
                    htupdatetask.Add("@Modified_Date", dateeval);
                    dtupdatetask = dataaccess.ExecuteSP("Sp_Order", htupdatetask);

                    Hashtable htupdate = new Hashtable();
                    DataTable dtupdate = new System.Data.DataTable();
                    htupdate.Add("@Trans", "UPDATE_STATUS");
                    htupdate.Add("@Order_ID", Order_Id);
                    htupdate.Add("@Order_Status", 1);
                    htupdate.Add("@Modified_By", userid);
                    htupdate.Add("@Modified_Date", dateeval);
                    dtupdate = dataaccess.ExecuteSP("Sp_Order", htupdate);
                    //  Response.End();
                    if (txt_Comments.Text != "")
                    {

                        Hashtable htagencykb = new Hashtable();
                        DataTable agencykb = new System.Data.DataTable();



                        htagencykb.Add("@Trans", "INSERT");
                        htagencykb.Add("@Order_Id", Order_Id);
                        htagencykb.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htagencykb.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htagencykb.Add("@Comment", txt_Comments.Text);
                        htagencykb.Add("@Inserted_By", userid);
                        htagencykb.Add("@Inserted_date", date);
                        htagencykb.Add("@Modified_By", userid);
                        htagencykb.Add("@Modified_Date", date);
                        htagencykb.Add("@status", "True");
                        agencykb = dataaccess.ExecuteSP("Sp_Order_Comments", htagencykb);




                    }


                    Hashtable htstatecounty = new Hashtable();
                    DataTable dtstatecounty = new System.Data.DataTable();
                    htstatecounty.Add("@Trans", "UPDATE_STATE_COUNTY");
                    htstatecounty.Add("@Order_ID", Order_Id);
                    htstatecounty.Add("@Barrower_State", int.Parse(ddl_Barrower_State.SelectedValue.ToString()));
                    htstatecounty.Add("@Barrower_County", int.Parse(ddl_Barrower_County.SelectedValue.ToString()));
                    dtstatecounty = dataaccess.ExecuteSP("Sp_Order", htstatecounty);
                    Save_Tax_Violation();
                    omb.ShowMessage("Order Completed Successfully", "Success");

                }
                else if (ddl_Status.SelectedValue == "9" || ddl_Status.SelectedValue == "10" || ddl_Status.SelectedValue == "11" || ddl_Status.SelectedValue == "12")
                {
                    DateTime date = new DateTime();
                    date = DateTime.Now;
                    string dateeval = date.ToString("dd/MM/yyyy");
                    string time = date.ToString("hh:mm tt");
                    Hashtable htupdate = new Hashtable();
                    DataTable dtupdate = new System.Data.DataTable();
                    htupdate.Add("@Trans", "UPDATE_STATUS");
                    htupdate.Add("@Order_ID", Order_Id);
                    htupdate.Add("@Order_Status", ddl_Status.SelectedValue);
                    htupdate.Add("@Modified_By", userid);
                    htupdate.Add("@Modified_Date", dateeval);

                    dtupdate = dataaccess.ExecuteSP("Sp_Order", htupdate);
                    if (txt_Comments.Text != "")
                    {

                        Hashtable htagencykb = new Hashtable();
                        DataTable agencykb = new System.Data.DataTable();



                        htagencykb.Add("@Trans", "INSERT");
                        htagencykb.Add("@Order_Id", Order_Id);
                        htagencykb.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htagencykb.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htagencykb.Add("@Comment", txt_Comments.Text);
                        htagencykb.Add("@Inserted_By", userid);
                        htagencykb.Add("@Inserted_date", date);
                        htagencykb.Add("@Modified_By", userid);
                        htagencykb.Add("@Modified_Date", date);
                        htagencykb.Add("@status", "True");
                        agencykb = dataaccess.ExecuteSP("Sp_Order_Comments", htagencykb);




                    }
                    Hashtable htcheckproducion = new Hashtable();
                    DataTable dtcheckproduction = new System.Data.DataTable();
                    htcheckproducion.Add("@Trans", "Sp_Order_Production");
                    htcheckproducion.Add("@Order_ID", Order_Id);
                    htcheckproducion.Add("@Order_Status_Id", ViewState["Order_Status"]);
                    htcheckproducion.Add("@Order_Task_Id", ViewState["Order_Task"]);
                    dtcheckproduction = dataaccess.ExecuteSP("Sp_Order_Production", htcheckproducion);

                    if (dtcheckproduction.Rows.Count > 0)
                    {

                        Production_Check = int.Parse(dtcheckproduction.Rows[0]["count"].ToString());
                    }
                    else
                    {

                        Production_Check = 0;
                    }

                    if (Production_Check == 0)
                    {
                        Hashtable htinsertproducion = new Hashtable();
                        DataTable dtinsertproduction = new System.Data.DataTable();
                        htinsertproducion.Add("@Trans", "INSERT");
                        htinsertproducion.Add("@Order_ID", Order_Id);
                        htinsertproducion.Add("@Order_Status_Id", ddl_Status.SelectedValue);
                        htinsertproducion.Add("@Order_Task_Id", int.Parse(ViewState["Order_Task"].ToString()));
                        htinsertproducion.Add("@User_Id", userid);
                        htinsertproducion.Add("@Production_Date", txt_Production_Date.Text);
                        htinsertproducion.Add("@Inserted_By", userid);
                        htinsertproducion.Add("@Instered_Date", dateeval);
                        htinsertproducion.Add("@Status", "True");

                        dtinsertproduction = dataaccess.ExecuteSP("Sp_Order_Production", htinsertproducion);

                    }


                    Hashtable htstatecounty = new Hashtable();
                    DataTable dtstatecounty = new System.Data.DataTable();
                    htstatecounty.Add("@Trans", "UPDATE_STATE_COUNTY");
                    htstatecounty.Add("@Order_ID", Order_Id);
                    htstatecounty.Add("@Barrower_State", int.Parse(ddl_Barrower_State.SelectedValue.ToString()));
                    htstatecounty.Add("@Barrower_County", int.Parse(ddl_Barrower_County.SelectedValue.ToString()));
                    dtstatecounty = dataaccess.ExecuteSP("Sp_Order", htstatecounty);

                    Save_Tax_Violation();
                    omb.ShowMessage("Order Submitted Successfully", "Success");

                }
            }
        }

    }


    private void Save_Tax_Violation()
    {


        Hashtable htcheck = new Hashtable();
        System.Data.DataTable dtcheck = new System.Data.DataTable();
        htcheck.Add("@Trans", "CHECK");
        htcheck.Add("@Order_Id", Order_Id);
        dtcheck = dataaccess.ExecuteSP("Sp_Tax_Violation_Entry", htcheck);

        int Check = 0;
        if (dtcheck.Rows.Count > 0)
        {
            Check = int.Parse(dtcheck.Rows[0]["count"].ToString());
        }
        else
        {

            Check = 0;
        }

        if (Check == 0)
        {

            Hashtable htinsert = new Hashtable();
            System.Data.DataTable dtinsert = new System.Data.DataTable();

            htinsert.Add("@Trans", "INSERT");
            htinsert.Add("@Order_Id", Order_Id);

            htinsert.Add("@Tax_Status", ddl_Tax_Staus.Text.ToUpper().ToString());
            htinsert.Add("@Code_Compliance_Comments", txt_Code_ComplianceComments.Text.ToUpper());
            htinsert.Add("@Demolition_Status_Date", txt_Demolition_Status_Date.Text.ToUpper());
            htinsert.Add("@Other_Comments", txt_Other_Comments.Text.ToUpper());
            htinsert.Add("@Municipal_Search_Total", txt_Municipal_Search_Total.Text.ToUpper());
            htinsert.Add("@Scheduled_for_Tax_Sale", txt_Scheduled_for_Tax_Sale.Text.ToUpper());
            htinsert.Add("@Tax_Sale_Date", txt_Tax_Sale_Date.Text.ToUpper());
            htinsert.Add("@Redemption_Amt", txt_Redemption_Amt.Text.ToUpper());
            htinsert.Add("@Last_Date_to_Redeem", txt_Last_Date_to_Redeem.Text.ToUpper());
            htinsert.Add("@Total_Amount_of_Taxes_Paid_by_3rd_Party", txt_Total_Amount_of_Taxes_Paid.Text.ToUpper());
            htinsert.Add("@Permit_Comments", txt_Permit_Comments.Text.ToUpper());
            htinsert.Add("@Special_Assessments_Comments", txt_Special_Assessments_Comments.Text.ToUpper());
            htinsert.Add("@Water_Sewer_Comments", txt_Water_Sawer_Comments.Text.ToUpper());
            htinsert.Add("@Other_Comments1", txt_Other_Comments_1.Text.ToUpper());
            htinsert.Add("@Tax_Proration_Amount", txt_Tax_Proration_Amount.Text.ToUpper());
            htinsert.Add("@Comments", Txt_Code_Comments.Text.ToUpper());
            htinsert.Add("@Detailed_list_of_steps_taken_to_obtain_information", txt_Demolition_Status_Date.Text.ToUpper());
            htinsert.Add("@Detailed_Reason_why_it_cannot_be_obtained", txt_Detailed_list.Text.ToUpper());
            htinsert.Add("@Inserted_By", userid);
            htinsert.Add("@Status", "True");
            dtinsert = dataaccess.ExecuteSP("Sp_Tax_Violation_Entry", htinsert);
        }
        else if (Check > 0)
        {
            Hashtable htupdate = new Hashtable();
            System.Data.DataTable dtupdate = new System.Data.DataTable();

            htupdate.Add("@Trans", "UPDATE");
            htupdate.Add("@Order_Id", Order_Id);


            htupdate.Add("@Tax_Status", ddl_Tax_Staus.Text.ToUpper().ToString());
            htupdate.Add("@Code_Compliance_Comments", txt_Code_ComplianceComments.Text.ToUpper());
            htupdate.Add("@Demolition_Status_Date", txt_Demolition_Status_Date.Text.ToUpper());
            htupdate.Add("@Other_Comments", txt_Other_Comments.Text.ToUpper());
            htupdate.Add("@Municipal_Search_Total", txt_Municipal_Search_Total.Text.ToUpper());
            htupdate.Add("@Scheduled_for_Tax_Sale", txt_Scheduled_for_Tax_Sale.Text.ToUpper());
            htupdate.Add("@Tax_Sale_Date", txt_Tax_Sale_Date.Text.ToUpper());
            htupdate.Add("@Redemption_Amt", txt_Redemption_Amt.Text.ToUpper());
            htupdate.Add("@Last_Date_to_Redeem", txt_Last_Date_to_Redeem.Text.ToUpper());
            htupdate.Add("@Total_Amount_of_Taxes_Paid_by_3rd_Party", txt_Total_Amount_of_Taxes_Paid.Text.ToUpper());
            htupdate.Add("@Permit_Comments", txt_Permit_Comments.Text.ToUpper());
            htupdate.Add("@Special_Assessments_Comments", txt_Special_Assessments_Comments.Text.ToUpper());
            htupdate.Add("@Water_Sewer_Comments", txt_Water_Sawer_Comments.Text.ToUpper());
            htupdate.Add("@Other_Comments1", txt_Other_Comments_1.Text.ToUpper());
            htupdate.Add("@Tax_Proration_Amount", txt_Tax_Proration_Amount.Text.ToUpper());
            htupdate.Add("@Comments", Txt_Code_Comments.Text.ToUpper());
            htupdate.Add("@Detailed_list_of_steps_taken_to_obtain_information", txt_Demolition_Status_Date.Text.ToUpper());
            htupdate.Add("@Detailed_Reason_why_it_cannot_be_obtained", txt_Detailed_list.Text.ToUpper());
            htupdate.Add("@Inserted_By", userid);
            htupdate.Add("@Status", "True");
            object update = dataaccess.ExecuteSPForScalar("Sp_Tax_Violation_Entry", htupdate);

        }
    }







    private void Bind_Tax_Violation_Details()
    {
        Hashtable htorderdetail = new Hashtable();
        System.Data.DataTable dtorderdetail = new System.Data.DataTable();
        htorderdetail.Add("@Trans", "SELECT");
        htorderdetail.Add("@Order_Id", Order_Id);
        dtorderdetail = dataaccess.ExecuteSP("Sp_Tax_Violation_Entry", htorderdetail);
        if (dtorderdetail.Rows.Count > 0)
        {

            // txt_Loan.Text = dtorderdetail.Rows[0]["Loan"].ToString();
            ddl_Tax_Staus.Text = dtorderdetail.Rows[0]["Tax_Status"].ToString();
            txt_Code_ComplianceComments.Text = dtorderdetail.Rows[0]["Code_Compliance_Comments"].ToString();
            txt_Demolition_Status_Date.Text = dtorderdetail.Rows[0]["Demolition_Status_Date"].ToString();
            txt_Other_Comments.Text = dtorderdetail.Rows[0]["Other_Comments"].ToString();
            txt_Municipal_Search_Total.Text = dtorderdetail.Rows[0]["Municipal_Search_Total"].ToString();
            txt_Scheduled_for_Tax_Sale.Text = dtorderdetail.Rows[0]["Scheduled_for_Tax_Sale"].ToString();
            txt_Tax_Sale_Date.Text = dtorderdetail.Rows[0]["Tax_Sale_Date"].ToString();
            txt_Redemption_Amt.Text = dtorderdetail.Rows[0]["Redemption_Amt"].ToString();
            txt_Last_Date_to_Redeem.Text = dtorderdetail.Rows[0]["Last_Date_to_Redeem"].ToString();
            txt_Total_Amount_of_Taxes_Paid.Text = dtorderdetail.Rows[0]["Total_Amount_of_Taxes_Paid_by_3rd_Party"].ToString();
            txt_Permit_Comments.Text = dtorderdetail.Rows[0]["Permit_Comments"].ToString();
            txt_Special_Assessments_Comments.Text = dtorderdetail.Rows[0]["Special_Assessments_Comments"].ToString();
            txt_Water_Sawer_Comments.Text = dtorderdetail.Rows[0]["Water_Sewer_Comments"].ToString();
            txt_Tax_Proration_Amount.Text = dtorderdetail.Rows[0]["Tax_Proration_Amount"].ToString();
            txt_Other_Comments_1.Text = dtorderdetail.Rows[0]["Other_Comments1"].ToString();
            Txt_Code_Comments.Text = dtorderdetail.Rows[0]["Comments"].ToString();
            txt_Detailed_list.Text = dtorderdetail.Rows[0]["Detailed_list_of_steps_taken_to_obtain_information"].ToString();
            txt_Detailed_list.Text = dtorderdetail.Rows[0]["Detailed_Reason_why_it_cannot_be_obtained"].ToString();
            

        }
        else
        {
            //txt_Loan.Text ="";
            ddl_Tax_Staus.SelectedIndex = 0;
            txt_Code_ComplianceComments.Text = "";
            txt_Demolition_Status_Date.Text = "";
            txt_Other_Comments.Text = "";
            txt_Municipal_Search_Total.Text = "";
            txt_Scheduled_for_Tax_Sale.Text = "";
            txt_Tax_Sale_Date.Text = "";
            txt_Redemption_Amt.Text = "";
            txt_Last_Date_to_Redeem.Text = "";
            txt_Total_Amount_of_Taxes_Paid.Text = "";
            txt_Comments.Text = "";
            txt_Permit_Comments.Text = "";
            txt_Special_Assessments_Comments.Text = "";
            txt_Water_Sawer_Comments.Text = "";
            txt_Tax_Proration_Amount.Text = "";
            txt_Other_Comments_1.Text = "";
            txt_Detailed_list.Text = "";
            txt_Detailed_list.Text = "";

        }

    }
 
   
    protected void Tab_SourceUpload_Click(object sender, EventArgs e)
    {
      
        // Municipal_Det.Visible = false;
  
        Source_Upload.Visible = true;
      
        tabsrcupload = 1;
        if (tabsrcupload == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            Tab_SourceUpload.ForeColor = foclr;
            Tab_SourceUpload.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
       
        }
        tr_SrcUpld.Visible = false;
        tr_SrcUpld1.Visible = false;
    }
    private void table_SrcUpldInfo()
    {
       
        // Municipal_Det.Visible = false;
      
        Source_Upload.Visible = true;
        
        tabsrcupload = 1;
        if (tabsrcupload == 1)
        {
            Color bgclr = ColorTranslator.FromHtml("#12B61F");
            Color foclr = ColorTranslator.FromHtml("#ffffff");
            Tab_SourceUpload.ForeColor = foclr;
            Tab_SourceUpload.BackColor = bgclr;
            Color bgcr = ColorTranslator.FromHtml("#33CCFF");
            Color focr = ColorTranslator.FromHtml("#303030");
            tbpnluser.ForeColor = focr;
            tbpnluser.BackColor = bgcr;
           
        }
    }
  
    protected void imgbtn_Assesd_Add_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void imgbtn_Munciple_Add_Click(object sender, ImageClickEventArgs e)
    {

    }
   
    protected void Imgbtn_Brancrupty_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void img_btn_order_source_tax_upload_add_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnDownload_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void Gridview_Bind_IT_Error_Data()
    {
        Hashtable htselorderkb = new Hashtable();
        DataTable dtuser = new System.Data.DataTable();

        htselorderkb.Add("@Trans", "SELECT");
        htselorderkb.Add("@Order_Id", Order_Id);
        dtuser = dataaccess.ExecuteSP("Sp_Orders_IT_Error", htselorderkb);
        if (dtuser.Rows.Count > 0)
        {
            //ex2.Visible = true;
            Grid_Order_IT_Error.Visible = true;
            Grid_Order_IT_Error.DataSource = dtuser;
            Grid_Order_IT_Error.DataBind();

        }
        else
        {

            Grid_Order_IT_Error.DataSource = null;
            Grid_Order_IT_Error.EmptyDataText = "No Records Are Avilable";
            Grid_Order_IT_Error.DataBind();

        }
    }

    protected void Gridview_Bind_Order_Kb_Data()
    {
        Hashtable htselorderkb = new Hashtable();
        DataTable dtuser = new System.Data.DataTable();

        htselorderkb.Add("@Trans", "SELECT");
        htselorderkb.Add("@Order_Id", Order_Id);
        dtuser = dataaccess.ExecuteSP("Sp_Order_Knowledge_Base", htselorderkb);
        if (dtuser.Rows.Count > 0)
        {
            //ex2.Visible = true;
            grd_order_kb.Visible = true;
            grd_order_kb.DataSource = dtuser;
            grd_order_kb.DataBind();

        }
        else
        {

            grd_order_kb.DataSource = null;
            grd_order_kb.EmptyDataText = "No Records Are Avilable";
            grd_order_kb.DataBind();

        }
    }
    protected void grd_order_kb_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl_order_kb_id = (Label)e.Row.FindControl("lblOrder_Kb_Id");
            Label lbl_order_kb_fileType = (Label)e.Row.FindControl("lbl_Order_Kb_File_Type");
            Label lbl_order_kb_filepath = (Label)e.Row.FindControl("lbl_orderkb_doc_path");
            ImageButton imbtn_orderdoc = (ImageButton)e.Row.FindControl("imgbtndoc");

            if (lbl_order_kb_filepath.Text != "" && lbl_order_kb_filepath.Text != null)
            {
                ViewState["doc_type"] = lbl_order_kb_fileType.Text;
                ViewState["doc_path"] = lbl_order_kb_filepath.Text;
                imbtn_orderdoc.Visible = true;

                if (lbl_order_kb_fileType.Text == ".doc" || lbl_order_kb_fileType.Text == ".docx")
                {
                    imbtn_orderdoc.ImageUrl = "~/img/word.png";

                }
                else if (lbl_order_kb_fileType.Text == ".xls" || lbl_order_kb_fileType.Text == ".xlsx")
                {

                    imbtn_orderdoc.ImageUrl = "~/img/Excel.png";
                }
                else if (lbl_order_kb_fileType.Text == ".pdf")
                {

                    imbtn_orderdoc.ImageUrl = "~/img/pdf.png";
                }
                else
                {

                    imbtn_orderdoc.ImageUrl = "~/Admin/MsgImage/Download.png";
                }
            }
            else
            {

                imbtn_orderdoc.Visible = false;
            }



        }
        
        tr_OrderKb.Visible = true;
        tr_OrderKb1.Visible = true;
    }

    protected void btn_AddOrder_Click(object sender, ImageClickEventArgs e)
    {
        tr_OrderKb.Visible = true;
        tr_OrderKb1.Visible = true;
        table_OrderKb();
        Clear_OrderKb();
        img_btn_order_kb_add.Text = "Save";
        txt_order_Kb_Document.Focus();
    }

    protected void btn_AddAgency_Click(object sender, ImageClickEventArgs e)
    {
        tr_Agency.Visible = true;
        
        txt_Agency_Comment.Text = "";
        imgbtn_agency_Add.Text = "Save";
        txt_Agency_Comment.Focus();
        table_AgencyKb();
    }
    protected void btn_AddCountyCmt_Click(object sender, ImageClickEventArgs e)
    {
        tr_CountyData.Visible = true;
        tr_CountyData1.Visible = true;
        
        Clear_County();
        ImageButton3.Text = "Save";
        ddl_TaxType_Commts.Focus();
        dbc.BindSourceUploadTax_Type(ddl_TaxType_Commts, Order_Id);
        table_countyCmt();
    }

    protected void btn_AddCountyDb_Click(object sender, ImageClickEventArgs e)
    {
        tr_CountyDbInfo.Visible = true;
        tr_CountyDbInfo1.Visible = true;
        
        ddl_CountyTaxtype.Focus();
        table_countyDB();
    }
    protected void btn_AddDelequent_Click(object sender, ImageClickEventArgs e)
    {
        tr_DelequentDb.Visible = true;
        tr_DelequentDb1.Visible = true;
       
        ClearDeliquent();
        imgbtn_Delequent_Tax_Add.Text = "Save";
        ddl_Tax_Delquent_Tax_type.Focus();
        table_DelequentDB();
    }
 
  

    protected void btn_Munciple_Add_Click(object sender, EventArgs e)
    {

    }
    protected void btn_ClearMunicipal_Click(object sender, EventArgs e)
    {

    }
    protected void btn_ClearSrcUpload_Click(object sender, EventArgs e)
    {
    
        table_SrcUpldInfo();
        Clear_Source();

    }
    private void Clear_Source()
    {
        ddl_Source_upload_Taxtype.SelectedIndex = 0;
        txt_Source_upload_Details.Text = "";
        fileupload22.Attributes.Clear();
    }
    private bool Validate_source_tax_upload()
    {


        if (txt_Source_upload_Details.Text == "")
        {
            txt_Source_upload_Details.Focus();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Msg", "<script> alert('Enter Details')</script>", false);
            return false;


        }
        return true;
    }
    protected void btn_AddSrcUpload_Click(object sender, EventArgs e)
    {
      
        table_SrcUpldInfo();
        if (Validate_source_tax_upload() != false && btn_AddSrcUpload.Text == "Save")
        {


            Hashtable htorderkb = new Hashtable();
            DataTable dtorderkb = new System.Data.DataTable();

            string Uploadpath = @"\\192.168.12.33TAXPLORER\TAX SOURCEFILES\" + txt_Order_Number.Text;
            DirectoryInfo di = new DirectoryInfo(Uploadpath);


            if (!di.Exists)
            {
                Directory.CreateDirectory(@"\\192.168.12.33\TAXPLORER\TAX SOURCEFILES\" + txt_Order_Number.Text);
            }
            HttpFileCollection uploads = HttpContext.Current.Request.Files;

            if (uploads != null)
            {
                string c = Path.GetFileName(fileupload22.PostedFile.FileName);
                string fileName = c;
                extension = Path.GetExtension(fileupload22.FileName);
                if (fileName != "")
                {
                    string dest_path1 = @"\\192.168.12.33\TAXPLORER\TAX SOURCEFILES\" + txt_Order_Number.Text + @"\" + fileName;
                    fileupload22.PostedFile.SaveAs(dest_path1);
                    ViewState["FPath"] = dest_path1;

                    Tax_Type_Source_Upload__path = ViewState["FPath"].ToString();
                }
            }
            else
            {

                Tax_Type_Source_Upload__path = null;
            }

            using (BinaryReader br = new BinaryReader(fileupload22.PostedFile.InputStream))
            {
                byte[] bytes = br.ReadBytes((int)fileupload22.PostedFile.InputStream.Length);

                DateTime date = new DateTime();
                date = DateTime.Now;
                htorderkb.Add("@Trans", "INSERT");
                htorderkb.Add("@Tax_Type_Id",1);
                htorderkb.Add("@Order_ID", Order_Id);
                htorderkb.Add("@Source_Details", txt_Source_upload_Details.Text);
                htorderkb.Add("@Document_Name", "123");
                htorderkb.Add("@Tax_Type_Source_upload_File_Type", extension);
                htorderkb.Add("@Tax_Type_Source_upload_Path", Tax_Type_Source_Upload__path);
                htorderkb.Add("@Inserted_By", userid);
                htorderkb.Add("@Inserted_date", date);
                htorderkb.Add("@Modified_By", userid);
                htorderkb.Add("@Modified_Date", date);
                htorderkb.Add("@ContentType", "audio/mpeg3");
                htorderkb.Add("@Data",bytes);
                htorderkb.Add("@Name", Path.GetFileName(fileupload22.PostedFile.FileName));
                dtorderkb = dataaccess.ExecuteSP("Sp_Orders_Tax_Source_Upload", htorderkb);

            }
           



        }
        Gridview_Bind_Tax_type_Source_Upload_Data();
        tr_SrcUpld.Visible = false;
        tr_SrcUpld1.Visible = false;
    }

   
   
   
    protected void Grd_Tax_Type_Comments_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int Delequent_Database_Id = Convert.ToInt32(Grd_Tax_Type_Comments.DataKeys[e.RowIndex].Values["Note_Id"].ToString());
        Hashtable htdelete = new Hashtable();
        DataTable dtdelete = new DataTable();
        htdelete.Add("@Trans", "DELETE");
        htdelete.Add("@Note_Id", Delequent_Database_Id);
        dtdelete = dataaccess.ExecuteSP("Sp_Orders_Tax_County_Comments", htdelete);
        Gridview_Bind_Tax_Type_Comments();

    }
    protected void Grd_Tax_Type_Comments_SelectedIndexChanged(object sender, EventArgs e)
    {
        tr_CountyData.Visible = true;
        tr_CountyData1.Visible = true;
        GridViewRow row = Grd_Tax_Type_Comments.SelectedRow;
        Label lblTax_Id = (Label)row.FindControl("lblTax_Id");
        Label lbl_Taxtype_Comments = (Label)row.FindControl("lbl_Taxtype_Comments");
        Label lblNote_Id = (Label)row.FindControl("lblNote_Id");
        ViewState["lbl_Note_Id"] = lblNote_Id.Text;
        dbc.BindSourceUploadTax_Type(ddl_TaxType_Commts, Order_Id);
        ddl_TaxType_Commts.SelectedValue = lblTax_Id.Text;
        Txt_taxtype_Comments.Text = lbl_Taxtype_Comments.Text;
        ImageButton3.Text = "Update";
        tr_county.Visible = true;
        table_countyCmt();
    }
  
    protected void Tax_Type_Source_upload_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int Tax_Type_Source_upload_id = int.Parse(Tax_Voice_Upload.DataKeys[e.RowIndex].Values["Tax_Type_Source_upload_id"].ToString());
        Hashtable htdelete = new Hashtable();
        DataTable dtdelete = new DataTable();
        htdelete.Add("@Trans", "DELETE");
        htdelete.Add("@Tax_Type_Source_upload_id", Tax_Type_Source_upload_id);
        dtdelete = dataaccess.ExecuteSP("Sp_Orders_Tax_Source_Upload", htdelete);
        Gridview_Bind_Tax_type_Source_Upload_Data();
    }
    protected void Tax_Type_Source_upload_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
   
    protected void grd_order_kb_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewDocument")
        {
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_path = (Label)row.FindControl("lbl_orderkb_doc_path");

            string filePath = lbl_path.Text;
           
            string ext = Path.GetExtension(filePath);
            Response.ContentType = ext.ToString();
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
            tr_OrderKb.Visible = true;
            tr_OrderKb1.Visible = true;

        }
        else if (e.CommandName == "DeleteRecord")
        {
            GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            Label lblOrder_Kb_Id = (Label)row.FindControl("lblOrder_Kb_Id");
            int orderkbid = int.Parse(lblOrder_Kb_Id.Text.ToString());
            Hashtable htdelete = new Hashtable();
            DataTable dtdelete = new DataTable();
            htdelete.Add("@Trans", "DELETE");
            htdelete.Add("@Order_Kb_Id", orderkbid);
            dtdelete = dataaccess.ExecuteSP("Sp_Order_Knowledge_Base", htdelete);
            Gridview_Bind_Order_Kb_Data();
        }
        else if (e.CommandName == "EditRecord")
        {
            tr_OrderKb.Visible = true;
            tr_OrderKb1.Visible = true;
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lblOrder_Kb_Id = (Label)row.FindControl("lblOrder_Kb_Id");
            Label lbl_Document = (Label)row.FindControl("lblDocument_Name");
            Label lbl_Comments = (Label)row.FindControl("lblComments");

            ViewState["Order_Kb_Id"] = lblOrder_Kb_Id.Text;
            txt_order_Kb_Document.Text = lbl_Document.Text;
            txt_order_Kb_Comment.Text = lbl_Comments.Text;

            img_btn_order_kb_add.Text = "UPDATE";
            Operation = "UPDATE";
            ViewState["Update"] = "UPDATE";

            table_OrderKb();
        }
        table_OrderKb();

    }
    protected void grd_Agency_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRecord")
        {

            tr_Agency.Visible = true;
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_AgencyOrder_Kb_Id = (Label)row.FindControl("lbl_Agency_Order_Kb_Id");
            Label lbl_Agency_Document = (Label)row.FindControl("lbl_Agency_Documents");
            Label lbl_agency_Comments = (Label)row.FindControl("lbl_Agency_Comments");

            ViewState["Agency_Order_Kb_Id"] = lbl_AgencyOrder_Kb_Id.Text;
            ViewState["Changeinfo"] = lbl_agency_Comments.Text;
            txt_Agency_Comment.Text = lbl_agency_Comments.Text;


            imgbtn_agency_Add.Text = "UPDATE";
            tr_Agency.Visible = true;
        }
        else if (e.CommandName == "DeleteRecord")
        {

            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_AgencyOrder_Kb_Id = (Label)row.FindControl("lbl_Agency_Order_Kb_Id");
            int Agencyid = int.Parse(lbl_AgencyOrder_Kb_Id.Text.ToString());
            Hashtable htdelete = new Hashtable();
            DataTable dtdelete = new DataTable();
            htdelete.Add("@Trans", "DELETE");
            htdelete.Add("@Order_Agency_Kb_Id", Agencyid);
            dtdelete = dataaccess.ExecuteSP("Sp_Orders_Agency_Knowledge_Base", htdelete);
            Gridview_Bind_Order_Agency_Kb_Data();

        }
     


    }
 
    protected void Grid_Delequent_Data_SelectedIndexChanged(object sender, EventArgs e)
    {
        tr_DelequentDb.Visible = true;
        tr_DelequentDb1.Visible = true;
        table_DelequentDB();
        GridViewRow row = Grid_Delequent_Data.SelectedRow;
        Label lbl_Delequent_Database_Id = (Label)row.FindControl("lbl_Delequent_Database_Id");
        int Delequent_Database_Id = Convert.ToInt32(lbl_Delequent_Database_Id.Text);

        ViewState["Delequent_Database_Id"] = Delequent_Database_Id;

        LinkButton lbl_Tax_Type = (LinkButton)row.FindControl("lbl_Deliquent_Tax_Type");
        Label lbl_Deliquent_Ph_No = (Label)row.FindControl("lbl_Deliquent_Ph_No");
        Label lbl_Deliquent_Make_Changes_Payable_to = (Label)row.FindControl("lbl_Deliquent_Make_Changes_Payable_to");
        Label lbl_Deliquent_Payee_Address = (Label)row.FindControl("lbl_Deliquent_Payee_Address");


        dbc.BindTax_Type(ddl_Tax_Delquent_Tax_type);


        if (ddl_Tax_Delquent_Tax_type.Items.FindByText(lbl_Tax_Type.Text).Value != null)
        {

            ddl_Tax_Delquent_Tax_type.Items.FindByText(lbl_Tax_Type.Text).Selected = true;
        }
        txt_delequent_phno.Text = lbl_Deliquent_Ph_No.Text;
        txt_Delequent_Make_Changes.Text = lbl_Deliquent_Make_Changes_Payable_to.Text;
        txt_Delequent_Payee_addres.Text = lbl_Deliquent_Payee_Address.Text;




        imgbtn_Delequent_Tax_Add.Text = "Update";
    }
    protected void Grid_Delequent_Data_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //delete tax entry 
        int Delequent_Database_Id = Convert.ToInt32(Grid_Delequent_Data.DataKeys[e.RowIndex].Values["Delequent_Database_Id"].ToString());
        Hashtable htdelete = new Hashtable();
        DataTable dtdelete = new DataTable();
        htdelete.Add("@Trans", "DELETE");
        htdelete.Add("@Delequent_Database_Id", Delequent_Database_Id);
        dtdelete = dataaccess.ExecuteSP("Sp_Orders_Tax_Deliquent_County_Data", htdelete);
        Gridview_Bind_Order_Deliquent_Data();
        //delete tax county info

    }
    protected void btn_Send_Click(object sender, EventArgs e)
    {

    }
    protected void btn_AddITInfo_Click(object sender, ImageClickEventArgs e)
    {
        tr_ITcomp.Visible = true;
        tr_ITcomp1.Visible = true;
        table_ITComp();
        Clear_ITcomp();
        btn_Error_Submit.Text = "Save";
        txt_Error.Focus();
    }
    protected void taboutputpreview_Click1(object sender, EventArgs e)
    {

    }
    protected void btnuserCancel_Click(object sender, EventArgs e)
    {

    }



  



    protected void btn_Cancel_Complaint_Click(object sender, EventArgs e)
    {
        tr_ITcomp.Visible = false;
        tr_ITcomp1.Visible = false;
        table_ITComp();
        Clear_ITcomp();


    }
    protected void Grid_Order_IT_Error_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewDocument")
        {
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_path = (Label)row.FindControl("lbl_ITorderkb_doc_path");

            string filePath = lbl_path.Text;
            string ext = Path.GetExtension(filePath);
            Response.ContentType = ext.ToString();
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
            tr_ITcomp.Visible = true;
            tr_ITcomp1.Visible = true;

        }
        else if (e.CommandName == "DeleteRecord")
        {
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lblOrder_Kb_Id = (Label)row.FindControl("lblITOrder_Kb_Id");
            int orderkbid = int.Parse(lblOrder_Kb_Id.Text.ToString());
            Hashtable htdelete = new Hashtable();
            DataTable dtdelete = new DataTable();
            htdelete.Add("@Trans", "DELETE");
            htdelete.Add("@IT_Error_Id", orderkbid);

            dtdelete = dataaccess.ExecuteSP("Sp_Orders_IT_Error", htdelete);


            Gridview_Bind_IT_Error_Data();


        }
        table_ITComp();

    }
    protected void img_btn_order_kb_Cancel_Click(object sender, EventArgs e)
    {
        tr_OrderKb.Visible = false;
        tr_OrderKb1.Visible = false;
        Clear_OrderKb();
        table_OrderKb();
    }
    protected void imgbtn_agency_Cancel_Click(object sender, EventArgs e)
    {
        tr_Agency.Visible = false;
        ClearOrderandAgency();
        table_AgencyKb();
    }
    protected void btn_County_Database_cacnel_Click(object sender, EventArgs e)
    {
        tr_CountyData.Visible = false;
        tr_CountyData1.Visible = false;
        Txt_taxtype_Comments.Text = "";
        table_countyCmt();
    }
    protected void imgbtn_Delequent_Tax_Cancel_Click(object sender, EventArgs e)
    {
        tr_DelequentDb.Visible = false;
        tr_DelequentDb1.Visible = false;
        ClearDeliquent();
       
        table_DelequentDB();
    }
    protected void btn_AddCountyTax_Click(object sender, EventArgs e)
    {
        Hashtable htupdaterec = new Hashtable();
        DataTable dtupdaterec = new System.Data.DataTable();
        DateTime date = new DateTime();
        date = DateTime.Now;
        string dateeval = date.ToString("dd/MM/yyyy");
        string time = date.ToString("hh:mm tt");

        htupdaterec.Add("@Trans", "INSERT");
        htupdaterec.Add("@Order_Id", Order_Id);
        htupdaterec.Add("@Tax_Type_Id", int.Parse(ddl_CountyTaxtype.SelectedValue.ToString()));
        htupdaterec.Add("@Ph_No", txt_CountyPhno.Text);
        htupdaterec.Add("@Make_Changes_Payable_to", txt_CountyPayto.Text);
        htupdaterec.Add("@Payee_Address", txt_CountyTaxPayeeadd.Text);
        htupdaterec.Add("@Modified_By", userid);
        htupdaterec.Add("@Modified_Date", date);
        htupdaterec.Add("@Status", "True");
        dtupdaterec = dataaccess.ExecuteSP("Sp_Orders_Tax_County_DataBase", htupdaterec);

        tr_CountyDbInfo.Visible = false;
        tr_CountyDbInfo1.Visible = false;
        tr_CountyDbInfo2.Visible = false;
        tr_CountyDbInfo3.Visible = false;
        txt_CountyPhno.Text = "";
        txt_CountyPayto.Text = "";
        txt_CountyTaxPayeeadd.Text = "";
        Gridview_Bind_CountyDatabaseInformation();
       
        table_countyDB();
    }

    protected void grd_Tax_County_Database_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            tr_CountyDbInfo.Visible = true;
            tr_CountyDbInfo1.Visible = true;
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_Conty_Database_Id = (Label)row.FindControl("lbl_Conty_Database_Id");
           
         

            Hashtable htdelete = new Hashtable();
            DataTable dtdelete = new DataTable();
            htdelete.Add("@Trans", "DELETE");
            htdelete.Add("@Conty_Database_Id", lbl_Conty_Database_Id.Text);
            htdelete.Add("@Order_Id",Order_Id);
            dtdelete = dataaccess.ExecuteSP("Sp_Orders_Tax_County_DataBase", htdelete);
            Gridview_Bind_CountyDatabaseInformation();
            dbc.BindTax_Type(ddl_CountyTaxtype);

      

        }
        tr_CountyDbInfo.Visible = true;
        tr_CountyDbInfo1.Visible = true;
        tr_CountyDbInfo2.Visible = true;
        tr_CountyDbInfo3.Visible = true;
        table_countyDB();
    }







    protected void btn_AddSrcUplod_Click(object sender, ImageClickEventArgs e)
    {

        tr_SrcUpld.Visible = true;
        tr_SrcUpld1.Visible = true;
        table_SrcUpldInfo();
    }
    protected void btn_ClearErrorInfo_Click(object sender, EventArgs e)
    {
       
    }
    protected void Grid_Order_IT_Error_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Grd_Tax_Type_Comments_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }


    protected void Grd_Tax_County_Link_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Tax_Link")
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            Label lbl_Tax_County_id = (Label)row.FindControl("lbl_County_Assement_Link_Id");

            LinkButton lbltax_County_Link = (LinkButton)row.FindControl("lblCountyTax_Link");

            LinkButton lbltax_assessor_link = (LinkButton)row.FindControl("lblAssessor_Link");
            Response.Redirect(lbltax_County_Link.Text);



        }
        else if (e.CommandName == "Ass_link")
        {

            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            Label lbl_Tax_County_id = (Label)row.FindControl("lbl_County_Assement_Link_Id");

            LinkButton lbltax_County_Link = (LinkButton)row.FindControl("lblCountyTax_Link");

            LinkButton lbltax_assessor_link = (LinkButton)row.FindControl("lblAssessor_Link");

            Response.Redirect(lbltax_assessor_link.Text);

        }
    }
    protected void grd_Tax_Sold_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void lnk_Home_Click(object sender, EventArgs e)
    {
        if (User_Role_Id == "2")
        {
            Session["cn_id"] = client_Id.ToString();
            Session["s_id"] = Subprocess_id.ToString();
            Response.Redirect("~/Tax_Admin_Home.aspx");
        }
        else if (User_Role_Id == "1")
        {

            Response.Redirect("~/Tax_Admin_Home.aspx");
        }

     
    }
    protected void LinkMydashboard_Click(object sender, EventArgs e)
    {
        Session["cn_id"] = client_Id.ToString();
        Session["s_id"] = Subprocess_id.ToString();
        Response.Redirect("~/Tax_Admin_Home.aspx");
    }
    protected void btn_AddSrcUpld_Click(object sender, ImageClickEventArgs e)
    {
        tr_SrcUpld.Visible = true;
        tr_SrcUpld1.Visible = true;
        table_SrcUpldInfo();
        Clear_Source();
        btn_AddSrcUpload.Text = "Save";
        ddl_Source_upload_Taxtype.Focus();
    }

    protected void Grid_Order_IT_Error_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        e.NewPageIndex = Grid_Order_IT_Error.PageIndex;

        Gridview_Bind_IT_Error_Data();
    }
    protected void grd_order_kb_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = grd_order_kb.PageIndex;
        Gridview_Bind_Order_Kb_Data();
    }
    protected void grd_Agency_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = grd_Agency.PageIndex;
        Gridview_Bind_Order_Agency_Kb_Data();
    }
    protected void Grd_Tax_Type_Comments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = Grd_Tax_Type_Comments.PageIndex;
        Gridview_Bind_Tax_Type_Comments();
    }
    protected void grd_Tax_County_Database_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = grd_Tax_County_Database.PageIndex;
        Gridview_Bind_CountyDatabaseInformation();
    }
    protected void Grid_Delequent_Data_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = Grid_Delequent_Data.PageIndex;
        Gridview_Bind_Order_Deliquent_Data();
    }
   
   
    protected void Tax_Type_Source_upload_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = Tax_Voice_Upload.PageIndex;
        Gridview_Bind_Tax_type_Source_Upload_Data();
    }
    
    
    protected void Tax_Type_Source_upload_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Download")
        {
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            Label lbl_path = (Label)row.FindControl("lblDocument_Path");

            string filePath = lbl_path.Text;
            string ext = Path.GetExtension(filePath);
            Response.ContentType = ext.ToString();
            Response.AppendHeader("Content-Disposition", "audio/mpeg3; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }
    }
    protected void Tax_Voice_Upload_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int Tax_Type_Source_upload_id = int.Parse(Tax_Voice_Upload.DataKeys[e.RowIndex].Values["Id"].ToString());
        Hashtable htdelete = new Hashtable();
        DataTable dtdelete = new DataTable();
        htdelete.Add("@Trans", "DELETE");
        htdelete.Add("@Tax_Type_Source_upload_id", Tax_Type_Source_upload_id);
        dtdelete = dataaccess.ExecuteSP("Sp_Orders_Tax_Source_Upload", htdelete);
        Gridview_Bind_Tax_type_Source_Upload_Data();
    }
    protected void Tax_Voice_Upload_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        e.NewPageIndex = Tax_Voice_Upload.PageIndex;
        Gridview_Bind_Tax_type_Source_Upload_Data();
    }
    protected void ddl_Agency_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_Agency_Type.SelectedIndex > 0)
        {
            tr_CountyDbInfo2.Visible = true;
            tr_CountyDbInfo3.Visible = true;

            int County_Database_Id = int.Parse(ddl_Agency_Type.SelectedValue.ToString());

            Hashtable htget = new Hashtable();
            DataTable dtget = new DataTable();
            htget.Add("@Trans", "GET_BY_COUNTY_DATA_BASE_ID");
            htget.Add("@County_Databse_Id", County_Database_Id);
            dtget = dataaccess.ExecuteSP("Sp_County_Database", htget);

            if (dtget.Rows.Count > 0)
            {

                txt_CountyPhno.Text = dtget.Rows[0]["Tax_Office_Phone_No"].ToString();
                txt_CountyPayto.Text = dtget.Rows[0]["Make_Changes_Payable_to"].ToString();
                txt_CountyTaxPayeeadd.Text = dtget.Rows[0]["Physical_Address"].ToString();



            }
            else {
                txt_CountyPhno.Text = "";
                txt_CountyPayto.Text = "";
                txt_CountyTaxPayeeadd.Text = "";

            }



        }
    }
    protected void Tax_Voice_Upload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Control ctrl = e.Row.FindControl("lbl_Source_Type");
       
        Label lbl_l = (Label)e.Row.FindControl("lbl_Source_Type");

        Control obj_player = e.Row.FindControl("dewplayer");
        HtmlTableCell tdplayer = (HtmlTableCell)e.Row.FindControl("tdPlayer");
        HtmlTableCell tdfile = (HtmlTableCell)e.Row.FindControl("tdfile");

        if (ctrl != null)
    {
        if (lbl_l.Text == ".mp3" )
        {
            tdplayer.Visible = true;
            tdfile.Visible = false;

        
            
        }
        else
        {
            tdplayer.Visible = false;
            tdfile.Visible = true;
      
           
        }
         }
    }
}