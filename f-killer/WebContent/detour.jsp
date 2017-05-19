<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<form id="toMainFrm" action="<%=request.getContextPath()%>/TeamController.do" method="post">
	<input type="hidden" value="selectTeam" name="cmd"/>
	<input type="hidden" value="${team.teamNo }" name="teamNo"/>
	<input type="hidden" value="detour" name="where"/>	
</form>
<form id="toTeamCalendar" action="<%=request.getContextPath()%>/TeamController.do" method="post">
	<input type="hidden" value="team_calendar" name="cmd"/>
</form>
</body>
</html>

<script>	
	$(document).ready(function(){
		var isModal = '<%=request.getParameter("is_modal")%>';		
		var where = '<%=request.getParameter("where")%>';		
		
		if(isModal =='false'){
			parent.document.location.reload();
		} else {
			if(where == 'mainOfMain'){
				var frm = document.getElementById("toMainFrm");
				frm.submit();
			}else if (where == 'personalCalendar'){
				location.href = '<%=request.getContextPath()%>/UserController.do?cmd=p_calendar';				
			}else if (where ='teamCalendar'){
				var frm = document.getElementById("toTeamCalendar");
				frm.submit();
			}			
		} 	
	});
</script>