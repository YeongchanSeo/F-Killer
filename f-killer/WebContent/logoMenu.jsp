<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
if(request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
@import url(http://weloveiconfonts.com/api/?family=entypo);

[class*="entypo-"]:before {
	font-family: 'entypo', sans-serif;
	font-size: 40px;
	color: #FFD329;
}
	#logoMenu-userName{
		vertical-align: -15px
	}
.container {
	position: relative;
	-webkit-perspective: 1000;
	-webkit-backface-visibility: hidden;
}

.badge-num {
	box-sizing: border-box;
	font-family: 'Trebuchet MS', sans-serif;
	background: #ff0000;
	cursor: default;
	border-radius: 50%;
	color: #fff;
	font-weight: bold;
	font-size: 13px;
	height: 25px;
	line-height: 1.55em;
	top: 3px;
    right: 10px;
	border: 3px solid #fff;
	position: absolute;
	text-align: center;
	width: 25px;
	box-shadow: 1px 1px 5px rgba(0, 0, 0, .2);
	animation: pulse 1.5s 1;
}

.badge-num:after {
	content: '';
	position: absolute;
	top: -2px;
	left: -2px;
	border: 2px solid rgba(255, 0, 0, .5);
	opacity: 0;
	border-radius: 50%;
	width: 100%;
	height: 100%;
	animation: sonar 1.5s 1;
}

@
keyframes sonar { 0% {
	transform: scale(.9);
	opacity: 1;
}

100%{
transform


:scale(2)


;
opacity


:


0;
}
}
@
keyframes pulse { 0% {
	transform: scale(1); 20%{
	transform: scale(1.4);
}
50%{
transform


:scale


(
.9


);
}
80%{
transform


:

 

scale


(1
.2


);
}
100%{
transform


:

 

scale


(1);
}
}
</style>
<script
	src="//assets.codepen.io/assets/common/stopExecutionOnTimeout-f961f59a28ef4fd551736b43f94620b5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.navbar-default .navbar-inner {
	/* background-image: linear-gradient(to bottom,#121531,#121531);
    border: 1px solid #121531; 남색*/
	/* background-image: linear-gradient(to bottom,#fff,#fff);
    border: 1px solid #fff; 흰색
    border-bottom: 3px solid red; */
	background-image: linear-gradient(to bottom, #423e3e, #423e3e);
	border: 1px solid #423e3e; /* 진회색 */
	border-bottom: 3px solid #FF0087;

	/* background-image: linear-gradient(to bottom,#696767,#696767);
    border: 1px solid #696767; 회색*/

	/* background-image: linear-gradient(to bottom,#5B5B5C,#333333);
    border: 1px solid #676666; 진회색 그라데이션*/

	/*background-image: linear-gradient(to bottom, #999, #666666);
	border: 1px solid #8C8989; 회색 그라데이션*/
}

.badge {
	background-color: #FF0087;
}
</style>
<div class="navbar topnav navbar-default">
	<div class="navbar-inner">
		<table class="nav" style="width: 100%; margin-right: 0px">
			<tbody style="width: 100%; margin: 0px">
				<tr style="width: 100%">
					<td style="width: 10%"><a href="#"
						onclick="goHome(${user.userNo})"><image class=""
								src="img/killer_logo.png" width="150px" height="75px" /></a></td>
					<td style="width: 30%"></td>
					<c:if test="${user!=null }">
						<td style="width: 35%">
								<form class="form-search" style="margin:0px" action="<%=request.getContextPath()%>/JobController.do" accept-charset="UTF-8">
								  <div class="input-append" >
								    <input type="text" class="span3 search-query" name="search_text" value="${search_text}" placeholder="검색어를 입력하세요.">
								    <input type="hidden" name="cmd" id="searchJob" value="searchJob">
								    <button type="submit" class="btn">검색</button>
								  </div>
								</form>
							</td>
						<td style="width: 15%">

							<div class="dropdown" id="alarm-dropdown-box">
								<div class="container" id="badge">
									<a class="entypo-bell dropdown-toggle" data-toggle="dropdown"
										onclick="showMyAlarm(${team.teamNo})"
										style="float: right; margin-right: 20px; text-decoration: none; cursor:pointer" ></a>
								</div>
								<%-- <a class="dropdown-toggle" data-toggle="dropdown" href="#" onclick="showMyAlarm(${team.teamNo})">
								<i class="fa fa-bell fa-2x" style="float: right; margin-right: 10px; color: orange"></i> --%>
							</a>
								<ul id="alarm-list-box" class="dropdown-menu" role="menu"
									aria-labelledby="dLabel" style="margin-top: 20px;">
								</ul>
								<script type="text/javascript">
								function showMyAlarm(teamNo){
									
									var badge = document.getElementById('badge');
									var nodes = badge.childNodes;
									if(nodes.length===4){
										badge.removeChild(badge.children[0]);
									}
									
									
									var listbox = $('#alarm-list-box');
									if(listbox.css('display')=='block'){
										listbox.css('display','none');
									}else{
										listbox.css('display','block');	
									}
									var type='personal_alarm';
									if(teamNo != null){
										type = 'team_alarm';
									}
									$.ajax({
										type: "get",
										url: "<%=request.getContextPath()%>/AlarmController.do",
										datatype: "json",	
										data:{
											"cmd":"alarm_list",
											"type":type
										}, 	
										success: function(list){
											var parseList = $.parseJSON(list);
											$('#alarm-list-box').empty();
											if(parseList.length<=0){
												var listText = '<li style="text-align:center">알람이 없습니다.</li>'
												$('#alarm-list-box').append(listText);
											}else{
												for(var cnt=0; cnt<parseList.length; cnt++){
													var listText = '<li><a href="#" onclick="showAlarmDetail('
																   +parseList[cnt].alarmNo+',\''+parseList[cnt].alarmType+'\','+parseList[cnt].detailNo
																   +','+parseList[cnt].teamNo+','+cnt+')">'
																   +parseList[cnt].message+'</a></li>';
													var type =parseList[cnt].alarmType; 
													if(type=='invite' || type=='INVITE'){
														listText = listText + '<li id="invite'+parseList[cnt].alarmNo+'" style="text-align:center; display:none">'+
																				   '<button class="btn btn-primary" onclick="confirmBtn('+parseList[cnt].teamNo+','+parseList[cnt].alarmNo+')">수락</button>'+
																			       '<button style="margin-left:10%" class="btn btn-default" onclick="cancelBtn('+parseList[cnt].teamNo+','+parseList[cnt].alarmNo+')">거절</button>'+
																			   '</li>';
													}
													$('#alarm-list-box').append(listText);
												}
											}
										},
										error: function(x,o,e){
											var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
											alert(msg);
										}
									});
								}
								
								
								
								function showAlarmDetail(alarmNo, alarmType, detailNo, teamNo, cnt){
									if(alarmType == 'job' || alarmType == 'JOB'){
										goJobAlarm(detailNo, teamNo, alarmNo);
									}else if(alarmType == 'meeting' || alarmType == 'MEETING'){
										goMeetingAlarm(detailNo, alarmNo);
									}else if(alarmType == 'notice' || alarmType == 'NOTICE'){
										goNoticeAlarm(detailNo, alarmNo);
									}else if(alarmType == 'invite' || alarmType == 'INVITE'){
										var id='#invite'+alarmNo;
										var target = $(id);
										if(target.css('display')=='block'){
											target.css('display','none');
										}else{
											target.css('display','block');	
										}
										$('#alarm-list-box').css('display','block');
									}
								}
								
								function confirmBtn(teamNo, alarmNo){
									$.ajax({
										type: "post",
										url: "<%=request.getContextPath()%>/UserController.do",
										datatype: "json",	
										data: {
											"cmd" : "work_in",
											"teamNo" : teamNo,
											"alarmNo" : alarmNo,
											"intention" : "yes"
										},
										success: function(response){		
											if(response=="OK"){
												alert("팀 초대를 수락하였습니다. 팀에 참여합니다.");
												resetTeamList();
												<%-- location.href("<%=request.getContextPath()%>/TeamController.do?cmd=inviteYes"); --%>
											}else{
												alert("팀 초대 수락요청에 실패하였습니다.");
											}
										},
										error: function(x,o,e){
											var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
											alert(msg);
										}
									});
									 $('#alarm-list-box').css('display','none'); 
								}
								function cancelBtn(teamNo, alarmNo){
									$.ajax({
										type: "post",
										url: "<%=request.getContextPath()%>/UserController.do",
										datatype: "json",	
										data: {
											"cmd" : "work_in",
											"teamNo" : teamNo,
											"alarmNo" : alarmNo,
											"intention" : "no"
										},
										success: function(response){		
											if(response=="OK"){
												alert("팀 초대를 거절하였습니다.");
											}else{
												alert("팀 초대 거부요청에 실패하였습니다.");
											}
										},
										error: function(x,o,e){
											var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
											alert(msg);
										}
									});
									 $('#alarm-list-box').css('display','none'); 
								}
							</script>
							</div>

						</td>

						<td style="width: 5%">
							<div class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<c:choose>
								<c:when test="${user.userProfile != null }">
								<img id="profile"
									src="<%=request.getContextPath()%>/img/userProfile/${user.userProfile }"
									alt="프로필" class="img-circle"
									style="margin-left: 5px; width: 50px; height: 50px">
								</c:when>
								<c:otherwise>
								<img id="profile"
									src="<%=request.getContextPath()%>/img/userProfile/default-avatar.png"
									alt="프로필" class="img-circle"
									style="margin-left: 5px; width: 50px; height: 50px">
								</c:otherwise>
								</c:choose>
								</a>
								<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel"
									style="margin-left: -20px">
									<li><a
										href='<%=request.getContextPath()%>/UserController.do?cmd=update_userInfo'>개인정보수정</a></li>
									<li><a
										href="<%=request.getContextPath()%>/UserController.do?cmd=logout">로그아웃</a></li>
									<li><a
										href='<%=request.getContextPath()%>/UserController.do?cmd=p_calendar'>개인일정관리</a></li>
								</ul>
							</div>
						</td>
						<td style="width: 5%"><span class="badge"
							style="height: 20px;"> <font id="logoMenu-userName"
								style="font-size: 1.5em;">${user.userName }</font>
						</span></td>
						<td style="width: 5%"></td>
					</c:if>
				</tr>
			</tbody>
		</table>
		<form id="goHomeFrm"
			action="<%=request.getContextPath()%>/UserController.do" method="get">
			<input type="hidden" name="cmd" id="goHomeCmd" value="">
		</form>
		<form id="goAlarmFrm" action="" method="">
			<input type="hidden" name="cmd" id="goAlarmCmd" value=""> <input
				type="hidden" name="detailNo" id="detailNo" value=""> <input
				type="hidden" name="fake" value="1"> <input type="hidden"
				name="type" value="member"> <input type="hidden"
				name="teamNo" id="teamNo" value=""> <input type="hidden"
				name="alarmNo" id="alarmNo" value=""> <input type="hidden" name="where" id="where" value="">
				<input type="hidden" name="auth" id="auth" value=""/>
		</form>

		<form id="inviteYesCmd" action="<%=request.getContextPath()%>/TeamController.do" method="post">
			<input type="hidden" name="cmd" value="cancel">			
		</form>
		
		<script>
			function goJobAlarm(detailNo, teamNo, alarmNo){
				$('#goAlarmFrm').attr('action','<%=request.getContextPath()%>/JobController.do');
				$('#goAlarmFrm').attr('method','get');
				$('#goAlarmCmd').val('job_list');
				$('#detailNo').val(detailNo);
				$('#teamNo').val(teamNo);
				$('#alarmNo').val(alarmNo);
				$('#where').val('fromAlarm');
				if('${auth}'==true){
					console.log('팀장이에요!');					
					$('#auth').val('leader');	
				}else{
					console.log('팀원이에요!');
					$('#auth').val('oneself');
				}
				
				$('#goAlarmFrm').submit();
			}
			function goNoticeAlarm(detailNo, alarmNo){
				$('#goAlarmFrm').attr('action','<%=request.getContextPath()%>/NoticeController.do');
				$('#goAlarmFrm').attr('method','get');
				$('#goAlarmCmd').val('notice_list');
				$('#detailNo').val(detailNo+"/"+alarmNo);
				$('#goAlarmFrm').submit();
			}
			function goMeetingAlarm(detailNo, alarmNo){
				$('#goAlarmFrm').attr('action','<%=request.getContextPath()%>/MeetingController.do');
				$('#goAlarmFrm').attr('method','get');
				$('#goAlarmCmd').val('meeting_list');
				$('#detailNo').val(detailNo+"/"+alarmNo);
				$('#goAlarmFrm').submit();
			}
			function resetTeamList(){
				var frm = document.getElementById("inviteYesCmd");
				frm.submit();
			}
			
		</script>
	</div>
</div>
<script type="text/javascript">
	var textarea = document.getElementById("messageWindow");
	var webSocket = new WebSocket(
			'ws://192.168.1.100:8080/f-killer/broadcasting');
	
	webSocket.onerror = function(event) {
		
	};
	webSocket.onopen = function(event) {
		//System.out.println("환영합니다.");
		webSocket.send('c:${user.userNo}');
	};
	webSocket.onmessage = function(event) {
		alert('알람이 도착했습니다!!');
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/UserController.do",
			datatype: "json",	
			data: {
				"cmd" : "update_alarm",
			},
			success: function(response){		
					updateBadge(response);
			},
			error: function(x,o,e){
				var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
				//alert(msg);
			}
		
		});
		
		
	};
	$(document).ready(function(){
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/UserController.do",
			datatype: "json",	
			data: {
				"cmd" : "update_alarm",
			},
			success: function(response){		
					updateBadge(response);
			},
			error: function(x,o,e){
				var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
				//alert(msg);
			}
		
		});
	});
		
	/* function startBadge(){//To rerun the animation the element must be re-added back to the DOM	
	var badge = document.getElementById('badge');
	 // var int = window.setInterval(updateBadge, 2000); //Update the badge ever 5 seconds
	  var badgeNum;
       var badgeChild = badge.children[0];
         if(badgeChild.className==='badge-num')
              badge.removeChild(badge.children[0]);
       
       badgeNum = document.createElement('div'); 
      badgeNum.setAttribute('class','badge-num');
         badgeNum.innerHTML = ${alarm_cnt};
       var insertedElement = badge.insertBefore(badgeNum,badge.firstChild); 
      console.log(badge.children[0]);
      
} */
	
	function updateBadge(alarm_cnt){//To rerun the animation the element must be re-added back to the DOM
		if(alarm_cnt==0){
			return;	
		}
		var badge = document.getElementById('badge');
		 // var int = window.setInterval(updateBadge, 2000); //Update the badge ever 5 seconds
		  var badgeNum;
	       var badgeChild = badge.children[0];
	         if(badgeChild.className==='badge-num')
	              badge.removeChild(badge.children[0]);
	       
	       badgeNum = document.createElement('div'); 
	      badgeNum.setAttribute('class','badge-num');
	      if(alarm_cnt!=0){
	         badgeNum.innerHTML = alarm_cnt;
	      }
	       var insertedElement = badge.insertBefore(badgeNum,badge.firstChild); 
	      console.log(badge.children[0]);
	      
	}
</script>


<script>
	function goHome(userNo){
		if(userNo!=null){
			$('#goHomeCmd').val("loginOK");
			$('#goHomeFrm').submit();
		}else{
			$('#goHomeCmd').val("loginNG");
			$('#goHomeFrm').submit();
		}
	}
	
	<%-- $(window).load(function() {
		var date = new Date();
		$("#profile").attr("src","<%=request.getContextPath()%>/img/userProfile/${user.userProfile}?cmd="+date);
	}); --%>
	
</script>

