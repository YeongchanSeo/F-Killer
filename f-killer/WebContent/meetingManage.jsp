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
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>

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
		height: auto;
		padding: 15px;
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
				<div class="span6 contents1">
					<div class="contents1-inner">
						<div class="row-fluid" style="margin:20px 0;">
							<font style="color:#F1075C; margin: 10px 0; font-family: inherit; font-weight: bold; line-height: 20px; font-size: 17.5px; text-rendering: optimizelegibility;">회의 리스트</font> 
							<button type="button" id="modalBtn" class="btn btn-default" style="margin-right:10px; background:#FF0087; color:white; float:right" onclick="showModal()">회의만들기</button>
						</div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 10%">No</th>
									<th style="width: 60%">제목</th>
									<th >날짜</th>
									<th style="text-align: center; width:10%">분류 </th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								 <c:when test="${meeting_list!=null and fn:length(meeting_list)>0}">
									         <c:forEach items="${meeting_list }" var="entity" varStatus="status">
											   <tr>
											      <td style="">${status.index+1}</td>
											      <td style="font-size:16px"><a target='iframe' href='<%=request.getContextPath()%>/MeetingController.do?cmd=update_meeting&meeting_no=${entity.meetingNo}'  style="color:black; text-decoration: none;">${entity.meetingTitle }</a></td>
											      <td>${entity.meetingDate }</td>
											      <td style="text-align: center">
												      <c:choose>
													      <c:when test='${entity.state==true}'>
													      	완료
													      </c:when>
													      <c:otherwise>
													      	예정
													      </c:otherwise>
												      </c:choose>
											      </td>
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
					<iframe class="contents2" src="<%=request.getContextPath()%>/updateMeeting.jsp" name="iframe"></iframe>
				</div>
			</div>
		</div>
	</div>
	<form id="refreshFrm" action="<%=request.getContextPath()%>/MeetingController.do" method="get">
		<input type="hidden" name="type" value="leader">
	</form>
<!-- 	<footer class="container-fluid text-center">
		<p>Footer Text</p>
	</footer> -->
	<div class="modal fade" id="layerpop" style="top:100%;">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <!-- 닫기(x) 버튼 -->
	        <button type="button" class="close" data-dismiss="modal">×</button>
	        <!-- header title -->
	        <h4 class="modal-title">회의 생성</h4>
	      </div>
	      <!-- body -->
	      <div class="modal-body" id="layerpop-modal-body" style="max-height: 500px;">
	      </div>
	      <!-- Footer -->
	      <div class="modal-footer">
	      	<div style="text-align: center">
		        <button type="button" id="modalOKBtn" class="btn btn-primary" style="margin-bottom:3px">확인</button>
		        <button type="button" id="modalNGBtn" class="btn btn-default" style="margin:0 0 3px 30px">취소</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	$(document).ready(function(){
		showSubMenu();
		$('#manageMeeting').addClass('selectedMenu-tr');
		$('#manageMeeting').find('td').find('a').addClass('selectedMenu-a');
	});
	$('#modalOKBtn').click(function(){
		var result=getLocation();
		if(result == true){
			$('#layerpop').css("top","100%").modal('hide');
		}
	});
		function showModal(){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/MeetingController.do?cmd=add_meeting');
			$('#layerpop').css("top","5%").modal();
			
			$('#modalNGBtn').click(function(){
				$('#layerpop-modal-body').load(null);
				$('#layerpop').css("top","100%").modal('hide');
			});
		}
		
	</script>	
	<script src="js/bootstrap.min.js"></script>
</body>
</html>