onmessage = function(event){
  var receiveData = event.data;
  sleep(10000); 
//$('#inviteMember').html(cnt + '명');
	 var delPlace = document.all.table; 
  for(var i = 0; i < cnt;i++){
		var isMember = delPlace.rows[i+1].cells[1].textContent;
		var email = delPlace.rows[i+1].cells[0].textContent;
		webSocket.send(map.get(email)+'%ee');
		if(isMember=="회원"){
				alert("초대할 회원" + email + "회원번호" + map.get(email));
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
  //워커를 호출한 곳으로 결과 메시지를 전송한다
  var sendData = receiveData + "OK~ I'm Worker"
  postMessage(sendData)
}
function sleep(milliSeconds){  
  var startTime = new Date().getTime(); // get the current time   
  while (new Date().getTime() < startTime + milliSeconds); // hog cpu 
} 
