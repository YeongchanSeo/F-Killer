<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
	#teamHeader{
		/* background-color:${team.teamColor}; */
		/* background-color:  */
		border-bottom: 3px double lightgrey;
	}
	.modalInput{
		width : 100px;
	}
	#selectEmail{
		width : 120px;
	}
	#add-list{
		margin-left: 20px;
	}
		.modal.fade{
   	-webkit-transition: none;
   	-moz-transition: none;
   	-ms-transition: none;
   	-o-transition: none;
   	transition: none;
   }
</style>
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:300px; margin:0 auto; margin-left:-150px; height:70px; line-height:45px; margin-top:180px;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" style="text-align:center;">
					<i class="fa fa-spinner fa-pulse"></i>&nbsp;&nbsp;&nbsp;메일을 전송중입니다.
				</div>
			</div>
		</div>
	</div>
<input type="hidden" id="teamNo" value="${team.teamNo }"/>
<!-- Modal -->
	<div class="modal fade" id="inviteModal" style="display:none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="top:100%; z-index:0;" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" data-toggle="modal" data-target="#myModal2" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">팀원초대</h4>
				</div>
				<div class="modal-body">
					<input class = "modalInput" type="text" name="id" id="id"> @ 
					<input class = "modalInput" type="text" name="email" id="email" disabled value="naver.com">
					<select	name="selectEmail" id="selectEmail">
						<option value="1">직접입력</option>
						<option value="naver.com" selected>naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="dreamwiz.com">dreamwiz.com</option>
						<option value="hanmir.com">hanmir.com</option>
						<option value="paran.com">paran.com</option>
					</select> 
					<input type="button" id="add" class="btn btn-default" value="추가" />
				</div>
				<div class="modal-list">
					<div class="container-fluid" style = "margin:10px;">
						
							<table id="table" width = "100%" class = "table table-bordered">
								<thead>
									<tr onMouseover="document.all.table.clickedRowIndex=this.rowIndex">
										<th width ="60%">이메일</th>
										<th width ="30%">회원구분</th>
										<th width ="10%"></th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id ="commit" data-dismiss="modal" onclick="showModal2()">확인</button>
				</div>
			</div>
		</div>
	</div>

<div class="row-fluid" id="teamHeader" style="height:80px; margin-top:0px">
<div style="margin-top:10px">

  <div class="span5"></div>
  <div class="span3" style="margin-left:0px">
  	<div class="row-fluid">
  		<div class="span11"><a href="#" style="color:black; text-decoration : none;" onclick="goTeamHome()"><h2 style="text-align: center">${team.teamName }</h2></a></div>
  	</div>
  </div>
  <div class="span4" style="margin-left:0px">
  	<div class="row-fluid">
  		<div class="span10"><h5 class="" style="float:right">
  			<div class="dropdown" style="display:inline">
  		  		<a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-user fa-3x"  style="color:black"></i></a>
  		  		<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" style="margin-left:-10px">
  		  			<c:forEach items="${member_list }" var="member">
  		  				<li><a href="#">${member.name }(${member.email })</a></li>
  		  			</c:forEach>
				</ul>
  		  	</div>
  			&nbsp;&nbsp;
  			<font style="font-size:1.5em; vertical-align: 5px">${fn:length(member_list) }명</font></h5>
  		</div>
  		<div class="span2"><h5><a onclick="showInviteModal()" href="#inviteModal" data-toggle="modal" data-target="#inviteModal"><i class="fa fa-plus-circle fa-3x" style="color:#FF0087"></i></a></h5></div>
  	</div>
  </div>
</div>
<form id="teamMainFrm" action="<%=request.getContextPath()%>/TeamController.do" method="post">
	<input type="hidden" name="cmd" value="goHome"/>
</form>
</div>


<script>
function showModal2(){
	$('#myModal').modal('hide');
	var id = setInterval(frame, 37);
	var i=0;
    function frame() {
        if (i==10) {
            clearInterval(id);
            $('#myModal2').modal('show');
        }
        i++;
    }
}
$('#myModal2').on('show.bs.modal', function () {
	var id = setInterval(frame, 10);
    function frame() {
        if ($('#myModal2').hasClass('in')) {
        	commit();
            clearInterval(id);
            $('#myModal2').modal('hide');
        }
    }
	})
function showInviteModal(){
	$('#inviteModal').css("top","5%");
}
function goTeamHome(){
		$('#teamMainFrm').submit();
	}
var cnt = 0;
Map = function(){
	this.map = new Object();
};   
Map.prototype = {
		put : function(key, value) {
			this.map[key] = value;
		},
		get : function(key) {
			return this.map[key];
		},
		containsKey : function(key) {
			return key in this.map;
		},
		containsValue : function(value) {
			for ( var prop in this.map) {
				if (this.map[prop] == value)
					return true;
			}
			return false;
		},
		isEmpty : function(key) {
			return (this.size() == 0);
		},
		clear : function() {
			for ( var prop in this.map) {
				delete this.map[prop];
			}
		},
		remove : function(key) {
			delete this.map[key];
		},
		keys : function() {
			var keys = new Array();
			for ( var prop in this.map) {
				keys.push(prop);
			}
			return keys;
		},
		values : function() {
			var values = new Array();
			for ( var prop in this.map) {
				values.push(this.map[prop]);
			}
			return values;
		},
		size : function() {
			var count = 0;
			for ( var prop in this.map) {
				count++;
			}
			return count;
		}
	};	
	var map = new Map();
	
	$('#add').click(function() { //추가버튼 클릭
		var id = $('#id').val();
		var email = $('#email').val();
		var memberNo;
				
		if(id == ''){
			return;
		}
	
	//회원check
	$.ajax({
		url:"<%=request.getContextPath()%>/UserController.do",
								type : "get",
								dataType : "json",
								async : false,
								data : {
									"cmd" : "checkUser",
									"id" : $('#id').val(),
									"email" : $('#email').val()
								},
								success : function(response) {
									if (response == "-1") {
										memberNo = 0;
									} else {
										memberNo = response;
										map.put($('#id').val() + "@" + $('#email').val(),memberNo);
									}
								},
								error : function(x, o, e) {
									var msg = "페이지 호출 에러 : " + x.status
											+ "," + o + "," + e;
									alert(msg);
								}
							});

					//테이블에 추가
					var table = document.getElementById("table");
					var row = table.insertRow();
					row.onmouseover = function() {
						table.clickedRowIndex = this.rowIndex;
					}
					var cell1 = row.insertCell(0);
					var cell2 = row.insertCell(1);
					var cell3 = row.insertCell(2);

					var text = $('#table').html();

					cell1.innerHTML = id + '@' + email;

					if (memberNo != 0) {
						cell2.innerHTML = "회원";
					} else {
						cell2.innerHTML = "비회원";
					}

					cell3.innerHTML = '<i onclick="doDel()" class="fa fa-times"></i>';
					$('#id').val('');
					cnt++;
				});

function doDel() {
	var delPlace = document.all.table; // 삭제될테이블장소
	var email = delPlace.rows[delPlace.clickedRowIndex].cells[0].textContent;
	map.remove(email);
	delPlace.deleteRow(delPlace.clickedRowIndex);
	cnt--;

}
function commit() {
	//$('#inviteMember').html(cnt + '명');
	 var delPlace = document.all.table; 
     for(var i = 0; i < cnt;i++){
   		var isMember = delPlace.rows[i+1].cells[1].textContent;
   		var email = delPlace.rows[i+1].cells[0].textContent;
   		
   		if(isMember=="회원"){
				var teamNo = '${team.teamNo}';
				$.ajax({
           		url : "<%=request.getContextPath()%>/TeamController.do",
           		dataTyepe : "json",
           		type : "post",
           		async : false,
           		data : {
           			"cmd" : "inviteMember",
           			"userNo" : map.get(email) , 
           			"teamNo" : teamNo
           		},
           		success : function(response){
           			if(response=="1"){
           				alert("회원 초대 성공");
           				webSocket.send(map.get(email)+'%ee');
           			} else {
           				alert("회원 초대 실패");
           			}
           			
           		},
           		error : function(x,o,e){
						var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
						alert(msg);
					}
           	});              	
			}else {
				$.ajax({
           		url : "<%=request.getContextPath()%>/TeamController.do",
           		dataTyepe : "json",
           		type : "post",
           		async : false,
           		data : {
           			"cmd" : "sendEmail",
           			"email" : email , 
           			"teamName" : '${team.teamName }'
           		},
           		success : function(response){
           			if(response=="1"){
           				alert("회원 초대 성공");	
           			} else {
           				alert("회원 초대 실패");
           			}
           			
           		},
           		error : function(x,o,e){
						var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
						alert(msg);
					}
           	});
			}       		
   	}
	
	$('#inviteModal').css("top","100%");
}

$('#selectEmail').change(function() {
	$("#selectEmail option:selected").each(function() {

		if ($(this).val() == '1') { //직접입력
			$("#email").val(''); //값 초기화
			$("#email").attr("disabled", false);
		} else {
			$("#email").val($(this).text()); //선택값 입력
			$("#email").attr("disabled", true);
		}
	});
});
</script>