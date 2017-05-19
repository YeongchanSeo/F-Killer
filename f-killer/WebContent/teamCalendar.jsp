<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FKILLER (Team Cooperation Project Program)</title>

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- <link rel='stylesheet' type='text/css' href='http://arshaw.com/css/main.css?6' /> -->
<link rel='stylesheet' type='text/css' href='http://arshaw.com/css/fullcalendar.css?3' />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel='stylesheet' type='text/css' href='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.css' />

<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-1.10.2.min.js'></script>
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-ui-1.10.3.custom.min.js'></script>
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.min.js'></script>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>

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
<script type='text/javascript'>
	$(document).ready(function() {
		$('#showCalendar').addClass('selectedMenu-tr');
		$('#showCalendar').find('th').find('a').addClass('selectedMenu-a');
		
		if( '${where}'!= null && '${where}' != "" && '${where}' != "null"){			
			$('.modal').css('z-index',"1050");
			$('.modal').css('top',"5%");
			$('#modalBody').load('MeetingController.do?cmd=one_meeting&meeting_no=${detailNo}');
			$('#fullCalModal').modal();			 
		}
				
		var list = new Array();
		var meetList = new Array();
		
		<c:forEach items="${job_list}" var="job">
			list.push("${job.jobNo}");
			list.push("${job.jobTitle}");
			var date = "${job.dueDate}";
			list.push(date.substring(0,4));
			list.push(date.substring(5,7));
			list.push(date.substring(8,10));
			list.push("${job.memberColor}");
			list.push("${job.userNo}");
		</c:forEach>
		
		<c:forEach items="${meeting_list}" var="meeting">
			meetList.push("${meeting.meetingNo}");
			var date = "${meeting.meetingDate}";
			meetList.push(date.substring(0,4));
			meetList.push(date.substring(5,7));
			meetList.push(date.substring(8,10));
		</c:forEach>
		
		
		var jobId = new Array();
		var meetingId = new Array();
		var events = [];

		for(var i=0;i<list.length;i+=7){						
			jobId.push(list[i]);
			var date = new Date(list[i+2], list[i+3]-1, list[i+4]);
			/* console.log(date); */
			/* console.log("번호:"+list[i]+"/제목:"+list[i+1]+"/마감일"+list[i+2]+"/"+list[i+3]+"/"+list[i+4]+"/담당자" + list[i+6]);
			console.log("id는 "+list[i]+"색깔은 "+list[i+5]); */
			events.push(
				{id: list[i], title : list[i+1], start: date , color : list[i+5] ,userNo : list[i+6]})
	    }
		
		for(var i=0;i<meetList.length;i+=4){					
			meetingId.push(meetList[i]+'/');
			var date = new Date(meetList[i+1], meetList[i+2]-1, meetList[i+3]);
			/* console.log(date); */
			/* console.log("번호:"+meetList[i]+"/회의일 : "+meetList[i+1]+"/"+meetList[i+2]+"/"+meetList[i+3]); */
			events.push(
				{id: meetList[i]+'/', title : "<span><i class='fa fa-user' style='font-size : 25px; color : #663300;'></i>&nbsp;회의</span>", start: date , color : '#ffffff', textColor : '#000000' })
	    }
		
		
		for(var i=0;i<jobId.length;i++){
			/* console.log("id는 "+jobId[i]); */
		}
		for(var i=0;i<meetingId.length;i++){
			/* console.log("meeting-id는 "+meetingId[i]); */
		}

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
				var index = (event.id).indexOf("/");				
				var meeting = event.id.substring(0,index);
				
				$('.modal').css('z-index',"1050");
				$('.modal').css('top',"5%");
				
	            if(index = (event.id).indexOf("/") > 0) {
	            	for(var j=0;j<meetingId.length;j++) {
	       				
						if(meeting == meetingId[j].substring(0,index+1) ){
							break;
						}						
					}
	            	$('#modalBody').load('MeetingController.do?cmd=one_meeting&meeting_no='+meeting);
	            } else {
	            	
	            	for(var j=0;j<jobId.length;j++){		
						if(event.id == jobId[j])
							break;
					}
	            	
	            	var auth;
	            	if("${user.userNo}"=="${team.leaderNo}"){
	     				auth = 'leader'; 
	     			}
	     			else if (event.userNo=='${user.userNo}'){
	     				auth = 'oneself';
	     			} else {
	     				auth = 'member';
	     			}
	            	$('#modalBody').load('JobController.do?cmd=one_job&where=teamCalendar&job_no='+jobId[j]+'&auth='+auth);
	            	//$('#modalBody').load('JobController.do?cmd=test&jobNo='+jobId[j]);
	            }				
	            $('#fullCalModal').modal();            
		    }
		});

	});
</script>
<style>
  .navbar {
		margin-bottom: 0;
		margin-top: 0;
		border-radius: 0;
		margin-bottom: 0px;
		margin-top: 0px;
		border-radius: 0px;
	}   
  .row.content {height: 500px}
  
  .sidenav {
    padding-top: 20px;
    height: 100%;
  }
  
  footer {
    height:50px;
    background-color: #555;
    color: white;
    padding: 15px;
  }
  
  @media screen and (max-width: 767px) {
    .sidenav {
      height: auto;
      padding: 15px;
    }
    .row.content {height:auto;} 
  }
</style>
</head>
<body>
	<div id="fullCalModal" class="modal fade" style="top:100%; left : 50%; width : 50%; height:700px; z-index:0;">
    <div class="modal-dialog" style="height : 700px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                	<span aria-hidden="true">×</span><span class="sr-only">close</span>
                </button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body" style="max-height : 600px; width : 95%"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid" style="background-color:#F4F2F2;">
		<div class="row-fluid content">
			<div class="span2 sidenav">
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10" style="background : white; box-shadow: 2px 2px 2px 1px #888888;">
				<div id='calendar' style='margin: 2em; font-size: 20px;' ></div>
			</div>
		</div>
	</div>
<!-- 	<footer class="container-fluid text-center">
		<p>Footer Text</p>
	</footer> -->



<script src="js/bootstrap.min.js"></script>
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

var savedLoc='${meeting.meetingLoc}';

//회의가 이미 등록되어 있을 때 등록된 회의 장소를 표시하기 위한 마커
var startmarker=null;
var startinfowindow=null;
//주소 검색을 위한 객체
var geocoder=new daum.maps.services.Geocoder();
if(savedLoc!=null){
	geocoder.addr2coord(savedLoc, function(status, result) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
			map.setCenter(coords);
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        startmarker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        startinfowindow = new daum.maps.InfoWindow({
	            content: '<div style="padding:5px;">'+result.addr[0].title+'</div>'
	        });
	        startinfowindow.open(map, startmarker);
		}
	});
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
        
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

var oldMarker=null;

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
	if(startmarker!=null){
		startmarker.setMap(null);
		startinfowindow.close();
	}
}
function sendAlarm(userNo){
	webSocket.send(userNo+'%e');
}
</script>
</body>
</html>