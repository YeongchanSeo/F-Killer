<%@page import="com.fkiller.web.contants.JobState"%>
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
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>
</head>
<body>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<div style="width:100%">	
	<div class="accordion" id="accordion2">
		<div class="accordion-group">
			<div class="accordion-heading">
				<a class="accordion-toggle" data-toggle="collapse" 
				data-parent="#accordion2" href="#collapseOne"> 공지
				</a>
			</div>
			<div id="collapseOne" class="accordion-body collapse in">
				<div class="accordion-inner">
					<c:forEach var="notice" items="${notice_list }">
						<a onclick="showModal(${notice.noticeNo })" href="#layerpop" data-toggle="modal">${notice.noticeTitle }</a><BR>	
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="accordion-group">
			<div class="accordion-heading">
				<a class="accordion-toggle" data-toggle="collapse"
					data-parent="#accordion2" href="#collapseTwo"> 회의
				</a>
			</div>
			<div id="collapseTwo" class="accordion-body collapse">
				<div class="accordion-inner">
					<c:forEach var="meeting" items="${meeting_list }">
						<a onclick="showMeetingModal(${meeting.meetingNo })" href="#layerpop" data-toggle="modal">${meeting.meetingTitle }</a><BR>	
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>	
	<!-- 모달 -->
	<div id="layerpop" style="top:100%;" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="myModalLabel">공지보기</h3>
		</div>
		<div class="modal-body" id="layerpop-modal-body">
			<!-- 공지 내용 -->
		</div>
		<div class="modal-footer">
			<div style="text-align: center">
		        <button type="button" id="modalOKBtn" class="btn btn-primary" style="margin-bottom:3px" data-dismiss="modal">확인</button>
	        </div>
		</div>
	</div>
	
	<script>
		function showModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/NoticeController.do?cmd=oneNotice&page=view&no='+no);
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null)
				$('#layerpop').css("top","100%");
			});
		}
		function showMeetingModal(no){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/MeetingController.do?cmd=one_meeting&meeting_no='+no);
			$('#layerpop').css("top","5%");
			$('#modalOKBtn').click(function(){
				$('#layerpop-modal-body').load(null);
				$('#layerpop').css("top","100%");
			});
		}
	</script>
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
		</script>
</body>
</html>