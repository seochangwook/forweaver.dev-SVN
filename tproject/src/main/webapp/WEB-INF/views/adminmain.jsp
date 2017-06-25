<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html ng-app="myadminApp">
<head>
	<title>adminHome</title>
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
	<!-- AngularJS CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
	<!-- AngularJS External File -->
	<script src="resources/js/adminmainangular.js"></script>
	<!-- Beautiful Code, Theme CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shCore.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushJava.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCore.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shThemeDefault.css"/>
</head>
<body>
	<div ng-controller="authcheckcontroller">
		<h1>SVN Test page(for Admin)</h1><br>
		<input type="button" ng-click="logoutclick()" value="logout ">
	</div>
	<br><br>
	<div id="repomake_local">
		<label>* 저장소 생성(바탕화면): </label>
		<input type="button" id="btn_test" value="click button"><br>
		<label>* 저장소 불러오기: </label>
		<input type="text" id="repopathtext" placeholder="input repo path">
		<input type="button" id="btn_test4" value="click button"><br>
		<label>* 저장소 아이디: </label>
		<input type="text" id="repouserid" placeholder="Input ID"><br>
		<label>* 저장소 비밀번호: </label>
		<input type="password" id="repouserpassword" placeholder="Input Password"><br>
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
	<input type='hidden' id='filepath' value=''>
	<input type='hidden' id='repourl' value=''>
	<input type='hidden' id='originalcontent' value=''>
	<div id="repotree">
	</div>
	<br>
	<div class="well">
		<label>* 저장소 커밋</label><br>
		<label>-> 커밋 경로:</label>
		<input type="text" id="commitpath" placeholder="view repo path" disabled="disabled"><br>
		<label>-> 커밋 디렉터리명:</label>
		<input type="text" id="commitdirname" placeholder="input dir name"><br>
		<label>-> 커밋 파일명:</label>
		<input type="text" id="commitfilename" placeholder="input file name"><br>
		<label>-> 커밋 로그명:</label>
		<input type="text" id="commitname" placeholder="input commit name"><br>
		<label>-> 파일내용:</label>
		<div class="row">
    		<div class="col-sm-6">
	    		<div ng-controller="codecontroller">
					<pre class="brush: java">
						{{printCode}}
					</pre>
				</div>
    		</div>
   		 	<div class="col-sm-6">
   		 		<textarea class="form-control" rows="7" id="filecontent" placeholder="input/modify content"></textarea><br>
   		 	</div>
  		</div>
  		<div class="btn-group btn-group-justified">
	     	<input type="button" id="btn_test6" value="new file commit">
	      	<input type="button" id="btn_test8" value="new dir commit">
	      	<input type="button" id="btn_test7" value="modify commit">
  		</div>
	</div>
</body>
<script type="text/javascript">
SyntaxHighlighter.all();

$(function(){
	$('#btn_test').click(function(){
		var trans_objeect = 
    	{
        	'url': 'C:\\Users\\seochangwook\\Desktop\\testrepo'
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
		var repouserid = $('#repouserid').val();
		var repouserpassword = $('#repouserpassword').val();
		
		var trans_objeect = 
    	{
        	'url': repourl,
        	'userid':repouserid,
        	'userpassword':repouserpassword
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
		var repouserid = $('#repouserid').val();
		var repouserpassword = $('#repouserpassword').val();
		
		var trans_objeect = 
    	{
        	'url': repourl,
        	'userid':repouserid,
        	'userpassword':repouserpassword
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
		var repouserid = $('#repouserid').val();
		var repouserpassword = $('#repouserpassword').val();
		
		var printHTML = "<label id='repourltext'>-> repo URL: "+repopath+"</label>";
		
		//저장소 정보 할당//
		printHTML += "<input type='hidden' id='repourl' value='"+repopath+"'>";
		//인증정보 할당//
		printHTML += "<input type='hidden' id='repouserid' value='"+repouserid+"'>";
		printHTML += "<input type='hidden' id='repouserpassword' value='"+repouserpassword+"'>";
		
		$('#makereponame').append(printHTML);
		
		console.log("repouURL(hidden): " + repopath);
		console.log("repouID(hidden): " + repouserid);
		console.log("repouPassword(hidden): " + repouserpassword);
	});
	$('#btn_test5').click(function(){
		var repourl = $('#repopathtexttree').val();
		var filepath = $('#filepath').val();
		var repouserid = $('#repouserid').val();
		var repouserpassword = $('#repouserpassword').val();
		
		console.log('table filepath: ' + filepath);
		
		//기존 경로를 위한 값 초기화//
		$('#filepath').val('');
		$('#repourl').val('');
		
		var trans_objeect = 
    	{
        	'url': repourl,
        	'userid':repouserid,
        	'userpassword':repouserpassword
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
				var repokind = [];
				var repocommitmsg = [];
				var repofilepath = [];
				
				repotreelistname = retVal.repotreelist.repotreelistname;
				repotreelistauthor = retVal.repotreelist.repotreelistauthor;
				repotreelistrevesion = retVal.repotreelist.repotreelistrevesion;
				repotreelistdate = retVal.repotreelist.repotreelistdate;
				repotreelistlock = retVal.repotreelist.repotreelistlock;
				repokind = retVal.repotreelist.repokind;
				repocommitmsg = retVal.repotreelist.repocommitmsg;
				repofilepath = retVal.repotreelist.repofilepath;
				
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
		        	printStr += "<th>커밋명</th>";
		        	printStr += "<th>잠금유무</th>";
		        	printStr += "<th>보기/이동</th>";
		        	printStr += "<th>다운로드</th>";
		        	printStr += "<th>제거</th>";
		        	printStr += "</tr>";
		        	printStr += "</thead>"; 
		        	printStr += "<tbody>";
		        	
		        	//테이블에 들어갈 데이터를 삽입//
		           	for(var i=0; i<repotreecount; i++){
		           		printStr += "<tr>";
		           		if(repokind[i] == 'dir'){
		           			printStr += "<td><img src='./resources/images/directory.PNG' width='50' height='50'></td>";
		            	}
		            	else if(repokind[i] == 'file'){
		            		printStr += "<td><img src='./resources/images/fileicon.PNG' width='50' height='50'></td>";
		            	}
		            	printStr += "<td>"+repotreelistname[i]+"</td>";
		            	printStr += "<td>"+repotreelistauthor[i]+"</td>";
		            	printStr += "<td>ver."+repotreelistrevesion[i]+"</td>";
		            	printStr += "<td>"+repotreelistdate[i]+"</td>";
		            	printStr += "<td>"+repocommitmsg[i]+"</td>";
		            	printStr += "<td>"+repotreelistlock[i]+"</td>";
		            	if(repokind[i] == 'dir'){
		            		printStr += "<td><button value='"+repotreelistname[i]+"' onclick='viewcode(this.value)'>move</button></td>";
		            		printStr += "<td><button value='"+repotreelistname[i]+"' disabled='disabled'>download</button></td>";
		            	}
		            	else if(repokind[i] == 'file'){
		            		printStr += "<td><button value='"+repotreelistname[i]+"' onclick='viewcode(this.value)'>view</button></td>";
		            		printStr += "<td><a href='http://localhost:8080/controller/download.do/"+repotreelistname[i]+"&filepath="+filepath+"'>Download</a></td>";
		            	}
		            	printStr += "<td><button value='"+repotreelistname[i]+"' onclick='deletepath(this.value)'>remove</button></td>";
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
				$('#repourl').val(repourl);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_test6').click(function(){
		var repourl = $('#repopathtexttree').val();
		var commitpath = $('#filepath').val();
		var commitlog = $('#commitname').val();
		var commitfilename = $('#commitfilename').val();
		var commitfilecontent = $('#filecontent').val();
		
		//alert('path: ' + commitpath + ', name: ' + commitfilename + ', content: ' + commitfilecontent);
		var trans_objeect = 
    	{
			'repourl':repourl,
        	'commitpath': commitpath,
        	'commitlog':commitlog,
        	'commitfilename':commitfilename,
        	'commitfilecontent':commitfilecontent
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/commitajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				if(retVal.commitinfo.resultval == '1'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit success</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								
							}
						}
					});
				}else if(retVal.commitinfo.resultval == '0'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit fail</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								
							}
						}
					});
				}
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_test7').click(function(){
		var repourl = $('#repopathtexttree').val();
		var update_content = $('#filecontent').val();
		var commitfilename = $('#commitfilename').val();
		var original_content = $('#originalcontent').val();
		var commitlog = $('#commitname').val();
		var commitpath = $('#filepath').val();
		
		//alert(repourl + ',' + original_content + ',' + update_content + ',' + commitlog + ',' + commitpath + ',' + filename);
		var trans_objeect = 
    	{
			'repourl':repourl,
        	'commitpath': commitpath,
        	'commitlog':commitlog,
        	'commitfilename':commitfilename,
        	'updatecontent':update_content,
        	'originalcontent':original_content
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/commitmodifyajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				if(retVal.commitinfo.resultval == '1'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit modify success</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								
							}
						}
					});
				}else if(retVal.commitinfo.resultval == '0'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit modify fail</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								
							}
						}
					});
				}
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_test8').click(function(){
		var repourl = $('#repopathtexttree').val();
		var commitpath = $('#filepath').val();
		var commitlog = $('#commitname').val();
		var commitfilename = $('#commitfilename').val();
		var commitfilecontent = $('#filecontent').val();
		var commitdirname = $('#commitdirname').val();
		
		var trans_objeect = 
    	{
			'repourl':repourl,
        	'commitpath': commitpath,
        	'commitlog':commitlog,
        	'commitfilename':commitfilename,
        	'commitfilecontent':commitfilecontent,
        	'commitdirname':commitdirname
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://localhost:8080/controller/commitdirajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				if(retVal.commitinfo.resultval == '1'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit success</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
							
							}
						}
					});
				}else if(retVal.commitinfo.resultval == '0'){
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>commit fail</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								
							}
						}
					});
				}
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
});
/////////////////////////
function viewcode(filename){
	var repourl = $('#repourl').val();
	var filepath = $('#filepath').val() + '/'+ filename;
	var repouserid = $('#repouserid').val();
	var repouserpassword = $('#repouserpassword').val();
	
	var trans_objeect = 
	{
    	'url': repourl,
    	'userid':repouserid,
    	'userpassword':repouserpassword,
    	'filename': filename,
    	'filepath': filepath
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
				$('#originalcontent').val(retVal.filecontentinfo.content);
				$('#filecontent').val(retVal.filecontentinfo.content);
				$('#commitfilename').val(filename);
				
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>소스코드 확인</p><br>'+
						'<label>'+retVal.filecontentinfo.content+'</label>',{
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
				var filepath = $('#filepath').val();
				var repourl = $('#repourl').val();
				
				filepath = filepath + '/' + filename;
				repourl = repourl + '/' + filename;
				
				$('#filepath').val(filepath);
				$('#repourl').val(repourl);
				$('#commitpath').val(repourl);
				
				//해당 경로로 다시 리스트 출력//
				list_reload(repourl);
			}
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
/////////////////////////////
function deletepath(filename){
	var repourl = $('#repourl').val();
	var filepath = $('#filepath').val() + '/'+ filename;
	var commitlog = $('#commitname').val();
	
	var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>'+filepath+' 를 제거 합니까?</p>',{
		title: 'SVN Test Dialog',
		type: 'question',
		print: false,
		width: 760,
		buttons: ['제거','닫기'],
		onClose: function(caption){
			if(caption == '닫기'){
				
			}else if(caption == '제거'){
				var trans_objeect = 
				{
			    	'url': repourl,
			    	'deletepath': filepath,
			    	'commitlog':commitlog
			    }
				var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
				
				$.ajax({
					url: "http://localhost:8080/controller/commitdeleteajax",
					type: 'POST',
					dataType: 'json',
					data: trans_json,
					contentType: 'application/json',
					mimeType: 'application/json',
					success: function(retVal){
						if(retVal.commitinfo.resultval == '1'){
							var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>'+filepath+' 를 제거 합니다.</p>',{
								title: 'SVN Test Dialog',
								type: 'confirmation',
								print: false,
								width: 760,
								buttons: ['닫기'],
								onClose: function(caption){
									if(caption == '닫기'){
										
									}
								}
							});
						}else if(retVal.commitinfo.resultval == '0'){
							var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>'+filepath+' 를 제거실패.</p>',{
								title: 'SVN Test Dialog',
								type: 'error',
								print: false,
								width: 760,
								buttons: ['닫기'],
								onClose: function(caption){
									if(caption == '닫기'){
										
									}
								}
							});
						}
					},
					error: function(retVal, status, er){
						var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>'+filepath+' 를 제거실패.</p>',{
							title: 'SVN Test Dialog',
							type: 'error',
							print: false,
							width: 760,
							buttons: ['닫기'],
							onClose: function(caption){
								if(caption == '닫기'){
									
								}
							}
						});
					}
				});
			}
		}
	});
}
/////////////////////////////
function list_reload(repourl){
	var filepath = $('#filepath').val();
	var repouserid = $('#repouserid').val();
	var repouserpassword = $('#repouserpassword').val();
	
	console.log('table filepath: ' + filepath);
	
	var trans_objeect = 
	{
    	'url': repourl,
    	'userid':repouserid,
    	'userpassword':repouserpassword
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
			var repokind = [];
			var repocommitmsg = [];
			var repofilepath = [];
			
			
			repotreelistname = retVal.repotreelist.repotreelistname;
			repotreelistauthor = retVal.repotreelist.repotreelistauthor;
			repotreelistrevesion = retVal.repotreelist.repotreelistrevesion;
			repotreelistdate = retVal.repotreelist.repotreelistdate;
			repotreelistlock = retVal.repotreelist.repotreelistlock;
			repokind = retVal.repotreelist.repokind;
			repocommitmsg = retVal.repotreelist.repocommitmsg;
			repofilepath = retVal.repotreelist.repofilepath;
			
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
	        	printStr += "<th>커밋명</th>";
	        	printStr += "<th>잠금유무</th>";
	        	printStr += "<th>보기/이동</th>";
	        	printStr += "<th>다운로드</th>";
	        	printStr += "<th>제거</th>";
	        	printStr += "</tr>";
	        	printStr += "</thead>"; 
	        	printStr += "<tbody>";
	        	
	        	//테이블에 들어갈 데이터를 삽입//
	           	for(var i=0; i<repotreecount; i++){
	           		printStr += "<tr>";
	           		if(repokind[i] == 'dir'){
	           			printStr += "<td><img src='./resources/images/directory.PNG' width='50' height='50'></td>";
	            	}
	            	else if(repokind[i] == 'file'){
	            		printStr += "<td><img src='./resources/images/fileicon.PNG' width='50' height='50'></td>";
	            	}
	            	printStr += "<td>"+repotreelistname[i]+"</td>";
	            	printStr += "<td>"+repotreelistauthor[i]+"</td>";
	            	printStr += "<td>ver."+repotreelistrevesion[i]+"</td>";
	            	printStr += "<td>"+repotreelistdate[i]+"</td>";
	            	printStr += "<td>"+repocommitmsg[i]+"</td>";
	            	printStr += "<td>"+repotreelistlock[i]+"</td>";
	            	if(repokind[i] == 'dir'){
	            		printStr += "<td><button value='"+repotreelistname[i]+"' onclick='viewcode(this.value)'>move</button></td>";
	            		printStr += "<td><button value='"+repotreelistname[i]+"' disabled='disabled'>download</button></td>";
	            	}
	            	else if(repokind[i] == 'file'){
	            		printStr += "<td><button value='"+repotreelistname[i]+"' onclick='viewcode(this.value)'>view</button></td>";	
	            		printStr += "<td><a href='http://localhost:8080/controller/download.do?filename="+repotreelistname[i]+"&filepath="+filepath+"'>Download</a></td>";
	            	}
	            	printStr += "<td><button value='"+repotreelistname[i]+"' onclick='deletepath(this.value)'>remove</button></td>";
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
			$('#repourl').val(repourl);
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
</script>
</html>
