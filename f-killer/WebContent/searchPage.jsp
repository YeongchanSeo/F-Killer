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
<!-- <script src="js/jquery-1.11.3.js"></script> -->
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
td {
	color: #3E4142;
	vertical-align:middle;
}
   .progress-custom.progress-striped .bar, .progress-striped .bar-info {
       background-color: #EAE333; /*노랑색*/
   }
   .progress-info.progress-striped .bar, .progress-striped .bar-info {
       background-color: #3365EA; /*파랑색*/
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
}
.progress-striped .jsPERMISSION{
	background-color: #062BF8;
}
.progress-striped .jsDONE{
	background-color: #08B900;
}
.progress-striped .jsEXPIRED{
	background-color: #FF0000;
}
</style>
</head>
<body>
 	<type input="hidden" name="leader" value="${team.leaderName }" id="leader">
 	 
 	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid container-wrapper">
		<div class="row-fluid">
			<div class="span2 sidenav">
				<jsp:include page="teamMenu.jsp" />
			</div>				
			<div class="span10 row-fluid outer">
			<div class="span6 contents1" id="scroll">
				<div style="position:absolute; left:0; top:0; padding:10px 15px; width:95%" id="inner-scroll">
					<div class="contents1-inner">
					<c:set var="cnt" value="0" />
						<div class = "header" style=" margin:10px 0px;display:none;"  id="${cnt+1 }">
							<span style="color: #F1075C; ">  						
								<font style="margin: 10px 0; font-family: inherit; font-weight: bold; font-size: 17.5px;">업무 리스트</font>
							</span>
							<c:set var="cnt" value="${cnt+1 }" />
						</div>
						<table class="table table-hover" width="100%">
									<thead>
									
						<c:choose>
							<c:when test="${search_job_list!=null and fn:length(search_job_list) > 0 }">
										<tr id="${cnt+1 }" style="display:none;">
											<th>중요도</th>
											<th>업무명</th>
											<th>담당자</th>
											<th>작업상태 <i class="fa fa-question-circle"
												data-toggle="tooltip" data-placement="top"></i></th>
											<th>마감기한</th>
											<c:set var="cnt" value="${cnt+1 }" />
										</tr>
									</thead>
									<tbody id="job">
										<c:forEach items="${search_job_list }" var="entity">
											<tr id="${cnt+1 }" style="display:none;">
												<c:if test="${entity.prop ==1}">
													<td>상</td>
												</c:if>
												<c:if test="${entity.prop ==2}">
													<td>중</td>
												</c:if>
												<c:if test="${entity.prop ==3}">
													<td>하</td>
												</c:if>
												<c:set var="str1" value="${entity.jobTitle}" />
												<c:set var="str2" value="${search_text}" />
												<c:if test="${fn:contains(str1, str2)}">
												<td><a onclick="showJob(${entity.jobNo })"
													href="#layerpop-job" data-toggle="modal" style="background:#f3f3f3;">${entity.jobTitle }</a></td></c:if>
												<c:if test="${!fn:contains(str1, str2)}">
												<td><a onclick="showJob(${entity.jobNo })"
													href="#layerpop-job" data-toggle="modal">${entity.jobTitle }</a></td></c:if>
												<c:set var="str1" value="${entity.userName}" />
												<c:set var="str2" value="${search_text}" />
												<c:if test="${fn:contains(str1, str2)}">										
												<td><a style="background:#f3f3f3; text-decoration:none; color:black;"">${entity.userName }</a></td></c:if>
												<c:if test="${!fn:contains(str1, str2)}">										
												<td>${entity.userName }</td></c:if>
																										<c:if test="${entity.jobState =='TO_DO' }">
															<td class="text-center" style="color: yellow">
																<div class="progress progress-striped" style="margin-bottom:0px;">
																  <div class="bar js${entity.jobState }" style="width: 20%;"></div>
																</div>
														</c:if>
														<c:if test="${entity.jobState == 'IN_PROGRESS' }">
															<td class="text-center" style="color: green">
																<div class="progress progress-striped" style="margin-bottom:0px;">
																  <div class="bar js${entity.jobState }" style="width: 50%;"></div>
																</div>
														</c:if>
														<c:if test="${entity.jobState == 'PERMISSION' }">
															<td class="text-center" style="color: orange">
																<div class="progress progress-striped" style="margin-bottom:0px;">
																  <div class="bar js${entity.jobState }" style="width: 80%;"></div>
																</div>
														</c:if>
														<c:if test="${entity.jobState == 'DONE' }">
															<td class="text-center" style="color: blue">
																<div class="progress progress-striped" style="margin-bottom:0px;">
																  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
																</div>
														</c:if>
														<c:if test="${entity.jobState == 'EXPIRED' }">
															<td class="text-center" style="color: red">
																<div class="progress progress-striped" style="margin-bottom:0px;">
																  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
																</div>
														</c:if>
														</td>
												<td>${entity.dueDate }</td>
												<c:set var="cnt" value="${cnt+1 }" />
											</tr>
										</c:forEach>
							</c:when>
							<c:otherwise>
								<section id="${cnt+1 }" style="display:none;">검색된 업무 목록이 없습니다.</section>
								<c:set var="cnt" value="${cnt+1 }" />
							</c:otherwise>
						</c:choose>
						</tbody>
						</table>
						</div>
						<div class="contents1-inner">			
						<form id="frm" action="<%=request.getContextPath()%>/NoticeController.do" method="post">
							<input type="hidden" name="cmd" value="notice_list">
						</form>
						<div class = "header" style=" margin:10px 0px;display:none;"  id="${cnt+1 }">
							<span style="color: #F1075C; ">  						
								<font style="margin: 10px 0; font-family: inherit; font-weight: bold; font-size: 17.5px;">공지사항</font>
							</span>
							<c:set var="cnt" value="${cnt+1 }" />
						</div>
						<table class="table table-hover" width="100%">
									<thead>
						<c:choose>
							<c:when test="${search_notice_list!=null and fn:length(search_notice_list)>0 }">
										<tr id="${cnt+1 }" style="display:none;">
											<th style="width: 11%">No</th>
											<th style="width: 71%"> 제목</th>
											<th style="width: 18%">날짜</th>
										</tr>
										<c:set var="cnt" value="${cnt+1 }" />
									</thead>
									<tbody>
									<c:forEach items="${search_notice_list }" var="notice">
											<tr id="${cnt+1 }" style="display:none;">
												<td>${ notice.noticeNo}</td>
													<c:set var="str1" value="${notice.noticeTitle}" />
													<c:set var="str2" value="${search_text}" />
													<c:if test="${fn:contains(str1, str2)}">	
													<td><a target='iframe' href='<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&no=${notice.noticeNo}&page=view' style="background:#f3f3f3;">${notice.noticeTitle }</a></td>								
													</c:if>
													<c:if test="${!fn:contains(str1, str2)}">	
													<td><a target='iframe' href='<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&no=${notice.noticeNo}&page=view'>${notice.noticeTitle }</a></td>								
													</c:if>
												<td>${ notice.updDate}</td>
												<c:set var="cnt" value="${cnt+1 }" />
											</tr>
									</c:forEach>
							</c:when>
							<c:otherwise>
								<section id="${cnt+1 }" style="display:none;">검색된 공지사항이 없습니다.</section>
								<c:set var="cnt" value="${cnt+1 }" />
							</c:otherwise>
						</c:choose>
							</tbody>
						</table>
					</div>
					<div class="contents1-inner">
					<div class = "header" style=" margin:10px 0px;display:none;"  id="${cnt+1 }">
						<span style="color: #F1075C; ">  						
							<font style="margin: 10px 0; font-family: inherit; font-weight: bold; font-size: 17.5px;">회의록 리스트</font>
						</span>
						<c:set var="cnt" value="${cnt+1 }" />
					</div>
					<table class="table table-hover" width="100%">
						<tbody>
							<c:choose>
							 <c:when test="${search_meeting_list!=null and fn:length(search_meeting_list)>0}">
							 			<thead>
											<tr id="${cnt+1 }" style="display:none;">
											<c:set var="cnt" value="${cnt+1 }" />
												<th style="width: 11%">No</th>
												<th style="width: 71%">제목</th>
												<th >날짜</th>
											</tr>
										</thead>
								         <c:forEach items="${search_meeting_list }" var="entity" varStatus="status">
										   <tr id="${cnt+1 }" style="display:none;">
										   <c:set var="cnt" value="${cnt+1 }" />
										      <td>${status.index+1}</td>
										      <td><a href='#' onclick='showMeeting(${entity.meetingNo})'>${entity.meetingTitle }</a></td>
										      <td>${entity.meetingDate }</td>
										   </tr>
										 </c:forEach>
									 </c:when>
									 <c:otherwise>
									 	<section id="${cnt+1 }" style="display:none;">검색된 회의 목록이 없습니다.</section>
										<c:set var="cnt" value="${cnt+1 }" />
									 </c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
					</div>
			</div>
			
<!-- 			<div class="span5">
				
				</div>팀이벤트 리스트 -->

			<div class="span6" id="meetingDetail" style="height:300%;  margin-left:5px">
				<iframe class="contents2" src="<%=request.getContextPath()%>/JobController.do?cmd=oneSearch&page=default&search_text=${search_text }" name="iframe"></iframe>
			</div>
		</div>
	</div>
	</div>
	
	<form id="frm2" target="iframe" action="<%=request.getContextPath()%>/MeetingController.do" method="get" style="margin:0; height:0">
		<input type="hidden" value="one_meeting" name="cmd"/>
		<input type="hidden" value="" name="meeting_no" id="meetingNo"/>
		<input type="hidden" value="meeting_log" name="type"/>
	</form>
	<form id="frm3" target="iframe" action="<%=request.getContextPath()%>/JobController.do" method="get" style="margin:0; height:0" >
		<input type="hidden" value="one_job" name="cmd"/>		
		<input type="hidden" name="auth"   value="" id="auth"/>
		<input type="hidden" name="job_no" value="" id="jobNo"/>
		<input type="hidden" name="where" value="personalJobMain"/>
	</form>


	<script src="js/bootstrap.min.js"></script>
	<script>
	$(function() {
		$("#startDate").datepicker({
			autoclose : true,
			todayHighlight : true
		}).datepicker('update', new Date());
		$("#dueDate").datepicker({
			autoclose : true,
			todayHighlight : true
		}).datepicker('update', new Date());
	});
	
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip({
			title : "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강",
			html : true
		});
		
			if('${team.leaderName}'=='${user.userName}'){
				$('#auth').val('leader');	
			}
			else{
				$('#auth').val('member');
			}
			var auth = $('#auth').val();
	});
	
		
		
		//권한도 전달인자로 넘겨 수정할 페이지를 띄울지 보기만하는 페이지 띄울지 
		function showJobModal(no){
			var auth;	
			if('${team.leaderName}'=='${user.userName}')
				auth="leader";
			else
				auth="member";
			
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/JobController.do?cmd=one_job&job_no='+no+'&auth='+auth);
			
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null)
				$('#layerpop').css("top","100%");
			});
		}

		function deleteJob(no){
			$.ajax({
				url:"<%=request.getContextPath()%>/JobController.do",
				type:"get",
				dataType:"json",
				data:{
					"cmd":"deleteJob",
					"jobNo":no
				},
				success:function(response){
					if(response=="1"){
						alert("삭제성공함");
						//$('#frm',parent.document).submit();
						//$('#layerpop-modal-body').load(null)
						//$('#layerpop').css("top","100%");
					}else if(response=="2"){
						alert("삭제실패함")
					}
				},
				error : function(x,o,e){
					var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
					alert(msg);
				}
			});
			
		}
		
		function getJobState(){
			var state = document.querySelectorAll('.jobState');
			var jobState;
			for(var i = 0; i < state.length;i++){				
				if(state[i].getAttribute('class') == 'jobState btn btn-default active'){
					jobState = state[i].getAttribute('id');
					break;
				}
			}
			return jobState;
			//alert("잡스테이트" + jobState);
		}
		
		
		function modifyJob(no){
			
			//alert($('#prop').val()+"/"+no+"/"+ $('#jobTitle').val()+"/"+jobState+"/"+$('#dueDate').val()+"/"+$('#desc').val());
			$.ajax({
				url:"<%=request.getContextPath()%>/JobController.do",
				type:"get",
				dataType:"json",
				data:{
					"cmd":"modifyJob",
					"prop" : $('#prop').val(),
					"jobNo" : no,
					"jobTitle" : $('#jobTitle').val(),
					"jobState" : getJobState(),
					"dueDate" : $('#dueDate').val(),
					"desc":$('#desc').val(),
					"userNo": '${user.userNo}',
					"teamNo": '${team.teamNo}'
				},
				success:function(response){
					if(response=="1"){
						alert("수정성공함");
						$('#frm',parent.document).submit();
					}else if(response=="2"){
						alert("수정실패함")
					}
				},
				error : function(x,o,e){
					var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
					alert(msg);
				}
			});
		}
		function showModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&page=view&no='+no);
			$('#layerpop').css("top","5%");
			$('#modalOKBtn-notice').click(function(){
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
		function showMeeting(meeting_no){
			$('#meetingNo').val(meeting_no);
			$('#frm2').submit();
		}
		function showJob(job_no){
			$('#jobNo').val(job_no);		
			$('#frm3').submit();
		}
		</script>
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
			function sendAlarm(userNo){
				webSocket.send(userNo+'%e');
			}

		</script>
</body>
</html>