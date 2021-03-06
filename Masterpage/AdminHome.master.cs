﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
public partial class Admin_Admin : System.Web.UI.MasterPage
{
    int userid;
    string Empname;
    string User_Role_Id;
    string Last_Login;
    Commonclass Comclass = new Commonclass();
    DataAccess Dataaccess = new DataAccess();
    int client_Id, Subprocess_id;
    string user_Photo;

    protected void Page_Load(object sender, EventArgs e)
    {
      
        User_Role_Id = Session["Role_Id"].ToString();
        if (Session["userid"] == null )
        {
            //Response.Redirect("~/Login.aspx");
        }
        else
        {
            userid = int.Parse(Session["userid"].ToString());
            Empname = Session["Empname"].ToString();
            lblusername.Text = Empname.ToString();

            user_Photo = Session["User_Photo"].ToString();
        }
        client_Id = int.Parse(Session["client_Id"].ToString());
        Subprocess_id=int.Parse(Session["subProcess_id"].ToString());
        if (Session["LastLogin"] != "")
        {

            lastlogin.Text = Session["LastLogin"].ToString();

        }
        else
        {

            lastlogin.Text = DateTime.Now.ToString();
        }
        if (!IsPostBack)
        {
            if (user_Photo == "0")
            {

                Img_User.ImageUrl = "~/images/default-emp.jpg";
            }
            else
            {

                Img_User.ImageUrl = "~/Admin/UserHandler.ashx?User_id=" + userid;
            }

           
            User_Wise_Restrict();
           
        }
    }
    protected void User_Wise_Restrict()
    {
        if (User_Role_Id == "1")
        {

            li_users.Visible = true;
            limasters.Visible = true;
            liReports.Visible = true;
            liTax_Masters.Visible = true;
        }
        else if(User_Role_Id=="2")
        {
            li_users.Visible = false;
            limasters.Visible = false;
            liReports.Visible = false;
            liTax_Masters.Visible = false;

        }
    }
   
    protected void Update_LastLogin()
    {

        Hashtable htuser = new Hashtable();
        DataTable dtuser = new DataTable();
        htuser.Add("@Trans", "UPDATE_LAST_LOGIN");
        htuser.Add("@Last_login", DateTime.Now);
        htuser.Add("@User_id", userid);
        dtuser = Dataaccess.ExecuteSP("Sp_User", htuser);
    }

    //protected void lnk_Home_Click(object sender, EventArgs e)
    //{

    //    Response.Redirect("~/Admin/Admin_Dashboard.aspx");
    //}
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
        if (User_Role_Id == "2")
        {
            Response.Redirect("~/Admin/Dashboard.aspx");
        }
        else
        {

            Response.Redirect("~/Tax_Admin_Home.aspx");
        }
        
    }
}
