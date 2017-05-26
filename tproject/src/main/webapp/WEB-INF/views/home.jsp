<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>Home</title>
	<!-- jQuery, bootstrap CDN -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script> <!-- msie 문제 해결 -->
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
</head>
<body>
<h1>SVN Test page</h1>
<br><br>
<label>* 저장소 생성</label>
<div id="repomake_local">
<input type="button" id="btn_test" value="click button">
</div>
<br>
<div id="makereponame">
</div>
<br><br>
<label>* 저장소 정보(UUID, revision, ...)</label>
<div id="repo_info">
<input type="button" id="btn_test2" value="click button">
</div>
<br>
<div id="repoinfo">
</div>
<br><br>
<label>* 저장소 history(로그)</label>
<div id="repo_log">
<input type="button" id="btn_test3" value="click button">
</div>
<br>
<div id="repolog">
</div>
<script type="text/javascript">
$(function(){
	$('#btn_test').click(function(){
		var trans_objeect = 
    	{
        	'url': '/Users/macbook/Desktop/repo',
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/makerepoajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				alert("success ajax..." + '/' + retVal.result + "저장소 생성");
				
				var printHTML = "<label id='repourltext'>-> local repo URL: "+retVal.repourl+"</label>"
				printHTML += "<input type='hidden' id='repourl' value='"+retVal.repourl+"'>";
				
				$('#makereponame').append(printHTML);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	})
	$('#btn_test2').click(function(){
		var repourl = $('#repourl').val();
		
		var trans_objeect = 
    	{
        	'url': repourl,
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/repoinfoajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				alert("success ajax..." + '/' + retVal.result);
				
				var printHTML = "<label id='repouuidtext'>-> repo UUID: "+retVal.repoinfo.repouuid+"</label><br>"
				printHTML += "<label id='reporevesiontext'>-> repo revesion: "+retVal.repoinfo.reporevesion+"</label><br>"
				
				$('#repoinfo').append(printHTML);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_test3').click(function(){
		var repourl = $('#repourl').val();
		
		var trans_objeect = 
    	{
        	'url': repourl,
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/repohistoryajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				alert("success ajax..." + '/' + retVal.result);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
});
</script>
</body>
</html>
