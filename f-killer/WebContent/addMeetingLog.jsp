<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<div class="wrapper" style="margin:10px; padding:10px">
	<h3 style="text-align: center">${meeting.meetingTitle }</h3>
	<form class="wrapper-form" id="frm" action="#" method="post">
	  <input type="hidden" name="meeting_no" value="${meeting.meetingNo }"/>
	  <input type="hidden" name="cmd" value="write_meetingLog">
	  <fieldset>
		<legend style="margin-bottom:0px">Detail</legend>
		<div class="control-group">
		  <label for="meetingDate">회의일시</label>
		  <div class="my">
		      <font>${meeting.meetingDate }</font>&nbsp;&nbsp;<font>${meeting.meetingTime }</font>
		  </div>
		</div>
		<div class="control-group">
			<label for="partInList">참여자</label>
		  <div class="my">
		  	<div class="btn-group" data-toggle="buttons-checkbox">
				<c:forEach items="${meeting.participants }" var="entity" varStatus="status">
		  			<c:if test="${status.index mod 4==0 and status.index!=0}">
		  				<br/>
		  			</c:if>
					<c:set value="" var="check"></c:set>
					<c:set value="" var="click"></c:set>
					<c:if test="${entity.state == true}">
						<c:set value="checked" var="check"></c:set>
						<c:set value="active" var="click"></c:set>
					</c:if>
					<button type="button" class="btn btn-default ${click }" onclick="clickEvent(${entity.partInNo})"><i class="fa fa-circle" style="color:${entity.memberColor}"></i> ${entity.userName }</button>
					<input type="checkbox" id="c${entity.partInNo}" id="partIn" name="part_in" value="${entity.partInNo }" style="display:none " ${check }>
				</c:forEach>
			</div>
		  </div>
		</div>
		<div class="control-group">
		  <label for="meetingTopic">안건</label>
		  <div class="my">
		    <font>${meeting.meetingTopic }</font>
		  </div>
		</div>
	  </fieldset>
	  <fieldset style="margin-top:20px">
	  	<legend>Description</legend>
	  	<div class="my" style="margin:5px 0 0 0; width:100%">
	      <textarea rows="10" style="width:95%" name="meeting_desc" id="meetingDesc"></textarea>
	    </div>
	  </fieldset>
	  <fieldset style="margin-top:20px">
		  <legend style="margin-bottom:0px">Location</legend>
		  <div class="control-group" >
		    <font for="meetingLog">${meeting.meetingLoc }</font>
		    <div class="my" style="margin:5px 0 0 0; width:100%">
		      <div id="map" style="width:100%; height:240px; border:solid 1px grey; margin:0">
		      </div>
		    </div>
		  </div>
	  </fieldset>
	</form>
	<div style="text-align: center">
		<button type="button" class="btn btn-primary" style="width:20%" onclick="writeMeetingLog()">등록</button>
		<button type="button" class="btn btn-default" style="width:20%; margin-left:30px" onclick="cancel()">취소</button>
	</div>
</div>
<script>
	function cancel(){
		location.href='<%=request.getContextPath()%>/MeetingController.do?cmd=update_meeting&meeting_no=${meeting.meetingNo}';
	}
	function writeMeetingLog(){
		var participants = [];
		$('input[name="part_in"]:checked').each(function(i, e) {
			participants.push($(this).val());
		});
		if(participants.length<=0){
			alert('참여자를 선택해주세요.');
			return false;
		}
		alert('회의록 등록');
		var data = $("#frm").serialize();
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/MeetingController.do",
			datatype: "json",	
			data: data,
			success: function(response){		
				if(response=="OK"){
					alert("등록 되었습니다.");
					$('#refreshFrm',parent.document).submit();
				}else{
					alert("등록이 실패 되었습니다.");
				}
			},
			error: function(x,o,e){
				var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
				alert(msg);
			}
		}); 
	}
</script>
<script>
function clickEvent(cnt){
	var cid='#c'+cnt;
	if(!$(cid).prop("checked"))
		$(cid).prop('checked', true);
	else
		$(cid).prop('checked', false);
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
<script src="js/bootstrap.min.js"></script>