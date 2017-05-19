<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1a5a43dcf455843cbcd1228d00945cef&libraries=services"></script>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
	.wrapper{
		width:470px;
		margin:15px auto;
		/* margin:auto 5px; */
		overflow-x: hidden;
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
	#inlineCheckbox1{
		margin: 0 5px;
	}
</style>
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
<c:choose>
	<c:when test="${meeting!=null }">
		<div class="wrapper">
			<c:if test="${meeting.state == false }">
				<div style="float:right; margin-right:20px"><button class="btn btn-defualt" id="write-meetingLog-btn"><i class="fa fa-book"></i>&nbsp;회의록 등록</button></div><br>
				<script>
					$('#write-meetingLog-btn').click(function(){
						location.href='<%=request.getContextPath()%>/MeetingController.do?cmd=write_meetingLog&meeting_no=${meeting.meetingNo}';
					})
				</script>
			</c:if>
			<c:choose>
				<c:when test="${meeting.state == false }">
					<h3 style="text-align: center; margin-bottom:0px">회의일정 수정</h3>
					<!-- <form class="form-horizontal wrapper-form" id="frm" action="amodify_proc.jsp" method="post"> -->
					<form class="form-horizontal wrapper-form" id="frm" action="<%=request.getContextPath() %>/MeetingController.do" method="post">
					  <input type="hidden" name="meeting_no" value="${meeting.meetingNo }"/>
					  <input type="hidden" name="cmd" value="update_meeting">
					  <div class="control-group">
					    <label  for="meetingTitle">제목</label>
					    <div class="my">
					      <input style="width:320px" type="text" name="meeting_title" id="meetingTitle" placeholder="회의 제목을 입력해주세요.">
					    </div>
					  </div>
					  <div class="control-group">
					    <label for="meetingTopic">안건</label>
					    <div class="my">
					      <textarea rows="3" style="width:320px" name="meeting_topic" id="meetingTopic"></textarea>
					    </div>
					  </div>
					  <div class="control-group">
					  	<label for="partInList">참여자</label>
					    <div class="my">
							<div class="btn-group" data-toggle="buttons-checkbox">
							<c:choose>
								 <c:when test="${member_list!=null and fn:length(member_list)>0}">
							  		<c:forEach items="${member_list }" var="entity" varStatus="status">
							  			<c:if test="${status.index mod 4==0 and status.index!=0}">
							  				<br/>
							  			</c:if>
										<c:set value="" var="check"></c:set>
										<c:set value="" var="click"></c:set>
										<c:set value="0" var="partInNo"></c:set>
										<c:if test="${meeting !=null}">
											<c:forEach items="${meeting.participants }" var="partIn" >
												<c:if test="${partIn.userNo==entity.userNo }">
													<c:set value="checked" var="check"></c:set>
													<c:set value="active" var="click"></c:set>
													<c:set value="${partIn.partInNo }" var="partInNo"></c:set>
												</c:if>
											</c:forEach>
										</c:if>
										<button type="button" class="btn btn-default ${click }" onclick="clickEvent(${entity.userNo})"><i class="fa fa-circle" style="color:${entity.memberColor}"></i> ${entity.name }</button>
										<input type="checkbox" id="c${entity.userNo}" id="partIn" name="part_in" value="${entity.userNo }/${partInNo}" style="display:none" ${check }>${entity.userNo }/${partInNo}
									</c:forEach>
								 </c:when>
							</c:choose>	
							</div>
					    </div>
					  </div>
					  <div class="control-group">
					    <label  for="meetingDate">회의일</label>
					    <div class="my row-fluid">
					      <div class='input-group date span7' id='datepicker' data-date-format='yyyy-mm-dd'>
					          <input type='text' class="form-control" id="meetingDate" style="width:160px" name="meeting_date"/>
					          <span class="input-group-addon">
					              <button type="button" class="btn"><i class="fa fa-calendar"></i></button>
					          </span>
					      </div>
					      	<span>
					       	  <button type="button" class="btn" style="margin-left:0px; margin-top:"><i class="fa fa-thumbs-o-up"></i> 추천</button>
					        </span>
					      
					    </div>
					  </div>
					  <div class="control-group">
					    <label  for="meetingTime">회의시간</label>
					    <div class="my">
					      <div class='input-group date' id='timepicker'>
					      	  <span>
					      	  	<select class="span1" id="meetingTimeH" name="meeting_time_h">
					      	  		<c:forEach var="cnt" begin="0" end="23">
					      	  			<c:choose>
					      	  				<c:when test="${cnt<10 }">
					      	  					<option>0${cnt }</option>
					      	  				</c:when>
					      	  				<c:otherwise>
					      	  					<option>${cnt }</option>
					      	  				</c:otherwise>
					      	  			</c:choose>
					      	  		</c:forEach>
					      	  	</select>
					
					      	  </span>시 &nbsp;
					      	  <span>
					      	  	<select class="span1" id="meetingTimeM" name="meeting_time_m">
					      	  		<option>00</option>
					      	  		<option>05</option><option>10</option><option>15</option><option>20</option>
					      	  		<option>25</option><option>30</option><option>35</option><option>40</option>
					      	  		<option>45</option><option>50</option><option>55</option>
					      	  	</select>
					      	  </span>분
					      </div>
					    </div>
					  </div>
					  <div class="control-group">
					  	<input type="hidden" value="" name="meeting_loc" id="meetingLoc"/>
					    <label for="meetingLog" style="margin-top:5px">장소</label>
					    <div class="my" style="margin:5px 0 0 0; width:100%">
					      <input style="width:260px; margin-left:20px; margin-top:-5px;" type="text" id="search-text" placeholder="장소를 검색하세요.">
					      <button type="button" class="btn" onclick="searchTarget()" style="margin-top:-5px;">검색</button>
						  <div id="map" style="width:100%; height:240px; border:solid 1px grey; margin-top:10px">
						  </div>
					    </div>
					  </div>
					  
					</form>
					
				</c:when>
				<c:otherwise>
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
									<input type="checkbox" id="c${entity.partInNo}" id="partIn" name="part_in" value="${entity.partInNo }" style="display:none" ${check }>
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
					      <textarea rows="10" style="width:95%" name="meeting_desc" id="meetingDesc">${meeting.meetingDesc }</textarea>
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
				</c:otherwise>
			</c:choose>
			<div class="control-group" style="text-align: center">
			  	 <button class="btn btn-default" style="width:20%; background:#FF0087; color:white "onclick="getLocation()">수정</button>
			  	 <button class="btn btn-default" style="width:20%;margin-left:40px; background:white" onclick="deleteMeeting()">삭제</button>
			</div>
			<form id="deleteFrm" action="<%=request.getContextPath()%>/MeetingController.do" method="get">
				<input type="hidden" name="cmd" value="delete_meeting">
				<input type="hidden" name="meeting_no" value="${meeting.meetingNo }">
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
function clickEvent(cnt){
	var cid='#c'+cnt;
	var pid='#p'+cnt;
	if(!$(cid).prop("checked")){
		$(cid).prop('checked', true);
		$(pid).prop('checked', true);
	}else{
		$(cid).prop('checked', false);
		$(pid).prop('checked', false);
	}
}

</script>
<script>
	function deleteMeeting(){
		
		$.ajax({
			type: "get",
			url: "<%=request.getContextPath()%>/MeetingController.do",
			datatype: "json",	
			data: {
				"cmd" : "delete_meeting",
				"meeting_no" : '${meeting.meetingNo}'
			},
			success: function(response){		
				if(response=="OK"){
					alert("삭제 되었습니다.");
					$('#refreshFrm',parent.document).submit();
				}else{
					alert("삭제가 실패 되었습니다.");
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
	$(document).ready(function(){
		if('${meeting.meetingTitle}' !=null){
			$('#meetingTitle').val('${meeting.meetingTitle}');
			$('#meetingTopic').val('${meeting.meetingTopic}');
			$('#search-text').val('${meeting.meetingLoc}');
			$('#meetingDate').val('${meeting.meetingDate}');
			$('#meetingDesc').val('${meeting.meetingDesc}');
			var meetingTime='${meeting.meetingTime}';
			var timeH=meetingTime.substring(0, 2);
			var timeM=meetingTime.substring(3, 5);
			$('#meetingTimeH').val(timeH);
			$('#meetingTimeM').val(timeM);
		}
	});
</script>

<script type="text/javascript">
    $(function () {
        $('#datepicker').datepicker({
            autoclose:true,
            todayHighlight:true
        }).datepicker('update',new Date());
    });
</script>
	
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

var savedLoc='${meeting.meetingLoc}';
var oldMarker=null;
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
			oldMarker=startmarker;
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

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places(); 



function searchTarget(){
// 키워드로 장소를 검색합니다
	var target=document.getElementById("search-text").value;
	ps.keywordSearch(target, placesSearchCB);

}
// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (status, data, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new daum.maps.LatLngBounds();

        for (var i=0; i<data.places.length; i++) {
            displayMarker(data.places[i]);    
            bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
           
        }

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }
}


// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
	if(startmarker!=null){
		startmarker.setMap(null);
		startinfowindow.close();
	}
	
	//기본이미지
	var dimageSrc='img/defaultmarker.png',
	dimageSize=new daum.maps.Size(45,40),
	dimageOption={offset:new daum.maps.Point(13,40)};
	var dmarkerImage=new daum.maps.MarkerImage(dimageSrc,dimageSize,dimageOption);
	
    // 마커를 생성하고 지도에 표시합니다
    var marker = new daum.maps.Marker({
    	image:dmarkerImage,
        map: map,
        position: new daum.maps.LatLng(place.latitude, place.longitude) 
    });
    
    //체크이미지
	var imageSrc='img/checkmarker.png',
		imageSize=new daum.maps.Size(27,40),
		imageOption={offset:new daum.maps.Point(13,40)};
	var markerImage=new daum.maps.MarkerImage(imageSrc,imageSize,imageOption);
	
    // 마커에 클릭이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'click', function() {
    	if(oldMarker!=null){
    		oldMarker.setImage(dmarkerImage);
    	}
    	oldMarker=marker;
    	
        marker.setImage(markerImage);
    });
    daum.maps.event.addListener(marker,'mouseover',function(){
    	// 마커에 마우스를 올리면 장소명이 인포윈도우에 표출됩니다
    	infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title + '</div>');
		infowindow.open(map,marker);
    });
    daum.maps.event.addListener(marker,'mouseout',function(){
    	infowindow.close();
    });
}
//회의등록시 선택한 마커의 도로명 주소를 가져옴
function getLocation(){
	var participants = [];
	$('input[name="part_in"]:checked').each(function(i, e) {
		participants.push($(this).val());
	});
	if(participants.length<=0){
		alert('참여자를 선택해주세요.');
		return false;
	}
	searchDetailAddrFromCoords(oldMarker.getPosition(),function(status,result){
		if(status===daum.maps.services.Status.OK){
			var detailAddr = result[0].jibunAddress.name;
			$('#meetingLoc').val(detailAddr);
			var data = $("#frm").serialize();
			$.ajax({
				type: "post",
				url: "<%=request.getContextPath()%>/MeetingController.do",
				datatype: "json",	
				data: data, 	
				success: function(response){		
					if(response=="OK"){
						alert("저장 되었습니다.");
						$('#refreshFrm',parent.document).submit();
					}else{
						alert("저장이 실패 되었습니다.");
						$('#meetingTitle').focus();
					}
				},
				error: function(x,o,e){
					var msg="페이지 호출 에러: "+x.status +","+o+","+e;	//500번 error (server측의 에러 :java코드 또는 db가 꺼졌을 때)
					alert(msg);
				}
			}); 
			
		}
	});
};

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2addr(coords, callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2detailaddr(coords, callback);
}
</script>
<script src="js/bootstrap.min.js"></script>