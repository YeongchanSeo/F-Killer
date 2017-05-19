<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<!-- <script	src = "http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"> </script>--> 
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
 -->
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" /> -->

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

/* named upload */
.filebox .upload-name {
  display: inline-block;
  padding: .5em .75em;  /* label의 패딩값과 일치 */
  font-size: inherit;
  font-family: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
  width : 150px;
}
	textarea{
		resize:none;
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
	background-color: #E24141;
}
.progress{
	margin-bottom:0px;
}
</style>
<body>
	
	
		<input type="hidden" id = "teamNo" value="${team.teamNo }"/>
		<input type="hidden" name="leader" value="${team.leaderName }" id="leader">

	
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
					<c:set var="cnt" value="0" />
						<div class = "header" style=" margin:10px 0px;display:none;"  id="${cnt+1 }">
							<span style="color: #F1075C; ">  						
								<font style="margin: 10px 0; font-family: inherit; font-weight: bold; font-size: 17.5px;">개인 업무리스트</font>
							</span>
							 <select id="user" style="width: 130px" class="pull-right">
								<option value="-1">-이름 선택-</option>
								<c:forEach var="member" items="${member_list }">
									<option value="${member.userNo }">${member.name}</option>
								</c:forEach>
							</select>
							<c:set var="cnt" value="${cnt+1 }" />
						</div>
						<table id="table" class="table table-hover">
									<thead>
										<tr id="${cnt+1 }" style="display:none;">
											<th style="width:15%">중요도</th>
											<th style="width:30%">업무명</th>
											<th style="width:15%">담당자</th>
											<th style="width:20%">작업상태 <i class="fa fa-question-circle"
												data-toggle="tooltip" data-placement="bottom"></i></th>
											<th style="width:20%">마감기한</th>
											<c:set var="cnt" value="${cnt+1 }" />
										</tr>
									</thead>
									<tbody id="table_body">
										<c:choose>
											<c:when test="${job_list!=null and fn:length(job_list) > 0 }">
												<c:forEach items="${job_list }" var="entity">
													<tr id="${cnt+1 }" style="display:none;">
														<c:if test="${entity.prop ==1}"><td>상</td></c:if>
														<c:if test="${entity.prop ==2}"><td>중</td></c:if>
														<c:if test="${entity.prop ==3}"><td>하</td></c:if>
														
														<td style="font-size:16px">
															<a style="color:black; text-decoration: none; cursor:pointer" target='iframe' onclick="showJob(${entity.jobNo},'${entity.userNo }')">${entity.jobTitle }</a></td>
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
														<c:set var="cnt" value="${cnt+1 }" />
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr id="${cnt+1 }" style="display:none;">
													<td colspan="5">업무 목록이 없습니다.</td>
													<c:set var="cnt" value="${cnt+1 }" />
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
					</div>
					<div class="span6" id="jobDetail" style="height:300%;  margin-left:0px">
						<iframe class="contents2" src="<%=request.getContextPath()%>/JobController.do?where=personalJobMain&cmd=one_job&page=default&job_no=0" name="iframe"></iframe>
					</div>
				</div>
		</div>
	</div>

		
	<form id="frm" target="iframe" action="<%=request.getContextPath()%>/JobController.do" method="get" style="margin:0; height:0" >
		<input type="hidden" value="one_job" name="cmd"/>		
		<input type="hidden" name="auth"   value="" id="auth"/>
		<input type="hidden" name="job_no" value="" id="jobNo"/>
		<input type="hidden" name="where" value="personalJobMain"/>
	</form>
	<form id="settingAlarmTargetFrm" target="iframe" action="<%=request.getContextPath()%>/JobController.do" method="get" style="margin: 0; height: 0">
		<input type="hidden" value="one_job" name="cmd" />
		<input type="hidden" value="" name="job_no" id="alarmJobNo" />
		<input type="hidden" value="oneself" name="auth"/>
		<input type="hidden" value="fromAlarm" name="where"/>
	</form>
	<script src="js/bootstrap.min.js"></script>
	<script>
		function sendAlarm(userNo){
			webSocket.send(userNo+'%e');
		}
		function showJob(job_no, job_userNo){
			//alert("담당자" + job_userName);
			if('${team.leaderNo}'=='${user.userNo}'){
 				$('#auth').val('leader');
 			}
 			else if (job_userNo=='${user.userNo}'){
 				$('#auth').val('oneself');
 			} else {
 				$('#auth').val('member');
 			}
			//alert($('#auth').val());
			$('#jobNo').val(job_no);		
			$('#frm').submit();
		}
	
		function setJobDetailForAlarm() {
			var detailNo = '${detailNo}';
			if (detailNo != null && detailNo != "") {
				$('#alarmJobNo').val(detailNo);
				$('#settingAlarmTargetFrm').submit();
			}
		}
		
		$(document).ready(function() {
			$('#showJob').addClass('selectedMenu-tr');
			$('#showJob').find('th').find('a').addClass('selectedMenu-a');
			 $('[data-toggle="tooltip"]').tooltip({placement: 'bottom', 
												   title: "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강", 
												   html: true});    			
 			setJobDetailForAlarm();
		});
		
		 $('#user').change(function(){
        	   $("#user option:selected").each(function () {
        	       
        		   if($(this).val()=='-1')
        	        	return;
        	        else{
        	        	$('#header').html($(this).html()+"님의 업무리스트");
        	        	
        	        	
        	        	 $.ajax({
        	        		url : "<%=request.getContextPath()%>/JobController.do",	        	
        	        		type : 'get',  
        	        		dataType : 'json',      	       
        	        		data : {
        	        			"cmd"    : "personal_job_list2",
        	        			"userNo" : $(this).val(),
        	        			"teamNo" : $('#teamNo').val()
        	        		}, 
        	        		success : function(response){
        	        			var list = new Array();
        	         	       	var data = response;
        	         	       	$('#table_body').empty();
        	         	     	        	        			
        	        			$.each(data,function(i,value){
        	        				list.push(value.jobNo);
        	        				list.push(value.prop);
        	        				list.push(value.jobTitle);
        	        				list.push(value.name);
        	        				list.push(value.jobState);
        	        				list.push(value.dueDate);			
        	        				
        	        			});
        	        			
        	        			var table_body = document.getElementById("table_body");
        	        			
        	        
                				for(var i=0;i<list.length;i+=6){
                					var tr=document.createElement("tr");
                					tr.setAttribute("id",list[i]);
                					
                					var td1=document.createElement("td");
                					if(list[i+1]==1)
                						td1.innerHTML="상";
                					else if(list[i+1]==2)
                						td1.innerHTML="중";
                					else if(list[i+1]==3)
                						td1.innerHTML="하";
                					
                					var td2=document.createElement("td");
                					td2.setAttribute("style", "font-size:16px");
             					    var a = document.createElement("a");
                					a.setAttribute("target","iframe");
                					a.setAttribute("onclick","showJob("+ list[i] + ",'" + list[i+3] + "')");
                					a.setAttribute("style","color:black; text-decoration:none; cursor:pointer;");
                					a.innerHTML=list[i+2];
                					td2.appendChild(a);
                					var td3=document.createElement("td");
                					td3.innerHTML = list[i+3];
                					
                					
                					var div = document.createElement("div");
									div.setAttribute("class", "progress progress-striped");
									
									var div2 = document.createElement("div");
									div2.setAttribute("class", "bar js"+list[i+4]);
									
									
									div.appendChild(div2);
                					               					
                					var td4=document.createElement("td");
                					if(list[i+4]=='TO_DO'){
                						td4.setAttribute("class","text-center");
                						td4.setAttribute("style","color:yellow;");
                						div2.setAttribute("style", "width:20%");
                					}else if(list[i+4]=='IN_PROGRESS'){
                						td4.setAttribute("class","text-center");
                						td4.setAttribute("style","color:green;");
                						div2.setAttribute("style", "width:50%");
                					}else if(list[i+4]=='PERMISSION'){
                						td4.setAttribute("class","text-center");
                						td4.setAttribute("style","color:orange;");		
                						div2.setAttribute("style", "width:80%");
                					}else if(list[i+4]=='DONE'){
                						td4.setAttribute("class","text-center");
                						td4.setAttribute("style","color:blue;");
                						div2.setAttribute("style", "width:100%");
                					}else if(list[i+4]=='EXPIRED'){
                						td4.setAttribute("class","text-center");
                						td4.setAttribute("style","color:red;");	
                						div2.setAttribute("style", "width:100%");
                					}
                					
                					td4.appendChild(div);	
                					
                					var td5 =document.createElement("td");
                					td5.innerHTML=list[i+5];
                					
                					tr.appendChild(td1);
                					tr.appendChild(td2);
                					tr.appendChild(td3);
                					tr.appendChild(td4);
                					tr.appendChild(td5);
                					table_body.appendChild(tr);
                				}
        	        		},
        	        		error : function(x,o,e){
        	    				var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
        	    				alert(msg);
        	    			}
        	        	});
        	     
        	        }
        	   });
        	});
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
	</script>
</body>
</html>