﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submit(Object sender, EventArgs e)
    {
        myLabel.Text = "my text";
        string name = "", userPass = "", userName = "", team = "", kita = "", ID = "",userPass1="";
        int xpp = 0;
        name = Request.Form["name"];
        userName = Request.Form["userName"];
        userPass1 = Request.Form["userPass"];
        userPass = SecurePasswordHasher.Hash(userPass1);
        team = Request.Form["team"];
        kita = Request.Form["kita"];
        ID = Request.Form["ID"];

        if (name == "" || userPass1 == "" || ID == "")
        {
            myLabel.Text = "נתונים לא מולאו כשורה";
            // Response.Redirect("form.aspx");
        }
        else
        {

            string fileName7 = "db1.mdb";
            string tableName = "users";
            string sql;
            string sql3;



            sql = "select * from " + tableName + " where userName='" + userName + "'";
            sql3 = "select * from " + tableName + " where ID='" + ID + "'";
            // string path = Server.MapPath("App_Data/db1.mdb");

            if (MyAdoHelper.IsExist(fileName7, sql)) //שימוש בפעולה לבדיקה אם המשתמש קיים 
            {
                myLabel.Text = "משתמש קיים";
                // Response.Redirect("form.aspx");

            }
            else if (MyAdoHelper.IsExist(fileName7, sql3))
            {
                myLabel.Text = "משתמש קיים";
            }
            else if (xpstuf.ValidateID(ID) == xpstuf.TzStatus.R_NOT_VALID || xpstuf.ValidateID(ID) == xpstuf.TzStatus.R_ELEGAL_INPUT)
            {
                myLabel.Text  = "מספר ת.ז לא תקין";
            }

            else
            {
                string pic;
                string uploadFolder = Request.PhysicalApplicationPath + "/media/pic/";
                if (FileUpload1.HasFile)
                {
                    string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                    string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
                    FileUpload1.SaveAs(uploadFolder + ID + extension);
                    pic = "media/pic/" + ID + extension;
                    sql = "insert into users(name, userName, userPass, team, xpp, ID, kita, pic)values('" + name + "','" + userName + "','" + userPass + "','" + team + "','" + xpp + "','" + ID + "','" + kita + "','" + pic + "');";
                    MyAdoHelper.DoQuery(fileName7, sql);
                    string sql2 = "CREATE TABLE ID" + ID + " (subject varchar(255), subjectID varchar(255), ctargil varchar(255), diff varchar(255), cou varchar(255));";
                    MyAdoHelper.DoQuery(fileName7, sql2);
                    string sql5 = "CREATE TABLE GRA" + ID + " (shlita int, datee varchar(255));";
                    MyAdoHelper.DoQuery(fileName7, sql5);
                    myLabel.Text = "ההרשמה בוצעה בהצלחה";
                    Response.Redirect("login.aspx");



                    Response.Redirect(Request.Url.AbsoluteUri);
                }
                else if(!FileUpload1.HasFile)
                {
                    sql = "insert into users(name, userName, userPass, team, xpp, ID, kita, pic)values('" + name + "','" + userName + "','" + userPass + "','" + team + "','" + xpp + "','" + ID + "','" + kita + "','" + "media/pic/123456782.png" + "');";
                    MyAdoHelper.DoQuery(fileName7, sql);
                    string sql2 = "CREATE TABLE ID" + ID + " (subject varchar(255), subjectID varchar(255), ctargil varchar(255), diff varchar(255), cou varchar(255));";
                    MyAdoHelper.DoQuery(fileName7, sql2);
                    string sql5 = "CREATE TABLE GRA" + ID + " (shlita int, datee varchar(255));";
                    MyAdoHelper.DoQuery(fileName7, sql5);
                    myLabel.Text = "ההרשמה בוצעה בהצלחה";
                    Response.Redirect("login.aspx");
                }

            }

        }
    }
}



