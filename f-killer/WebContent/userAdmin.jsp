<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="margin : 10%;">
<h3>이름 : ${user.userName }</h3>
<p>e-mail : ${user.userEmail }</p>
<img id="profile" src="<%=request.getContextPath()%>/img/userProfile/${user.userProfile }" alt="프로필" 
								 class="img-circle" style="margin-left: 5px; width:50px; height:50px">
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<table class="table table-hover">
	<tr>
		<th>소속팀</th>
		<th>직책</th>
	</tr>
	<c:forEach items="${team_list }" var="team">
		<tr>
			<td>${team.teamName }</td>
			
			<c:choose>
				<c:when test="${user.userName != team.leaderName}">
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