<%@page import="com.fkiller.web.contants.JobState"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
 <!-- <script src="js/jquery-1.11.3.js"></script>  -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>

<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/favicon.ico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">


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
	margin-left:15px;
}
.contents1{
	height:700px; position:relative; overflow-y:scroll; overflow-x:hidden;
	background-color:white; /* margin:10px 0 0 15px; */ border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;
	margin-top:10px;
}
.contents2{
	width:100%; height:700px; border:none; margin:10px; border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;
}
.container-wrapper{
	background-color:#F4F2F2;
}
.sidenav{
	width:100%;
}
.progress-striped .jsTO_DO{
    background-color: #E2E840;
}
.progress-striped .jsIN_PROGRESS{
	background-color: #F89406;
	width : 50%;
}
.progress-striped .jsPERMISSION{
	background-color: #062BF8;
	width : 80%;
}
.progress-striped .jsDONE{
	background-color: #08B900;
	width : 100%;
}
.progress-striped .jsEXPIRED{
	background-color: #E24141;
	width : 100%;
}
.progress{
	margin-bottom:0px;
}

.modal-body {
    /*max-height: 80vh; //Sets the height to 80/100ths of the viewport. 
    max-width: 80vh;*/
    max-width: 80vh;
    max-height: 70vh;
}
</style>
</head>
<body>
	<div id="layerpop" style="top: 100%;" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			 <h3>&nbsp; </h3>			
		</div>
		<div class="modal-body" id="layerpop-modal-body"></div>		
		<div class="modal-footer">
			<div style="text-align: center">
				<button type="button" id="modalOKBtn" class="btn btn-primary" style="margin-bottom: 3px" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
		
 	 
 	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid container-wrapper">
		<div class="row-fluid">
			<div class="span2 sidenav">
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10 row-fluid outer">
			<div class="span6 contents1">
				<div style="position:absolute; left:0; top:0; padding:10px 15px; width:95%">
					<div>
						<h4 style="color: #F1075C">업무리스트</h4>
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width:15%; text-align : center;">중요도</th>
										<th style="width:30%; text-align : center;">업무명</th>
										<th style="width:15%; text-align : center;">담당자</th>
										<th style="width:20%; text-align : center;">작업상태 
											<i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom"></i>
										</th>
										<th style="width:20%; text-align : center;">마감기한</th>
									</tr>
								</thead>
								<tbody>
								<c:choose>
									<c:when test="${job_list!=null and fn:length(job_list) > 0 }">
										<c:forEach items="${job_list }" var="entity">
											<tr id="${entity.jobNo }">
												<c:if test="${entity.prop ==1}">
													<td style="text-align : center;">상</td>
												</c:if>
												<c:if test="${entity.prop ==2}">
													<td style="text-align : center;">중</td>
												</c:if>
												<c:if test="${entity.prop ==3}">
													<td style="text-align : center;">하</td>
												</c:if>

												<td style="font-size:16px; text-align : center;"><a onclick="showJobModal(${entity.jobNo} ,'${entity.userName }')"
													href="#layerpop" data-toggle="modal" style="color:black; text-decoration: none">${entity.jobTitle }</a></td>
												
																														
												<td style="text-align : center;">${entity.userName }</td>
												<c:if test="${entity.jobState =='TO_DO' }">
													<td class="text-center" style="color: yellow">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 20%;"></div>
														</div>
													</td>
												</c:if>
												<c:if test="${entity.jobState == 'IN_PROGRESS' }">
													<td class="text-center" style="color: green">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 50%;"></div>
														</div>
														</td>
												</c:if>
												<c:if test="${entity.jobState == 'PERMISSION' }">
													<td class="text-center" style="color: orange">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 80%;"></div>
														</div>
														</td>
												</c:if>
												<c:if test="${entity.jobState == 'DONE' }">
													<td class="text-center" style="color: blue">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
														</div>
														</td>
												</c:if>
												<c:if test="${entity.jobState == 'EXPIRED' }">
													<td class="text-center" style="color: red">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
														</div>
														</td>
												</c:if>
												
												<td style="text-align : center;">${entity.dueDate }</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">업무 목록이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
								</tbody>
							</table>
						</div>
					</div>
			</div>
			<div class="span6 contents2"  style="margin-left:15px; margin-right:0px; background-color:white">
				<div style="padding:10px 15px;">
					<h4 style="color: #F1075C">공지사항</h4>
						<table class="table table-bordered">
							<thead>
								<tr class="info">
									<th style="color: #F1075C">공지</th>
								</tr>							
							</thead>
							
							<c:forEach var="notice" items="${notice_list }">
								<tr><td><a onclick="showModal(${notice.noticeNo })" href="#layerpop" data-toggle="modal" style="color:black; text-decoration: none">&nbsp;&nbsp;&nbsp;${notice.noticeTitle }</a></td><tr>										
							</c:forEach>	
						</table>
						<table class="table table-bordered">
							<tr><th class="info" style="color: #F1075C">회의</th></tr>
							<c:forEach var="meeting" items="${meeting_list }">
								<tr><td><a onclick="showMeetingModal(${meeting.meetingNo })" href="#layerpop" data-toggle="modal" style="color:black; text-decoration: none">&nbsp;&nbsp;&nbsp;${meeting.meetingTitle }</a></td></tr>											
							</c:forEach>
						</table>
						
						
						
						<%-- <div class="accordion" id="accordion2">
							<div class="accordion-group">
								<div class="accordion-heading">
									<a class="accordion-toggle" data-toggle="collapse"
										data-parent="#accordion2" href="#collapseOne"> 공지 </a>
								</div>
								<div id="collapseOne" class="accordion-body collapse in">
									<div class="accordion-inner">
										<c:forEach var="notice" items="${notice_list }">

											<a onclick="showModal(${notice.noticeNo })" href="#layerpop"
												data-toggle="modal">${notice.noticeTitle }</a>
											<BR>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-group">
								<div class="accordion-heading">
									<a class="accordion-toggle" data-toggle="collapse"
										data-parent="#accordion2" href="#collapseTwo"> 회의 </a>
								</div>
								<div id="collapseTwo" class="accordion-body collapse">
									<div class="accordion-inner">
										<c:forEach var="meeting" items="${meeting_list }">
											<a onclick="showMeetingModal(${meeting.meetingNo })"
												href="#layerpop" data-toggle="modal">${meeting.meetingTitle }</a>
											<BR>
										</c:forEach>
									</div>
								</div>
							</div>
						</div> --%>
					</div>
			</div>
		</div>
	</div>
	</div>
	<script src="js/bootstrap.min.js"></script>
	<script>
	function sendAlarm(userNo){
		webSocket.send(userNo);
	}
		$(document).ready(function() {
			$('[data-toggle="tooltip"]').tooltip({
				title : "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강",
				html : true,
				placement : 'bottom'
			});			
		});
	
		
		//권한도 전달인자로 넘겨 수정할 페이지를 띄울지 보기만하는 페이지 띄울지 
		function showJobModal(no, job_userName){
			var auth;
			if('${team.leaderName}'=='${user.userName}'){
				auth="leader";
 			}
 			else if (job_userName=='${user.userName}'){
 				auth="oneself";
 			} else {
 				auth="member";
 			}
			
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/JobController.do?cmd=one_job&where=mainOfMain&job_no='+no+'&auth='+auth);			
			$('#layerpop').css("top","5%");		
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null)
				$('#layerpop').css("top","100%");
			});
		}
		function showModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&page=view&no='+no+'&where=mainOfMain');
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null)
				$('#layerpop').css("top","100%");
			});
		}
		function showMeetingModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/MeetingController.do?cmd=one_meeting&meeting_no='+no);
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null);
				$('#layerpop').css("top","100%");
			});
		}
		
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new daum.maps.InfoWindow({zIndex:1});
		
		var savedLoc='${meeting.meetingLoc}';	
		
		//회의가 이미 등록되어 있을 때 등록된 회의 장소를 표시하기 위한 마커
		var startmarker=null;
		var startinfowindow=null;
		//주소 검색을 위한 객체
		var geocoder=new daum.maps.services.Geocoder();
		if(savedLoc!=null){
			geocoder.addr2coord(savedLoc, function(status, result) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === daum.maps.services.Status.OK) {
			        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
					map.setCenter(coords);
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        startmarker = new daum.maps.Marker({
			            map: map,
			            position: coords
			        });
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        startinfowindow = new daum.maps.InfoWindow({
			            content: '<div style="padding:5px;">'+result.addr[0].title+'</div>'
			        });
			        startinfowindow.open(map, startmarker);
				}
			});
		}
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		    mapOption = {
		        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		        
		    };  
		
		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption); 
		
		var oldMarker=null;
		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
			if(startmarker!=null){
				startmarker.setMap(null);
				startinfowindow.close();
			}
		}		
		</script>		
</body>
</html>