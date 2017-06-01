<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>Home</title>
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
</head>
<body>
	<h1>SVN Test page</h1>
	<br><br>
	<div id="repomake_local">
		<label>* 저장소 생성(바탕화면): </label>
		<input type="button" id="btn_test" value="click button"><br>
		<label>* 저장소 불러오기: </label>
		<input type="text" id="repopathtext" placeholder="input repo path">
		<input type="button" id="btn_test4" value="click button"><br>
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
	<div id="repologlist">
	</div>
	<br><br>
	<label>* 저장소 트리구조 출력: </label>
	<input type="text" id="repopathtexttree" placeholder="input repo path">
	<input type="button" id="btn_test5" value="click button"><br>
	<div id="repotree">
	</div>
</body>
<script type="text/javascript">
$(function(){
	$('#btn_test').click(function(){
		var trans_objeect = 
    	{
        	'url': '/Users/macbook/Desktop/repo'
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
				
				$('#makereponame').empty();
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
        	'url': repourl
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
				var printStr = '';	
				
				$('#repoinfo').empty();
				
				printStr = "<div id='infolist'>";
	        	printStr += "<table class='table table-hover'>";
	        	printStr += "<thead>";
	        	printStr += "<tr>";
	        	printStr += "<th>구분</th>";
	        	printStr += "<th>정보</th>";
	        	printStr += "</tr>";
	        	printStr += "</thead>"; 
	        	printStr += "<tbody>";
	        	printStr += "<tr>";
	        	printStr += "<td>UUID</td>";
	            printStr += "<td>"+retVal.repoinfo.repouuid+"</td>";
	            printStr += "</tr>";
	            printStr += "<tr>";
	            printStr += "<td>마지막 리비전 ver</td>";
	            printStr += "<td>"+retVal.repoinfo.reporevesion+"</td>";
	            printStr += "</tr>";
	            printStr += "<tr>";
	            printStr += "<td>Root</td>";
	            printStr += "<td>"+retVal.repoinfo.reporoot+"</td>";	
	            printStr += "</tr>";
	            printStr += "<tr>";
	            printStr += "<td>Loation</td>";
	            printStr += "<td>"+retVal.repoinfo.repolocation+"</td>";	
	            printStr += "</tr>";
	           	printStr += "</tbody>";
	            printStr += "</table>";
	            printStr += "</div>";
	            
				$('#repoinfo').append(printStr);
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
        	'url': repourl
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
				var printStr = '';	
				
				var totalcount = retVal.loginfolist.count;
				var revesionlist = [];
				var authorlist = [];
				var datelist = [];
				var logmessagelist = [];
				var changepathlist = [];
				
				revesionlist = retVal.loginfolist.revesionlist;
				authorlist = retVal.loginfolist.authorlist;
				datelist = retVal.loginfolist.datelist;
				logmessagelist = retVal.loginfolist.logmessagelist;
				changepathlist = retVal.loginfolist.changepathlist;
				
				$('#repologlist').empty();
				
				//테이블에 원소가 한개이상있을 경우//
		        if(totalcount > 0){
		        	printStr = "<div id='loglist'>";
		        	printStr += "<table class='table table-hover'>";
		        	printStr += "<thead>";
		        	printStr += "<tr>";
		        	printStr += "<th>구분</th>";
		        	printStr += "<th>날짜</th>";
		        	printStr += "<th>리비전 ver</th>";
		        	printStr += "<th>권한</th>";
		        	printStr += "<th>commit 메세지</th>";
		        	printStr += "<th>변경된 파일정보</th>";
		        	printStr += "</tr>";
		        	printStr += "</thead>"; 
		        	printStr += "<tbody>";
		        	
		        	//테이블에 들어갈 데이터를 삽입//
		           	for(var i=0; i<totalcount; i++){
		           		printStr += "<tr>";
		            	printStr += "<td>"+(i+1)+"</td>";
		            	printStr += "<td>"+datelist[i]+"</td>";
		            	printStr += "<td>"+revesionlist[i]+"</td>";
		            	printStr += "<td>"+authorlist[i]+"</td>";
		            	printStr += "<td>"+logmessagelist[i]+"</td>";
		            	printStr += "<td>"+changepathlist[i]+"</td>";
	                	printStr += "</tr>"; 
		           	}
		        	
		           	printStr += "</tbody>";
		            printStr += "</table>";
		            printStr += "</div>";
		        }
				
		        else{
		        	printStr = "<div id='loglist'>";
	         	  	printStr += "<p id='info_sub1' style='font-size:14px;color:#586069; margin:0px'><br>SVN디렉터리가 존재하지 않거나 정보가 없음</b></p>";
	         	  	printStr += "</div>";
	         	  	
	         	  	var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>데이터가 존재하지 않거나 URL을 확인하세요</p>',{
						title: 'SVN Test Dialog',
						type: 'error',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								//alert('yes click');
							}
						}
					});
		        }
				
		        $('#repologlist').append(printStr); //다시 테이블을 보여주기 위해서 HTML코드 적용//
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_test4').click(function(){
		var repopath = $('#repopathtext').val();
		
		var printHTML = "<label id='repourltext'>-> repo URL: "+repopath+"</label>"
		printHTML += "<input type='hidden' id='repourl' value='"+repopath+"'>";
		
		$('#makereponame').append(printHTML);
	});
	$('#btn_test5').click(function(){
		var repourl = $('#repopathtexttree').val();
		
		var trans_objeect = 
    	{
        	'url': repourl
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/repotreeajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				var repotreecount = retVal.repotreelist.listcount;
				var repotreelistname = [];
				var repotreelistauthor = [];
				var repotreelistrevesion = [];
				var repotreelistdate = [];
				var repotreelistlock = [];
				
				repotreelistname = retVal.repotreelist.repotreelistname;
				repotreelistauthor = retVal.repotreelist.repotreelistauthor;
				repotreelistrevesion = retVal.repotreelist.repotreelistrevesion;
				repotreelistdate = retVal.repotreelist.repotreelistdate;
				repotreelistlock = retVal.repotreelist.repotreelistlock;
				
				//Table에 결과를 출력//
				$('#repotree').empty();
				
				if(repotreecount > 0){
		        	printStr = "<div id='repotree'>";
		        	printStr += "<table class='table table-hover'>";
		        	printStr += "<thead>";
		        	printStr += "<tr>";
		        	printStr += "<th>구분</th>";
		        	printStr += "<th>파일</th>";
		        	printStr += "<th>관리자</th>";
		        	printStr += "<th>리비전 ver</th>";
		        	printStr += "<th>날짜</th>";
		        	printStr += "<th>잠금유무</th>";
		        	printStr += "<th>소스보기</th>"
		        	printStr += "</tr>";
		        	printStr += "</thead>"; 
		        	printStr += "<tbody>";
		        	
		        	//테이블에 들어갈 데이터를 삽입//
		           	for(var i=0; i<repotreecount; i++){
		           		printStr += "<tr>";
		            	printStr += "<td>"+(i+1)+"</td>";
		            	printStr += "<td>"+repotreelistname[i]+"</td>";
		            	printStr += "<td>"+repotreelistauthor[i]+"</td>";
		            	printStr += "<td>ver."+repotreelistrevesion[i]+"</td>";
		            	printStr += "<td>"+repotreelistdate[i]+"</td>";
		            	printStr += "<td>"+repotreelistlock[i]+"</td>";
		            	printStr += "<td><button value='"+repotreelistname[i]+"' onclick='viewcode(this.value)'>view</button></td>";
	                	printStr += "</tr>"; 
		           	}
		        	
		           	printStr += "</tbody>";
		            printStr += "</table>";
		            printStr += "</div>";
		        }
				
		        else{
		        	printStr = "<div id='repotree'>";
	         	  	printStr += "<p id='info_sub1' style='font-size:14px;color:#586069; margin:0px'><br>SVN디렉터리가 존재하지 않거나 정보가 없음</b></p>";
	         	  	printStr += "</div>";
	         	  	
	         	  	var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>데이터가 존재하지 않거나 URL을 확인하세요</p>',{
						title: 'SVN Test Dialog',
						type: 'error',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								//alert('yes click');
							}
						}
					});
		        }
				
				$('#repotree').append(printStr); //다시 테이블을 보여주기 위해서 HTML코드 적용//
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
});
/////////////////////////
function viewcode(filename){
	var repourl = $('#repopathtexttree').val();
	
	var trans_objeect = 
	{
    	'url': repourl,
    	'filename':filename
    }
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: "http://localhost:8080/controller/filecontentajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			var type = retVal.filecontentinfo.type;
			
			if(type == 'file'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>소스코드 확인</p>',{
					title: 'SVN Test Dialog',
					type: 'information',
					print: false,
					width: 760,
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			}
			
			else if(type == 'directory'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>디렉터리 입니다.(소스코드를 확인할 수 없습니다.)</p>',{
					title: 'SVN Test Dialog',
					type: 'warning',
					print: false,
					width: 760,
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			}
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
</script>
</html>
