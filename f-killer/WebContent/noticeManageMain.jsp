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
   .progress-custom.progress-striped .bar, .progress-striped .bar-info {
       background-color: #EAE333; /*노랑색*/
   }
   .progress-info.progress-striped .bar, .progress-striped .bar-info {
       background-color: #3365EA; /*파랑색*/
   }
</style>
</head>
<body>

	<!-- 모달 -->
	<div id="createNoticeModal" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="myModalLabel">공지만들기</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" id="form">
				<div class="control-group">
					<label class="control-label" for="noticeTitle" style="width:auto">제목</label>
					<div class="controls" style="margin-left:30px">
						<input type="text" class="span6" id="noticeTitle"
							placeholder="공지 제목을 입력하세요">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="noticeContent"  style="width:auto">내용</label>
					<div class="controls"  style="margin-left:30px">
						<textarea rows="10" id="noticeContent" class="span6"
							style="resize: none;" placeholder="공지 내용을 입력하세요"></textarea>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			<button type="button" class="btn btn-primary" onclick="addNotice()">등록</button>
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
			<div class="span6 contents1" id="scroll">
				<div style="position:absolute; left:0; top:0; padding:10px 15px;width:95%">
					<div style="">			
						<c:if test="${where=='manage'}">
							<div class="row-fluid" style="margin-top:10px;">
							<h4 style="color: #F1075C;">공지사항</h4>
						</div>
						<div class="pull-right">
							<a href="#createNoticeModal" role="button" class="btn" data-toggle="modal" style=" background:#FF0087; color:white; margin-top:-30px; margin-right:10px;">공지만들기</a>	
						</div>
						</c:if>
						<form id="frm" action="<%=request.getContextPath()%>/NoticeController.do" method="post">
							<input type="hidden" name="cmd" value="notice_list">
						</form>
						
						<c:if test="${where!='manage'}">
							<div class="row-fluid" style="margin-top: -10px; margin-bottom:10px;">
								<h4 style="color:#F1075C;">공지사항</h4>
							</div>
						</c:if>
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
									<c:when test="${notice_list!=null and fn:length(notice_list)>0 }">
									<c:forEach items="${notice_list }" var="notice">
										<tr>
											<td>${ notice.noticeNo}</td>
											<c:if test="${where=='manage' }">										
												<td style="font-size:16px;"><a target='iframe' href='<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&no=${notice.noticeNo}&page=manage' style="color:black; text-decoration: none">${notice.noticeTitle }</a></td>										
											</c:if>
											<c:if test="${ where == 'view' }">
												<td style="font-size:16px;"><a target='iframe' href='<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&no=${notice.noticeNo}&page=view' style="color:black; text-decoration: none">${notice.noticeTitle }</a></td>
											</c:if>										
											<td>${ notice.updDate}</td>
										</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="3">공지 목록이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="span6" id="meetingDetail" style="height:300%;  margin-left:5px">
				<iframe class="contents2" src="<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&page=default" name="iframe"></iframe>
			</div>
		</div>
	</div>
			<form id="settingAlarmNoticeFrm" target="iframe" action="<%=request.getContextPath()%>/NoticeController.do" method="get" style="margin:0; height:0">
				<input type="hidden" value="oneNotice" name="cmd"/>
				<input type="hidden" value="" name="no" id="alarmNoticeNo"/>
				<input type="hidden" value="view" name="page"/>
			</form>
			<script>
				$(document).ready(function(){
					var detailNo = '${detailNo}';
					if(detailNo != null && detailNo!=""){
						$('#alarmNoticeNo').val(detailNo);
						$('#settingAlarmNoticeFrm').submit();
					}
					var where = '${where}';
					if(where == 'manage'){
						showSubMenu();
						$('#manageNotice').addClass('selectedMenu-tr');
						$('#manageNotice').find('td').find('a').addClass('selectedMenu-a');
					}else{
						$('#showNotice').addClass('selectedMenu-tr');
						$('#showNotice').find('th').find('a').addClass('selectedMenu-a');
					}
				});
			</script>

			<script src="js/bootstrap.min.js"></script>
			<script>
				function addNotice(){					
					$.ajax({
						type : "post",
						url  : "<%=request.getContextPath()%>/NoticeController.do",
						dataType : "json",
						data : {
							"cmd" : "add_notice",
							"title" : $('#noticeTitle').val(),
							"content" : $('#noticeContent').val()
						},
						success : function(response){
							if(response == "1"){
								alert("저장되었습니다");
								$('#createNoticeModal').modal('hide');
								$('#frm').submit();
							}
							else {
								alert("저장이 실패 되었습니다.");
							}
						},
						error : function(x,o,e){
							var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
							alert(msg);
						}							
					});
								
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
		</script>
</body>
</html>