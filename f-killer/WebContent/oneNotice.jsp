<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:if test="${ page !='mainOfMain' }">	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
	<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
</c:if>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
.team-menu-table th, .team-menu-table td{
	padding:15px 0;
}
	.wrapper{
		/* width:480px; */
		width:90%;
		margin:15px auto;
	}
	.notice-box-outer{
		width:100%; 
		margin:auto;  
		text-align: center; 
		padding:15% 0 ;
	}
/* 	.notice-box-inner{
		width:50%; 
		margin:auto; 
		text-align: cneter; 
		border:solid 7px white; 
		border-radius:20px; 
		background-color:#F9DCDC; 
		box-shadow: 2px 2px 1px #888888;
	} */
	.notice-text{
		color:#000033;
	}
	.notice-icon{
		color:#000066; 
		margin-bottom:40px
	}
	.navbar {
		margin-bottom: 0;
		margin-top: 0;
		border-radius: 0;
		margin-bottom: 0px;
		margin-top: 0px;
		border-radius: 0px;
	}
</style>

</head>
<body>
	<input type="hidden" value="${notice.noticeNo }" id="noticeNo" />
	<div class="wrapper">
		<c:choose>
			<c:when test="${where == 'view' }">
				<label style="font-size:25px;margin-top : 30px;text-align : center;"><strong>${notice.noticeTitle }</strong></label>
				<HR style="width : 90%;">
				<label style="font-size:20px;"><strong>날짜</strong> &nbsp;&nbsp;&nbsp;<font style="font-size : 17px;">${notice.updDate }</font></label>	<BR><BR>			
				
				<legend style="width : 90%;"><strong>내용</strong></legend> <label style="font-size:17px;">${notice.noticeDesc }</label>
			</c:when>
			<c:when test="${where == 'manage' }">
				<label style="font-size:20px;margin-top : 30px; margin-bottom : 10px; display : inline-block;"><strong>제목</strong></label>
					&nbsp;&nbsp;&nbsp;<input type="text" style="width:85%" id = "title" value="${notice.noticeTitle }"/><BR><BR>
				<label style="font-size:20px;"><strong>날짜 &nbsp;&nbsp;&nbsp;</strong><font style="font-size : 17px;">${notice.updDate }</font></label>	<BR>
				
				<legend style="font-size : 20px;"><strong>내용</strong></legend>
					<textarea id="desc" rows="15" style="width : 97%;">${notice.noticeDesc }</textarea><BR>
				<br>
				<div style="text-align : center;">				
					<button class="btn btn-defualt" style="width:20%; margin-right:50px; background:#FF0087; color:white" onclick="noticeModify()">수정</button>
					<button class="btn btn-defualt" style="width:20%; background:white" onclick="noticeDelete()">삭제</button>
				</div>
			</c:when>
			<c:when test="${where == 'default' }">
				<div class="notice-box-outer">
					<div class="notice-box-inner">
						<h3 class="notice-text">공지를 선택하세요.</h3><br>
						<i class="fa fa-bullhorn fa-5x notice-icon"></i>
					</div>
				</div>
			</c:when>	
		</c:choose>
	</div>			

	<script>
		function noticeDelete(){
			$.ajax({
				type: "get",
				url: "<%=request.getContextPath()%>/NoticeController.do",
				datatype: "json",	
				data: {
					"cmd" : "delete_notice",			
					"noticeNo" : "${notice.noticeNo }"
				}, 	
				success: function(response){		
					if(response=="1"){
						alert("삭제 되었습니다.");
						$('#frm',parent.document).submit();
					}else{
						alert("삭제가 실패 되었습니다.");				
					}
				},
				error: function(x,o,e){
					var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
					alert(msg);
				}
			});
		}
		function noticeModify(){
			$.ajax({
				type: "post",
				url: "<%=request.getContextPath()%>/NoticeController.do",
				datatype : "json",
				data : {
					"cmd" : "update_notice",
					"noticeNo" : "${notice.noticeNo }",
					"title" : $('#title').val(),
					"desc" : $('#desc').val()
				},
				success : function(response) {
					if (response == "1") {
						alert("수정 되었습니다.");
						$('#frm', parent.document).submit();
					} else {
						alert("수정이 실패 되었습니다.");
					}
				},
				error : function(x, o, e) {
					var msg = "페이지 호출 에러: " + x.status + "," + o + "," + e; //500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
					alert(msg);
				}
			});
		}
	</script>
</body>
</html>