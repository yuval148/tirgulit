﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>
<html dir="rtl">
	<head>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

        <title></title>
		<style>
            
		    /*custom font*/
			@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700,900);
            
			/*basic reset*/
			* {margin: 0; padding: 0;}

			html {
				height: 100%;
				/*Image only BG fallback*/
				
				/*background = gradient + image pattern combo*/
				background: 
					linear-gradient(rgba(196, 102, 0, 0.6), rgba(155, 89, 182, 0.6));
			}

			body {
				font-family: Rubik, arial;
			}
			/*form styles*/
			#f {
				width: 400px;
				margin: 50px auto;
				text-align: center;
				position: relative;
			}
			#f fieldset {
				background: white;
				border: 0 none;
				border-radius: 3px;
				box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
				padding: 20px 30px;
				box-sizing: border-box;
				width: 80%;
				margin: 0 10%;
				
				/*stacking fieldsets above each other*/
				position: relative;
			}
			/*Hide all except first fieldset*/
			#f fieldset:not(:first-of-type) {
				display: none;
			}
			/*inputs*/
			#f input, #f textarea {
				padding: 15px;
				border: 1px solid #ccc;
				border-radius: 3px;
				margin-bottom: 10px;
				width: 100%;
				box-sizing: border-box;
				font-family: montserrat;
				color: #2C3E50;
				font-size: 13px;
			}
			/*buttons*/
			#f .action-button {
				width: 100px;
				background: #27AE60;
				font-weight: bold;
				color: white;
				border: 0 none;
				border-radius: 1px;
				cursor: pointer;
				padding: 10px 5px;
				margin: 10px 5px;
			}
			#f .action-button:hover, #f .action-button:focus {
				box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
			}
			/*headings*/
			.fs-title {
				font-size: 20px;
				text-transform: uppercase;
				color: #2C3E50;
				margin-bottom: 10px;
                font-family: Rubik;
                font-weight:700
			}
			.fs-subtitle {
				font-weight: normal;
				font-size: 13px;
				color: #666;
				margin-bottom: 20px;
                font-family: Rubik;
                font-weight:400
			}
			/*progressbar*/
			#progressbar {
				margin-bottom: 30px;
				overflow: hidden;
				/*CSS counters to number the steps*/
				counter-reset: step;
			}
			#progressbar li {
				list-style-type: none;
				color: white;
				text-transform: uppercase;
				font-size: 9px;
				width: 33.33%;
				float: right;
				position: relative;
			}
			#progressbar li:before {
				content: counter(step);
				counter-increment: step;
				width: 20px;
				line-height: 20px;
				display: block;
				font-size: 10px;
				color: #333;
				background: white;
				border-radius: 3px;
				margin: 0 auto 5px auto;
			}
			/*progressbar connectors*/
			#progressbar li:after {
				content: '';
				width: 100%;
				height: 2px;
				background: white;
				position: absolute;
				left: 50%;
				top: 9px;
				z-index: -1; /*put it behind the numbers*/
			}
			#progressbar li:first-child:after {
				/*connector not needed before the first step*/
				content: none; 
			}
			/*marking active/completed steps green*/
			/*The number of the step and the connector before it = green*/
			#progressbar li.active:before,  #progressbar li.active:after{
				background: #27AE60;
				color: white;
			}
             ::-webkit-input-placeholder {
               font-family:Rubik;
               font-weight:300;
             }
 
             :-moz-placeholder { /* Firefox 18- */
               font-family:Rubik;
              font-weight:300;
             }
 
             ::-moz-placeholder {  /* Firefox 19+ */
               font-family:Rubik;
               font-weight:300;
             }
 
             :-ms-input-placeholder {  
               font-family:Rubik;
               font-weight:300;
             }
		</style>
	</head>
	<body style="font-family:Rubik">
		<!-- multistep form -->
         <form name="f" id="f" method="post" runat="server" onsubmit="return check();">
		  <!-- progressbar -->
		  <ul id="progressbar">
			<li class="active">פרטים אישיים</li>
			<li>יצירת חשבון</li>
			<li>תמונת פרופיל</li>
		  </ul>
		  <!-- fieldsets -->
		  <fieldset>
			<h2 class="fs-title">ברוכים הבאים לפלייגראונד! </h2>
			<h3 class="fs-subtitle">בשלב זה הכניסו את שמכם, הכיתה ומספר תעודת הזהות.<br/>כשתסיימו, לחצו הבא כדי לעבור לשלב בחירת שם המשתמש והסיסמה.</h3>
			<input placeholder="שם מלא" type="text" id="name" name="name" maxlength="50" size="15"/> 
            <input placeholder="כיתה" type="text" id="kita" name="kita" maxlength="4" size="15"/>
            <input placeholder="מספר תעודת זהות" type="text" id="ID" name="ID" maxlength="9" size="9" />
			<input type="button" name="next" id="next1" class="next action-button" runat="server" value="הבא" />
            <br /><asp:label id="myLabel" runat="server" />

		  </fieldset>
		  <fieldset>
			<h2 class="fs-title">כמעט סיימנו!</h2>
			<h3 class="fs-subtitle">בשלב זה עליכם לבחור שם משתמש, סיסמה ושם לקבוצתכם. <br/> רצוי לבחור סיסמה ארוכה עם שילובי מספרים ואותיות. <br/> לחצו 'הבא' כדי לבחור תמונת פרופיל ולסיים את ההרשמה.</h3>         
            <input placeholder="שם משתמש" type="text" id="userName" name="userName" maxlength="145" size="15"/>
            <input placeholder="סיסמא" type="password" id="userPass" name="userPass"  maxlength="16" size="15" />
            <input placeholder="חזור שנית על הסיסמא" type="password" id="userPass2" name="userPass2"  maxlength="16" size="15" />

            <input placeholder="שם קבוצה" type="text" id="team" name="team" maxlength="16" size="15" />
			<input type="button" name="previous" class="previous action-button" value="הקודם" />
			<input type="button" name="next" id="next2" class="next action-button" value="הבא" />
		  </fieldset>
		  <fieldset>
			<h2 class="fs-title">זהו!</h2>
			<h3 class="fs-subtitle">בשלב זה באפשרותך להעלות תמונת פרופיל שתייצג אותך באתר. <br/> לאחר ההעלאה לחצו על כפתור 'סיים' על מנת לסיים את ההרשמה. <br/> אין חובה להעלות תמונת פרופיל אך רצוי.</h3>
            <asp:FileUpload ID="FileUpload1" runat="server"/>
			<input type="button" name="previous" class="previous action-button" value="הקודם" />
               <asp:Button ID="Button1" class="submit action-button" runat="server" Text="סיים" type="submit"  OnClick="submit"  />
		  </fieldset>
		</form>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
		<script type="text/javascript">					
			//jQuery time
			var current_fs, next_fs, previous_fs; //fieldsets
			var right, opacity, scale; //fieldset properties which we will animate
			var animating; //flag to prevent quick multi-click glitches
			$('#next1').click(function () {
			    if ($('#name').val()=='') {
			        alert("שכחת למלא את שמך!");
			        animating = false;
			    }
			    else if ($('#kita').val() == '') {
			        alert("שכחת למלא את כיתתך!");
			        animating = false;
			    }
			    else if ($('#ID').val() == '') {
			        alert("שכחת למלא את מספר תעודת הזהות!");
			        animating = false;
			    }
			    else if (!($.isNumeric($('#ID').val()))) {
			        alert("תעודת הזהות צריכה להיות מספר!");
			        animating = false;
			    }
			    else if ($('#kita').val().indexOf('.') !== -1 || $('#kita').val().indexOf(',') !== -1 || $('#kita').val().indexOf("'") !== -1 || $('#kita').val().indexOf('"') !== -1 || $('#kita').val().indexOf(';') !== -1) {
			        alert("נא לא להשתמש בסימני פיסוק!");
			        animating = false;
			    }
			    else {
			            if (animating) return false;
			            animating = true;

			            current_fs = $(this).parent();
			            next_fs = $(this).parent().next();

			            //activate next step on progressbar using the index of next_fs
			            $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

			            //show the next fieldset
			            next_fs.show();
			            //hide the current fieldset with style
			            current_fs.animate({ opacity: 0 }, {
			                step: function (now, mx) {
			                    //as the opacity of current_fs reduces to 0 - stored in "now"
			                    //1. scale current_fs down to 80%
			                    scale = 1 - (1 - now) * 0.2;
			                    //2. bring next_fs from the right(50%)
			                    right = (now * 50) + "%";
			                    //3. increase opacity of next_fs to 1 as it moves in
			                    opacity = 1 - now;
			                    current_fs.css({
			                        'transform': 'scale(' + scale + ')',
			                        'position': 'absolute'
			                    });
			                    next_fs.css({ 'right': right, 'opacity': opacity });
			                },
			                duration: 800,
			                complete: function () {
			                    current_fs.hide();
			                    animating = false;
			                },
			                //this comes from the custom easing plugin
			                easing: 'easeInOutBack'
			            });
			    }
			});
			$('#next2').click(function () {
			    if ($('#userName').val() == '') {
			        alert("שכחת למלא את המשתמש!");
			    }
			    else if ($('#userPass').val() == '') {
			        alert("שכחת למלא את הסיסמא!");
			    }
			    else if (!($('#userPass').val() == $('#userPass2').val())) {
			        alert("סיסמאות לא תואמות");
			    }
			    else if ($('#team').val() == '') {
			        alert("שכחת למלא את שם הקבוצה!");
			    }
			    else {
			        if (animating) return false;
			        animating = true;

			        current_fs = $(this).parent();
			        next_fs = $(this).parent().next();

			        //activate next step on progressbar using the index of next_fs
			        $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

			        //show the next fieldset
			        next_fs.show();
			        //hide the current fieldset with style
			        current_fs.animate({ opacity: 0 }, {
			            step: function (now, mx) {
			                //as the opacity of current_fs reduces to 0 - stored in "now"
			                //1. scale current_fs down to 80%
			                scale = 1 - (1 - now) * 0.2;
			                //2. bring next_fs from the right(50%)
			                right = (now * 50) + "%";
			                //3. increase opacity of next_fs to 1 as it moves in
			                opacity = 1 - now;
			                current_fs.css({
			                    'transform': 'scale(' + scale + ')',
			                    'position': 'absolute'
			                });
			                next_fs.css({ 'right': right, 'opacity': opacity });
			            },
			            duration: 800,
			            complete: function () {
			                current_fs.hide();
			                animating = false;
			            },
			            //this comes from the custom easing plugin
			            easing: 'easeInOutBack'
			        });
			    }
			    
			});

			$(".previous").click(function(){
				if(animating) return false;
				animating = true;
				
				current_fs = $(this).parent();
				previous_fs = $(this).parent().prev();
				
				//de-activate current step on progressbar
				$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
				
				//show the previous fieldset
				previous_fs.show(); 
				//hide the current fieldset with style
				current_fs.animate({opacity: 0}, {
					step: function(now, mx) {
						//as the opacity of current_fs reduces to 0 - stored in "now"
						//1. scale previous_fs from 80% to 100%
						scale = 0.8 + (1 - now) * 0.2;
						//2. take current_fs to the right(50%) - from 0%
						right = ((1-now) * 50)+"%";
						//3. increase opacity of previous_fs to 1 as it moves in
						opacity = 1 - now;
						current_fs.css({'right': right});
						previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
					}, 
					duration: 800, 
					complete: function(){
						current_fs.hide();
						animating = false;
					}, 
					//this comes from the custom easing plugin
					easing: 'easeInOutBack'
				});
			});
		</script>
	</body>
</html>

