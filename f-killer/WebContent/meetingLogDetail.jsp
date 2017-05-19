<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
	.notice-box-outer{
		width:100%; 
		margin:auto; 
		text-align: center; 
		padding:15% 0 ;
	}
/* 	.notice-box-inner{
		width:50%; 
		margin:auto; 
		text-align: cneter; 
		border:solid 7px white; 
		border-radius:20px; 
		background-color:#F9DCDC; 
		box-shadow: 2px 2px 1px #888888;
	} */
	.notice-text{
		color:#672A2A;
	}
	.notice-icon{
		color:#EE5F5B; 
		margin-bottom:40px
	}
</style>
<style>
	.wrapper{
		width:480px;
		margin:15px auto;
	}
	.wrapper-form{
		margin: 20px;
	}
	label{
		width:60px;
		float:left;
		text-align: right;
	}
	.my{
		margin-left: 80px;
	}
	.partIn{
		width:20px;
		height:20px;
		display: inline-block;
		border-radius:50px;
	}
</style>

</head>
<body>
<c:choose>
	<c:when test="${meeting!=null }">
		<div class="wrapper">
		<h3 style="text-align: center">${meeting.meetingTitle }</h3>
		<form class="wrapper-form">
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
				<c:forEach items="${meeting.participants }" var="partIn" varStatus="status">
			  		<c:if test="${status.index % 4==0 and status.index!=0 }">
			  			<br>
			  		</c:if>
			  		<c:choose>
				  		<c:when test="${partIn.state==true }">
				  			<div class="partIn" style="background-color:${partIn.memberColor};"></div>&nbsp;<font style="margin-right:10px;vertical-align: 5px">${partIn.userName }</font>
				  		</c:when>
				  		<c:otherwise>
				  			<div class="partIn" style="background-color:grey;"></div>&nbsp;<font style="margin-right:10px;vertical-align: 5px;text-decoration: line-through;">${partIn.userName }</font>
				  		</c:otherwise>
			  	 	</c:choose>
			  	</c:forEach>
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
		  	<font>${meeting.meetingDesc }</font>
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
		</div>
	</c:when>
	<c:otherwise>
		<div class="notice-box-outer">
			<div class="notice-box-inner">
				<h3 class="notice-text">회의를 선택하세요.</h3><br>
				<i class="fa fa-users fa-5x notice-icon"></i>
			</div>
		</div>
	</c:otherwise>
</c:choose>

<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

var savedLoc='${meeting.meetingLoc}';
if(savedLoc==null){
	alert('저장된 장소 없음');
	savedLoc='서울특별시 동작구 동작대로 79-1';
}
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

</body>
</html>