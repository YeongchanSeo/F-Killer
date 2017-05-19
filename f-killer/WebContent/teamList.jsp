<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
if(request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="js/jquery-1.11.3.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<title>FKILLER (Team Cooperation Project Program)</title>

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
    .navbar {
      margin-bottom: 0;
      margin-top: 0;
      border-radius: 0;
    }
    .nameBlock{
	width : 320px;
	}
	.table{
		width : 320px;
		height : 50px;
		border-collapse: collapse;
		
		border-bottom-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		

		box-shadow: 5px 5px 5px 0px lightgray;
	}
	.table th, .table td {
		border : none;
	}
	.teamName{
		text-align : center;
	}
	.arrow{
		align : right;
		border : none;
		outline : none;
	}
	.news{
		background : white;
		height : 30px;
	}
	.favorites{
		font-size : 25px;
		color : black;
		/*#FFC65E*/
		border : none;
		outline : none;
	}
	.background{
		/* background-color:#696767; 진회색*/
		/* background-color:#C4C4C4; 회색*/
		background-color:#E7E7E7;
	}
</style>
</head>
<body class="background">
<nav class="navbar">
  <jsp:include page="logoMenu.jsp" />
</nav>
<nav class="navbar">
  <div style="text-align: center; margin:5% 0 4% 0">
  	<font style="font-size:50px;"><strong>My Team List</strong></font>
  </div>
</nav>
<div style="margin-left:-70px;">
<c:set var="n" value="0"></c:set> 
<c:forEach var="team" items="${team_list}" varStatus="status">
	<c:choose>
		<c:when test="${status.count == (1 + ( 3*n )) }">
			<div class="row-fluid" style="margin-top:50px">
			<div class="span2 offset2">
			<c:set var="n" value="${n+1}"/>
		</c:when>
		<c:otherwise>
			<div class="span2 offset1">
		</c:otherwise>
	</c:choose>
	
	<div class="nameBlock" >
		<table class="table" style="background : ${team.teamColor}" data-toggle="tooltip" data-placement="bottom" id="${team.teamNo}">
			<tr>
				<td style="border-bottom : 1px solid ${team.teamColor}">
					<a class="favorites" style="background : ${team.teamColor}">
					<c:choose>
						<c:when test="${team.favorites == true}">
							<i id='${team.teamNo}a' class="fa fa-star favor ${team.favorites}"></i>											
						</c:when>
						<c:otherwise>
							<i id='${team.teamNo}a' class="fa fa-star-o favor ${team.favorites}"></i>
						</c:otherwise>
					</c:choose>	</a>
				</td>
				<td style="border-bottom:1px solid ${team.teamColor}">
					<button class="close" value="" id="${team.teamNo}">&times;</button>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="border-bottom:1px solid ${team.teamColor}">
					<h2 class="teamName" id="${team.teamNo}" style="cursor:pointer">${team.teamName}</h2>
				</td>
			</tr>				
			<tr>	
				<td colspan="2" style="text-align:right;">
					<button class="arrow" value="" id="${team.teamNo}" style="background: ${team.teamColor}"> ▼</button>
				</td>
			</tr>
			<tbody id="news${team.teamNo}" class="news" >
				
			</tbody>
		</table>
	</div>
	</div>
	<c:choose>
		<c:when test="${status.count == fn:length(team_list) }">
			<c:choose>
				<c:when test = "${ (fn:length(team_list))%3 == 0 }">
					</div>
					<div class="row-fluid" style="margin-top:50px">	
					<div class="span2 offset2">
				</c:when>
				<c:otherwise>
					<div class="span2 offset1">
				</c:otherwise>
			</c:choose>
				<div class="nameBlock" >
					<table class="table" style="background : #656565" data-toggle="tooltip" data-placement="bottom" id="createTeam">
						<tr>
							<td style="border-bottom:1px solid #656565">&nbsp;			
							</td>
							<td style="border-bottom:1px solid #656565">&nbsp;				
							</td>	
						</tr>
						<tr>
							<td colspan="2" style="borde-bottomr:1px solid #656565"><h3 class="teamName" id="createTeam" style="font-size:70px; color:white; cursor:pointer">+</h3></td>
						</tr>
						<tr>	
							<td colspan="2" style="border-top:1px solid #656565; text-align:right;">&nbsp;</td>
						</tr>			
					</table>
				</div>
				</div>
			</div>
		</c:when>
		<c:when test="${status.count %3==0 }">
			</div>
		</c:when>
	</c:choose>
</c:forEach>
	<c:if test="${fn:length(team_list) == 0 || team_list == null}">
		<div class="row-fluid" style="margin-top:50px">	
			<div class="span2 offset2">
			<div class="nameBlock" >
				<table class="table" style="background : pink" data-toggle="tooltip" data-placement="bottom" id="createTeam">
					<tr>
						<td style="border-bottom:1px solid pink">&nbsp;			
						</td>
						<td style="border-bottom:1px solid pink">&nbsp;				
						</td>	
					</tr>
					<tr>
						<td colspan="2" style="borde-bottomr:1px solid pink"><h3 class="teamName" id="createTeam">+</h3></td>
					</tr>
					<tr>	
						<td colspan="2" style="border-top:1px solid pink; text-align:right;">&nbsp;</td>
					</tr>			
				</table>
			</div>
			</div>
		</div>
	</c:if>
</div>
<form id="teamChoiceform" action="<%=request.getContextPath()%>/TeamController.do" method="post">
	<input type="hidden" id="selectedTeamNo" name="selectedTeamNo" value="">
	<input type="hidden" id="cmd" name="cmd" value="selectTeam">
	<input type="hidden" name="where" value="selectTeam"/>
</form>

<input type="hidden" id="tablerow" value="">

<form id="deleteTeamform" action="<%=request.getContextPath() %>/TeamController.do" method="post">
	<input type="hidden" id="cmd" name="cmd" value="deleteTeam">
	<input type="hidden" id="teamNo" name="teamNo" value="">
</form>

<form id="goAlarmFrm" action="" method="get">
	<input type="hidden" name="cmd" id="goAlarmCmd" value="">
	<input type="hidden" name="detailNo" id="detailNo" value="">
	<input type="hidden" name="fake" value="1">
	<input type="hidden" name="teamNo" id="teamNo" value=''>
</form>

<form id="refreshfrm" action="<%=request.getContextPath()%>/TeamController.do" method="post">
	<input type="hidden" name="cmd" value="cancel">			
</form>


<script src="js/bootstrap.min.js"></script>
<script>
var table;
var id;
var list;



/* if('${cmd}'=='updatePersonalInfo'){
	alert("들어옴!");
	$("#refreshfrm").submit();
	
}	 */
	$(document).ready(function(){
		
		list = new Array(); 
		<c:forEach items="${team_list}" var="team">
			list.push("${team.teamNo}");
		</c:forEach>
	
		for(var i=0;i<list.length;i++){
		
			var news = "news"+list[i];						
	 		$("#"+news).hide();
			$("#"+news).val("off");			
		} 	
		$(document).on({
			
		    'mouseenter': function (e) {
		    	table = $(this).attr("id")
				id = '#'+table;	    
		    	
			    $(id).tooltip('show');
		    },
		     
		}, ".table")
		
		
		$('#star').click(function(){
			
			var id = $(this).attr('id');
			var className = $(this).attr('class');
			
		});		
		
	});
	
	
	$(document).on("click",".favor",function(){
		
		var id = $(this).attr('id');
		var className = $(this).attr('class');
		var isFavorite;
		
		var index = id.indexOf('a');
		var teamNo = id.substring(0,index);	
		
		
		if( className.indexOf('true') != -1 ){
			isFavorite = 'true';
		} else {
			isFavorite = 'false';
		}
		
		
		$.ajax({
 			type : "post",
 			url : "<%=request.getContextPath()%>/UserController.do",
 			datatype : "json",
 			data : {
 				"cmd":"favorites",
 				"teamNo":teamNo,
 				"isFavorite": isFavorite
 			},
 			success : function(response){
 				
 				var list = new Array();
 				if( response != null || response != "" ){
 					console.log("가져온 데이터입니다."+response);
 					
 					console.log('teamNo는='+teamNo);
 					var fId = '#'+teamNo+"a";
 					
 					if(response == 'true'){
 						
 						console.log('if 들어왔습니다.');
 						alert( $(fId).attr('class'));
 						
 						
 						$(fId).attr('class','fa fa-star favor true');
 						
 					} else {
 						console.log('else립니다.')
 						$(fId).attr('class','fa fa-star-o favor false');
 					}
 					
 					isFavorite = response;
 					
 				} else {
 					alert("favorite 수정 실패했습니다.");
 					     					
 				}
 			},
 			error : function(x,o,e){
 				var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
 				alert(msg);
 			}
 		});
	});

	
	$('.table').mouseenter(function(){
		
		var data = new Array(); 
		
		<c:forEach items="${team_list}" var="team">
			data.push("${team.teamNo}");
			data.push("${team.leaderName}");
			data.push("${team.startDate}");
			data.push("${team.endDate}");
			data.push("${team.teamTopic}");
		</c:forEach>

		table = $(this).attr("id");		
		id = '#'+table		
		var string;

		for(var i=0;i<data.length;i+=5){			
			
			if(table == data[i]){
				string = "팀장 : "+data[i+1]+"<BR>기간 : "+data[i+2]+"~"+data[i+3]+"<BR>주제 : "+data[i+4];
				break;
			}					
		}		
		
		$(id).tooltip({
			title : string, html : true
		});				
	});

	var rowcnt=0;
	var deleteall=0;
	var length;
	
	$(".arrow").click(function(){
		var name = $(this).attr('id');
		var news = "#news"+name;
	
	 if($("#"+name).val()== 'on'){
		 
		 	 $(news).fadeOut("slow");
             $("#"+name).val('off');
             
             if($('#tablerow').val() != ""){
            	 
            	 $('#tablerow').attr('value','deleteAll');
            	 doDel(name);
            	 rowcnt=0;
             }             
             
        } else {        	
        	 $(news).fadeIn("slow");
             $("#"+name).val('on');
             
             if( rowcnt == 0 ) {
	             $.ajax({
	     			type : "post",
	     			url : "<%=request.getContextPath()%>/TeamController.do",
	     			datatype : "json",
	     			data : {
	     				"cmd":"teamListNews",
	     				"teamNo":name
	     			},
	     			success : function(response){
	     				
	     				var list = new Array();
	     				if( response != null){
	     					console.log("가져온 데이터입니다."+response);
	     					
	     					
	     					if(response == "" || response == "null" || response == null)
	     						alert("새로운 소식이 없습니다!");
	     					
	     					var data = $.parseJSON(response);     					
	     					$.each(data,function(i,value){     						
	     						list.push(value.num);
	     						list.push(value.title);
	     						list.push(value.alarmType);
	     						list.push(value.alarmNo);
	     					});     			
	     						     					
	     					for(var i=0;i<list.length;i++){
	     						console.log(list[i]+"/");
	     					}
	     					
	     					length = list.length/4;
	     					id = "news"+name;
	     					
	     					body = document.getElementById(id);
	     					
	     					var row;					
	     					for(var i=0;i<list.length;i+=4){
	     						
	     						row = body.insertRow();
	     						row.onmouseover = function() {
	     							body.clickedRowIndex = this.rowIndex;
	     						};
	     						
	     						var cell1 = row.insertCell(0);
	     						var d = list[i]+"/"+list[i+3]+","+name;	     						
	     						
	     						var cell2 = row.insertCell(1);
	     							     						
	     						cell1.innerHTML =  '<h5 class="news_contents '+list[i+2] +'" id='+d+'>'+ list[i+1]+'</h5>';
	     						cell2.innerHTML = "";
	     						
	     						rowcnt += 1;
	     					}
	     					
	     					$('#tablerow').attr('value',rowcnt);
	     						     				
	     				} else {
	     					alert("접근 실패했습니다.");	     					     					
	     				}
	     				
	     			},
	     			error : function(x,o,e){
	     				var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
	     				alert(msg);
	     			}
	     		});
             }
        }
	});
	
	$(document).on("click",".news_contents",function(){
		
		var clickRowId = $(this).attr('id');
		
		var index = clickRowId.indexOf('/');
		var s_index = clickRowId.indexOf(',');
		var detailNo = clickRowId.substring(0,index);
		var alarmNo = clickRowId.substring(index+1,s_index);
		var teamNo = clickRowId.substring(s_index+1, index.length)
		
		if(clickRowId != null){
			
			console.log('아이디 제대로 나옵니다. if입니다.')
			console.log(index + "/datail="+detailNo+"/alarm="+alarmNo+"/team="+teamNo);
			
			var rowClass = $(this).attr('class');
			
			
			if(rowClass.indexOf('meeting') > 0 || rowClass.indexOf('MEETING') > 0){
				goMeetingAlarm(detailNo, alarmNo, teamNo);
			}else if(rowClass.indexOf('notice') > 0 || rowClass.indexOf('NOTICE') > 0){
				goNoticeAlarm(detailNo, alarmNo, teamNo);
			}			
			
		}else{
			console.log('엘스입니다.')
		}
	});
	
	
	
	function doDel(teamNo){
	 
		var mytable = document.getElementById('news'+teamNo);
		
		var row = $('#tablerow').val();
		
		
		if( row == rowcnt ) {
			console.log("rowcnt='' 들어옴" + row+"/"+rowcnt);
			mytable.deleteRow(mytable.clickedRowIndex-3);
			rowcnt-=1;
			$('#tablerow').val(rowcnt);
					
		} else if( row == 'deleteAll'){
			
			console.log("else 들어옴"+row+"/"+rowcnt);
			for(var i=0;i<rowcnt;i++)
				mytable.deleteRow(i-3);
		}
	}
	
	function goNoticeAlarm(detailNo, alarmNo, teamNo){
		$('#goAlarmFrm').attr('action','<%=request.getContextPath() %>/NoticeController.do');
		$('#goAlarmCmd').val('notice_list');
		$('#detailNo').val(detailNo+"/"+alarmNo);
		$('#teamNo').val(teamNo);		
		$('#goAlarmFrm').submit();
	}
	function goMeetingAlarm(detailNo, alarmNo, teamNo){
		$('#goAlarmFrm').attr('action','<%=request.getContextPath() %>/MeetingController.do');
		$('#goAlarmCmd').val('meeting_list');		
		$('#detailNo').val(detailNo+"/"+alarmNo);		
		$('#teamNo').val(teamNo);		
		$('#goAlarmFrm').submit();
	}

	 
	$('.teamName').click(function(){
		
		table = $(this).attr("id");	
		id = '#'+table	
		var string;
		console.log(table+"/"+id);
		
		var frm = document.getElementById("teamChoiceform");
		
		if( id == "#createTeam"){
			string = "팀 생성하러 갑니다.";
			frm.cmd.value = "goCreateTeam";
		} else{
			string = "팀 선택입니다.";
			frm.selectedTeamNo.value = table;
		}
		
	
		
		frm.submit();
	});	
	
	$('.close').click(function(){
		
		idNo = $(this).attr("id");
		id = "#"+idNo;
		
		var frm = document.getElementById("deleteTeamform");
		
		frm.teamNo.value = idNo;
		
		frm.submit();
	});
	
</script>
</body>
</html>