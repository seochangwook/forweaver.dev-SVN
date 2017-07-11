<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jQuery, bootstrap CDN -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script> <!-- msie 문제 해결 -->
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<!-- Zebra-Dialog CDN -->
	<script src="resources/js/dialog/zebra_dialog.src.js"></script>
	<link rel="stylesheet" href="resources/css/dialog/zebra_dialog.css" type="text/css"/>
	<!-- SocketJS CDN -->
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
	
	<title>Chatting page</title>
</head>
<body>
	<h1>Chatting Page</h1>
	<input type="button" id="chattinglistbtn" value="채팅 참여자 리스트">
	<br>
	<div>
		<input type="text" id="message"/>
    	<input type="button" id="sendBtn" value="전송"/>
    	<div id="data"></div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	$("#chattinglistbtn").click(function(){
		var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>채팅방 참여자 리스트</p>',{
			title: 'Chatting List',
			type: 'confirmation',
			print: false,
			width: 760,
			buttons: ['닫기'],
			onClose: function(caption){
				if(caption == '닫기'){
					//alert('yes click');
				}
			}
		});
    });
});
</script>
<script type="text/javascript">
$(function(){
	$("#sendBtn").click(function(){
		console.log('send message...');
        sendMessage();
    });
});

//websocket을 지정한 URL로 연결
var sock= new SockJS("<c:url value="/echo"/>");
//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
sock.onmessage = onMessage;
//websocket 과 연결을 끊고 싶을때 실행하는 메소드
sock.onclose = onClose;
        
function sendMessage(){      
	//websocket으로 메시지를 보내겠다.
  	sock.send($("#message").val());     
}
            
//evt 파라미터는 websocket이 보내준 데이터다.
function onMessage(evt){  //변수 안에 function자체를 넣음.
	var data = evt.data;
	
   	$("#data").append(data+"<br/>");
  	/* sock.close(); */
}
    
function onClose(evt){
	$("#data").append("연결 끊김");
}    
</script>
</html>