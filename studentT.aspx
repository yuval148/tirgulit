﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="studentT.aspx.cs" Inherits="culture" %>
<!--#include file="upperT.aspx"-->
<html>
<head>
    <title></title>
 <style>
            body {
                background: url("/media/bfg5.jpg");
                background-size: 100%, 100%;
                background-repeat: no-repeat;
            }
            #stu-div{
                margin:10px;
            }
    </style>

</head>
<body>
    <div class="w3-row">
    <div id="pro-div" class="w3-panel w3-row w3-right w3-half"></div>
    <div id="changepass" style="opacity:0;float:right; margin-top:60px; font-family:Heebo" class="w3-quarter w3-panel" runat="server">

        <div id="pass" style="opacity:0" runat="server">
            <table align="center">
                <tr>
                    <td style="font-weight:700">שם משתמש</td>
                    <td><span style="color:#9c9c9c"><%=userName %></span></td>
                </tr>
                <tr>
                    <td style="font-weight:700">סיסמה</td>
                    <td><input class="w3-input" type="text" name="userPass1" id="userPass1" placeholder="<%=userPass %>"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span style="font-family:Heebo; font-weight:300">לעדכון סיסמה, הכנס את הסיסמה החדשה ולחץ עדכן.</span></td>
                </tr>
            </table> 
            <button name="update" id="update">עדכון סיסמה</button>
        </div>
        <br />
        <button type="button" 
onclick="document.getElementById('pass').style.opacity = '100'" class="w3-button w3-red">
הצג סיסמה</button>
        </div>
        </div>
 <div id="form" style="opacity:100; text-align:center" runat="server">
    <form method="post">
     <table align="center">
            <tr>
                <td>תלמיד</td>
                <td>
              
                    <div id="student_selection">
    </div>
                    </td></tr>
            </table>
         <input type="submit" name="submit" id="Submit" value="צפה בתלמיד" />
            </form>
        </div>
    <div id="stuopc" style="opacity:0;width:80%;margin-left:auto;margin-right:auto" class="w3-responsive" runat="server">
        <div id="stu-div"></div>
</div>
                 

    
    <!-- צריך להיות פה כפתור שרק בלחיצה עליו מפעיל את הדיב הבא !-->
    

        <script id="pro-temp" type="text/x-handlebars-template">
                    {{#each stu}}
                    <div class="w3-half" style="top:200px">
                        <span style="font-size:50px;font-weight:700;font-family:Heebo;"> {{name}} </span>
                        <br />
                        <span style="font-size:20px; font-weight:300;font-family:Heebo; line-height:80%; text-align:right">{{kita}}, קבוצת  {{team}}</span>                     

                    </div>
                               <img src="media/{{pic}}" style="width:120px; height:120px;margin:10px;" class="w3-circle w3-center w3-half">
                    {{/each}}
                </script>
    

    <script id="stu-temp" type="text/x-handlebars-template">
        <table class="w3-table-all w3-card">
            <tr>
                <th>נושא</th>
                <th>דרגת קושי</th>
                <th>מספר התרגילים שנשלחו בנושא</th>
                <th>מספר התרגילים שנפתרו מתוכם</th>
                <th>אחוז שליטה</th>
            </tr>
            {{#each stu}}
            <tr>
                <td>{{subject}}</td>
                <td>{{diff}} יח"ל</td>
                <td>{{ctargil}}</td>
                <td>{{cou}}</td>
                <td>{{GetMasterPrecent cou ctargil}}%</td>
            </tr>
            {{/each}}
        </table>
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var newSelect = document.createElement('select');
            newSelect.id="ID";
            newSelect.name="ID";
            newSelect.className="w3-select"
            var selectHTML = "";
            var data = (<%=this.json%>);
            var choices = $.map(data, function(el) { return el; })
            for (i = 0; i < choices.length; i = i + 1) {
                var x = choices[i]["ID"];
                var y = choices[i]["name"];
                selectHTML += "<option value='" + x + "'>" + y + "</option>";
            }
            selectHTML += "</select>";

            newSelect.innerHTML = selectHTML;
            document.getElementById('student_selection').appendChild(newSelect);
             Handlebars.registerHelper('GetMasterPrecent', function (cou, ctargil) {
            var pre = parseInt(cou) / parseInt(ctargil);
            var final = pre * 100;
            return parseInt(final);

             });
             Handlebars.registerHelper('GetLevel', function (xp) {
                 if (xp >= 0 && xp < 100)
                 {
                     r = 1;
                 }
                 if (xp >= 100 && xp < 250)
                 {
                     r = 2;
                 }
                 if (xp >= 250 && xp < 500)
                 {
                     r = 3;
                 }
                 if (xp >= 500 && xp < 900)
                 {
                     r = 4;
                 }
                 if (xp >= 900 && xp < 1450)
                 {
                     r = 5;
                 }
                 return r;
             });
        var stuInfo = document.getElementById("stu-temp").innerHTML;
        var stuTemplate = Handlebars.compile(stuInfo);
        var stuData = stuTemplate(<%=this.json2%>);
        document.getElementById("stu-div").innerHTML += stuData;

        var proInfo = document.getElementById("pro-temp").innerHTML;
        var proTemplate = Handlebars.compile(proInfo);
        var proData = proTemplate(<%=this.json3%>);
        document.getElementById("pro-div").innerHTML += proData;
        
        document.getElementById("update").onclick = function() {send()};
        function send(){
            var ID="<%=ID%>";
            var up = document.getElementById("userPass1").value;
            up = '"' + up+'"';
            $.ajax({
                        type: "POST",
                        url: "studentT.aspx/changepss",
                        data:'{"userPass1":'+up+',"ID":'+ID+' }',
                        contentType: "application/json; charset=utf-8",
                        success: function() {
                            alert("yayyyy");
                        },
                        failure: function() {
                            alert("oy");
                        }
            });
            }
        });
    </script>
</body>
</html>