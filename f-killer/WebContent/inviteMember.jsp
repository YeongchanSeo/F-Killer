<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	if('${user.userNo}'==null || '${user.userNo}'<=0){
		location.href='login.jsp';
	}
</script>
<style>

	.modalInput{
		width : 100px;
	}
	#selectEmail{
		width : 120px;
	}
	#add-list{
		margin-left: 20px;
	}

</style>
</head>
<body>
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
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary">보내기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">팀원초대</button>0명
	 --><script>
		$('#add').click(
				function() { //추가버튼 클릭
					var id = $('#id').val();
					if(id == ''){
						return;
					}
					$('#id').val('');
					
					var table = document.getElementById("table");		   	
					var row = table.insertRow();				
					row.onmouseover = function() {
						table.clickedRowIndex = this.rowIndex;
					}
					var cell1 = row.insertCell(0);
				    var cell2 = row.insertCell(1);
				    var cell3 = row.insertCell(2);
					
					var email = $('#email').val();
					var text = $('#table').html();
					
					cell1.innerHTML = id + '@' + email;
					cell2.innerHTML = "회원";
					cell3.innerHTML = '<i onclick="doDel()" class="fa fa-times"></i>';
		});		

		function doDel(){
			var delPlace = document.all.table; // 삭제될테이블장소
			var email = delPlace.rows[delPlace.clickedRowIndex].cells[0].textContent; 
			delPlace.deleteRow(delPlace.clickedRowIndex);
			
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
</body>
</html>