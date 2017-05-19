<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/favicon.ico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">

<!-- <script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script> -->
<style>
.navbar {
      margin-bottom: 0;
      margin-top: 0;
      border-radius: 0;
    }
#submit {
	width : 370px;
	margin-left : 130px;
	border :0;
	outline:0;
}
#timetable{
	background: white;
	font-size : 40px;
	width:60px;
	height:60px;	
	border :0;
	outline:0;
}
#divTitle{
	text-align : center;
}
.info{
	width : 350px;
	background:black;
}
#layerpop{
	width:50%;
	margin-left: -25%;
}
.modal .modal-body {
    max-height: 80%;
}

</style>
</head>
<body style="background-color:#E7E7E7">
	<c:set var="isTimeTable" value="false"/>
	<div class="modal fade" id="layerpop" style="top: 100%;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">시간표 등록</h4>
				</div>
				<!-- body -->
				<div class="modal-body" id="layerpop-modal-body"></div>
				<!-- Footer -->
				<div class="modal-footer">
					<div style="text-align: center">
						<button type="button" id="modalOKBtn" class="btn btn-primary"
							style="margin-bottom: 3px">확인</button>
						<button type="button" id="modalNGBtn" class="btn btn-default"
							style="margin: 0 0 3px 30px">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<nav class="navbar">
		<jsp:include page="logoMenu.jsp" />
	</nav>
	
	<div class="row fluid" style="margin-top: 100px; width: 730px; margin:10% auto; padding:5%; background-color:white; border-radius:10px; box-shadow: 3px 3px 2px #888888;">
		<div style="width: 600px; margin: auto">
			<form class="form-horizontal" role="form" method="post"
				action="<%=request.getContextPath()%>/UserController.do" id="form">
				<%System.out.println(request.getContextPath());%>
				<div class="control-group" id="divTitle">
					<h2>회원가입&nbsp;&nbsp;&nbsp;</h2>
				</div>
				<div class="control-group" id="divName">
					<label for="inputName" class="col-lg-2 control-label">이&nbsp;&nbsp;&nbsp;&nbsp;름&nbsp;&nbsp;&nbsp;</label>
					<div class="col-lg-12">
						<input type="text" class="form-control info" id="name" name="name"
							data-rule-required="true" placeholder="이름을 입력해주세요" maxlength="15">
					</div>
				</div>
				<div class="control-group" id=divEmail">
					<label for="inputEmail" class="form-control control-label">이&nbsp;메&nbsp;일&nbsp;&nbsp;&nbsp;</label>
					<div class="col-lg-12">
						<input type="text" class="form-control" name="email_id"
							id="email_id" data-rule-required="true" style="width: 15%;"
							placeholder="아이디" maxlength="40">&nbsp;@&nbsp; <input
							type="text" class="form-control" name="email_addr"
							id="email_addr" style="width: 15%;" disabled value="naver.com">
						<select class="form-control" name="selectEmail" id="selectEmail"
							style="width: 120px;">
							<option value="1">직접입력</option>
							<option value="naver.com" selected>naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</div>
				</div>

				<div class="control-group" id="divPassword">
					<label for="inputPassword" class="col-lg-2 control-label">패스워드&nbsp;&nbsp;&nbsp;</label>
					<div class="col-lg-12">
						<input type="password" class="form-control info" id="password"
							name="password" data-rule-required="true"
							placeholder="비밀번호를 입력해 주세요" maxlength="30">
					</div>
				</div>
				<div class="control-group" id="divPasswordCheck">
					<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드
						확인&nbsp;&nbsp;&nbsp;</label>
					<div class="col-lg-12">
						<input type="password" class="form-control info"
							id="passwordCheck" data-rule-required="true"
							placeholder="패스워드 확인" maxlength="30">
					</div>
				</div>
				<div class="control-group" id="divTimetable">
					<label for="inputTimetable" class="col-lg-2 control-label"
						style="padding-top: 10px;">시&nbsp;간&nbsp;표&nbsp;&nbsp;&nbsp;</label>
					<div class="col-lg-12" id="img_container">
						<a class="button" href='#timeTableModal' id="timetable"
							onclick="showModal()"><i class="fa fa-table"></i></a> <span id ="isReg">미등록</span>
					</div>
				</div>

				<div class="control-group">
					<div class="col-lg-offset-2 col-lg-10">
						<button type="submit" class="btn btn-default" id="submit">회원
							가입 하기</button>
					</div>
				</div>
				<input type="hidden" name="cmd" value="join"> 
				<input type="hidden" name="email_address" value="" id="email_address">
				<input type="hidden" name="isTimeTable" value="false" id="timeTable">
				<input type="hidden" name="sun" value="" id ="sun">
				<input type="hidden" name="mon" value="" id ="mon">
				<input type="hidden" name="tue" value="" id ="tue">
				<input type="hidden" name="wen" value="" id ="wen">
				<input type="hidden" name="thu" value="" id ="thu">
				<input type="hidden" name="fri" value="" id ="fri">
				<input type="hidden" name="sat" value="" id ="sat">
				
			</form>
		</div>
	</div>

	<script>
		function showModal(){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/timeTable.jsp');
			$('#layerpop').css("top","5%").modal();
			$('#modalOKBtn').click(function(){	
				
				
				setTimeTable();
				$('#timeTable').val("true");	
				$('#isReg').html("등록완료");
				$('#layerpop').css("top","100%").modal('hide');				
			});
			$('#modalNGBtn').click(function(){
				$('#layerpop-modal-body').load(null);
				$('#layerpop').css("top","100%").modal('hide');
			});
		}
		
		
            $(function(){
               
                var modalContents = $(".modal-contents");
                var modal = $("#defaultModal");
              
                              
                $('#selectEmail').change(function(){
                	   $("#selectEmail option:selected").each(function () {
                	        
               	        if($(this).val()== '1'){ 
               	             $("#email_addr").val('');                       
               	             $("#email_addr").attr("disabled",false); 
               	        }else{ 
               	             $("#email_addr").val($(this).text());      
               	             $("#email_addr").attr("disabled",true); 
               	        }
               	   });
               	});
                 
              
                $( "#form" ).submit(function( event ) {
                             
                    if($('#name').val()==""){
                        modalContents.text("이름을 입력하여 주시기 바랍니다.");
                                 
                        $('#name').focus();
                        return false;
                    }                                   
                   
                    if($('#email_id').val()==""){
                        alert("이메일은 필수 항목입니다!");
                      
                        $('#email_id').focus();
                        return false;
                    }
                    
                    if($('#password').val().length < 8){
                    	alert("비밀번호는 8자리 이상 이여야 합니다.");
                       
                        $('#password').focus();
                        return false;
                    }  
                    
                    if($('#password').val()==""){
                    	alert("패스워드를 입력하여 주시기 바랍니다.");
                        
                        $('#password').focus();
                        return false;
                    }           
                   
                    if($('#passwordCheck').val()==""){
                    	alert("패스워드 확인을 입력하여 주시기 바랍니다.");
                       
                        $('#passwordCheck').focus();
                        return false;
                    }
                    
                    if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                    	alert("패스워드가 일치하지 않습니다.");
                                         
                        $('#passwordCheck').focus();
                        return false;
                    }
                    
                    
                    if($('#isReg').text() == '미등록'){
                    	
                    	alert("시간표를 등록해 주세요!");
                    	
                    	$('#isReg').focus();
                    	return false;
                    }
                    	
                   	
                    var frm = document.getElementById("form");
                    
                    $("#email_address").val(frm.email_addr.value);
                });
                 
            });
             
        </script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>