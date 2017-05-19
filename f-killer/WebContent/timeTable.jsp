<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c"  uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
	.class.hover{
		background-color : gray;
	}
	td.class{
		background-color : white;
	}
	
	.time{
		height: 30px;
		text-align: right;
		padding-right: 8px;
	}
	td.checked{
		background-color: #F3B3D5;
	}
	.table {
		border-collapse: collapse;
	}
</style>
	<c:set var = "startTimeHour" value = "8"/>
	<c:set var = "startTimeMin" value = "0"/>	
	<c:set var = "criteria" value = "30"/>

		<div class="row-fluid">
			<div class="offset1 span10">
				<table class="table table-bordered" id="table">
					<c:forEach begin="0" end="24" var="i">
						<tr>
							<c:forEach begin="0" end="7" var="j">
								<c:if test="${i%2 == 1 && j == 0}">
									<td class="time" rowspan="2"><fmt:formatNumber
											value="${(startTimeHour-1) + (i+1)/2  }" pattern="#" />:00 ~
										<fmt:formatNumber value="${startTimeHour + (i+1)/2 }"
											pattern="#" />:00</td>
								</c:if>
								<c:if test="${i == 0 }">
									<c:if test="${j == 0 }">
										<th style="width:20%">&nbsp;&nbsp;</th>
									</c:if>
									<c:if test="${j == 1 }">
										<th>일</th>
									</c:if>
									<c:if test="${j == 2 }">
										<th>월</th>
									</c:if>
									<c:if test="${j == 3 }">
										<th>화</th>
									</c:if>
									<c:if test="${j == 4 }">
										<th>수</th>
									</c:if>
									<c:if test="${j == 5 }">
										<th>목</th>
									</c:if>
									<c:if test="${j == 6 }">
										<th>금</th>
									</c:if>
									<c:if test="${j == 7 }">
										<th>토</th>
									</c:if>
								</c:if>
								<c:if test="${i != 0 && j != 0}">
									<td r="${i }" c="${j }" id="${i }-${j }" class="class"></td>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
<script>
$(document).ready(function (){
	$('td.class').hover(function(){
		$(this).addClass('hover');
	}, function(){
		$(this).removeClass('hover');
	}).on('click', function(){
		$(this).toggleClass('checked');
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
					sun += '0';
				else
					sun += '1';
			} else if (c == 2) {
				if (tds[i].getAttribute("class") == "class checked")
					mon += '0';
				else
					mon += '1';
			} else if (c == 3) {
				if (tds[i].getAttribute("class") == "class checked")
					tue += '0';
				else
					tue += '1';
			} else if (c == 4) {
				if (tds[i].getAttribute("class") == "class checked")
					wen += '0';
				else
					wen += '1';
			} else if (c == 5) {
				if (tds[i].getAttribute("class") == "class checked")
					thu += '0';
				else
					thu += '1';
			} else if (c == 6) {
				if (tds[i].getAttribute("class") == "class checked")
					fri += '0';
				else
					fri += '1';
			} else if (c == 7) {
				if (tds[i].getAttribute("class") == "class checked")
					sat += '0';
				else
					sat += '1';
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
	/* 
	 function calDay(c){
	 if(c == 1)
	 return "일";
	 else if(c == 2)
	 return "월";
	 else if(c == 3)
	 return "화";
	 else if(c == 4)
	 return "수";
	 else if(c == 5)
	 return "목";
	 else if(c == 6)
	 return "금";
	 else if(c == 7)
	 return "토";	
	 }
	 function calTime(r){
	 var start = 8 + (r-1) * 0.5;
	 var end = 8 + r * 0.5;
	 return cal(start) + "~" + cal(end);
	 }
	 function cal(time){
	 if(time*10 % 10 == 5)
	 return (time-0.5) + "시30분"
	 else
	 return time + "시00분";
	 }  */
</script>