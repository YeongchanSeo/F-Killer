<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
 -->
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
.file_input_textbox {
	float: left;
	width: 150px;
}

.file_input_div {
	position: relative;
	width: 100px;
	height: 30px;
	overflow: hidden;
}

.file_input_button {
	width: 100px;
	height: 30px;
	position: absolute;
	top: 0px;
	font-size: inherit;
	font-family: inherit;
	vertical-align: middle;
	/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#ff5db1+0,ef017c+100;Pink+3D+%231 */
	background: #ff5db1; /* Old browsers */
	background: -moz-linear-gradient(45deg, #ff5db1 0%, #ef017c 100%);
	/* FF3.6-15 */
	background: -webkit-linear-gradient(45deg, #ff5db1 0%, #ef017c 100%);
	/* Chrome10-25,Safari5.1-6 */
	background: linear-gradient(45deg, #ff5db1 0%, #ef017c 100%);
	/* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ff5db1',
		endColorstr='#ef017c', GradientType=1);
	/* IE6-9 fallback on horizontal gradient */
	color: #FFFFFF;
	border-style: solid;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.file_input_hidden {
	font-size: 45px;
	position: absolute;
	right: 0px;
	top: 0px;
	opacity: 0;
	filter: alpha(opacity = 0);
	-ms-filter: "alpha(opacity=0)";
	-khtml-opacity: 0;
	-moz-opacity: 0;
}
.modal-body {
    max-height: 600px;
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
.file_input_textbox{
	width:210px; 
	margin-right:2px;
}
</style>
</head>
<body>


	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">업무만들기</h4>
			</div>
			<div class="modal-body row-fluid">

				<form id="form" class="form-horizontal" method="post"
					action="<%=request.getContextPath()%>/JobController.do"
					enctype="multipart/form-data">

					<input type="hidden" name="cmd" value="add_job" /> 
					<input type="hidden" name="userId" id="user_id" value="" />
					<div class="control-group">
						<label class="control-label" for="jobTitle" style="width:auto">업무명</label>
						<div class="controls"  style="margin-left:70px;">
							<input type="text" name="job_title" id="jobTitle" class="span10"
								placeholder="업무명을 입력하세요">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="importance" style="width:auto">중요도</label>
						<div class="controls"  style="margin-left:70px;">
							<select id="importance" name="prop">
								<option value="0">-중요도 선택-</option>
								<option value="1">상</option>
								<option value="2">중</option>
								<option value="3">하</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="assignee" style="width:auto">담당자</label>
						<div class="controls"  style="margin-left:70px;">
							<div class="btn-group" data-toggle="buttons-radio">
								<c:forEach var="member" items="${member_list}" varStatus="status">
									<c:if test="${status.index % 6 == 0 and status.index!=0}">
										<br><span style="width:70px"></span>
									</c:if>
									<button type="button" class="btn btn-default member"
										id="${member.userNo}" value="">${member.name }</button>
								</c:forEach>
								<input type="hidden" id="user_no" name="user_no" value="" />
							</div>
						</div>
					</div>

					<div class="control-group" id="divdueDate">
						<label for="inputName" class="control-label" style="width:auto">업무기한</label>
						<div class="input-group date span6 controls" id="dueDate"
							data-date-format="yyyy-mm-dd" style="margin-left: 15px;">
							<input class="form-control" type="text" readonly id="date"
								name="due_date" />
							<button type="button" class="btn">
								<i class="fa fa-calendar-check-o"></i>
							</button>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="jobDetail" style="width:auto">업무내용</label>
						<div class="controls"  style="margin-left:70px;">
							<textarea name="job_desc" id="jobDetail" rows="5" class="span10"></textarea>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="file" style="width:auto">파일</label>
						<div class="controls"  style="margin-left:70px;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tbody id="input1">
									<tr>
										<td>
											<input type="text" id="fileName0" class="file_input_textbox" style="" readonly="readonly">

											<div class="file_input_div">
												<input type="button" value="업로드" class="file_input_button" />
												<input type="file" class="file_input_hidden" name="file0"
													onchange="javascript: document.getElementById('fileName0').value = this.value" />
												
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<input type="button" value="추가" onclick="addIB('input1')"
								class="btn" style="margin-top:10px">
						</div>
					</div>
					<div class="control-group" id="fileList">
						<label class="control-label"></label>
						<div class="controls" style="margin-left:70px;">
							<!-- <input type="button" value="추가" onclick="addIB('input1')"
								class="btn"> -->
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="create_job" class="btn btn-default"
					data-dismiss="modal">만들기</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
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
					<div class="contents1-inner">
						<form id="frm" action="<%=request.getContextPath()%>/JobController.do" method="get">
							<input type="hidden" name="cmd" value="job_manage_list">
							<input type="hidden" name="where" value="modify">
						</form>
						<div class="pull-left" style="margin-top:-10px; margin-bottom:20px;">
							<h4 style="color: #F1075C;">업무리스트</h4>
						</div>
						<div class="pull-right">
							<a href="#myModal" role="button" class="btn" data-toggle="modal" style="background:#FF0087; color:white; margin-right:10px;">업무만들기</a>	
						</div>
						<table id="table" class="table table-hover">
							<thead>
								<tr>
									<th style="width:15%">중요도</th>
									<th style="width:30%">업무명</th>
									<th style="width:15%">담당자</th>
									<th style="width:20%">작업상태 <i class="fa fa-question-circle"
										data-toggle="tooltip" data-placement="bottom"></i></th>
									<th style="width:20%">마감기한</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${job_list!=null and fn:length(job_list) > 0 }">
										<c:forEach items="${job_list }" var="entity">
											<tr id="${entity.jobNo }">
												<c:if test="${entity.prop ==1}"><td>상</td></c:if>
												<c:if test="${entity.prop ==2}"><td>중</td></c:if>
												<c:if test="${entity.prop ==3}"><td>하</td></c:if>
												<td style="font-size:16px"><a style="color:black; text-decoration: none" target='iframe' href='<%=request.getContextPath()%>/JobController.do?where=jobManageMain&auth=leader&cmd=one_job&job_no=${entity.jobNo}'>${entity.jobTitle }</a></td>
												<td>${entity.userName }</td>
												<c:if test="${entity.jobState =='TO_DO' }">
													<td class="text-center" style="color: yellow">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 20%;"></div>
														</div>
												</c:if>
												<c:if test="${entity.jobState == 'IN_PROGRESS' }">
													<td class="text-center" style="color: green">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 50%;"></div>
														</div>
												</c:if>
												<c:if test="${entity.jobState == 'PERMISSION' }">
													<td class="text-center" style="color: orange">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 80%;"></div>
														</div>
												</c:if>
												<c:if test="${entity.jobState == 'DONE' }">
													<td class="text-center" style="color: blue">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
														</div>
												</c:if>
												<c:if test="${entity.jobState == 'EXPIRED' }">
													<td class="text-center" style="color: red">
														<div class="progress progress-striped">
														  <div class="bar js${entity.jobState }" style="width: 100%;"></div>
														</div>
												</c:if>
												</td>
												<td>${entity.dueDate }</td>
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
						
						<form id="settingAlarmTargetFrm" target="iframe" action="<%=request.getContextPath()%>/JobController.do" method="get" style="margin: 0; height: 0">
							<input type="hidden" value="one_job" name="cmd" />
							<input type="hidden" value="" name="job_no" id="alarmJobNo" />
							<input type="hidden" value="leader" name="auth"/>
							<input type="hidden" value="${where }" name="where"/>
						</form>
						</div>
					
				</div>
				<div class="span6" id="meetingDetail" style="height:300%;  margin-left:0px">
					<iframe class="contents2" src="<%=request.getContextPath()%>/JobController.do?where=jobManageMain&cmd=one_job&page=default&job_no=0" name="iframe"></iframe>
				</div>
				</div></div>
			</div>

			
			<script src="js/bootstrap.min.js"></script>
			<script>
			function sendAlarm(userNo){
				webSocket.send(userNo+'%e');
			}

				 $(document).ready(function(){
					 showSubMenu();
					 setJobDetailForAlarm();
					$('#manageJob').addClass('selectedMenu-tr');
					$('#manageJob').find('td').find('a').addClass('selectedMenu-a');
					 $('[data-toggle="tooltip"]').tooltip({placement: 'bottom', title: "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강", html: true});   
				 });
				
				 var n=1;
				 function addIB(obj) {
					    var a = document.getElementById(obj);
					    var td=document.createElement("td");
					    var tr=document.createElement("tr");
						
					    var input1 = document.createElement("input");
					    input1.setAttribute("type", "text");
					    input1.setAttribute("id", "fileName"+n);
					    input1.setAttribute("class", "file_input_textbox");
					    input1.setAttribute("readonly", "readonly");
					    
					    var div1 = document.createElement("div");
					    div1.setAttribute("class", "file_input_div");
					    
					    var input2 = document.createElement("input");
					    input2.setAttribute("type", "button");
					    input2.setAttribute("value", "업로드");
					    input2.setAttribute("class", "file_input_button");
					    
					    var input3 = document.createElement("input");
					    input3.setAttribute("type", "file");
					    input3.setAttribute("onchange", 'javascript: document.getElementById("fileName'+n+'").value = this.value');
					    input3.setAttribute("class", "file_input_hidden");
					    input3.setAttribute("name", "fileName"+n);
						
					    
					    td.appendChild(input1);
					    div1.appendChild(input2);
					    div1.appendChild(input3);
					   	td.appendChild(div1);
					    tr.appendChild(td);
					    a.appendChild(tr);
					    n++;		   
					} 
				function setJobDetailForAlarm() {
					var detailNo = '${detailNo}';
					if (detailNo != null && detailNo != "") {
						$('#alarmJobNo').val(detailNo);
						$('#settingAlarmTargetFrm').submit();
					}
				}
				/* $(document).ready( //위로 옮겨놧음
					setJobDetailForAlarm();
				}); */
				$("#create_job").click(	function() {
					var frm;
					
					var user = document.querySelectorAll('.member');
						for (var i = 0; i < user.length; i++) {
						if (user[i].getAttribute('class') == 'btn btn-default member active') {
							userId = user[i].getAttribute('id');
							frm = $('#form');
							$('#user_no').val(userId);
							webSocket.send(userId+"%ee");
							break;
						}
					}
					frm.submit();
				});

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
			</script>
</body>
</html>