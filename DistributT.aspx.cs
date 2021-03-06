﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Distribut : System.Web.UI.Page
{
    public string json = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["ErrIsertForm"] = "";//משתנה שיציג הודעה ללקוח אם סיסמה או שם משתמש קיימים
        DateTime today = DateTime.Today;
        string datec = today.ToString("dd/MM/yyyy");
        if (Session["userNameT"] == null)
        {
            Response.Redirect("loginT.aspx");
        }
        string subject = "", diff = "", kita="", numof1, byy;
        string dd, mm, yyyy, exp;
        string icon = "note_add", title = "";
        int numof;
        string sqlkita = "SELECT DISTINCT kita FROM users;";
        DataTable dtkita = MyAdoHelper.ExecuteDataTable("db1.mdb", sqlkita); //יונתן תציל אותי ותעביר לפרונט
        json = Json(dtkita);
        int iikaptin = 0;
        string k = "kita";
        if (Request.Form["submit"] != null)
        {
            foreach (DataRow row in dtkita.Rows)
            {
                k = "kita" + iikaptin.ToString();
                kita = kita + Request.Form[k] + ",";
                iikaptin++;
            }
            subject = Request.Form["subject"];
            numof1 = Request.Form["numof"];
            diff = Request.Form["diff"];
            dd = Request.Form["dd"];
            mm = Request.Form["mm"];
            yyyy = Request.Form["yyyy"];
            exp = dd + "/" + mm + "/" + yyyy;
            byy = Session["nameT"].ToString();
            if (subject == "0" || numof1 == "" || numof1 == "0" || diff == "0" || kita == "")
            {
                Session["ErrIsertForm"] = "נתונים לא מולאו כשורה";
            }
            else
            {
                string[] kitot = kita.Split(',');
                numof = int.Parse(numof1);
                string sql2 ="";
                string fileName7 = "db1.mdb";       //SQLSTUF START
                iikaptin = 1;
                if (kitot.Length==1)
                {
                    sql2 = "SELECT * FROM users WHERE kita='" + kitot[0] + "';";
                }
                else if(kitot.Length >1)
                {
                    sql2 = "SELECT * FROM users WHERE kita='" + kitot[0] + "'";
                    while (iikaptin<kitot.Length)
                    {
                        sql2 += " OR kita='" + kitot[iikaptin] + "'";
                        iikaptin++;
                    }
                    sql2 += ";";
                }
                DataTable dt1;
                DataTable dtu;
                DataTable dtat;
                DataTable dtatu;
                dt1 = MyAdoHelper.ExecuteDataTable(fileName7, sql2);//users
                int i = 0,x,f,rand,b=0,d=0;
                Random rnd = new Random();
                string ID,sql1,sql3,sql4,sql5,sql6,sql7,sql8,sql9;
                string TALMIDMAAGARSQL;
                bool found = false;
                sql3 = "SELECT * FROM TAT" + subject + " WHERE diff='" + diff + "';"; //מאגר
                dtat = MyAdoHelper.ExecuteDataTable(fileName7, sql3);
                if (dtat.Rows.Count > 0)
                {
                    foreach (DataRow Row in dt1.Rows)  /////////foreach////////////
                    {
                        ID = dt1.Rows[i][5].ToString();
                        sql1 = "SELECT * FROM ID" + ID + " WHERE subjectID='" + subject + "';";   //טבלה אישית
                        dtu = MyAdoHelper.ExecuteDataTable(fileName7, sql1);
                        if (dtu.Rows.Count > 0)
                        {
                            if (dtu.Rows[0][3].ToString() == diff) //אם כבר קיימת רשומה וטבלה והכל כיף
                            {
                                if (dtat.Rows.Count <= numof)
                                {
                                    //sendthemall
                                    sql5 = "SELECT * FROM TAT" + subject + "_" + ID + ";";  //מאגר אישי
                                    dtatu = MyAdoHelper.ExecuteDataTable(fileName7, sql5);
                                    x = 0;
                                    f = 0;
                                    b = 0;
                                    d = 0;
                                    while (x < dtat.Rows.Count)//עבור כל תרגיל
                                    {
                                        found = false;
                                        while (f < dtatu.Rows.Count) //בדיקה האם התרגיל קיים עובר על כל המאגר האישי
                                        {
                                            if (dtat.Rows[x][0].ToString() == dtatu.Rows[f][0].ToString())
                                            {
                                                found = true;
                                                break; //תפסיק את החיפוש
                                            }
                                            sql8 = "SELECT * FROM TAT" + subject + "_" + ID + " WHERE ID='" + dtat.Rows[x][0].ToString() + "';";
                                            if (MyAdoHelper.IsExist(fileName7, sql8))
                                            {
                                                found = true;
                                                break; //תפסיק את החיפוש
                                            }
                                            f++;
                                        }
                                        if (!found)
                                        {
                                            b++;
                                            sql6 = "INSERT INTO TAT" + subject + "_" + ID + " (ID, location, answ, iscomplete, datec, exp, byy)values('" + dtat.Rows[x][0].ToString() + "','" + dtat.Rows[x][1].ToString() + "','" + dtat.Rows[x][2].ToString() + "','0','"+datec+"','" + exp +"','" + byy + "');";
                                            MyAdoHelper.DoQuery(fileName7, sql6);
                                        }
                                        x++;
                                    }
                                    d = b + int.Parse(dtu.Rows[0][2].ToString());
                                    sql7 = "UPDATE ID" + ID + " SET ctargil='" + d.ToString() + "' WHERE subjectID='" + subject + "';";//הוספת התרגילים החדשים לסיתרגיל
                                    MyAdoHelper.DoQuery(fileName7, sql7);
                                    title = "נוספו " + b.ToString() + " תרגילים חדשים ב" + xpstuf.IDsubject(subject); //msg
                                    sql9 = "INSERT INTO notifi (icon, title, ID, datec, exp, seen) VALUES('" + icon + "','" + title + "','" + ID + "','" + datec + "','" + exp + "',False);";
                                    MyAdoHelper.DoQuery(fileName7, sql9);
                                }
                                else
                                {
                                    //random
                                    sql5 = "SELECT * FROM TAT" + subject + "_" + ID + ";";  //מאגר אישי
                                    dtatu = MyAdoHelper.ExecuteDataTable(fileName7, sql5);
                                    x = 0;
                                    f = 0;
                                    b = 0;
                                    d = 0;
                                    while (x < numof)//עבור כל תרגיל
                                    {
                                        sql5 = "SELECT * FROM TAT" + subject + "_" + ID + ";";  //מאגר אישי מעודכן למניעת כפילויות
                                        dtatu = MyAdoHelper.ExecuteDataTable(fileName7, sql5);
                                        rand = rnd.Next(0, numof);//אקראי, הגרלה
                                        while (f < dtatu.Rows.Count) //בדיקה האם התרגיל קיים עובר על כל המאגר האישי
                                        {
                                            if (dtat.Rows[rand][0].ToString() == dtatu.Rows[f][0].ToString())
                                            {
                                                rand = rnd.Next(0, numof); //אם נמצא, תרגיל חדש
                                                f = 0;
                                            }
                                            sql8 = "SELECT * FROM TAT" + subject + "_" + ID + " WHERE ID='" + dtat.Rows[rand][0].ToString() + "';";
                                            if (MyAdoHelper.IsExist(fileName7, sql8))
                                            {
                                                rand = rnd.Next(0, numof); //אם נמצא, תרגיל חדש
                                                f = 0;
                                            }
                                            f++;
                                        }
                                        sql6 = "INSERT INTO TAT" + subject + "_" + ID + " (ID, location, answ, iscomplete, datec, exp, byy)values('" + dtat.Rows[rand][0].ToString() + "','" + dtat.Rows[rand][1].ToString() + "','" + dtat.Rows[rand][2].ToString() + "','0','"+datec+"','" + exp + "','" + byy + "');";
                                        MyAdoHelper.DoQuery(fileName7, sql6);
                                        b++;
                                        x++;
                                    }
                                    d = b + int.Parse(dtu.Rows[0][2].ToString());
                                    sql7 = "UPDATE ID" + ID + " SET ctargil='" + d.ToString() + "' WHERE subjectID='" + subject + "';";//הוספת התרגילים החדשים לסיתרגיל
                                    MyAdoHelper.DoQuery(fileName7, sql7);
                                    title = "נוספו " + b.ToString() + " תרגילים חדשים ב" + xpstuf.IDsubject(subject); //msg
                                    sql9 = "INSERT INTO notifi (icon, title, ID, datec, exp, seen) VALUES('" + icon + "','" + title + "','" + ID + "','" + datec + "','" + exp + "',False);";
                                    MyAdoHelper.DoQuery(fileName7, sql9);
                                }
                                i++;
                            }
                            else if (dtu.Rows[0][3].ToString() != diff) //אם קיימת רשומה אבל ברמה שונה, נדלג.
                            {
                                i++;
                            }
                        }
                        else //אם אין טבלה ורשומה, ניצור חדשה.
                        {
                            TALMIDMAAGARSQL = "CREATE TABLE TAT" + subject + "_" + ID + " (ID varchar(255), location varchar(255), answ varchar(255), iscomplete bit, datec varchar(255), exp varchar(255), byy varchar(255));";
                            MyAdoHelper.DoQuery(fileName7, TALMIDMAAGARSQL);//טבלה נוצרה
                            if (dtat.Rows.Count <= numof)
                            {
                                sql4 = "INSERT INTO ID" + ID + " (subject, subjectID, ctargil, diff, cou)values('" + xpstuf.IDsubject(subject) + "','" + subject + "','" + dtat.Rows.Count.ToString() + "','" + diff + "','0');";
                                MyAdoHelper.DoQuery(fileName7, sql4);
                                title = "נוספו " + dtat.Rows.Count.ToString() + " תרגילים חדשים ב" + xpstuf.IDsubject(subject); //msg
                                sql9 = "INSERT INTO notifi (icon, title, ID, datec, exp, seen) VALUES('" + icon + "','" + title + "','" + ID + "','" + datec + "','" + exp + "',False);";
                                MyAdoHelper.DoQuery(fileName7, sql9);
                                //sendthemall
                                x = 0;
                                while (x < dtat.Rows.Count)//עבור כל תרגיל
                                {
                                    sql6 = "INSERT INTO TAT" + subject + "_" + ID + " (ID, location, answ, iscomplete, datec, exp, byy)values('" + dtat.Rows[x][0].ToString() + "','" + dtat.Rows[x][1].ToString() + "','" + dtat.Rows[x][2].ToString() + "','0','"+datec+"','" + exp + "','" + byy + "');";
                                    MyAdoHelper.DoQuery(fileName7, sql6);
                                    x++;
                                }
                            }
                            else
                            {
                                x = 0;
                                sql4 = "INSERT INTO ID" + ID + " (subject, subjectID, ctargil, diff, cou)values('" + xpstuf.IDsubject(subject) + "','" + subject + "','" + numof1 + "','" + diff + "','0');";
                                MyAdoHelper.DoQuery(fileName7, sql4);
                                title = "נוספו " + numof1 + " תרגילים חדשים ב" + xpstuf.IDsubject(subject); //msg
                                sql9 = "INSERT INTO notifi (icon, title, ID, datec, exp, seen) VALUES('" + icon + "','" + title + "','" + ID + "','" + datec + "','" + exp + "',False);";
                                MyAdoHelper.DoQuery(fileName7, sql9);
                                //random
                                sql5 = "SELECT * FROM TAT" + subject + "_" + ID + ";";  //מאגר אישי
                                dtatu = MyAdoHelper.ExecuteDataTable(fileName7, sql5);
                                x = 0;
                                f = 0;
                                while (x < numof)//עבור כל תרגיל
                                {
                                    sql5 = "SELECT * FROM TAT" + subject + "_" + ID + ";";  //מאגר אישי מעודכן למניעת כפילויות
                                    dtatu = MyAdoHelper.ExecuteDataTable(fileName7, sql5);
                                    rand = rnd.Next(0, dtat.Rows.Count);//אקראי, הגרלה
                                    while (f < dtatu.Rows.Count) //בדיקה האם התרגיל קיים עובר על כל המאגר האישי
                                    {
                                        if (dtat.Rows[rand][0].ToString() == dtatu.Rows[f][0].ToString())
                                        {
                                            rand = rnd.Next(0, dtat.Rows.Count); //אם נמצא, תרגיל חדש
                                            f = -1;
                                        }
                                        f++;
                                    }
                                    sql6 = "INSERT INTO TAT" + subject + "_" + ID + "(ID, location, answ, iscomplete, datec, exp, byy)values('" + dtat.Rows[rand][0].ToString() + "','" + dtat.Rows[rand][1].ToString() + "','" + dtat.Rows[rand][2].ToString() + "','0','"+datec+"','" + exp + "','" + byy + "');";
                                    MyAdoHelper.DoQuery(fileName7, sql6);
                                    x++;
                                }
                            }
                            i++;
                        }

                    }
                    Session["ErrIsertForm"] = "הפעולה הושלמה בהצלחה!";
                }
                else
                {
                    Session["ErrIsertForm"] = "מאגר התרגילים ריק.";
                }
           }

        }
       
    }
    public string Json(DataTable table)
    {
        {
            string JSONString = string.Empty;
            JSONString = Newtonsoft.Json.JsonConvert.SerializeObject(new { Class=table });
            return JSONString;
        }
    }

}


