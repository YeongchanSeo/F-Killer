<%@page import="com.fkiller.web.contants.JobState"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
td {
	color: #3E4142;
	vertical-align:middle;
}
<style>
   .progress-custom.progress-striped .bar, .progress-striped .bar-info {
       background-color: #EAE333; /*노랑색*/
   }
   .progress-info.progress-striped .bar, .progress-striped .bar-info {
       background-color: #3365EA; /*파랑색*/
   }
   
</style>
</head>
<body>
	<h4 style="color: blue">업무리스트</h4>
	<c:choose>
		<c:when test="${job_list!=null and fn:length(job_list) > 0 }">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>중요도</th>
						<th>업무명</th>
						<th>담당자</th>
						<th>작업상태 <i class="fa fa-question-circle"
							data-toggle="tooltip" data-placement="top"></i></th>
						<th>마감기한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${job_list }" var="entity">
						<tr id="${entity.jobNo }">
							<td>${entity.prop }</td>
							<td>${entity.jobTitle }</td>
							<td>${entity.name }</td>
							<c:if test="${entity.jobState =='TO_DO' }">
								<td class="text-center" style="color: yellow">
							</c:if>
							<c:if test="${entity.jobState == 'IN_PROGRESS' }">
								<td class="text-center" style="color: green">
							</c:if>
							<c:if test="${entity.jobState == 'PERMISSION' }">
								<td class="text-center" style="color: orange">
							</c:if>
							<c:if test="${entity.jobState == 'DONE' }">
								<td class="text-center" style="color: blue">
							</c:if>
							<c:if test="${entity.jobState == 'EXPIRED' }">
								<td class="text-center" style="color: red">
							</c:if>
							<i class="fa fa-circle-o-notch fa-spin fa-2x"></i>
							</td>
							<td>${entity.dueDate }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
		<c:otherwise>
			등록된 계시물이 없습니다.
		</c:otherwise>
	</c:choose>


	<script>
		/* $(document).ready(function(){
		 $('[data-toggle="tooltip"]').tooltip({title: "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강", html: true});   
		 }); */

		$('tr').click(function() {
			var id = $(this).attr('id');
			if (id == 'header') {
				return;
			} 
		});
	</script>
</body>
</html>