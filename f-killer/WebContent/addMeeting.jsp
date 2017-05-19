<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>

<style>
	.wrapper{
		width:500px;
		margin:auto;
	}
	.wrapper-form{
		margin: 20px;
		margin-top:40px
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

<div class="wrapper">
<h3 style="text-align: center; margin-bottom:0px">회의일정 등록</h3>

<form class="form-horizontal wrapper-form" id="frm" action="<%=request.getContextPath() %>/MeetingController.do" method="post">
  <input type="hidden" name="cmd" value="add_meeting">
  <div class="control-group">
    <label  for="meetingTitle">제목</label>
    <div class="my">
      <input style="width:340px" type="text" name="meeting_title" id="meetingTitle" placeholder="회의 제목을 입력해주세요.">
    </div>
  </div>
  <div class="control-group">
    <label for="meetingTopic">안건</label>
    <div class="my">
      <textarea rows="3" style="width:340px" name="meeting_topic" id="meetingTopic"></textarea>
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
					<button type="button" class="btn btn-default" onclick="clickEvent(${entity.userNo})"><i class="fa fa-circle" style="color:${entity.memberColor}"></i> ${entity.name }</button>
					<input type="checkbox" id="c${entity.userNo}" id="partIn" name="part_in" value="${entity.userNo }" style=" display:none ">
				</c:forEach>
			 </c:when>
		</c:choose>	
		</div>
    </div>
  </div>
  <div class="control-group">
    <label  for="meetingDate">회의일</label>
    <div class="my row-fluid">
      <div class='input-group date span6' id='datepicker' data-date-format='yyyy-mm-dd'>
          <input type='text' class="form-control" id="meetingDate" style="width:160px" name="meeting_date"/>
          <span class="input-group-addon">
              <button type="button" class="btn" id="dateSelectBtn"><i class="fa fa-calendar"></i></button>
          </span>
      </div>
      	<span>
       	  <button type="button" class="btn" style="margin-left:20px; margin-top:" onclick="recommendTime()"><i class="fa fa-thumbs-o-up"></i> 추천</button>
        </span><br>
      	
    </div>
  </div>
  <div class="control-group" id="recommend-time-table">
  	  <%@include file="timeTable.jsp"%>
  </div>
  <script>
 	  $(document).ready(function(){
 		  $('#recommend-time-table').hide();
 	  });
 	  
 	 function initTimeTable(){
		var participants = [];
		$('input[name="part_in"]:checked').each(function(i, e) {
			participants.push($(this).val());
		});
		if(participants.length<=0){
			alert('참여자를 선택해주세요.');
			return false;
		}
		var list = new Array();
		$.ajax({
			url : "<%=request.getContextPath()%>/TeamController.do",
			type : "post",
			dataType : "json",
			async : false,
			data : {
				"cmd" : "recommend_time_table",
				"participants" : participants.join(),
			},
			success : function(response){
											
				$.each(response,function(i,value){
					list.push(value.data);
				});	
				for(var i=1;i<=7;i++){
					for(var j=1;j<=24;j++){
						var res = list[i-1].substring(j-1,j);
						
						if(res==1){
							$('#'+j + "-" + i).addClass("checked");
						}
					}
				}
			},
			error : function(x,o,e){
					var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
					alert(msg);
			}
		});
		
		return true;
	}
 	  function clearTimeTable(){
 		 for(var i=1;i<=7;i++){
				for(var j=1;j<=24;j++){
					$('#'+j + "-" + i).removeClass("checked");
				}
			}
 	  }
 	  
 	  function recommendTime(){
 		  var timeTable =$('#recommend-time-table');
 		  if(timeTable.css('display')=='none'){
 			  var result = initTimeTable();
 			  if(result){
 				$("td.class").off("click");
 			  	timeTable.show();
 			  }
 		  }else{
 			  clearTimeTable();
 			  timeTable.hide();
 		  }
 	  }
 	  
  </script>
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
      <input style="width:280px; margin-left:20px; margin-top:-5px;" type="text" id="search-text" placeholder="장소를 검색하세요.">
      <button type="button" class="btn" onclick="searchTarget()" style="margin-top:-5px;">검색</button>
	  <div id="map" style="width:100%; height:240px; border:solid 1px grey; margin-top:10px">
	  </div>
    </div>
  </div>
  
</form>
</div>

<script>
function clickEvent(cnt){
	var cid='#c'+cnt;
	if(!$(cid).prop("checked"))
		$(cid).prop('checked', true);
	else
		$(cid).prop('checked', false);
}
</script>

<script type="text/javascript">
    $(function () {
        $('#datepicker').datepicker({
            //format: 'LL'
            autoclose:true,
            todayHighlight:true
        }).datepicker('update',new Date());
    });
</script>



<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

var savedLoc='서울특별시 동작구 동작대로 79-1';

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
	            content: '<div style="padding:5px;">회의장소</div>'
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

var oldMarker=null;

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
	if(oldMarker==null){
		alert("회의장소를 선택해주세요.");
		return false;
	}
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
						location.href="MeetingController.do?type=leader";
						return true;
					}else if(response=="EXIST"){
						alert('이미 회의가 존재하는 날짜입니다.');
						$('#dateSelectBtn').focus();
						return false;
					}else{
						alert("저장이 실패 되었습니다.");
						$('#meetingTitle').focus();
						return false;
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
