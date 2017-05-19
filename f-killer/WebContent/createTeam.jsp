<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

<link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.css" rel="stylesheet"/>

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
	#divTitle{
		margin-left : 230px;
	}
	.info{
		width : 350px;
		background:black;
	}
	.buttons{
		width : 80px;
	}
	.endbuttons{
		margin-left : 230px;
	}
	.cnt{
		margin : 0;
	}
    .modalInput{
		width : 100px;
	}
	#selectEmail{
		width : 120px;
	}
	#selectEmail-modal{
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
</head>
<body style="background-color:#E7E7E7">
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:300px; margin:0 auto; margin-left:-150px; height:70px; line-height:45px; margin-top:180px;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" style="text-align:center;">
					<i class="fa fa-spinner fa-pulse"></i>&nbsp;&nbsp;&nbsp;메일을 전송중입니다.
				</div>
			</div>
		</div>
	</div>
<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">팀원초대</h4>
				</div>
				<div class="modal-body">
					<input class = "modalInput" type="text" name="id" id="id"> @ 
					<input class = "modalInput" type="text" name="email" id="email" disabled value="naver.com">
					<select	name="selectEmail-modal" id="selectEmail-modal">
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
					<button type="button" class="btn btn-primary" id ="commit">확인</button>
				</div>
			</div>
		</div>
	</div>
<nav class="navbar">
  <jsp:include page="logoMenu.jsp" />
</nav>

<div class="row-fluid" style='margin-top:100px;'>
<div style="width:600px; margin:auto; background-color:white; padding:30px 20px; border-radius:10px; box-shadow: 3px 3px 2px #888888;">
<form class="form-horizontal" role="form" method="post" action="<%=request.getContextPath() %>/TeamController.do" id="form">
            <div class="control-group" id="divTitle"><h2>팀 생성 하기&nbsp;&nbsp;&nbsp;</h2></div>
            <div class="control-group" id="divteamName">
                <label for="inputName" class="col-lg-2 control-label">팀&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;름&nbsp;&nbsp;&nbsp;</label>
                <div class="col-lg-12">
                    <input type="text" class="form-control info" id="teamName" data-rule-required="true" name="teamName">
                </div>
            </div>
             <div class="control-group" id="divTopic">
                <label for="inputName" class="col-lg-2 control-label">주&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;</label>
                <div class="col-lg-12">
                    <input type="text" class="form-control info" id="topic" data-rule-required="true" name="teamTopic">
                </div>
            </div>
            <div class="control-group" id="divStartDate">
                <label for="inputName" class="col-lg-2 control-label">프로젝트 시작일&nbsp;&nbsp;</label>
                <div class="input-group date" id="startDate" data-date-format="yyyy-mm-dd" style="margin-left : 0.5%;">
                	<input class="form-control" type="text" readonly  name="startDate" id="startDate2"/>
					<span class="input-group-addon">
						<button type="button" class="btn"><i class="fa fa-calendar-check-o"></i></button></span>                  
						
                </div>
            </div>
            <div class="control-group" id="divEndDate">
                <label for="inputName" class="col-lg-2 control-label">프로젝트 마감일&nbsp;&nbsp;</label>
                 <div class="input-group date" id="endDate" data-date-format="yyyy-mm-dd" style="margin-left:0.5%;">
                	<input class="form-control" type="text" readonly name="endDate" id="endDate2" />
					<span class="input-group-addon">
						<button type="button" class="btn"><i class="fa fa-calendar-check-o"></i></button></span>                  
                </div>
            </div>
            
            <div class="control-group" id="divEmail">
             <label for="inputEmail" class="form-control control-label">교수님 이메일&nbsp;&nbsp;</label>
             	<div class="col-lg-12">
                     <input type="text" class="form-control" name="email_id" id="email_id" data-rule-required="true" style="width:100px;" placeholder="아이디" maxlength="40">&nbsp;@&nbsp;
             
                     <input type="text" class="form-control" name="email_addr" id="email_addr" style="width:100px;" disabled value="naver.com">
					<select class="form-control" name="selectEmail" id="selectEmail"  style="width:120px;">
					     <option value="1">직접입력</option>
					     <option value="naver.com" selected>naver.com</option>
					     <option value="hanmail.net">hanmail.net</option>
					     <option value="hotmail.com">hotmail.com</option>
					     <option value="nate.com">nate.com</option>
					     <option value="yahoo.co.kr">yahoo.co.kr</option>
					     <option value="gmail.com">gmail.com</option>
					</select>
                </div> 
            </div>
            
            <div class="control-group" id="divReport">
                <label for="inputPassword" class="col-lg-2 control-label">보고 방식&nbsp;&nbsp;&nbsp;</label>
                <div class="col-lg-12">
                
		                <div class="btn-group" data-toggle="buttons-radio">
						  <button type="button" class="btn btn-default report" id="auto" value="">자동</button>
						  <button type="button" class="btn btn-default report" id="menual" value="">수동</button>						 
						</div>                
                </div>
            </div>
             <div class="control-group" id="divReportcycle">
                <label for="inputPassword" class="col-lg-2 control-label">보고 주기&nbsp;&nbsp;&nbsp;</label>
                <div class="col-lg-12">                
		                <div class="btn-group" data-toggle="buttons-radio">
						  <button type="button" class="btn btn-default cycle" value="ONE_WEEK">1주일</button>
						  <button type="button" class="btn btn-default cycle" value="TWO_WEEK">2주일</button>	
						  <button type="button" class="btn btn-default cycle" value="ONE_MONTH">한달</button>					 
						</div>
                </div>
            </div>
            
             <div class="control-group" id="divInvite">
             	<label for="inputInvite" class="col-lg-2 control-label invite">&nbsp;&nbsp;&nbsp;</label>
            	<div class="col-lg-12">            		
            		<button type="button" class="btn btn-warning invite" id="invite" data-toggle="modal" data-target="#myModal">팀원 초대
            		<span class="badge" id="inviteMember">0명</span>           		
            		</button>
            		
            	</div>             	   
            </div>      
           
            <div class="control-group endbuttons">
                <div class="col-lg-offset-1 col-lg-10" style=" margin:15px 0 0 -30px">
                    <button type="button" class="btn btn-default buttons" id="ok" data-toggle="modal" data-target="#myModal2" style="background:#FF0087; color:white;"><strong>팀 생성</strong> </button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-default buttons" id="cancel" style="background:white"> 취 소 </button>
                </div>
            </div>
            <input type="hidden" id="report" name="report" value="">
            <input type="hidden" id="cycle" name="cycle" value="">
            <input type="hidden" name="cmd" value="createTeam">
            <input type="hidden" id="email_address" name="email_address" value="">
        </form>
        </div>
        </div>
         
         
         <form method="post" action="<%=request.getContextPath() %>/TeamController.do" id="cancelform">
         	<input type="hidden" name="cmd" id="cancel_cmd" value="cancel">
         </form>

        <script>
		        $('#myModal2').on('show.bs.modal', function () {
		        	var id = setInterval(frame, 10);
		    	    function frame() {
		    	        if ($('#myModal2').hasClass('in')) {
		    	        	createTeam();
		    	            clearInterval(id);
		    	            $('#myModal2').modal('hide');
		    	        }
		    	    }
		       	})
        
        		function createTeam(){
        			//패스워드 검사
                    if($('#teamName').val()==""){
                        alert("팀이름을 입력해 주세요!");
                                            
                        $('#teamName').focus();
                        return false;                        
                    }
                     
                    //패스워드 확인
                    if($('#topic').val()==""){
                        alert("팀주제를 입력해 주세요!");
                                                                     
                        $('#topic').focus();
                        return false;
                    }
                     
              
                     
                    //이름
                    if($('#startDate2').val()==""){
                        alert("프로젝트 시작일을 입력해 주세요!");
                                              
                        $('#startDate2').focus();
                        return false;
                    }
                    if($('#endDate2').val()==""){
                        alert("프로젝트 마감일을 입력해 주세요!");
                                              
                        $('#endDate2').focus();
                        return false;
                    }        
                    
                    
                    //이메일
                    if($('#email_id').val()==""){
                    	alert("이메일을 입력해 주세요!");
                       
                        $('#email_id').focus();
                        return false;
                    }
                    if($("#report").val()=="true"){
            			if($('#cycle').val()==""){
            				alert("보고주기를 설정해 주세요!");
            		
            			
            				$(".cycle").focus();
            				return false;            			
            			}          			
            		}
                    var frm = document.getElementById("form");
                    $("#email_address").val(frm.email_addr.value);
                    
    				

        			$.ajax({       				
        				url : "<%=request.getContextPath() %>/TeamController.do",
        				type : "post",
        				dataType : "json",
        				async : false,
        				data : {
        					"cmd" : "createTeam",
        					"report" : $("#report").val(),
        					"cycle" : $("#cycle").val(),
        					"email_id" : $('#email_id').val(),
        					"email_address" : $('#email_address').val(),
        					"teamName" : $('#teamName').val(),
        					"teamTopic" : $('#topic').val(),
        					"startDate" : $("#startDate2").val(),
        					"endDate" : $('#endDate2').val(),     					
        				},
        				success : function(response){
                  			if(response=="-1"){
                  				alert("팀 생성을 실패");
                  			} else {
                  			  var delPlace = document.all.table; 
                              for(var i = 0; i < cnt;i++){
                            		var isMember = delPlace.rows[i+1].cells[1].textContent; 
                            		var email = delPlace.rows[i+1].cells[0].textContent;
                  				
                            		if(isMember=="회원"){
                            			
                      					$.ajax({
                                    		url : "<%=request.getContextPath()%>/TeamController.do",
                                    		dataTyepe : "json",
                                    		type : "post",
                                    		async : false,
                                    		data : {
                                    			"cmd" : "inviteMember",
                                    			"userNo" : map.get(email) , 
                                    			"teamNo" : response
                                    		},
                                    		success : function(response){
                                    			if(response=="1"){
                                    				alert("회원 초대 성공");
                                    				webSocket.send(map.get(email)+'%e');
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
                                    			"teamName" : $('#teamName').val()
                                    		},
                                    		success : function(response){
                                    			/* if(response=="1"){
                                    				alert("회원 초대 성공");	
                                    			} else {
                                    				alert("회원 초대 실패");
                                    			}
                                    			 */
                                    		},
                                    		error : function(x,o,e){
                  							var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
                  							alert(msg);
                  						}
                                    });
                      			}                           		
                              }
                  			}
                  			
                  		},
                  		error : function(x,o,e){
							var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
							alert(msg);
						}
        			});
        			location.href='<%=request.getContextPath()%>/TeamController.do?cmd=completeCreateTeam';
        		}
        
		    	
        		$(document).ready(function(){
		    		$("#divReportcycle").hide();
		    		$("#report").val("true");
		    	});
		    	$("#auto").click(function(){
		    		$("#divReportcycle").show();
		    		$("#report").val("true");
		    	});
		    	$("#menual").click(function(){
		    		
		    		$("#divReportcycle").hide();
		    		$("#report").val("false");
		    	});
		    	$(".cycle").click(function(){
		    		var choice = $(this).val();
		    		$("#cycle").val(choice);
		    	});
		    	
		    	$('#cancel').click(function(){
		    		$('#cancelform').submit();
		    	});
        
            $(function(){
               
                $('#selectleader').change(function(){
                	   $("#selectleader option:selected").each(function () {
                	         $("#leader").val($(this).text());      //선택값 입력
                	         $("#leader").attr("disabled",true); //비활성화
                	   });
                });
                               
                
                $('#selectEmail').change(function(){
             	   $("#selectEmail option:selected").each(function () {
             	        
             	        if($(this).val()== '1'){ //직접입력
             	             $("#email_addr").val('');                      
             	             $("#email_addr").attr("disabled",false);
             	        }else{ 
             	             $("#email_addr").val($(this).text());
             	             $("#email_addr").attr("disabled",true);
             	        }
             	   });
             	  $('#selectEmail-modal').change(function() {
          			$("#selectEmail-modal option:selected").each(function() {

          				if ($(this).val() == '1') { //직접입력
          					$("#id").val(''); //값 초기화
          					$("#id").attr("disabled", false);
          				} else {
          					$("#email").val($(this).text()); //선택값 입력
          					$("#email").attr("disabled", true);
          				}
          			});
             	});
                
                $('.report').on('click', function () {
                    $(this).button('complete')
                  });
                
               
            })
           });
            $(document).ready(function(){
            	  $(function () {
                  	  $("#startDate").datepicker({ 
                  	        autoclose: true, 
                  	        todayHighlight: true
                  	  }).datepicker('update', new Date());
    	              	$("#endDate").datepicker({ 
    	          	        autoclose: true, 
    	          	        todayHighlight: true
    	          	  }).datepicker('update', new Date());
                  	}); 
            });
                
                //------- validation 검사
/*                 $( "#form" ).submit(function( event ) {
                	   
                }); */
                  
                    
              
                    
                  
                 /*   
                    alert(frm.teamName.value+"/"+frm.teamTopic.value+"/"+
                    		frm.email_id.value+"/"+frm.email_addr.value+"/"+frm.startDate.value+"/"+
                    		frm.endDate.value+"/"+frm.report.value+"/"+frm.cycle.value);
 */
                  
                
        	
          	var cnt = 0;
          	Map = function(){
          		 this.map = new Object();
          		};   
          		Map.prototype = {   
          		    put : function(key, value){   
          		        this.map[key] = value;
          		    },   
          		    get : function(key){   
          		        return this.map[key];
          		    },
          		    containsKey : function(key){    
          		     return key in this.map;
          		    },
          		    containsValue : function(value){    
          		     for(var prop in this.map){
          		      if(this.map[prop] == value) return true;
          		     }
          		     return false;
          		    },
          		    isEmpty : function(key){    
          		     return (this.size() == 0);
          		    },
          		    clear : function(){   
          		     for(var prop in this.map){
          		      delete this.map[prop];
          		     }
          		    },
          		    remove : function(key){    
          		     delete this.map[key];
          		    },
          		    keys : function(){   
          		        var keys = new Array();   
          		        for(var prop in this.map){   
          		            keys.push(prop);
          		        }   
          		        return keys;
          		    },
          		    values : function(){   
          		     var values = new Array();   
          		        for(var prop in this.map){   
          		         values.push(this.map[prop]);
          		        }   
          		        return values;
          		    },
          		    size : function(){
          		      var count = 0;
          		      for (var prop in this.map) {
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
						dataType :"json",
						async:false,
						data : {
							"cmd" : "checkUser",
							"id" : $('#id').val(),
							"email" :  $('#email').val()
						},
						success : function(response){
							if(response == "-1"){
								memberNo = 0;
							} else {
								memberNo = response;
								map.put($('#id').val() + "@" + $('#email').val(), memberNo);
							}
						},
						error : function(x,o,e){
							var msg = "페이지 호출 에러 : " + x.status + "," + o + "," + e;
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
					
					if(memberNo!=0){
						cell2.innerHTML = "회원";			
					}else{
						cell2.innerHTML = "비회원";	
					}
					
					cell3.innerHTML = '<i onclick="doDel()" class="fa fa-times"></i>';
					$('#id').val('');
					cnt++;
		});		

		function doDel(){
			var delPlace = document.all.table; // 삭제될테이블장소
			var email = delPlace.rows[delPlace.clickedRowIndex].cells[0].textContent; 
			map.remove(email);
			delPlace.deleteRow(delPlace.clickedRowIndex);
			cnt--;
			
		}
		
		$('#commit').click(function(){
			$('#inviteMember').html(cnt+'명');
			$('#myModal').modal('hide');
		});
		

		
		
	</script>	
	
<script src="js/bootstrap.min.js"></script>
</body>
</html>