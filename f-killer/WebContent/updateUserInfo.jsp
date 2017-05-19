<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
if(request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

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
	.img-rounded {
		width : 170px;
		height : 220px;
	}

.navbar {
      margin-bottom: 0;
      margin-top: 0;
      border-radius: 0;
    }
#submit {
	width : 370px;
	margin-left : 130px;
	border :0;
	outline:0;
}
#timetable{
	background: white;
	font-size : 40px;
	width:60px;
	height:60px;	
	border :0;
	outline:0;
}
#divTitle{
	text-align : center;
}
.info{
	width : 350px;
	background:black;
}
#layerpop{
	width:50%;
	margin-left: -25%;
}
.modal .modal-body {
    max-height: 80%;
}
.ji {
	
}

.where {
  display: block;
  margin: 25px 15px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
}

/* imaged preview */
.filebox .upload-display {
	margin-bottom: 5px;
}

@media(min-width: 768px) {
	.filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap {
	display: inline-block;
	width: 200px;
	padding: 2px;
	vertical-align: middle;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
}

.filebox .upload-display img {
	display: block;
	max-width: 200px;
	width: 100% /5;
	height: auto;
}

.filebox.bs3-primary label {
  color: #fff;
  background-color: #FF6699;
 /*  background-color: #337ab7; */
	border-color: #FF6699;
}

</style>
</head>
<body style="background-color:#E7E7E7">
	<c:set var="isTimeTable" value="false"/>
	<div class="modal hide fade" id="timeTableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">시간표 등록</h4>
				</div>
				<!-- body -->
				<div class="modal-body" id="layerpop-modal-body">
					<%@include file="timeTable.jsp"%>
				</div>
				<!-- Footer -->
				<div class="modal-footer">
					<div style="text-align: center">
						<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
   						<button class="btn btn-primary" id = "save">변경사항 저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<nav class="navbar">
		<jsp:include page="logoMenu.jsp" />
	</nav>
	
	<div class="container">
		<div class="row-fluid" style="width: 730px; margin:10% auto; padding:5%; background-color:white; border-radius:10px; box-shadow: 3px 3px 2px #888888;">
			<div class="span12">
				<h3 class="text-center" style="margin-bottom : 20px;">회원정보 수정</h3>
				
			<form method="post" action="<%=request.getContextPath()%>/FileUplodeController.do" id="form" enctype="multipart/form-data">
				<div style="margin : auto;">
				<div class="row-fluid" style="margin:10px;">
					<div class="offset2 span3" >
						<c:if test="${user.userProfile !=null}">
							<img src="img/userProfile/${user.userProfile }" alt="사진없음" class="img-rounded"/><BR>
						</c:if>
						<c:if test="${user.userProfile == null }">
							<img src="img/userProfile/default-avatar.png" alt="사진없음" class="img-rounded"/><BR>
						</c:if>
						<!-- <button type="button" class="filebox" style = "margin-top: 10px;" id="addProfile">사진등록</button> -->
						 <div class="filebox bs3-primary preview-image" style="margin-top : 5px;">
							<input class="upload-name" value="${user.userProfile }" disabled="disabled" style="width: 45%;" id="profileImg">

							<label for="input_file">업로드</label> 
						  <input type="file" id="input_file" class="upload-hidden" name="file"> 
						</div>
						
						
						
					</div>
					<div class="span7" style="margin-left:0px;">
						<div class="row-fluid" style="margin-bottom:10px; margin-top: 15px;">
							<div class="span3 text-right">
								<label class="control-label ji" for="name">이름</label>
							</div>
							<div class="span5" >
								<input type="text" name = "name" id="name" value="${user.userName }">													
							</div>
						</div>
						<div class="row-fluid" style="margin-bottom:10px;">
							<div class="span3 text-right">
								<label class="control-label ji" for="password">비밀번호</label>
							</div>
							<div class="span5" >
								<input type="password" name="password" id="password" placeholder="비밀번호 입력">												
							</div>
						</div>
						<div class="row-fluid" style="margin-bottom:10px;">
							<div class="span3 text-right">
								<label class="control-label ji" for="passwordCheck">비밀번호 확인</label>
							</div>
							<div class="span5" >
								<input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 재입력">
							</div>
						</div>
						<div class="row-fluid" style="margin-bottom:10px;" >
							<div class="span3 text-right">
								<label for="timeTable" class="control-label ji">시간표</label>
							</div>
							<div class="span5" >
								<a  onclick="initTimeTable(${user.userNo})" class="button" data-toggle="modal" href='#timeTableModal' id="timetable"><i class="fa fa-table"></i></a> 
								<span id ="isReg" style="vertical-align: 13px">
									<c:if test="${timeTable!=null}">등록완료</c:if>										
									<c:if test="${timeTable==null}">미등록</c:if>										
								</span>
							</div>
						</div>
					</div>
				</div>
				</div>
				
				<input type="hidden" name="cmd" value="update_user_info"> 
				<c:if test="${timeTable!=null}">
					<%-- <input type="hidden" name="timeTableNo" value="${timeTable.timetableNo}"> --%>
					<input type="hidden" name="isTimeTable" value="true"id="timeTable">
					<input type="hidden" name="sun" value="${timeTable.sun}" id="sun">
					<input type="hidden" name="mon" value="${timeTable.mon}" id="mon">
					<input type="hidden" name="tue" value="${timeTable.tue}" id="tue">
					<input type="hidden" name="wen" value="${timeTable.wed}" id="wen">
					<input type="hidden" name="thu" value="${timeTable.thu}" id="thu">
					<input type="hidden" name="fri" value="${timeTable.fri}" id="fri">
					<input type="hidden" name="sat" value="${timeTable.sat}" id="sat">
				</c:if>
				<c:if test="${timeTable==null}">
					<%-- <input type="hidden" name="timeTableNo" value="${timeTable.timetableNo}"> --%>
					<input type="hidden" name="isTimeTable" value="false" id="timeTable">
					<input type="hidden" name="sun" value="" id="sun">
					<input type="hidden" name="mon" value="" id="mon">
					<input type="hidden" name="tue" value="" id="tue">
					<input type="hidden" name="wen" value="" id="wen">
					<input type="hidden" name="thu" value="" id="thu">
					<input type="hidden" name="fri" value="" id="fri">
					<input type="hidden" name="sat" value="" id="sat">
				</c:if>
					<input type="hidden" name="cmd" value="updateUserInfo"><br/>
					<button type="submit" class="btn btn-default offset4 span4" style="width : 25%; background : #FF0087; color:white">수정 완료</a>
				</form>
					
				
				
				
			</div>			
		</div>
	</div>
	<input type="hidden" name="userNo" value="${user.userNo }" id="userNo">	
	<script>
		
	  $(document).ready(function () {
		  $('#logoMenu-userName').css("vertical-align","-5px");
			
		    var fileTarget = $('.filebox .upload-hidden');
		    fileTarget.on('change', function () {
		        if (window.FileReader) {
		            var filename = $(this)[0].files[0].name;
		        } else {
		            var filename = $(this).val().split('/').pop().split('\\').pop();
		        }
		        ;
		        $(this).siblings('.upload-name').val(filename);
		    });
		    var imgTarget = $('.preview-image .upload-hidden');
		    imgTarget.on('change', function () {
		        var parent = $(this).parent();
		        parent.children('.upload-display').remove();
		        
		        if (window.FileReader) {
		            if (!$(this)[0].files[0].type.match(/image\//))
		                return;
		            var reader = new FileReader();
		            reader.onload = function (e) {
		                var src = e.target.result;
		                /* alert($('.upload-name').val());
		                alert("imgSrc="+src); */
		                $(".img-rounded").attr("src",src);		               
		            };
		            reader.readAsDataURL($(this)[0].files[0]);
		        } else {
		            $(this)[0].select();
		            $(this)[0].blur();
		            var imgSrc = document.selection.createRange().text;
		           
		            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');
		            var img = $(this).siblings('.upload-display').find('img');
		            img[0].style.filter = 'progid:DXImageTransform.Microsoft.AlphaImageLoader(enable=\'true\',sizingMethod=\'scale\',src="' + imgSrc + '")';
		        }
		    });
		});
	
	
	
		$('#addProfile').click(function() {
			
			
		});
	
<%-- 		function showModal(){
			$('#layerpop-modal-body').load('<%=request.getContextPath()%>/timeTable.jsp');
			$('#layerpop').css("top","5%").modal();
			
			if($('#timeTable').val()=='true'){
				initTimeTable($('#userNo').val());
			}
			$('#modalOKBtn').click(function(){		
				setTimeTable();
				$('#timeTable').val("true");	
				$('#isReg').html("등록완료");
				$('#layerpop').css("top","100%").modal('hide');				
			});
			$('#modalNGBtn').click(function(){
				$('#layerpop-modal-body').load(null);
				$('#layerpop').css("top","100%").modal('hide');
			});
		} --%>
		
		$('#save').click(function(){
			setTimeTable();
			$('#timeTable').val("true");
			
			$('#isReg').html("등록완료");
			$('#timeTableModal').modal('hide');		
		});
		
		var list = new Array();
		function initTimeTable(no){
			
			$.ajax({
				url : "<%=request.getContextPath()%>/UserController.do",
				type : "post",
				dataType : "json",
				async : false,
				data : {
					"cmd" : "oneTimeTable",
					"userNo" : no,
				},
				success : function(response){
												
					$.each(response,function(i,value){
						list.push(value.data);
					});				
				},
				error : function(x,o,e){
						var msg = "페이지 호출 에러 : "+x.status+","+o+","+e;
						alert(msg);
					}
			})
			/* alert(typeof(list[1]) + list[1]); */
			for(var i=1;i<=7;i++){
				for(var j=1;j<=24;j++){
					var res = list[i-1].substring(j-1,j);
					if(res==1){
						$('#'+j + "-" + i).addClass("checked");
					}
				}
			}
			
		}
		
            $(function(){
                              
                $('#selectEmail').change(function(){
                	   $("#selectEmail option:selected").each(function () {
                	        
               	        if($(this).val()== '1'){ 
               	             $("#email_addr").val('');                       
               	             $("#email_addr").attr("disabled",false); 
               	        }else{ 
               	             $("#email_addr").val($(this).text());      
               	             $("#email_addr").attr("disabled",true); 
               	        }
               	   });
               	});
                 
              
                $("#form").submit(function( event ) {
                             
                    if($('#name').val()==""){
                       alert("이름을 입력하여 주시기 바랍니다.");
           
                        $('#name').focus();
                        return false;
                    }                                   
                   
                    
                    if($('#password').val()==""){
                    	alert("패스워드를 입력하여 주시기 바랍니다.");
                       
                        $('#password').focus();
                        return false;
                    }                     
                   
                    if($('#passwordCheck').val()==""){
                    	alert("패스워드 확인을 입력하여 주시기 바랍니다.");
                       
                        $('#passwordCheck').focus();
                        return false;
                    }
                    
                    if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                    	alert("패스워드가 일치하지 않습니다.");
                        
                        $('#passwordCheck').focus();
                        return false;
                    }                   
                   	
                    var frm = document.getElementById("form");
                                        
                });                
            });
		

	function setTimeTable() {
		
		var tds = document.getElementsByClassName("class");
		var sun = '';
		var mon = '';
		var tue = '';
		var wen = '';
		var thu = '';
		var fri = '';
		var sat = '';

		for (var i = 0; i < tds.length; i++) {
			//var r = tds[i].getAttribute("r");
			var c = tds[i].getAttribute("c");

			if (c == 1) {
				if (tds[i].getAttribute("class") == "class checked")
					sun += '1';
				else
					sun += '0';
			} else if (c == 2) {
				if (tds[i].getAttribute("class") == "class checked")
					mon += '1';
				else
					mon += '0';
			} else if (c == 3) {
				if (tds[i].getAttribute("class") == "class checked")
					tue += '1';
				else
					tue += '0';
			} else if (c == 4) {
				if (tds[i].getAttribute("class") == "class checked")
					wen += '1';
				else
					wen += '0';
			} else if (c == 5) {
				if (tds[i].getAttribute("class") == "class checked")
					thu += '1';
				else
					thu += '0';
			} else if (c == 6) {
				if (tds[i].getAttribute("class") == "class checked")
					fri += '1';
				else
					fri += '0';
			} else if (c == 7) {
				if (tds[i].getAttribute("class") == "class checked")
					sat += '1';
				else
					sat += '0';
			}
		}
		$('#sun').val(sun);
		$('#mon').val(mon);
		$('#tue').val(tue);
		$('#wen').val(wen);
		$('#thu').val(thu);
		$('#fri').val(fri);
		$('#sat').val(sat);	
	}
</script>
<script src="js/bootstrap.js"></script>
</body>
</html>