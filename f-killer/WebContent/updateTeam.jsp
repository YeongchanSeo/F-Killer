<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

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

<c:set var="email" value="${professor.email}" />
<c:set var="email_length" value="${fn:length(professor.email)}"/>

<c:set var="index" value="${ fn:indexOf(email,'@') }" />
<c:set var="addr_index" value="${index+1 }" />
<c:set var="pro_id" value="${fn:substring(email, 0 ,index)}"/>
<c:set var="leader_no" value=""/>


<c:set var="pro_addr" value="${fn:substring(email , addr_index , email_length) }"/>

<style>
/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {

	margin-bottom: 0;
	margin-top: 0;
	border-radius: 0;
	margin-bottom: 0px;
	margin-top: 0px;
	border-radius: 0px;
}

/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
.row.content {
	height: 500px
}

/* Set gray background color and 100% height */
.sidenav {
	padding-top: 20px;
	height: 100%;
}

/* Set black background color, white text and some padding */
footer {
	height: 15px;
	background-color: #999;
	color: white;
	padding: 15px;
}

/* On small screens, set height to 'auto' for sidenav and grid */
@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}

    #update{
    	margin-top : 80px;
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
		width : 90px;
		height : 30px;
	}
	.endbuttons{
		margin-left : 230px;
	}
 	.buttons1.active {
        background : #FFAEDE;
        color : white;
     }
	.buttons1 {
		margin-top : 10px;		
	} 
	#outer{
      margin: 20px;
   }
</style>
</head>
<body style="background-color:#F4F2F2">
<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
<nav class="navbar" style="background : white;"> <jsp:include page="teamHeader.jsp" /> </nav>
	<div class="container-fluid"  style="background-color:#F4F2F2; height:785px;">
		<div class="row-fluid content" >
			<div class="span2 sidenav" >
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10" style="box-shadow: 2px 2px 2px 1px #888888; background : white; margin-top : 20px;">	
				<div id="outer">
					<div class="row-fluid">
					<div class="frm-wrapper  span8 offset2">
					<form class="form-horizontal" role="form" method="post" action="<%=request.getContextPath() %>/TeamController.do" id="form">
					            <div class="control-group" id="divTitle"><h2>팀 정보 수정&nbsp;&nbsp;&nbsp;</h2></div>
					            <div class="control-group" id="divteamName">
					                <label for="inputName" class="col-lg-2 control-label">팀&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;름&nbsp;&nbsp;&nbsp;</label>
					                <div class="col-lg-12">
					                    <input type="text" class="form-control info" id="teamName" data-rule-required="true" name="teamName" value="${team.teamName }">
					                </div>
					            </div>
					             <div class="control-group" id="divTopic">
					                <label for="inputName" class="col-lg-2 control-label">주&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;</label>
					                <div class="col-lg-12">
					                    <input type="text" class="form-control info" id="topic" data-rule-required="true" name="teamTopic" value="${team.teamTopic }">
					                </div>
					            </div>
					            <div class="control-group" id="divStartDate">
					                <label for="inputName" class="col-lg-2 control-label">프로젝트 시작일&nbsp;&nbsp;</label>
					                <div class=" input-group date span6" id="startDate" data-date-format="yyyy-mm-dd" style="margin-left:0.5%">
					                	<input class="form-control" type="text" readonly name="startDate"/>
										<span class="input-group-addon">
											<button type="button" class="btn"><i class="fa fa-calendar-check-o"></i></button></span>                  
					                </div>
					            </div>
					            <div class="control-group" id="divEndDate">
					                <label for="inputName" class="col-lg-2 control-label">프로젝트 마감일&nbsp;&nbsp;</label>
					                 <div class="input-group date span6" id="endDate" data-date-format="yyyy-mm-dd" style="margin-left:0.5%">
					                	<input class="form-control" type="text" readonly name="endDate"/>
										<span class="input-group-addon">
											<button type="button" class="btn"><i class="fa fa-calendar-check-o"></i></button></span>                  
					                 </div>
					            </div>
					  			<div class="control-group" id="divLeader">
					             <label for="inputEmail" class="form-control control-label">팀 장&nbsp;&nbsp;</label>
					             	<div class="col-lg-12">
										<select class="form-control" name="selectleader" id="selectleader"  style="width:120px;">						     
										     <c:forEach items="${member_list}" var="member">
										     	<option class="leader" value="${member.name}" ${member.name == team.leaderName? "selected" : ""} id="${member.userNo}"> ${member.name }</option>
										     	<c:if test="${member.name == team.leaderName }">
										     		<c:set var="leader_no" value="${member.userNo }" />
										     	</c:if>
										     </c:forEach>
										</select>
					                </div> 
					            </div>
					            <c:set var="n" value="0" />
					            <c:set var="membercnt" value="${fn:length(memberList)}" />
					            
					           <div class="control-group" id="divMember">
					           
									<c:if test="${member_list != null }">
										<label for="inputName" class="col-lg-2 control-label">팀 원&nbsp;&nbsp;</label>
											 <div class=" divMember" id="member">
											 	<div class="btn-group" data-toggle="buttons-checkbox" >
											 		<c:set var="n" value="0" />
											 		
											 		<c:forEach items="${member_list }" var="member" varStatus="status">
											 			<c:if test="${status.count % 5 == 1 and status.count != 1}">
											 					</div>
											 				</div>
											 				<label for="inputName" class="col-lg-2 control-label">&nbsp;&nbsp;</label>
												            <div class=" divMember" id="member">
												          	    <div class="btn-group" data-toggle="buttons-checkbox">
											 			</c:if>
											 			<c:choose>
								                			<c:when test="${status.count == (1+(5*n)) }" >
								                				<!-- 첫번째 라인일때 처리 -->
								                				<button type="button" class="btn buttons1 member" id="${member.userNo}" value="no">${ member.name}</button>
								                				<c:set var="n" value="${n+1 }" />
								                			</c:when>
								                			<c:otherwise>
								                				<button type="button" class="btn buttons1 member" style="margin-left : 10px;
								                							border-radius : 4px;" id="${member.userNo}" value="no">${ member.name}</button>
								                			</c:otherwise>
								                		</c:choose>
											 		</c:forEach>
											 		
												  </div>
										 	  </div>
										 	  
									</c:if>
									
								</div>
								           
					            <%-- <c:if test='${pro_addr != null && pro_addr != "" && pro_addr != "null"}'> --%>
					            
					            <div class="control-group" id="divEmail">
					             <label for="inputEmail" class="form-control control-label">교수님 이메일&nbsp;&nbsp;</label>
					             	<div class="col-lg-12">
					                     <input type="text" class="form-control" name="email_id" id="email_id" data-rule-required="true"
					                     					style="width:100px;" placeholder="아이디" maxlength="40" value="${pro_id}">&nbsp;@&nbsp;
					             
					             		<c:choose>
					             			<c:when test="${pro_addr == null || pro_addr == '' || pro_addr == 'null' }">
					             				<input type="text" class="form-control" name="email_addr" id="email_addr" style="width:100px;" disabled value="naver.com">
					             					<select class="form-control" name="selectAddrEmail" id="selectAddrEmail"  style="width:120px;">
													     <option value="1">직접입력</option>
													     <option value="naver.com" selected >naver.com</option>
													     <option value="hanmail.net" >hanmail.net</option>
													     <option value="hotmail.com" >hotmail.com</option>
													     <option value="nate.com" >nate.com</option>
													     <option value="yahoo.co.kr" >yahoo.co.kr</option>
													     <option value="gmail.com" >gmail.com</option>
													</select>
					             			</c:when>
					             			<c:otherwise>
					             				<input type="text" class="form-control" name="email_addr" id="email_addr" style="width:100px;" disabled value="${pro_addr}">
					             				<select class="form-control" name="selectAddrEmail" id="selectAddrEmail"  style="width:120px;">
												     <option value="1">직접입력</option>
												     <option value="naver.com" ${pro_addr == 'naver.com'? "selected" : ""} >naver.com</option>
												     <option value="hanmail.net" ${pro_addr == 'hanmail.net'? "selected" : ""}>hanmail.net</option>
												     <option value="hotmail.com" ${pro_addr == 'hotmail.com'? "selected" : ""}>hotmail.com</option>
												     <option value="nate.com" ${pro_addr == 'nate.com'? "selected" : ""}>nate.com</option>
												     <option value="yahoo.co.kr" ${pro_addr == 'yahoo.co.kr'? "selected" : ""}>yahoo.co.kr</option>
												     <option value="gmail.com" ${pro_addr == 'gmail.com'? "selected" : ""}>gmail.com</option>
												</select>
					             			</c:otherwise>
					             		</c:choose>   
					                </div> 
					            </div>
					            
					            <div class="control-group" id="divReport">
					                <label for="inputPassword" class="col-lg-2 control-label">보고 방식&nbsp;&nbsp;&nbsp;</label>
					                <div class="col-lg-12">                
							                <div class="btn-group" data-toggle="buttons-radio">
							                <c:choose>
							                	<c:when test="${professor.auto == true}">
							                		<button type="button" class="btn btn-default report active" id="auto" value="">자동</button>
											  		<button type="button" class="btn btn-default report " id="menual" value="">수동</button>						
							                	</c:when>
							                	<c:otherwise>
							                		<button type="button" class="btn btn-default report " id="auto" value="">자동</button>
											  		<button type="button" class="btn btn-default report active" id="menual" value="">수동</button>		
							                	</c:otherwise>
							                </c:choose>
											  
											</div>
					                </div>
					            </div>
					            
					            
					            <c:set var="cycle" value="" />
					            <c:choose>
					            	<c:when test="${professor.cycle == ONE_WEEK }">
					            		<c:set var="cycle" value="1week"/>
					            	</c:when>
					            	
					            	<c:when test="${professor.cycle == TWO_WEEK }">
					            		<c:set var="cycle" value="2week"/>
					            	</c:when>	          
					            	<c:otherwise>
					            		<c:set var="cycle" value="month"/>
					            	</c:otherwise>
					            </c:choose> 
					          
					             <div class="control-group" id="divReportCicle">
					                <label for="inputPassword" class="col-lg-2 control-label">보고 주기&nbsp;&nbsp;&nbsp;</label>
					                <div class="col-lg-12">                
							                <div class="btn-group" data-toggle="buttons-radio">			                	
						                		<c:choose>
						                			<c:when test="${cycle == '1week' }" >
														<button type="button" class="btn btn-default cicle active" value="1week">1주일</button>
														<button type="button" class="btn btn-default cicle" value="2week">2주일</button>	
														<button type="button" class="btn btn-default cicle" value="month">한달</button>
						                			</c:when>
						                			<c:when test="${cycle == '2week' }">
						                				<button type="button" class="btn btn-default cicle" value="1week">1주일</button>
														<button type="button" class="btn btn-default cicle active" value="2week">2주일</button>	
														<button type="button" class="btn btn-default cicle" value="month">한달</button>
						                			</c:when>
						                			<c:otherwise>
						                				<button type="button" class="btn btn-default cicle" value="1week">1주일</button>
														<button type="button" class="btn btn-default cicle" value="2week">2주일</button>	
														<button type="button" class="btn btn-default cicle active" value="month">한달</button>
						                			</c:otherwise>
						                		</c:choose>
											</div>
					                </div>
					            </div>
					            
					            <input type="hidden" id="report" name="report" value="">
					            <input type="hidden" id="cicle" name="cicle" value="">
					            <input type="hidden" name="profNo" value="${professor.profNo}">
						<%-- </c:if>  --%>
					           
					            <input type="hidden" name="cmd" value="updateTeam">
				            	<input type="hidden" id="email_address" name="email_address" value="${pro_addr }">
				            	 <input type="hidden" name="leaderNo" id="leaderNo" value="${leader_no}">
				            	  <input type="hidden" name="deleteUser" id='deleteUser' value="">
				            	 
				            
					            <div class="control-group endbuttons">
					                <div class="col-lg-offset-2 col-lg-10" style="margin-top : 10px;">
					                    <button type="submit" class="btn btn-default buttons" id="ok" onclick="" style="background : #FF0087; color : white;"><strong>확 인</strong> </button>
					                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                    <button type="button" class="btn btn-default buttons" id="cancel" style="background : white; color : black;"><strong>취 소</strong> </button>
					                </div>
					            </div>
					           
					            
					       </form>
				        </div>
				       </div> 
				         <form method="post" action="<%=request.getContextPath() %>/TeamController.do" id="cancelform">
				         	<input type="hidden" name="cmd" id="cancel_cmd" value="goHome">
				         </form>
				        
				         
				        <script>
				        
				        var startdate = '${team.startDate}';
				    	var sy = startdate.substring(0,4);
				    	var sm = startdate.substring(5,7);
				    	var sd = startdate.substring(8,10);
				    	    	
				    	var enddate = '${team.endDate}';
				    	var ey = enddate.substring(0,4);
				    	var em = enddate.substring(5,7);
				    	var ed = enddate.substring(8,10);
				    	
				    	var deleteUser = new Array();
				    	    	
						        $(document).ready(function(){
						        	showSubMenu();
									$('#manageTeamInfo').addClass('selectedMenu-tr');
									$('#manageTeamInfo').find('td').find('a').addClass('selectedMenu-a');
						        	if('${pro_addr != null && pro_addr != "" && pro_addr != "null"}'){
						        		
							        	if('${professor.auto}'== true){
							        		
							        		console.log("자동입니다.");
							        		$("#divReportCicle").show();
							        		$("#report").val("auto");
							        		$("#cicle").val('${cycle}');
							        		
							        	} else {
							        		console.log("수동입니다.");
							    			$("#divReportCicle").hide();
							    			$("#report").val("menual");
							        	}
						        	}
						        	
						        	 var start = new Date();
						        	start.setFullYear(sy, sm-1, sd);
						        	/* alert("start / "+start); */
						        	
						        	var end = new Date();
						        	end.setFullYear(ey, em-1, ed);
						        	/* alert("end / " + end); */
						        	
						        	 $("#startDate").datepicker({ 	     
						        		 autoclose: true, 
					               	        todayHighlight: true,
					               	        dateFormat : 'yyyy-mm-dd',	               	        
					               	        defaultDate : start
					               	  
					               	  }).datepicker('setDate', start);  
						        	 
					               	  $("#endDate").datepicker({ 
					               		 autoclose: true, 
					               	        todayHighlight: true,
					               	     	dateFormat : 'yyyy-mm-dd',
					 	          	        defaultDate : end
					 	          	     
					 	          	  }).datepicker('setDate', end); 
					               	  
					               	$('#cancel').click(function(){
							    		$('#cancelform').submit();
							    	});
						        
						    	});
						    	
						        if('${pro_addr != null && pro_addr != "" && pro_addr != "null"}') {
						        	
							    	$("#auto").click(function(){
							    		$("#divReportCicle").show();
							    		$("#report").val("auto");
							    	});
							    	$("#menual").click(function(){
							    		
							    		$("#divReportCicle").hide();
							    		$("#report").val("menual");
							    	});
							    	$(".cicle").click(function(){
							    		var choice = $(this).val();
							    		$("#cicle").val(choice);
							    	});
						        }
						        
				        		$(".member").click(function(){
				        			
				        			
				        			
				        			var isDelete = $(this).val();
				        			var userNo = $(this).attr('id');
				        			
				        			if(isDelete == 'no'){	//delete 체크 되지 않음
				        				
				        				$(this).val('del');
				        				
				        				deleteUser.push(userNo);
				        				
				        				
				        			} else {			//delete 체크 되었음
				        				
				        				
				        				$(this).val('no');
				        				var index = deleteUser.indexOf(userNo);
				        				
				        				deleteUser.splice(index,1);        				
				        			}
				        		});
				        
				        		/*  $(function () {
				               	  $("#startDate").datepicker({ 
				               	        autoclose: true, 
				               	        todayHighlight: true,
				               	        defaultDate : sy+"-"+sm+"-"+sd
				               	  
				               	  }) .datepicker('update', new Date());              	  
				               	  $("#endDate").datepicker({ 
				 	          	        autoclose: true, 
				 	          	        todayHighlight: true,
				 	          	        defaultDate : ey+"-"+em+"-"+ed
				 	          	     
				 	          	  }) .datepicker('update', new Date());
				               	  
				               	}); */
				        
				            $(function(){
				                                
				                          
				                $('#selectleader').change(function(){
				                	   $("#selectleader option:selected").each(function () {
				                	         $("#leaderNo").val($(this).attr("id"));
				                	   });
				                });
				                
				                
				                $('#selectAddrEmail').change(function(){
				             	   $("#selectAddrEmail option:selected").each(function () {
				             	        var emailAddr = $("#selectAddrEmail option:selected").val();
				             	        if($(this).val()== '1'){ //직접입력
				             	        	console.log("if에 들어왔습니다.")
				             	        	console.log(emailAddr)
				             	             $("#email_addr").attr('value','');               
				             	             $("#email_addr").attr("disabled",false);
				             	        }else{
				             	        	console.log("이메일 else에 들어왔습니다.")	
				             	        	console.log(emailAddr)
				             	             $("#email_addr").attr('value',emailAddr);
				             	             $("#email_addr").attr("disabled",true);
				             	             $('#email_address').val(emailAddr);
				             	        }
				             	   });
				             	});
				                
				                if('${pro_addr != null && pro_addr != "" && pro_addr != "null"}'){
				                	
					                $('.report').on('click', function () {
					                    $(this).button('complete')
					                  });
				                
				                }
				                
				                
				                //------- validation 검사
				                $( "#form" ).submit(function( event ) {
				                     
				                    if($('#password').val()==""){
				                    	 alert("패스워드를 입력해 주세요!");
				                         
				                         $('#password').focus();
				                         return false;   
				                    }                     
				                  
				                    if($('#passwordCheck').val()==""){
				                    	 alert("패스워드 확인을 입력해 주세요!");
				                         
				                         $('#passwordCheck').focus();
				                         return false;
				                    }                     
				                    
				                    if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
				                    	alert("패스워드가 일치하지 않습니다!");
				                        
				                        $('#passwordCheck').focus();
				                        return false;
				                    } 
				                    
				                    if($('#name').val()==""){
				                    	 alert("이름을 입력해 주세요!");
				                         
				                         $('#name').focus();
				                         return false;
				                    }           
				                  
				                    if($('#email').val()==""){
				                    	alert("이메일을 입력해 주세요!");
				                        
				                        $('#email').focus();
				                        return false;
				                    }
				                    
				                    if('${pro_addr != null && pro_addr != "" && pro_addr != "null"}'){
				                    	if($("#report").val()=="auto"){
				            				if($('#cicle').val()==""){
				            					alert("보고주기를 설정해 주세요!");
				            		
				            			
				            					$(".cicle").focus();
				            					return false;            			
				            				}		
				            			}
				                    } 
				                    $("#email_address").value = $('#email_addr').val(); 
				                    $("#deleteUser").val(deleteUser);
				                    
				                });
				                 
				            });
				             
				        </script>
				</div>
			</div>
		</div>
	</div><!-- 
	<footer class="container-fluid text-center">
		<p>Footer Text</p>
	</footer> -->
<script src="js/bootstrap.js"></script>
</body>
</html>