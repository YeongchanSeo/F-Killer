<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>
#a {
	background : red;
}
</style>
<body>
<input type="button" id="add" class="btn btn-default" value="추가" />
<table width = "50%" class = "table table-bordered" border='1'>
	<thead>
		<tr onMouseover="document.all.table.clickedRowIndex=this.rowIndex">
			<th width ="60%">email</th>
			<th width ="30%">member?</th>	
		</tr>
	</thead>
	<!-- <tr>
		<td>a</td>
		<td>a</td>
	</tr>
	<tr>
		<td>b</td>
		<td>b</td>
	</tr> -->
	<tbody id="table">
		
	</tbody>
</table>
<script>
		$('#add').click(function() { //추가버튼 클릭
			
			var table = document.getElementById("table");		   	
			var row = table.insertRow();	
			
			row.onmouseover = function() {
				table.clickedRowIndex = this.rowIndex;
			}
			
			var cell1 = row.insertCell(0);
			/* cell1.id = 'a'; */
			cell1.class = 'cell1'
		    var cell2 = row.insertCell(1);
			/* cell2.id = 'b'; */
			cell2.class = 'cell2'
			
			cell2.id='a';
			
			
			var email = $('#email').val();
			var text = $('#table').html();
			
			
			/* $('#b').css('background','blue'); */
			
			cell1.innerHTML = '<h3 class="h3"> hihi</h3>';
			cell2.innerHTML = '<i onclick="doDel()" class="fa fa-times"></i>';
		});		

		function doDel(){
			var delPlace = document.all.table; // 삭제될테이블장소
			var email = delPlace.rows[delPlace.clickedRowIndex].cells[0].textContent; 
			alert($(this).attr('id'));	
			alert("row Num:"+delPlace.clickedRowIndex);		
			delPlace.deleteRow(delPlace.clickedRowIndex);
			
		}		
		$('#a').click(function(){
			alert("클릭!");
		});
	</script>	

<script src="js/bootstrap.min.js"></script>
</body>
</html>