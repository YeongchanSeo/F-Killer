<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<div style="margin : 10%;">
<h3>팀명 : ${team.teamName }</h3>
<p>팀주제 : ${team.teamTopic }</p>
<p>기간 : ${team.startDate } ~ ${team.endDate }</p>
팀원
<table class="table table-hover">
	<tr>
		<th>이름</th>
		<th>직책</th>
	</tr>
	<c:forEach items="${member_list }" var="member">
		<tr>
			<td>${member.name }</td>
			
			<c:choose>
				<c:when test="${member.name != team.leaderName}">
					<td> </td>
				</c:when>
				<c:otherwise>
					<td>팀장</td>
				</c:otherwise>
			</c:choose>
		</tr>
	</c:forEach>
</table>
</div>