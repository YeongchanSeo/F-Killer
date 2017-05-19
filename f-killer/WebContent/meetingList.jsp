<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

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
	margin-bottom: 0px;
	margin-top: 0px;
	border-radius: 0px;
}

/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
.row.content {
	height: 500px
}

/* Set gray background color and 100% height */
.sidenav {
	padding-top: 20px;
	height: 100%;
}

/* Set black background color, white text and some padding */
footer {
	height: 15px;
	background-color: #555;
	color: white;
	padding: 15px;
}

/* On small screens, set height to 'auto' for sidenav and grid */
@media screen and (max-width: 767px) {
	.sidenav {
		height: 700px;
		padding: 15px;
		background-color : black;
	}
	.row.content {
		height: auto;
	}
}
.outer{
	border-left:1px double lightgray;
	padding-left:20px;
	margin-left:0px;
}
.span6{
	margin-left:15px
}
.contents1{
	height:700px; position:relative; overflow-y:scroll; overflow-x:hidden;
	background-color:white; /* margin:10px 0 0 15px; */ border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;
	margin-top:10px
}
.contents2{
	width:100%; height:700px; border:none; margin:10px; 
	border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;
}
.container-wrapper{
	background-color:#F4F2F2;
}
.sidenav{
	width:100%
}
.contents1-inner{
	position:absolute; left:0; top:0; width:95%; padding:10px 15px;
}
</style>
</head>
<body>
	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid container-wrapper">
		<div class="row-fluid">
			<div class="span2 sidenav">
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10 row-fluid outer">
			<div class="span6 contents1" id="scroll">
				<div class="contents1-inner">
					<div class="row-fluid" style="margin:10px 0;">
						<h4 style="color:#F1075C;">회의록 리스트</h4>
					</div>
					<table class="table table-hover" width="100%">
						<thead>
							<tr>
								<th style="width: 10%">No</th>
								<th style="width: 60%">제목</th>
								<th style="width: 30%">날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							 <c:when test="${meeting_list!=null and fn:length(meeting_list)>0}">
								         <c:forEach items="${meeting_list }" var="entity" varStatus="status">
										   <tr>
										      <td >${status.index+1}</td>
										      <td style="font-size:16px"><a href='#' onclick='showMeeting(${entity.meetingNo})' style="color:black; text-decoration: none;">${entity.meetingTitle }</a></td>
										      <td>${entity.meetingDate }</td>
										   </tr>
										 </c:forEach>
									 </c:when>
									 <c:otherwise>
									 	<tr>
								      		<td colspan="5">회의 목록이 없습니다.</td>
								        </tr>
									 </c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			<div class="span6" id="meetingDetail" style="height:300%;  margin-left:5px">
				<iframe class="contents2" src="<%=request.getContextPath()%>/meetingLogDetail.jsp" name="iframe"></iframe>
			</div>
			</div>
		</div>
	</div>
<!-- 	<footer class="container-fluid text-center">
		<p>Footer Text</p>
	</footer> -->
	<form id="frm" target="iframe" action="<%=request.getContextPath()%>/MeetingController.do" method="get" style="margin:0; height:0">
		<input type="hidden" value="one_meeting" name="cmd"/>
		<input type="hidden" value="" name="meeting_no" id="meetingNo"/>
		<input type="hidden" value="meeting_log" name="type"/>
	</form>
	<script>
		$(document).ready(function(){
			var detailNo = '${detailNo}';
			if(detailNo!=null  && detailNo!=""){
				showMeeting(detailNo);
			}
			$('#showMeeting').addClass('selectedMenu-tr');
			$('#showMeeting').find('th').find('a').addClass('selectedMenu-a');
		})
		function showMeeting(meeting_no){
			$('#meetingNo').val(meeting_no);
			$('#frm').submit();
		}
	</script>
	<script src="js/bootstrap.min.js"></script>
			<script type="text/javascript">
			var scroll=0;
			var height=$('#scroll').height();
			$(document).ready(function() {
			$('#scroll').scroll(function() {
			var scrollHeight = $('#scroll').scrollTop()+$('#scroll').height();
			var documentHeight = $('#scroll').prop('scrollHeight');
			if (scrollHeight >= documentHeight) {
			for(var i=0; i <20; i++, scroll++) {
			$("#"+scroll).css('display','');
			}
			}
			});
			});
			$(document).ready(function() {
			for(; scroll<20; scroll++) {
			$("#"+scroll).css('display','');
			} 
			
			});
	</script>
</body>
</html>