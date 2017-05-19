<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
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
										<c:if test="${entity.prop ==1}"><td>상</td></c:if>
										<c:if test="${entity.prop ==2}"><td>중</td></c:if>
										<c:if test="${entity.prop ==3}"><td>하</td></c:if>
										<c:if test="${page=='mainOfMain' }">
											<td><a onclick="showJobModal(${entity.jobNo })" href="#layerpop" data-toggle="modal">${entity.jobTitle }</a></td>									
										</c:if>
										<c:if test="${page=='personalJobMain' }">
											<td><a target='iframe' href='<%=request.getContextPath()%>/JobController.do?cmd=one_job&no=${entity.jobNo}'>${job.jobTitle }</a></td>
										</c:if>
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
						등록된 게시물이 없습니다.
					</c:otherwise>
				</c:choose>
			
			<!-- 모달 -->
	<div id="layerpop" style="top:100%;" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">업무상세보기</h3>
		</div>
		<div class="modal-body" id="layerpop-modal-body">
			<!-- jobDetailView.jsp -->
		</div>
		<div class="modal-footer">
			<div style="text-align: center">
		        <button type="button" id="modalOKBtn" class="btn btn-primary" style="margin-bottom:3px" data-dismiss="modal">확인</button>
	        </div>
		</div>
	</div>
	<script>
		//권한도 전달인자로 넘겨 수정할 페이지를 띄울지 보기만하는 페이지 띄울지 
		$(document).ready(function() {
			$('[data-toggle="tooltip"]').tooltip({
				title : "to do : 노랑<BR>in progress : 주황<BR>permission : 파랑<BR>done : 초록<BR>expired : 빨강",
				html : true
			});
			
		});
		function showJobModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/JobController.do?cmd=one_job&page=view&job_no='+no);
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null)
				$('#layerpop').css("top","100%");
			});
		}
		
		
		</script>
</body>
</html>