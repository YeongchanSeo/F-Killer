<%@page import="com.fkiller.web.contants.JobState"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<script>console.log("jobDetailView의 where값은 = ${where}")</script>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<script>console.log("jobDetailView의 where값은 = ${where}")</script>
<c:if test="${ where=='teamCalendar'}">	
	<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	 -->
</c:if>
<c:if test="${where=='personalJobMain'}" >
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>	
</c:if>
<c:set var = "where2" value='<%=request.getParameter("where") %>'/>
<c:if test="${where2=='personalJobMain' }">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>	
</c:if>
<c:if test="${where=='jobManageMain' }">
	 <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	 <link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>	
</c:if>
<c:if test="${where=='personalJobMain' }">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
</c:if>
<c:if test="${where=='personalJobCalendar' }">
<!-- 	<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script> -->
</c:if>
<c:if test="${where=='mainOfMain' }">
	
</c:if>
<title>Insert title here</title>
<style>
.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip:rect(0,0,0,0);
  border: 0;
}

.filebox label {
  display: inline-block;
  padding: .5em .75em;
  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}
.navbar {
	margin-bottom: 0;
	margin-top: 0;
	border-radius: 0;
	margin-bottom: 0px;
	margin-top: 0px;
	border-radius: 0px;
}
.btn-small{
	padding:2px 5px;
}
	.wrapper{
		/* width:480px; */
		width:97%;
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
		color:#033300;
	}
	.notice-icon{
		color:#085402; 
		margin-bottom:40px
	}
textarea{
	resize:none;
}
legend{
	margin-bottom:5px;
}
.file_input_textbox {
	float: left;
	width:270px;
	/* width: 150px; */
}

.file_input_div {
	position: relative;
	width: 80px;
	height: 30px;
}

.file_input_button {
	width: 80px;
	height: 30px;
	position: absolute;
	top: -5px;
	font-size: inherit;
	font-family: inherit;
	vertical-align: middle;

	color: black;
	border-style: solid;
 	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
}
.file_download_button {
	width: 80px;
	height: 30px;
	position: relative;
	top: -5px;
	font-size: inherit;
	font-family: inherit;
	vertical-align: middle;

	color: black;
	border-style: solid;
 	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
}
input[type="file"]{
	width:80px;
}
.file_input_hidden {
	width: 80px;
	font-size: 30px;
	position: absolute;
	right: 0px;
	top: -5px;
	opacity: 0;
	filter: alpha(opacity = 0);
	-ms-filter: "alpha(opacity=0)";
	-khtml-opacity: 0;
	-moz-opacity: 0;
}
.jobState.btn.btn-small.btn-default.active{
	background-color: #FF0087;
	color:white;
}
.btn.btn-default.btn-small.member{
	margin:1px;
	border-radius: .5em;
}
.btn.btn-default.btn-small.member.active{
	background-color: #FF0087;
	color:white;
	margin:1px;
	border-radius: .5em;
}
/* input[type=text] {clear: none;
border: 0px none;
float: none;
background-color: #FFF;
 배경을 투명하게 할경우에는 background-color: transparent;}
 */
.component{
	margin:10px 0;
}
.cmt-wrapper{
	position:relative; overflow-y:scroll; overflow-x:hidden;

}

</style>
</head>
<body>
<div class="wrapper">
	<c:choose>
		<c:when test="${page=='default' }">
			<div class="notice-box-outer">
				<div class="notice-box-inner">
					<h3 class="notice-text">업무를 선택하세요.</h3>
					<br>
					<i class="fa fa-pencil-square-o fa-5x notice-icon"></i>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row-fluid" id="fieldset-width-data">
				<form id="form" action="<%=request.getContextPath()%>/JobController.do" method="post" enctype="multipart/form-data">
					<div class="span12">
						<h2>
							${job.teamName}<BR>
							<c:if test="${auth=='member' }"><small>${job.jobTitle }</small></c:if>
							<c:if test="${auth=='leader' || auth=='oneself'}"><input name="job_title" type="text" id="jobTitle" value="${job.jobTitle }"></c:if>						
						</h2>
						<div class="row-fluid">
							<div class="span6" id="contents-wrapper">
								<fieldset>
									<legend>Detail</legend>	
									<div class="component">							 
										<c:if test="${auth=='leader' }">
											<div id="prop-filed">
											<span>중요도 &nbsp;&nbsp; </span>
											<select id="prop" style="margin-bottom: 0px; width:40%;" class="span6">
												<option value ="0">-중요도-</option>
												<c:choose>
													<c:when test="${job.prop==1}"><option value ="1" selected>상</option></c:when>
													<c:otherwise><option value ="1">상</option></c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${job.prop==2}"><option value ="2" selected>중</option></c:when>
													<c:otherwise><option value ="2">중</option></c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${job.prop==3}"><option value ="3" selected>하</option></c:when>
													<c:otherwise><option value ="3">하</option></c:otherwise>
												</c:choose>										
											</select>
											</div>
																				
										</c:if>
										<input type="hidden" name="prop" id="hidden_prop" value=""/>
										
										
										<c:if test="${auth=='member' || auth=='oneself' }">
											<span>중요도 : </span>
											<c:if test="${job.prop ==1}">상</c:if>
											<c:if test="${job.prop ==2}">중</c:if>
											<c:if test="${job.prop ==3}">하</c:if> 
											<BR>
										</c:if>
									
									</div>
									<div class="component">	
										작업상태
										<div class="btn-group" data-toggle="buttons-radio" style="margin-top:3px;">
											<c:choose>
												<c:when test="${ job.jobState =='TO_DO'}">
													<c:if test="${auth=='member' }">
														<button type="button" onclick ="checkAuth('false')" id="TO_DO" disabled="disabled" class="jobState btn btn-small btn-default active">to do</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" onclick ="checkAuth('true')" id="TO_DO" class="jobState btn btn-small btn-default active">to do</button>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${auth=='member' }">
														<button type="button" id="TO_DO" disabled="disabled" class="jobState btn btn-small btn-default">to do</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" id="TO_DO" class="jobState btn btn-small btn-default">to do</button>
													</c:if>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${ job.jobState =='IN_PROGRESS'}">
													<c:if test="${auth=='member' }">
														<button type="button" id="IN_PROGRESS" disabled="disabled" class="jobState btn btn-small btn-default active">in progress</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" id="IN_PROGRESS" class="jobState btn btn-small btn-default active">in progress</button>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${auth=='member' }">
														<button type="button" id="IN_PROGRESS" disabled="disabled" class="jobState btn btn-small btn-default">in progress</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" id="IN_PROGRESS" class="jobState btn btn-small btn-default">in progress</button>
													</c:if>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${ job.jobState =='PERMISSION'}">
													<c:if test="${auth=='member' }">
														<button type="button" id="PERMISSION" disabled="disabled" class="jobState btn btn-small btn-default active">permission</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" id="PERMISSION" class="jobState btn btn-small btn-default active">permission</button>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${auth=='member' }">
														<button type="button" id="PERMISSION" disabled="disabled" class="jobState btn btn-small btn-default">permission</button>
													</c:if>
													<c:if test="${auth=='oneself' || auth=='leader' }">
														<button type="button" id="PERMISSION" class="jobState btn btn-small btn-default">permission</button>
													</c:if>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${ job.jobState =='DONE'}">
													<c:if test="${auth=='oneself' || auth=='member' }">
														<button type="button" id="DONE" disabled="disabled" class="jobState btn btn-small btn-default active">done</button>
													</c:if>
													<c:if test="${auth=='leader' }">
														<button type="button" id="DONE" class="jobState btn btn-small btn-default active">done</button>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${auth=='oneself' || auth=='member' }">
														<button type="button" id="DONE" disabled="disabled" class="jobState btn btn-small btn-default">done</button>
													</c:if>
													<c:if test="${auth=='leader' }">
														<button type="button" id="DONE" class="jobState btn btn-small btn-default">done</button>
													</c:if>
												</c:otherwise>
											</c:choose>
											<input type="hidden" value="" name="job_state" id="hidden_state"/>
										</div>
									</div>
									<div class="component">
										<c:if test="${auth=='oneself' || auth=='member' }"><BR><span>업무기한 : ${job.dueDate }</span></c:if>
										<c:if test="${auth=='leader'}">
											<div class="input-group date " id="dueDate"
												data-date-format="yyyy-mm-dd" style="margin-left: 0.5%">
												<span>업무기한</span>&nbsp;&nbsp;
												 <input class="form-control" type="text" id="endDate" readonly style="width: 40%; margin-top:5px" />
												 <span class="input-group-addon">
													<button type="button" class="btn" style="margin-top:-5px">
														<i class="fa fa-calendar-check-o"></i>
													</button>
												</span>
											</div>
										</c:if>
									</div>
									<div class="component">
										<c:if test="${auth=='oneself' || auth=='member' }"><p>담당자 : ${job.userName }</p></c:if>
										<c:if test="${auth=='leader' }">
										담당자
										<div class="btn-group" data-toggle="buttons-radio" style="margin-left:10px;">
											<c:set var = "memberCnt" value="0"/>
											<c:forEach var="member" items="${member_list}" varStatus="status">
												<c:choose>
													<c:when test="${job.userName==member.name }">
														<button type="button" class="member btn btn-default btn-small active" id="${member.userNo}" value="">${member.name }</button>
													</c:when>
													<c:otherwise>
														<button type="button" class="member btn btn-default btn-small" id="${member.userNo}" value="">${member.name }</button>				
													</c:otherwise>	
												</c:choose>
												<c:set var = "memberCnt" value="${memberCnt+1 }"/>
												<c:if test="${memberCnt%3==0 }">
													<BR>
												</c:if>
											</c:forEach>									
										</div>
										</c:if>
									</div>								
									<input type="hidden" name="user_no" value="" id="user_no"/> 
								</fieldset>
								<fieldset>
									<legend>Description</legend>
									<c:if test="${auth=='member' }">
										<textarea class="form-control span12" id="desc" rows="5" readonly	style="margin-bottom: 5px" >${job.jobDesc }</textarea>
									</c:if>
									<c:if test="${auth=='oneself' || auth=='leader' }">
										<textarea class="form-control span12" id="desc" rows="5" style="margin-bottom: 5px" >${job.jobDesc }</textarea>
									</c:if>
									<input type="hidden" id="hidden_desc" value="" name="job_desc"/>
								</fieldset>
							</div>
							<div class="span6">
								<fieldset>
									<legend>Comment</legend>
								</fieldset>
								<div class="row-fluid cmt-wrapper">
									<div class="span12" id="cmt">
										<div id="cmt-list">
											<c:forEach items="${job.comments }" var="comment">
												${comment.name }<BR>
												${comment.date }<BR>
												${comment.desc }<hr>
											</c:forEach>
										</div>
									</div>
								</div>
								<div id="write-cmt" style="margin-top:10px">
									<textarea id="cmt-content" class="span12" placeholder="코멘트를 달아주세요"></textarea>
									<BR>
									<button style="float:right;" type="button" class="btn btn-default span6" onclick = "cmtAdd(${job.jobNo})">Comment</button>
								</div>
							</div>
						</div>					
						<div class="row-fluid">
								<fieldset id="file-fieldset">
									<legend>Upload File</legend>
									<div class="component">
										<div>
											<c:if test="${auth=='leader' || auth=='oneself' }">
												<input type="button" value="파일추가" onclick="addIB('input1')" class="btn">		
											</c:if>
										</div>
										<div class="component">
											<c:set var = "fileCnt" value="0"/>
											<c:set var = "fileArray" value=""/>
											<table cellpadding="0" cellspacing="0" border="0">
												<tbody id="input1">
												<c:choose>
													<c:when test="${fn:length(job.files)==0 }">
														<c:if test="${auth=='leader' || auth=='oneself' }">
														<tr>
															<td>
																<input type="text" id="fileName${fileCnt }"	class="file_input_textbox" readonly="readonly">
															</td>
															<td style="padding:-5px 0 0 0">
																<div class="file_input_div" style="padding-top:-5px">														
																	<input type="button" value="업로드" class="file_input_button" /> 
																	<input type="file" class="file_input_hidden" name="fileName${fileCnt }" 
																		onchange="javascript: document.getElementById('fileName${fileCnt }').value = this.value" />
																</div>
															</td>
															<td></td>
														</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<c:forEach items="${job.files }" var="file">
															<tr>
																<td>
																	<input type="hidden" id="h${fileCnt}" value="${file.fileNo}"/>
																	<input type="text" id="fileName${fileCnt}" value="${file.fileName }" class="file_input_textbox" readonly="readonly">
																</td>
																<td style="padding:-5px 0 0 0">
																	<button type="button"  class="file_download_button" onclick="download('${file.fileName}')">다운로드</button>
																</td>
																<td style="padding:-5px 0 0 0">
																	<c:if test="${auth=='leader' || auth=='oneself' }">
																	<div class="file_input_div">																
																		<button type="button"  class="file_input_button" >수정</button>	
																		<input type="file" class="file_input_hidden" name="fileName${fileCnt }"
																		       onchange="javascript: document.getElementById('fileName${fileCnt}').value = this.value" />
																	</div>																	
																	</c:if>
																</td>
															</tr>
															<c:set var="fileCnt" value = "${fileCnt+1 }"/>													
														</c:forEach>
														<input type="hidden" value="" name="update_files" id="fileArray"/>
													</c:otherwise>				
												</c:choose>
												</tbody>
											</table>
										</div>
										<%-- <div class="component">
											<c:if test="${auth=='leader' || auth=='oneself' }">
												<input type="button" value="추가" onclick="addIB('input1')" class="btn">		
											</c:if>	
										</div> --%>
									</div>							
								</fieldset>
							<%--<div class="span6">
								 <textarea id="cmt-content" class="span12" placeholder="코멘트를 달아주세요"></textarea>
								<BR>
								<button type="button" class="btn btn-default span6" onclick = "cmtAdd(${job.jobNo})">Comment</button> 
							</div>--%>
						</div>
						<div class="component">
							<c:if test="${auth=='leader' || auth=='oneself'}">
								<div style="text-align: center">&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" onclick="modifyJob(${job.jobNo})"
										class="btn btn-default" id="modify-btn" style="width:20%; background:#FF0087; color:white;">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" onclick="deleteJob(${job.jobNo})"
										class="btn btn-default" id="delete-btn" style="width:20%; background:white">삭제</button>
								</div>
							</c:if>
						</div>
					</div>
				<input type="hidden" name="cmd" id="cmd" value=""/>
				<input type="hidden" name="job_no" id="job_no" value=""/>
				<input type="hidden" name="where" value="${where}"/>
				<input type="hidden" name="due_date" value="" id="hidden_due_date"/>
				<c:if test="${where=='mainOfMain' || where=='teamCalendar'}">
					<input type="hidden" name="is_modal" value="true"/>
					<input type="hidden" name="team_no" value="${team.teamNo}"/>
				</c:if>
				<c:if test="${where=='personalCalendar' }">
					<input type="hidden" name="team_no" value="${team_no}"/>
					<input type="hidden" name="is_modal" value="true"/>
				</c:if>
				<c:if test="${where=='jobManageMain' || where=='personalJobList' }">
					<input type="hidden" name="is_modal" value="false"/>
				</c:if>
	
				</form>
			</div>
		</c:otherwise>		
	</c:choose>
</div>


	<c:if test="${where=='personalJobMain' || where=='jobManageMain' }">
		<script src="js/bootstrap.min.js"></script>
	</c:if>


<script>	
	function download(fileName){
		location.href="<%=request.getContextPath()%>/JobController.do?cmd=download&file_name="+fileName;
	};
	
 	var enddate = '${job.dueDate}';
	
	var ey = enddate.substring(0,4);
	var em = enddate.substring(5,7);
	var ed = enddate.substring(8,10);
	var end = new Date();
	end.setFullYear(ey, em-1, ed);
	
		$(document).ready(function() {
			 var wrapperHeight = $('#contents-wrapper').height(); 
			 var buttonHeight = $('#write-cmt').height();
			 wrapperHeight = wrapperHeight - buttonHeight;
			$('.cmt-wrapper').css('height',wrapperHeight-50);
			
			$("#dueDate").datepicker({ 
           	autoclose: true, 
           	todayHighlight: true,
           	dateFormat : 'yyyy-mm-dd',
          	defaultDate : end  
        }).datepicker('setDate', end); 	
	});
		
		function getTimeStamp() {
		    var d = new Date();
		 
		    var s =
		        leadingZeros(d.getFullYear(), 4) + '-' +
		        leadingZeros(d.getMonth() + 1, 2) + '-' +
		        leadingZeros(d.getDate(), 2);
		 
		    return s;
		}
		 
		function leadingZeros(n, digits) {
		    var zero = '';
		    n = n.toString();
		 
		    if (n.length < digits) {
		        for (i = 0; i < digits - n.length; i++)
		            zero += '0';
		    }
		    return zero + n;
		}
		
		function cmtAdd(no){
			var content = $("#cmt-content").val();
		if(content==''){
			return;
		}
		$("#cmt-content").val('');
		var cmtList = $("#cmt-list").html();
		
		var recentDate = getTimeStamp(); 	
		cmtList += ("${user.userName}"+'<BR>'+recentDate+'<BR>' + content + '<BR><hr>');
		$("#cmt-list").html(cmtList);
		
		$.ajax({
			url:"<%=request.getContextPath()%>/JobController.do",
			type:"get",
			dataType:"json",
			data:{
				"cmd":"addCmt",
				"desc" : content,
				"userNo" : "${user.userNo}",
				"jobNo" : no
			},
			success:function(response){
				if(response=="1"){
					
				}else if(response=="2"){
					
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
				
				//alert(state[i].getAttribute('class'));
				if(state[i].getAttribute('class') == 'jobState btn btn-small btn-default active'){
					jobState = state[i].getAttribute('id');					
					break;
				}
			}
			return jobState;			
		}
		
	
	
	function deleteJob(no){
		var output = '';
		for(var i = 0 ; i < '${fileCnt}'; i++){
			var fileNo = $('#h'+i).val();
			var fileName = $('#fileName'+i).val();
			if(fileName.substring(0,12)=="C:\\fakepath\\"){
				fileName = fileName.substring(12,fileName.length);
			}
			output+=(fileNo+"/"+fileName+"/");
		}
		if('${auth}' =='leader'){
			getJobUser();
			$('#hidden_prop').val($('#prop').val());
			$('#hidden_due_date').val($('#endDate').val());
		}else{
			$('#user_no').val('${user.userNo}');
			$('#hidden_prop').val('${job.prop}');
			$('#hidden_due_date').val('${job.dueDate }');
		}
		if('${fileCnt}'!=0){
			$('#fileArray').val(output);				
		}
		$('#cmd').val('deleteJob');
		$('#job_no').val(no);
		
		$('#hidden_state').val(getJobState());
		$('#hidden_desc').val($('#desc').val());
		$('#form').submit();
	}
	function modifyJob(no){
		//if()
		//alert("수정하러 왓음");
		var output = '';
		for(var i = 0 ; i < '${fileCnt}'; i++){
			var fileNo = $('#h'+i).val();
			var fileName = $('#fileName'+i).val();
			if(fileName.substring(0,12)=="C:\\fakepath\\"){
				fileName = fileName.substring(12,fileName.length);
			}
			output+=(fileNo+"/"+fileName+"/");
		}
		var user;
		$('#hidden_state').val(getJobState());
		//alert("번호설정하셈");
		if('${auth}' =='leader'){
			getJobUser();
			$('#hidden_prop').val($('#prop').val());
			var where = '${where}';
			
			$('#hidden_due_date').val($('#endDate').val());
			/* parent.sendAlarm($('#user_no').val()+"%e"); */
			
		}else{
			$('#hidden_due_date').val('${job.dueDate}');
			$('#user_no').val('${user.userNo}');
			$('#hidden_prop').val('${job.prop}');
			$('#endDate').val('${job.dueDate}');
			$('#hidden_due_date').val('${job.dueDate }');
			/* if($('#hidden_state').val()=='PERMISSION'){
				parent.sendAlarm('${team.leaderNo}%ee');
			} */
		}

		if('${fileCnt}'!=0){
			$('#fileArray').val(output);				
		}
		$('#cmd').val('modifyJob');		
		$('#job_no').val(no);
		
		$('#hidden_desc').val($('#desc').val());
		$('#form').submit();
		
		if('${auth}' =='leader'){
			parent.sendAlarm($('#user_no').val()+"%e");
		}else{
			if($('#hidden_state').val()=='PERMISSION'){
				parent.sendAlarm('${team.leaderNo}%ee');
			}
		}
	}
	
	 var n="${fileCnt}";
	 function addIB(obj) {
		    var a = document.getElementById(obj);
		    var td=document.createElement("td");
		    var tr=document.createElement("tr");
			
		    var input1 = document.createElement("input");
		    input1.setAttribute("type", "text");
		    input1.setAttribute("id", "fileName"+n);
		    input1.setAttribute("class", "file_input_textbox");
		    input1.setAttribute("readonly", "readonly");
		   
		    td.appendChild(input1);
		    
		   
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
			
		    var td2 = document.createElement("td");
		    div1.appendChild(input2);
		    div1.appendChild(input3);
		    td2.appendChild(div1);
		    td2.setAttribute("colpan","2");
		    
		    
		    tr.appendChild(td);
		    tr.appendChild(td2);
		    a.appendChild(tr);
		    n++;		   
		} 
	 
	 function getJobUser(){
			var user = document.querySelectorAll('.member');
			//alert("유저번호 받으러 왓음");
			//alert(user.length);
			for (var i = 0; i < user.length; i++) {
				
				//alert(user[i].getAttribute('class'));
				if (user[i].getAttribute('class') == 'member btn btn-default btn-small active') {
					userId = user[i].getAttribute('id');	
					$('#user_no').val(userId);
					//alert($('#user_no').val());
					break;
				}
			}
		}
</script>
	
</body>
</html>