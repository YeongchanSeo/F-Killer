<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="js/jquery-1.11.3.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<title>FKILLER (Team Cooperation Project Program)</title>

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/favicon.ico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">

<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	margin-top: 0;
	border-radius: 0;
}
#header1{
	/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#63b6db+0,309dcf+66 */
background: #63b6db; /* Old browsers */
background: -moz-linear-gradient(left,  #63b6db 0%, #309dcf 66%); /* FF3.6-15 */
background: -webkit-linear-gradient(left,  #63b6db 0%,#309dcf 66%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to right,  #63b6db 0%,#309dcf 66%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#63b6db', endColorstr='#309dcf',GradientType=1 ); /* IE6-9 */
	
}
#header{
	background:#5EF0F2;
}
</style>
</head>
<body>
	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<!-- 팀모달 -->
	<div id="modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" >
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					
				</div>
				<div class="modal-body">
				
				</div>
				<div class="modal-footer">
					 <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 유저모달 -->
	<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
				
				</div>
				<div class="modal-footer">
					<!-- <button class="btn" data-dismiss="modal" aria-hidden="true">확인</button>
					<button class="btn btn-primary">팀으로</button> -->
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="tabbable">
			<!-- 왼쪽과 오른쪽 탭에만 필요 -->
			<ul class="nav nav-tabs">
				<li class="active"><a href="#teamTab" data-toggle="tab" onclick="teamList()">팀관리</a></li>
				<li><a href="#userTab" data-toggle="tab" onclick="userList()">회원관리</a></li>
				<li><a href="#fileTab" data-toggle="tab" onclick="fileList()">파일관리</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="teamTab">
					<table class="table table-hover">					
						<thead>
							<tr id = "header">
								<th>팀번호</th>
								<th>팀이름</th>
								<th>프로젝트기간</th>
								<th>운영</th>
							</tr>
						</thead>					
						<tbody id="team_table_body">
							
						</tbody>
					</table>
				</div>
				<div class="tab-pane" id="userTab">
					<table class="table table-hover">					
							<thead>
								<tr id = "header">
									<th>회원번호</th>
									<th>회원이름</th>
									<th>이메일</th>
									<th>가입방법</th>
									<th>가입일</th>
								</tr>
							</thead>
					
						<tbody id="user_table_body">
							
						</tbody>
					</table>
				</div>			
				<div class="tab-pane" id="fileTab">
						<table class="table table-hover" id="table">					
							<thead>
								<tr id = "header">
									<th>파일번호</th>
									<th>파일명</th>
									<th>팀명</th>
									<th>파일크기</th>
									<th>업로드날짜</th>
									<th></th>									
								</tr>
							</thead>					
						<tbody id="file_table_body">
							
						</tbody>
					</table>
					<form action="<%=request.getContextPath() %>/ManageController.do" method="post" id="frm">
						<input type="hidden" name="cmd" value="download"/>
						<input type="hidden" id="file_name" name="file_name" value=""/>
						<input type="hidden" id="team_no" name="team_no" value=""/>
					</form>
				</div><!-- fileTab -->
			</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function(){
			teamList();
		});
	
		function teamList(){
			$.ajax({
        		url : "<%=request.getContextPath()%>/ManageController.do",	        	
        		type : 'post',  
        		dataType : 'json',      	       
        		data : {
        			"cmd":"team_list",
        		}, 
        		success : function(response){
        			var list = new Array();
        			var data = response;
        			$('#team_table_body').empty();
        			if(data==null){
        				$('#team_table_body').append(" <tr><td colspan='3'>아무것도 없어용</td></tr>");
        			}else{
        				
        				$.each(data,function(i,value){
        					list.push(value.team_no);
        					list.push(value.team_name);
        					list.push(value.start_date+"~"+value.end_date);
        					list.push(value.oper);
        				});
        				for(var i=0;i<list.length;i++){
        					console.log(list[i]+"/");
        				}
        				
        				length = list.length/4;
        				body = document.getElementById("team_table_body");
        				
        				var row;
        				for(var i=0;i<list.length;i+=4){
        					row = body.insertRow();
        					row.onmouseover = function(){
        						body.clickedRowIndex = this.rowIndex;
        					};
        					
        					var cell1 = row.insertCell(0);
        					var cell2 = row.insertCell(1);
        					var cell3 = row.insertCell(2);
        					var cell4 = row.insertCell(3);
        					
        					cell1.innerHTML = "<label  onclick=one_team("+list[i]+")>"+list[i]+"</label>";
        					cell2.innerHTML = "<label  onclick=one_team("+list[i]+")>"+list[i+1]+"</label>";
        					cell3.innerHTML = "<label  onclick=one_team("+list[i]+")>"+list[i+2]+"</label>";
        					cell4.innerHTML = "<label  onclick=one_team("+list[i]+")>"+list[i+3]+"</label>";
        					
        				}
        				
        			}  
        		},
        		error : function(x,o,e){
    				var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
    				alert(msg);
    			}
        	});
		}
		function userList(){
			$.ajax({
        		url : "<%=request.getContextPath()%>/ManageController.do",	        	
        		type : 'post',  
        		dataType : 'json',      	       
        		data : {
        			"cmd"    : "user_list",
        		}, 
        		success : function(response){
        			var list = new Array();
        			var data = response;
        			$('#user_table_body').empty();
        			if(data==null){
        				$('#user_table_body').append(" <tr><td colspan='3'>아무것도 없어용</td></tr>");
        			}else{
        				
        				$.each(data,function(i,value){
        					list.push(value.user_no);
        					list.push(value.user_name);
        					list.push(value.user_email);
        					list.push(value.join_method);
        					list.push(value.reg_date);
        				});
        				for(var i=0;i<list.length;i++){
        					console.log(list[i]+"/");
        				}
        				
        				length = list.length/5;
        				body = document.getElementById("user_table_body");
        				
        				var row;
        				for(var i=0;i<list.length;i+=5){
        					row = body.insertRow();
        					row.onmouseover = function(){
        						body.clickedRowIndex = this.rowIndex;
        					};
        					
        					var cell1 = row.insertCell(0);
        					var cell2 = row.insertCell(1);
        					var cell3 = row.insertCell(2);
        					var cell4 = row.insertCell(3);
        					var cell5 = row.insertCell(4);
        					
        					cell1.innerHTML = "<label  onclick=one_user("+list[i]+")>"+list[i]+"</label>";
        					cell2.innerHTML = "<label  onclick=one_user("+list[i]+")>"+list[i+1]+"</label>";
        					cell3.innerHTML = "<label  onclick=one_user("+list[i]+")>"+list[i+2]+"</label>";
        					cell4.innerHTML = "<label  onclick=one_user("+list[i]+")>"+list[i+3]+"</label>";
        					cell5.innerHTML = "<label  onclick=one_user("+list[i]+")>"+list[i+4]+"</label>";
        					
        				}
        				
        			}
        		},
        		error : function(x,o,e){
    				var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
    				alert(msg);
    			}
        	});
		}
		function fileList(){
			$.ajax({
        		url : "<%=request.getContextPath()%>/ManageController.do",	        	
        		type : 'post',  
        		dataType : 'json',      	       
        		data : {
        			"cmd"    : "file_list",
        		}, 
        		success : function(response){
        			var list = new Array();
        			var data = response;
        			$('#file_table_body').empty();
        			if(data==null){
        				$('#file_table_body').append(" <tr><td colspan='3'>아무것도 없어용</td></tr>");
        			}else{
        				
        				$.each(data,function(i,value){
        					list.push(value.file_no);
        					list.push(value.file_name);
        					list.push(value.team_no);
        					list.push(value.team_name);
        					list.push(value.file_size);
        					list.push(value.reg_date);
        				});
        				for(var i=0;i<list.length;i++){
        					console.log(list[i]+"/");
        				}
        				
        				length = list.length/5;
        				body = document.getElementById("file_table_body");
        				
        				var row;
        				for(var i=0;i<list.length;i+=6){
        					row = body.insertRow();
        					row.onmouseover = function(){
        						body.clickedRowIndex = this.rowIndex;
        					};
        					
        					var cell1 = row.insertCell(0);
        					var cell2 = row.insertCell(1);
        					var cell3 = row.insertCell(2);
        					var cell4 = row.insertCell(3);
        					var cell5 = row.insertCell(4);
        					var cell6 = row.insertCell(5);
        					
        					cell1.innerHTML = "<label  onclick=one_file('"+list[i+1]+"',"+list[i+2]+")>"+list[i]+"</label>";
        					cell2.innerHTML = "<label  onclick=one_file('"+list[i+1]+"',"+list[i+2]+")>"+list[i+1]+"</label>";
        					cell3.innerHTML = "<label  onclick=one_file('"+list[i+1]+"',"+list[i+2]+")>"+list[i+3]+"</label>";
        					cell4.innerHTML = "<label  onclick=one_file('"+list[i+1]+"',"+list[i+2]+")>"+list[i+4]+"</label>";
        					cell5.innerHTML = "<label  onclick=one_file('"+list[i+1]+"',"+list[i+2]+")>"+list[i+5]+"</label>";
        					cell6.innerHTML = "<input type='hidden' name='cmd' value='download'/>"
        					
        				}
        				
        			}
        		},
        		error : function(x,o,e){
    				var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
    				alert(msg);
    			}
        	});
		}
	
		$('.fa').click(function(){	
			var delPlace = document.all.table; // 삭제될테이블장소
			var fileIdx = delPlace.rows[delPlace.clickedRowIndex].cells[0].textContent; 
			delPlace.deleteRow(delPlace.clickedRowIndex);
			//db에서도 제거(팀번호(PK)필요한디...)
		});
		$('tr').click(function() {
			var id = $(this).attr('id');
			if (id == 'header') {
				return;
			} 
		});
		
		function one_team(team_no){
			$('.modal-header').text("${team.team_name}");
			$('#modal').load("ManageController.do?cmd=one_team&team_no="+team_no);
			$('#modal').modal();
		}
		
		function one_user(user_no){
			$('#modal').load("ManageController.do?cmd=one_user&user_no="+user_no);
			$('#modal').modal();
		}
		
		function one_file(file_name,team_no){
			var frm = $('#frm');
			$('#file_name').val(file_name);
			$('#team_no').val(team_no);
			frm.submit();
		}
	</script>
	<script src="js/bootstrap.min.js"></script>	
	<div id="fullCalModal" class="modal fade" style="top:5%; left : 50%; width : 40%; height:700px; z-index:0;">
    <div class="modal-dialog" style="height : 700px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                	<span aria-hidden="true">×</span><span class="sr-only">close</span>
                </button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body" style="max-height : 600px; width : 95%"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>