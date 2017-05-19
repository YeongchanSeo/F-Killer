<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FKILLER (Team Cooperation Project Program)</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

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
	background-color: #555;
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

   #outer{
     
      margin: 20px;
   }
   .page-wrapper{
      border:thin solid black;
      height:200px;
   }
   .smallbox{
      margin: 0 auto;
      position: relative;
       width:243px;
      height:350px;
      border: medium solid black;
   }
   .folder{
      margin: 0 auto;
      width:100%;
      height:250px;
      border-bottom: medium solid black;
   }
  
   
   #td{
   	  padding:10px;
   	  width:13%;
   }


   .description{
      line-height:100px;
      text-align:center;
      font-size: 20px;
      font-weight:700;
   }
   .file-image-box{
   	  text-align: center; 
   	  width:50%; 
   	  margin:10px auto 10px auto
   }
   .file-name{
   	  text-align: center;
   }
   .thumbnail:hover{
   	  box-shadow: 4px 4px 2px grey;
   }
   
   .thumbnail{
   	  height:250px
   }
   
</style>

</head>
<body style="background-color:#F4F2F2;">

	<nav class="navbar"> <jsp:include page="logoMenu.jsp" /> </nav>
	<nav class="navbar" style="background : white;"> <jsp:include page="teamHeader.jsp" /> </nav>	
	<div class="container-fluid" >
		<div class="row-fluid content" >
			<div class="span2 sidenav" >
				<jsp:include page="teamMenu.jsp" />
			</div>
			<div class="span10" style="box-shadow: 2px 2px 2px 1px #888888; background : white; margin-top : 20px;">	
				<div id="outer" >
					<div style="margin:0 0 15px 10px">
						<button type="button" class="btn btn-primary" onclick="getFile()" style="background : #FF0087; width : 9%; height:35px; font-size:20px"><strong>받 기</strong></button>&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="deleteFile()" style="background : #FF0087; width : 9%; height:35px; font-size:20px"><strong>삭 제</strong></button>
					</div>
					<div style="border:solid 1px grey; padding:10px">
						<form id="frm" action="<%=request.getContextPath() %>/FileController.do" method="post">
							<input type="hidden" id="test" name="test" value=""/>
							<table style="width:100%">
							    <tbody>
							        <tr>
								        <c:forEach items="${file_list }" var="file" varStatus="status">
								        	<c:if test="${status.index % 7 == 0}">
								        		</tr>
								        		<tr>
								        	</c:if>
								        	<td id="td">
								        		<div class="thumbnail">
									              <div>
									              	<input type="checkbox" style="width:15px;height:15px" name="selected_file" value="${file.fileNo }/${file.fileName}"/>
									              </div>
												  <div class="file-image-box">
												  	<c:choose>
												  		<c:when test="${file.fileExtension == '.txt' }">
												  			<i class="fa fa-file-text-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.png' or file.fileExtension == '.jpg' or file.fileExtension == '.gif'}">
												  			<i class="fa fa-file-image-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.avi' or file.fileExtension == '.mp4' or file.fileExtension == '.wmv'}">
												  			<i class="fa fa-file-video-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.xlsx' }">
												  			<i class="fa fa-file-excel-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.pptx' }">
												  			<i class="fa fa-file-powerpoint-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.pdf' }">
												  			<i class="fa fa-file-pdf-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.docx' }">
												  			<i class="fa fa-file-word-o fa-4x"></i>
												  		</c:when>
												  		<c:when test="${file.fileExtension == '.mp3' or file.fileExtension == '.wav'}">
												  			<i class="fa fa-file-audio-o fa-4x"></i>
												  		</c:when>
												  		<c:otherwise>
												  			<i class="fa fa-file-o fa-4x"></i>
												  		</c:otherwise>
												  	</c:choose>
												  </div>
												  <div style="text-align: center"><font>(${file.fileSize } bite)</font></div>
												  <div style="border:solid 1px lightgrey; width:100%"></div>
												  <div class="file-description" style="width:100%; ">
													  <h4 class="file-name">${file.fileName }</h4>
													  <font size="3.0em">업무명 : ${file.jobTitle}<br>작성일 : ${file.regDate }</font>
												  </div>
												</div>
								        	</td>
								        </c:forEach>
							        </tr>
							    </tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
			</div>
			</div>			
			
<!-- 			<footer class="container-fluid text-center">
				<p>Footer Text</p>
			</footer> -->
			<script src="js/bootstrap.min.js"></script>
			<script>
				$(document).ready(function(){
					$('#showStorage').addClass('selectedMenu-tr');
					$('#showStorage').find('th').find('a').addClass('selectedMenu-a');
				});
				function getFile(){
					var frm = $('#frm');
					$('#test').val('download');
					frm.submit();
				}
				function deleteFile(){
					var frm = $('#frm');
					$('#test').val('delete');
					frm.submit();
				}
			</script>
</body>
</html>