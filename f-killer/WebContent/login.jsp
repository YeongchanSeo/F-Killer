<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FKILLER (Team Cooperation Project Program)</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="js/jquery-1.11.3.js"></script>

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/favicon.ico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">

<style>
    .navbar {
      margin-bottom: 0;
      margin-top: 0;
      border-radius: 0;
    }
    #fb-auth {
	   width: 65%;
	   border: 0;
	   outline: 0;
	   color: #ffffff;
	   background: #003399;
	   height: 40px;
   }

   .fIcon {
      font-size: 18px;
      color: #ffffff;
   }
   
   #login {
      width: 65%;
      height: 40px;
      background : #ffffff;
      /* font-color : white; */
   }
   
   #join {
      width: 30%;
   }
   
   .b1 {
      background-image: url('img/background/p1.png');
	  background-size: 100%;
      background-repeat: no-repeat;
      transition: background 1s linear;
      
   }
   .b2 {
      background-image: url('img/background/p2.png');
	  background-size: 100%;
      background-repeat: no-repeat;
      transition: background 1s linear;
      
   }
   .b3 {
      background-image: url('img/background/p3.png');
	  background-size: 100%;
      background-repeat: no-repeat;
      transition: background 1s linear;
      
   }
   .b4 {
      background-image: url('img/background/p4.png');
	  background-size: 100%;
      background-repeat: no-repeat;
      transition: background 1s linear;
      
   }
   .b5 {
      background-image: url('img/background/p5.png');
	  background-size: 100%;
      background-repeat: no-repeat;
      transition: background 1s linear;
      
   }
   .opacity{
   	  opacity:0.8;
   }
   .back {
      /* background: #000000;
      ocacity : 0.5; */
   }
   
   .input {
      width: 60%;
   }
	.fIcon {
		font-size: 18px;
		color: #ffffff;
	}
	
	#login {
		width: 65%;
		height: 40px;
		background : #ffffff;
		/* font-color : white; */
	}
	
	#join {
		width: 30%;
	}
	
	body {
		background-image: url('img/1.png');
	}
	
	.input {
		width: 60%;
	}
</style>
</head>
<body class="b1">
<img src="img/background/p1.png" style="display:none"></img>
<img src="img/background/p2.png" style="display:none"></img>
<img src="img/background/p3.png" style="display:none"></img>
<img src="img/background/p4.png" style="display:none"></img>
<img src="img/background/p5.png" style="display:none"></img>
<script>
	var imgNum = 1;
 	$(document).ready(function(){
		setInterval(changeBackground, 5000);
	});
	
	function changeBackground(){
		/* $('body').stop().fadeOut("1000", function () {
	        $('body').css("background-img", "url('img/background/p1.png')").fadeIn(1000);
	    }); */
		$('body').removeClass('b'+imgNum);
		imgNum = (imgNum)%5 +1;
		$('body').addClass('b'+imgNum);
	}
</script>
<%-- <nav class="navbar">
  <jsp:include page="logoMenu.jsp" />
</nav> --%>
   <div class="row-fluid">
      <div class="span4 offset4 back" style="margin-top: 8%">
         <div style="text-align: center; margin-top: 20px;">
         
         
            <div class="control-group">
               <label class="control-label" style="font-size : 80px; color : white;"><strong>F-KILLER</strong></label>
               <div class="controls">
                  
               </div>
            </div>
            <div class="control-group opacity">
               <label class="control-label" for="inputEmail" style="font-size : 16px; color : white;  margin-top:20%;"><!-- <strong>이메일</strong> --></label>
               <div class="controls">
                  <input type="text" id="inputEmail" placeholder="이메일을 입력하세요" class="input">
               </div>
            </div>
            <div class="control-group opacity">
               <label class="control-label" for="inputPassword" style="font-size : 16px; color : white;"><!-- <strong>비밀번호</strong> --></label>
               <div class="controls">
                  <input type="password" id="inputPassword" placeholder="비밀번호를 입력하세요" class="input">
               </div>
            </div>
            <div class="control-group">
               <div class="controls" style="margin-top : 20px;">
                  <label class="checkbox inline" style="font-size : 16px; color : white; "> <input type="checkbox" id="saveEmail" ><strong>이메일저장</strong></label>&nbsp;&nbsp;&nbsp; 
                  <label class="checkbox inline" style="margin-left : 5% ; font-size : 16px; color : white;"><input type="checkbox" id="autoLogin"><strong>자동로그인</strong></label>
               </div>
            </div>
            <div class="control-group">
               <div class="controls">
                  <button class="btn" id="login" style="margin-left : 15px;"><strong>로그인</strong></button>
                  &nbsp;&nbsp;&nbsp;
                  <!-- <input type="button" class="btn" id="join" value="회원가입"> -->
               </div>
            </div>

            <div class="control-group">
               <div id="fb-root" class="controls"></div>
               <button id="fb-auth" class="btn" style="margin-top: 2%; margin-bottom: 10px;">
                  <i class="fa fa-facebook fIcon"></i><strong>&nbsp;&nbsp;&nbsp;&nbsp;페이스북으로   로그인</strong></button>
            </div>
            <div class="control-group">
               <div class="controls" style="margin-bottom : 25px;">
                  <a href="<%=request.getContextPath()%>/join.jsp" id="join" style="font-size : 16px; color : white;"><strong>회원가입</strong></a>
               </div>
            </div>
            
         </div>
      </div>
   </div>
   <form action="<%=request.getContextPath()%>/UserController.do" id="frm" method="post">
      <input type="hidden" name="email" value="">
      <input type="hidden" name="password" value="">
      <input type="hidden" name="cmd" value="login">
   </form>

   <form action="<%=request.getContextPath()%>/UserController.do" id="facebookfrm" method="post">
      <input type="hidden" name="Fname" value="">
      <input type="hidden" name="Femail" value="">
      <input type="hidden" name="cmd" value="facebookLogin">
      <input type="hidden" id = "noFace" name="noFace" value="">
   </form>
	
   <form id="goHomeFrm" action="<%=request.getContextPath()%>/UserController.do" method="get">
		<input type="hidden" name="cmd" id="goHomeCmd" value="">
   </form>
   
   
   <script src="js/bootstrap.min.js"></script>
   <script>
		function goHome(){
			$('#goHomeCmd').val("loginOK");
			$('#goHomeFrm').submit();
		}
		$(document).ready(function(){
			if('${user.userNo}'!=null && '${user.userNo}'>0){
				goHome();
			}
		});
	</script>
   <script language=javascript>
      window.fbAsyncInit = function() {
         FB.init({
            appId : 551354935019382,
            status : true,
            cookie : false,
            xfbml : true,
            oauth : true
         });
      }

      function updateButton(response) {
         var button = document.getElementById('fb-auth');
         if (response.authResponse) {

            FB.api('/me?fields=name,email', function(response) {
               if (confirm('facebookID:' + response.email
                     + ' 로 로그인하시겠습니까?')) {                  
                  console.log("이메일:" + response.email + "/이름:"
                        + response.name);
                  facebookLogin(response.name, response.email);
               } else {
                  
                  // 취소를 선택했을 경우의 처리(아래는 페이스북 로그아웃 처리)
                  FB.logout(function(response) {
                     
                  });
               }
            });

         } else {
            FB.login(function(response) {
               /* document.cookie = "fbs_[551354935019382]=;"; // 쿠키를 제거해 주고, */
               if (response.authResponse) {
                  FB.api('/me?fields=name,email', function(response) {
                     console.log("이메일:" + response.email + "/이름:"
                           + response.name);
                     facebookLogin(response.name, response.email);                     
                  });
               } else {
                  
                  FB.logout(function(response) {
                  });
               }
            }, {
               scope : 'public_profile,email'
            });
         }
      }

      document.getElementById('fb-auth').onclick = function() {

         FB.Event.subscribe('auth.statusChange', updateButton);
         FB.getLoginStatus(updateButton);
      };

      (function() {
         var e = document.createElement('script');
         e.async = true;
         e.src = document.location.protocol
               + '//connect.facebook.net/ko_KR/all.js';
         document.getElementById('fb-root').appendChild(e);
      }());
      
   </script>
   <script>
   
   	  $(document).ready(function(){
   		
	   		var userEmail = getCookie("userEmail");
	   		if(userEmail != 'undefined')
	   	    	$("#inputEmail").val(userEmail);
	   	    
	   	    
	   	    //자동 로그인 시에 비밀번호 저장
	   	    var userPassword = getCookie("userPassword");
			if(userPassword != 'undefined')
	   	    	$("#inputPassword").val(userPassword);
	   	    
	   	    
	   	    if($("#inputEmail").val() != "") {
	   	        $("#saveEmail").attr("checked", true);
	   	        
	   	    	if($("#inputPassword").val() != "") {
		   	        $("#autoLogin").attr("checked", true);
		   	        $("#frm").submit();
		   	    }
	   	    }
	   	    
	   		
	   	     
	   	    $("#saveEmail").change(function() {
	   	        if($("#saveEmail").is(":checked")) { 
	   	            var userEmail = $("#inputEmail").val();
	   	            setCookie("userEmail", userEmail, 7);
	   	        }else{ 
	   	            deleteCookie("userEmail");
	   	        }
	   	    });
	   	    
	   		$("#autoLogin").change(function() {
	   	        if($("#autoLogin").is(":checked")) {
	   	        	
	   	         	$("#saveEmail").attr("checked", true);
	   	            var userEmail = $("#inputEmail").val();
	   	            var userPassword = $("#inputPwd").val();
	   	            setCookie("userEmail", userEmail, 7);
	   	            setCookie("userPassword", userPassword,7);
	   	            
	   	        } else{ 
	   	        	
	   	        	if($("#saveEmail").is(":checked"))
	   	        		deleteCookie("userPassword");
	   	        	else {
	   	        	 	deleteCookie("userEmail");
	   	        		deleteCookie("userPassword");
	   	        	}   	            
	   	        }
	   	    });
	   	     
	   	  
	   	    $("#inputEmail").keyup(function(){ 
	   	        if($("#saveEmail").is(":checked")) {
	   	            var userEmail = $("#inputEmail").val();
	   	            setCookie("userEmail", userEmail, 7);
   	       		}
   	   		});
	   	    
	   	 	$("#inputEmail").keyup(function(){ 
	   	        if($("#autoLogin").is(":checked")) {
	   	            var userEmail = $("#inputEmail").val();
	   	            setCookie("userEmail", userEmail, 7);
	       		}
	   		});
	   	 	
	   	 	$("#inputPwd").keyup(function(){ 
	   	        if($("#autoLogin").is(":checked")) {	   	        	
	   	            var userPassword = $("#inputPwd").val();
	   	            setCookie("userPassword", userPassword, 7);
	       		}
	   		});
   		  
   	  });
   	  
   	  
	   	function setCookie(cookieName, value, exdays){
	   	    var exdate = new Date();
	   	    exdate.setDate(exdate.getDate() + exdays);
	   	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	   	    document.cookie = cookieName + "=" + cookieValue;
	   	}
	   	 
	   	function deleteCookie(cookieName){
	   	    var expireDate = new Date();
	   	    expireDate.setDate(expireDate.getDate() - 1);
	   	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	   	}
	   	 
	   	function getCookie(cookieName) {
	   	    cookieName = cookieName + '=';
	   	    var cookieData = document.cookie;
	   	    var start = cookieData.indexOf(cookieName);
	   	    var cookieValue = '';
	   	    if(start != -1){
	   	        start += cookieName.length;
	   	        var end = cookieData.indexOf(';', start);
	   	        if(end == -1)end = cookieData.length;
	   	        cookieValue = cookieData.substring(start, end);
	   	    }
	   	    return unescape(cookieValue);
	   	}
   	  
   	  
   	  
      $("#login").click(function() {
         var frm = document.getElementById("frm");

         frm.email.value = $("#inputEmail").val();
         frm.password.value = $("#inputPassword").val();

         
         
         frm.submit();         
      });

     <%--  $("#join").click(function() {
    	  
    	  alert("들어옵니다!join클릭!");
         location.href = "<%=request.getContextPath()%>/join.jsp";
      }); --%>

      function facebookLogin(name, email) {
         
         var frm = document.getElementById("facebookfrm");
         frm.Fname.value = name;
         frm.Femail.value = email;
         $('#noFace').attr("value","noFace");
         

         frm.submit();
      }
   </script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>