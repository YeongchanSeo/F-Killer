<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
	.teamMenu{
		margin:10px;
		color:black;
		font-size: 20px;
		/* padding:10px 0; */
	}
	.teamSubMenu{
		margin-left:30px;
		color:#601B40;
		font-size: 15px;
		text-align: right;
		/* padding:10px 0; */
	}
	.selectedMenu-tr{
		background-color:#EAD3E6;
	}
	.selectedMenu-a{
		color:#CB3296;
	}
	.team-menu-table th, .team-menu-table td{
		padding:15px 0;
	}
	.team-menu-table tbody tr:hover>td, .team-menu-table tbody tr:hover>th {
    	background-color: #E0DBDF;
	}
</style>
<table class="table table-hover team-menu-table" width="100%">
	<tr id="showReport" style="border-top: hidden;"><th class="teamMenuTh"><a class="teamMenu" href="#" onclick="showProgress()" style="text-decoration : none;">팀 진행상황</a></th></tr>
	<tr id="showCalendar" class=""><th><a class="teamMenu" href="#" onclick="team_calendar()" style="text-decoration : none;">일정 보기</a></th></tr>
	<tr id="showNotice" class=""><th><a class="teamMenu" href="#" onclick="noticeAll()" style="text-decoration : none;">공지 보기</a></th></tr>
	<tr id="showMeeting" class=""><th><a class="teamMenu" href="#" onclick="meeting()" style="text-decoration : none;">회의록 보기</a></th></tr>
	<tr id="showJob" class=""><th><a class="teamMenu" href="#" onclick="personal_job()" style="text-decoration : none;">업무보기</a></th></tr>
	<tr id="showStorage" class=""><th><a class="teamMenu" href="#" onclick="storage()" style="text-decoration : none;">저장소</a></th></tr>
	<c:if test="${auth!=null && auth==true }">	<!-- teamLeader 체크. 현재 로그인 된 user의 번호와 일치하면 auth=true -->
		<tr id="manageTeam" class="manage-menu"><th><a class="teamMenu" href="#" onclick="showSubMenu()" style="text-decoration : none;">팀 관리</a></th></tr>
		<tr id="manageTeamInfo" class="sub-menu"><td><a class="teamSubMenu" href="#" onclick="updateTeam()" style="text-decoration : none;">팀 정보 수정</a></td></tr>
		<tr id="manageNotice" class="sub-menu"><td><a class="teamSubMenu" href="#" onclick="noticeManage()" style="text-decoration : none;">공지 관리</a></td></tr>
		<tr id="manageMeeting" class="sub-menu"><td><a class="teamSubMenu" href="#" onclick="meetingManage()" style="text-decoration : none;">회의 관리</a></td></tr>
		<tr id="manageJob" class="sub-menu"><td><a class="teamSubMenu" href="#" onclick="jobManage()" style="text-decoration : none;">업무 관리</a></td></tr>
	</c:if>
</table>
<input type="hidden" value="hi" id="hi"/>
<form id="meetingFrm" action="<%=request.getContextPath() %>/MeetingController.do" method="get">
	<input type="hidden" value="" name="cmd" id="cmd"/>
	<input type="hidden" value="" name="type" id="type"/>
</form>
<form id="jobFrm" action="<%=request.getContextPath() %>/JobController.do" method="get">
	<input type="hidden" value="" name="cmd" id="job_cmd"/>
</form>
<form id="personalJobFrm" action="<%=request.getContextPath() %>/JobController.do" method="get">
	<input type="hidden" value="" name="cmd" id="personal_job_cmd"/>
</form>
<form id="jobManageFrm" action="<%=request.getContextPath() %>/JobController.do" method="get">
	<input type="hidden" value="" name="cmd" id="jobManage_cmd"/>
</form>
<form id="teamCalendarFrm" action="<%=request.getContextPath() %>/TeamController.do" method="post">
	<input type="hidden" value="" name="cmd" id="team_calendar_cmd"/>
</form>
<form id="noticeAllFrm" action="<%=request.getContextPath() %>/NoticeController.do" method="get">
	<input type="hidden" value="" name="cmd" id="notice_all_cmd"/>
	<input type="hidden" value="1" name="fake">
</form>
<form id="updateTeamFrm" action="<%=request.getContextPath() %>/TeamController.do" method="post">
	<input type="hidden" value="" name="cmd" id="update_team_cmd"/>
</form>
<form id="noticeFrm" action="<%=request.getContextPath() %>/NoticeController.do" method="post">
	<input type="hidden" value="notice_list" name="cmd" id=""/>
</form>
<form id="progressFrm" action="<%=request.getContextPath() %>/TeamController.do" method="post">
	<input type="hidden" value="" name="cmd" id="progress_cmd"/>
</form>

<script>
	$(document).ready(function(){
		$(".sub-menu").hide();
	});
	function showSubMenu(){
		$('.sub-menu').slideToggle();
	}
	
	function job(){
		var frm=$('#jobFrm');
		$('#job_cmd').val('job_list');
		frm.submit();
	}
	function personal_job(){
		var frm=$('#personalJobFrm');
		$('#personal_job_cmd').val('personal_job_list');
		frm.submit();
	}

	function jobManage(){
		var frm=$('#jobManageFrm');
		$('#jobManage_cmd').val('job_manage_list');
		frm.submit();
	}
	
	function meeting(){
		var frm=$('#meetingFrm');
		$('#cmd').val('meeting_list');
		$('#type').val('member');
		frm.submit();
	}
	function meetingManage(){
		var frm=$('#meetingFrm');
		$('#cmd').val('meeting_list');
		$('#type').val('leader');
		frm.submit();
	}
	function team_calendar(){
		var frm=$('#teamCalendarFrm');
		$('#team_calendar_cmd').val('team_calendar');
		frm.submit();
	}
	function updateTeam(){
		var frm = $('#updateTeamFrm');
		$('#update_team_cmd').val('go_update_team');
		frm.submit();
	}
	function noticeAll(){
		var frm = $('#noticeAllFrm');
		$('#notice_all_cmd').val('notice_list');
		frm.submit();
	}
	function storage(){
		location.href='<%=request.getContextPath()%>/FileController.do?cmd=storage';
		
	}
	function noticeManage(){
		var frm = $('#noticeFrm');
		frm.submit();
	}
	function showProgress(){
		var frm = $('#progressFrm');
		$('#progress_cmd').val('progress_list');
		frm.submit();
	}
</script>