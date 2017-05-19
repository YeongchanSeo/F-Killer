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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
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
		width:480px;
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
				제목 : ${notice.noticeTitle }
				날짜 : ${notice.updDate }
				내용 : ${notice.noticeDesc }
			</c:when>
			<c:when test="${where == 'default' }">
				<div class="notice-box-outer">
					<div class="notice-box-inner">
						<h3 class="notice-text">검색하신 단어는</h3><br>
						<i class="fa fa-search fa-5x notice-icon"></i><br/>
						 <h3 class="notice-text">"${search_text }"</h3><br/><h3 class="notice-text">입니다.</h3>
					</div>
				</div>
			</c:when>	
		</c:choose>
	</div>			
</body>
</html>