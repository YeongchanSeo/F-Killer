<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel='stylesheet' type='text/css' href='http://arshaw.com/css/main.css?6' />
<link rel='stylesheet' type='text/css' href='http://arshaw.com/css/fullcalendar.css?3' />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel='stylesheet' type='text/css' href='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.css' />

<link rel="shortcut icon" href="img/icon/avicon.ico" type="image/x-icon">
<link rel="icon" href="img/icon/faviconico" type="image/x-icon">
<link rel="icon" type="image/png" sizes="32x32" href="img/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="img/icon/favicon-16x16.png">
<link rel="manifest" href="img/icon/manifest.json">

<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-1.10.2.min.js'></script>
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-ui-1.10.3.custom.min.js'></script>
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.min.js'></script>
<!-- <link rel="stylesheet" type="text/css" href="Content/fullcalendar/fullcalendar.print.css" /> -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>

<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

 -->

<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<title>FKILLER (Team Cooperation Project Program)</title>

<c:if test="${cmd != 'p_calendar'}" >
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen"> 
	<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-1.10.2.min.js'></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	
	
</c:if>

<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-ui-1.10.3.custom.min.js'></script>
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.min.js'></script>
<!-- <link rel="Stylesheet" type="text/css" href="/Content/fullcalendar/fullcalendar.print.css" /> -->

<style>
    .navbar {
      margin-bottom: 0;
      margin-top: 0;
      border-radius: 0;
    }
</style>

<script type='text/javascript'>
	$(document).ready(function() {

		var list = new Array();
		
		
		<c:forEach items="${job_list}" var="job">
				
			list.push("${job.jobNo}");
			list.push("${job.jobTitle}");
			var date = "${job.dueDate}";
			list.push(date.substring(0,4));
			list.push(date.substring(5,7));
			list.push(date.substring(8,10));			
			list.push("${job.teamNo}");
			list.push("${job.leaderNo}");
		</c:forEach>
		
		var jobId = new Array();
		//var userName = new Array();
		var events = [];

		for(var i=0;i<list.length;i+=7){						
			jobId.push(list[i]);
			//userName.push(list2[i/5]);
			var date = new Date(list[i+2], list[i+3]-1, list[i+4]);
			//console.log(date);
			console.log("번호:"+list[i]+"/제목:"+list[i+1]+"/마감일"+list[i+2]+"/"+list[i+3]+"/"+list[i+4]+"/담당자"+list[i+5]);
			events.push(
				{id: list[i], title : list[i+1], start: date , color : '#FF99CC' , teamNo : list[i+5], leaderNo : list[i+6] })
	    }
		
		for(var i=0;i<jobId.length;i++){
			console.log("id는 "+jobId[i] + "담당자는");
		}
		
		/* $('#profile').mouseenter(function() {
			alert("hihi");
		});
		 */
		
		$('.modal').css('z-index',"1050");
		$('#profile').css('z-index',"0");
		
 		$('#calendar').fullCalendar({
			 customButtons: {
			        myCustomButton: {
			            text: 'custom!',
			            click: function() {
			                alert('clicked the custom button!');
			            }
			        }
			    },
			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'month,agendaWeek,agendaDay'
			},
			editable : true,
			eventLimit: true,
			events : events,
			eventRender: function(event, element) {                                          
				element.find('span.fc-event-title').html(element.find('span.fc-event-title').text());					  
			},
			
			eventClick: function(event) {
				
				var j;				
				for(var j=0;j<jobId.length;j++){					
					if(event.id == jobId[j])
						break;
				}
				console.log("모달모달="+jobId[j]);
				
				var auth;
            	if('${user.userNo}'== event.leaderNo)
     				auth = 'leader'; 
     			else 
     				auth = 'oneself';
            	
								
				$('.modal').css('z-index',"1050");
				$('.modal').css('top',"5%");
				$('#profile').css('z-index',"1050");
				$('#modalTitle').html(event.title);
				
				$('#modalBody').load('<%=request.getContextPath()%>/JobController.do?where=personalCalendar&teamNo='+event.teamNo+'&cmd=one_job&job_no='+jobId[j]+'&auth='+auth);
				//$('#modalBody').load('JobController.do?cmd=test&jobNo='+jobId[j]);
		              
				
				$('#fullCalModal').modal(); 
		    }/* , eventMouseover: function(calEvent, jsEvent, view) {
               alert(calEvent.id);
       		}, */
			
		});
 		/* $('.modal').css('z-index',"0"); */

	});
	function sendAlarm(userNo){
		webSocket.send(userNo+'%e');
	}
</script>
</head>
<body style="background-color:#F4F2F2;">
<nav class="navbar" style="z-index:1050;">
  <jsp:include page="logoMenu.jsp" />
</nav>
<div class="container-fluid" style="background-color:#F4F2F2;">
	<div class="content" style="background : white; box-shadow: 2px 2px 2px 1px #888888;text-align : center;">
		<div id='calendar' style='margin: 1em; font-size: 25px; padding : 2em;'></div>
	</div>
</div>


 <div id="fullCalModal" class="modal fade" style="top:100%; left : 45%; width : 45%; height:700px; z-index:0;">
    <div class="modal-dialog" style="height : 700px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                	<span aria-hidden="true">×</span><span class="sr-only">close</span>
                </button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body" style="max-height : 600px;"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script src="js/bootstrap.min.js"></script>

</body>
</html>