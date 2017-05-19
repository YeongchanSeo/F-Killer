<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, java.io.*" %>
<%@ page import="com.fkiller.web.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	try {
		  String str = "<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>"
				 	 + "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
		  			 + "<title>FKILLER (Team Cooperation Project Program)</title>"
		  			 + "<script	src='https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js'></script>"
		  			 + "<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>"
		  			 + "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css'>"
  					 + "<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css'/>"
		  			 + "<script src='https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js'></script>"
		  			 + "<script src='https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js'></script>"
					 + "<link rel='shortcut icon' href='img/icon/avicon.ico' type='image/x-icon'>"
		  			 + "<link rel='icon' href='img/icon/favicon.ico' type='image/x-icon'>"
		  			 + "<link rel='icon' type='image/png' sizes='32x32' href='img/icon/favicon-32x32.png'>"
		  			 + "<link rel='icon' type='image/png' sizes='96x96' href='img/icon/favicon-96x96.png'>"
		  			 + "<link rel='icon' type='image/png' sizes='16x16' href='img/icon/favicon-16x16.png'>"
		  			 + "<link rel='manifest' href='img/icon/manifest.json'>"
					 + "<style>body{background-color:#F4F2F2;}.navbar {margin-bottom: 0;margin-top: 0;border-radius: 0;margin-bottom: 0px;"
		  			 + "margin-top: 0px;border-radius: 0px;}"
					 + ".row.content {height: 500px}"
					 + ".sidenav {padding-top: 20px;height: 100%; }"
					 + "footer {height: 15px;background-color: #555;color: white;padding: 15px;}"
					 + "@media screen and (max-width: 767px) {.sidenav {height: auto;padding: 15px;}"
		  			 + ".row.content {height: auto;}}"
		  			 + ".outer{border-left:1px double lightgray;padding-left:20px;margin-left:0px;}"
		  			 + ".span6{margin-left:15px;}"
		  			 + ".contents1{height:700px; position:relative; overflow-y:scroll; overflow-x:hidden;background-color:white; /* margin:10px 0 0 15px; */ border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;"
		  			 + "margin-top:10px;}"
		  			 + ".contents2{width:100%; height:700px; border:none; margin:10px; border-radius:5px; box-shadow: 2px 2px 2px 1px #888888;}"
		  			 + ".container-wrapper{background-color:#F4F2F2;}"
		     		 + "#box{border:2px solid #aaaaaa;padding: 50px 70px;margin:30px auto;background: white;box-shadow: 2px 2px 2px 1px #888888;}"
		        	 + ".progress-custom.progress-striped .bar, .progress-striped .bar-info {background-color: #EAE333;}"
		     		 + ".progress-info.progress-striped .bar, .progress-striped .bar-info {background-color: #3365EA;}"
		     		 + ".row-fluid .span4{margin-left: 0px;}</style></head></body>";
		  		 str += "<div id='outer'><div class='container' id='box'><div class='row-fluid'>"
					 + "<input type='hidden' value='"+((TeamVo)session.getAttribute("team")).getTeamName()+"' id='teamName'/>"
					 + "<h2 class='text-center'>"+((TeamVo)session.getAttribute("team")).getTeamName() +"</h2>"
					 + "<h5 class='text-center'>프로젝트 기간 : "+request.getAttribute("startDate")+"&nbsp;&nbsp;~&nbsp;&nbsp;"+ request.getAttribute("endDate")+"</h5><br/>"
					 + "</div><div class='row-fluid'><div class='pull-right'>"
				     + "<p class='text-left'>팀장 : " +request.getAttribute("leader")+"</p>"
					 + "<p class='text-left'>팀원 : ";
				     int i=0;
				     for(TeamMemberVo member: (java.util.List<TeamMemberVo>)session.getAttribute("member_list")){
		    			  if(!member.getName().equals(request.getAttribute("leader"))){
		    				  str+=member.getName()+"&nbsp";
		    			  } if(i%5==0&&i!=0){
		    				  str+="</p><p class='text-left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		    			  }
		    		  }
				 int temp = (Integer)request.getAttribute("done");
    			 double done = temp;
				 str += "</p></div></div><div class='row-fluid'>"
					 + "<h4 class='text-left'>프로젝트 진행상황</h4><p>전체 "+request.getAttribute("done")+"/"+request.getAttribute("jobNumber")+"</p>"
					 + "<div class='row-fluid'><div class='progress progress-striped active span11'>"
					 + "<div class='bar' style='width: "+done/(Integer)request.getAttribute("jobNumber")*100+"%;'></div></div>"
					 + "<p class = 'span1'>"+(int)(done/(Integer)request.getAttribute("jobNumber")*100)+"%</p>"			
					 + "</div></div>"
					 + "<div class='row-fluid'><p style='margin-bottom:0px;'>작업상태별</p><div id='bar-chart'></div></div>"
					 + "<div class='row-fluid'>"
					 + "<h4 class='text-left'>개인별 진행상황</h4>"
					 + "<div class='row-fluid report'>";
					 int cnt=0;
					 for(ReportVo report: (java.util.List<ReportVo>)session.getAttribute("report_list")){
			    		  str+= "<div class='span4'>"
			    		  + "<p>"+report.getUserName();
			    		  if(report.getUserName().equals(request.getAttribute("leader")))
			    			  str+= "<i style='color:orange;'class='fa fa-star fa-lg'></i>";
			    		  str += "</p>"
						  + "<div id='donut-chart"+cnt+"'></div>"
						  + "<p class='text-center'>작업진행률 :" +  report.getJobState()[3]+"/"+ report.getJobs()+ "</p>"
						  + "<p class='text-center'>회의출석률 :" + report.getPartInMeeting()+"/"+report.getTotalMeeting() + "</p>"
						  + "<p class='text-center'>정시마감률 :" + report.getCompletion()+"/"+report.getClosed()+"</p>"
						  + "</div>";
						  	cnt++;
		    		  }
				  str += "</div></div></div></div>";
				  str += "<script src='https://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js'></script>"
					  + "<script>new Morris.Bar({"
					  + "element: 'bar-chart',"
					  +  "data: ["
					  + "{ y: 'to do', a: '"+request.getAttribute("toDo")+"'}, { y: 'in progress', a: '"+request.getAttribute("inProgress")+"'},	{ y: 'permission', a: '"+request.getAttribute("permission")+"'},"
					  + "{ y: 'done', a: '"+request.getAttribute("done")+"'},{ y: 'expired', a: '"+request.getAttribute("expired")+"'} ],"
					  + " xkey: 'y', ykeys: ['a'],  labels: ['작업량'],"
					  + "barColors: function (row, series, type) {if(row.label == 'to do') return '#EEED39';"
					  + "else if(row.label == 'in progress') return '#F89406';"
					  + "else if(row.label == 'permission') return '#062BF8';"
					  + "else if(row.label == 'done') return '#08B900'; else if(row.label == 'expired') return '#E24141';"
					  + "},hideHover : true,"
					  + "resize : true, grid : true,"
					  + "barSizeRatio:0.3});"
				      + "var chart = new Array();var todo = new Array();var inprogress = new Array();var permission = new Array();"
					  + "var done = new Array();var expired = new Array();";	
					  for(ReportVo report: (java.util.List<ReportVo>)session.getAttribute("report_list")){
					  	str+="todo.push(\""+report.getJobState()[0]+"\");";
					    str+="inprogress.push(\""+report.getJobState()[1]+"\");";
					  	str+="permission.push(\""+report.getJobState()[2]+"\");";
					  	str+="done.push(\""+report.getJobState()[3]+"\");";
					  	str+="expired.push(\""+report.getJobState()[4]+"\");";
					  }

				str+="for(var i = 0 ; i < "+request.getAttribute("memberNumber")+";i++){"
					+"var cmt=0;"
					+"chart[i] = Morris.Donut({"
					+" element: 'donut-chart'+i,"
					+" data: ["
					+" {label: 'to do', value: 2 }, {label: 'in progress', value: 5}, {label: 'permission', value: 6},"
					+" {label: 'done', value: 2},"
					+" {label: 'expired', value: 3},"	    
					+"	  ],"
					+"	  colors:['#EEED39','#F89406','#062BF8','#08B900','#E24141']"
					+"	});	"
					+"chart[i].setData([{label:'to do', value:todo[i]},"
					 +"                   {label:'in progress', value:inprogress[i]},"
					 +"                   {label:'permission', value:permission[i]},"
					 +"                   {label:'done', value:done[i]},"
					  +"                  {label:'expired', value:expired[i]}]);	"
					+"chart[i].select(0);}";
				  str += "</script></body></html>";

		  Calendar calender = Calendar.getInstance();
		  int year = calender.get(Calendar.YEAR);
		  System.out.println(year);
		  int month = calender.get(Calendar.MONTH)+1;
		  int date = calender.get(Calendar.DAY_OF_MONTH);
		  File dir = new File("C:/temp");
		  if(!dir.exists())
			  dir.mkdirs();
	      BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new DataOutputStream(new FileOutputStream("C:/temp/report.html")),"UTF-8"));
	      bw.write(str);
	      bw.flush();
	      bw.close();
	      System.out.println("Done.");
	      }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/favicon.ico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">

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
   #box{
   	border:2px solid #aaaaaa;
   	padding: 50px 70px;
   	margin:30px auto;
   	background: white;
  	box-shadow: 2px 2px 2px 1px #888888;
   }
      .progress-custom.progress-striped .bar, .progress-striped .bar-info {
       background-color: #EAE333; /*노랑색*/
   }
   .progress-info.progress-striped .bar, .progress-striped .bar-info {
       background-color: #3365EA; /*파랑색*/
   }
   
   .row-fluid .span4{
   		margin-left: 0px;
   }
</style>

</head>
<body>
	<div class="modal hide" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:300px; margin:0 auto; margin-left:-150px; height:70px; line-height:45px; top:39%;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" style="text-align:center;">
					<i class="fa fa-spinner fa-pulse"></i>&nbsp;&nbsp;&nbsp;메일을 전송중입니다.
				</div>
			</div>
		</div>
	</div>
	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid container-wrapper">
		<div class="row-fluid content">
			<div class="span2 sidenav">
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10 outer">	
				<div id="outer" >
					<div class="container" id="box">
						<div class="row-fluid">
							<button type="submit" class="btn btn-large" style="float:right; background : #FF0087; color:white" id="sendReport" >보내기</button><br><br>
							<input type="hidden" value="${team.teamName }" id="teamName"/>
							<h2 class="text-center">${team.teamName} </h2>
							<h5 class="text-center">프로젝트 기간 : ${startDate}&nbsp;&nbsp;~&nbsp;&nbsp; ${endDate }</h5><br/>
						</div>
						<div class="row-fluid">
							<div class="pull-right">
								<p class="text-left">팀장 : ${team.leaderName }</p>
								
								<p class="text-left">팀원 : <c:forEach items="${member_list }" var="member" varStatus="status">
									<c:if test="${member.name!=leader }">${member.name }</c:if>
									<c:if test="${status.index %5 == 0 and status.index!=0 }">
										</p>
										<p class="text-left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
								</c:forEach></p>
							</div>
						</div>
						<div class="row-fluid">
							<h4 class="text-left">프로젝트 진행상황</h4>
							<p>전체 ${done }/${jobNumber}</p>
								<div class="row-fluid">
									<div class="progress progress-striped active span11">
										<div class="bar" style="width: ${done/jobNumber*100}%;"></div>
									</div>
									<p class = "span1"><fmt:formatNumber value="${done/jobNumber*100}" pattern="#.##"/>%</p>			
								</div>
						</div>
						<div class="row-fluid">
							<p style="margin-bottom:0px;">작업상태별</p>
							<div id="bar-chart"></div>
						</div>
						<div class="row-fluid">
							<h4 class="text-left">개인별 진행상황</h4>
							<div class="row-fluid report">
								<c:set var="cnt" value="0"/>
								<c:forEach items="${report_list }" var="report">
									<div class="span4">
										<p>${report.userName} <c:if test="${report.userName==leader }"><i style="color:orange;"class="fa fa-star fa-lg"></i></c:if></p>
										<div id="donut-chart${cnt }"></div>
										<c:set var="cnt" value="${cnt+1}"/>
										<p class="text-center">작업진행률 : ${report.jobState[3]}/${report.jobs}</p>
										<p class="text-center">회의출석률 : ${report.partInMeeting }/${report.totalMeeting }</p>
										<p class="text-center">정시마감률 : ${report.jobState[3] }/${report.jobState[3] + report.jobState[4] }</p>
									</div>
								</c:forEach>
							</div>		
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <footer class="container-fluid text-center">
			<p>Footer Text</p>
		</footer> -->
	</div>	
			<script src="js/bootstrap.min.js"></script>
			<script>
			$(document).ready(function(){
				$('#showReport').addClass('selectedMenu-tr');
				$('#showReport').find('th').find('a').addClass('selectedMenu-a');
			});
			
			
			new Morris.Bar({
				  element: 'bar-chart',
				  data: [
				    { y: 'to do', a: '${toDo}'},
				    { y: 'in progress', a: '${inProgress}'},
				    { y: 'permission', a: '${permission}'},
				    { y: 'done', a: '${done}'},
				    { y: 'expired', a: '${expired}'} 
				  ],
				  xkey: 'y',
				  ykeys: ['a'],
				  labels: ['작업량'],
				  barColors: function (row, series, type) {
					  if(row.label == "to do") return "#EEED39";
					  else if(row.label == "in progress") return "#F89406";
					  else if(row.label == "permission") return "#062BF8";
					  else if(row.label == "done") return "#08B900";
					  else if(row.label == "expired") return "#E24141";
					  },
				  hideHover : true,
				  resize : true,
				  grid : true,
				  barSizeRatio:0.3
				});
			var chart = new Array();
			var todo = new Array();
			var inprogress = new Array();
			var permission = new Array();
			var done = new Array();
			var expired = new Array();
			
			<c:forEach items="${report_list}" var="state">
				todo.push("${state.jobState[0]}");
				inprogress.push("${state.jobState[1]}");
				permission.push("${state.jobState[2]}");
				done.push("${state.jobState[3]}");
				expired.push("${state.jobState[4]}");
			</c:forEach>
			for(var i = 0 ; i < '${memberNumber}';i++){
				var cmt=0;
				chart[i] = Morris.Donut({
					  element: 'donut-chart'+i,
					  data: [
					    {label: "to do", value: 2 },
					    {label: "in progress", value: 5},
					    {label: "permission", value: 6},
					    {label: "done", value: 2},
					    {label: "expired", value: 3},	    
					  ],
					  colors:['#EEED39','#F89406','#062BF8','#08B900','#E24141']	 
					});	
				//분기처리해서 개별적으로 데이터 세팅하는 방법밖에 없을까...
				chart[i].setData([{label:"to do", value:todo[i]},
				                    {label:"in progress", value:inprogress[i]},
				                    {label:"permission", value:permission[i]},
				                    {label:"done", value:done[i]},
				                    {label:"expired", value:expired[i]}]);	
				chart[i].select(0);
			}
			$( "#sendReport" ).click(function() {
				$('#myModal').modal('show');
				$.ajax({
              		url : "<%=request.getContextPath()%>/TeamController.do",
              		dataTyepe : "json",
              		type : "post",
              		data : {
              			"teamName": $('#teamName').val(),
              			"cmd" : "sendReport",
              		},
              		error : function(x,o,e){
						var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
						//alert(msg);
					}
              	})
			    var width = 0;
			    var id = setInterval(frame, 20);
			    function frame() {
			        if (width == 100) {
			            clearInterval(id);
			            $('#myModal').modal('hide');
			        } else {
			            width++; 
			        }
			    }
            	})
		
			</script>
</body>
</html>	