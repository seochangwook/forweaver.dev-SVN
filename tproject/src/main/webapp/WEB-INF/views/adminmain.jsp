<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html ng-app="myadminApp">
<head>
	<link rel="icon" type="image/png"  href="resources/images/svnicon.png"/> <!-- favicon fix -->
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushDiff.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushPlain.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCore.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shThemeDefault.css"/>
</head>
<script type="text/javascript">
    SyntaxHighlighter.defaults['toolbar'] = false;
    SyntaxHighlighter.highlight(); 
</script>
<body>
	<div ng-controller="authcheckcontroller">
		<h1>SVN Test page(for Admin)</h1><br>
		<input type="button" value="logout" ng-click="logoutclick('${serverip}')">
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
	<input type="button" id="btn_test5" value="view repo">&nbsp
	<input type="button" id="btn_status" value="repo status">&nbsp
	<input type="button" id="btn_update" value="repo update">&nbsp
	<input type="number" id="update_revesion" placeholder="input update revesion" min="0">&nbsp
	<label id="infotext">(select 0 is latest revesion)</label><br>
	<input type='hidden' id='filepath' value=''>
	<input type='hidden' id='repourl' value=''>
	<input type='hidden' id='originalcontent' value=''>
	<input type="hidden" id='originalrepourl' value=''> 
	<br>
	<div id="resultwell">
	</div>
	<br>
	<div id="repotree">
	</div>
	<br>
	<div class="well">
		<label>* 저장소 파일/디렉터리</label><br>
		<label>-> 생성 경로:</label>
		<input type="text" id="commitpath" placeholder="view repo path" disabled="disabled"><br>
		<label>-> 디렉터리 생성:</label>
		<input type="text" id="commitdirname" placeholder="input dir name"><br>
		<label>-> 파일 생성:</label>
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
	     	<input type="button" id="btn_test6" value="new file add">
	      	<input type="button" id="btn_test8" value="new dir add">
	      	<input type="button" id="btn_test7" value="modify file">
  		</div>
  		<br>
  		<div>
  			<input type="button" id="btn_commit" value="commit">&nbsp
  			<input type="text" id="commitlog" placeholder="input commit message"><br>
  			<div id="resultwellcommit">
			</div>
  		</div>
	</div>
	<div>
		<label>* 저장소 checkout</label><br>
		<div class="well">
			<label>-> 체크아웃 URL:</label>
			<input type="text" id="checkoutrepourl" placeholder="input repo URL"><br>
			<label>-> 체크아웃 Local 경로:</label>
			<input type="text" id="checkoutlocalpath" placeholder="input Local path"><br>
			<label>-> Revesion 1:</label>
			<input type="number" id="checkoutrevesionone" placeholder="input revesion 1" min="0"><br>
			<label>-> Revesion 2:</label>
			<input type="number" id="checkoutrevesiontwo" placeholder="input revesion 2" min="0"><br><br>
			<input type="button" id="btn_checkout" value="checkout run">
			<div id="checkoutresult">
			</div>
		</div>
	</div>
	<div>
		<label>* 저장소 diff (Revision Differences)</label><br>
		<div class="well">
			<label>-> 저장소 경로 (로컬):</label>
			<input type="text" id="diffrepopath" placeholder="input repo path"><br>
			<label>-> Compare Revesion 1:</label>
			<input type="number" id="compare_revesion_one" placeholder="input revesion 1" min="0"><br>
			<label>-> Compare Revesion 2:</label>
			<input type="number" id="compare_revesion_two" placeholder="input revesion 2" min="0"><br><br>
			<input type="button" id="btn_diff_button" value="diff run">
		</div>
		<div id="diffresult">
			<label>-> diff 결과 출력영역</label>
			<pre id="code" class="brush : diff">
			</pre>
		</div>
	</div>
	<div>
		<label>* 저장소 blame (About file modifier by file line)</label><br>
		<div class="well">
			<label>-> 조사 저장소 파일 경로 (로컬):</label>
			<input type="text" id="blamerepofilepath" placeholder="input repo path"><br>
			<label>-> Start Revesion :</label>
			<input type="number" id="start_revesion" placeholder="input revesion 1" min="0"><br>
			<label>-> End Revesion :</label>
			<input type="number" id="end_revesion" placeholder="input revesion 2" min="0"><br><br>
			<input type="button" id="btn_blame_button" value="blame run">
		</div>
		<div id="diffresult">
			<label>-> blame 결과 출력영역</label>
			<pre id="codeblame" class="brush : plain">
			</pre>
		</div>
	</div>
	<div>
		<label>* 채팅방 이동</label><br>
		<form name='TransTest' id='tForm' method='get' action='http://${serverip}:8080/controller/chatting.do'>
			<p><button name='subject' type='submit'>채팅방 입장</button></p>
		</form>
	</div>
	<input type="hidden" id="ipaddress" value='${serverip}'>
</body>
<script type="text/javascript">
var serverip = $('#ipaddress').val();
</script>
<script type="text/javascript">
$(function(){
	$('#btn_checkout').click(function(){
		var checkouturl = $('#checkoutrepourl').val();
		var checkoutpath = $('#checkoutlocalpath').val();
		var checkoutrevesionone = $('#checkoutrevesionone').val();
		var checkoutrevesiontwo = $('#checkoutrevesiontwo').val();
	
		var trans_objeect = 
    	{
        	'checkoutrepourl':checkouturl,
        	'checkoutlocalpath':checkoutpath,
        	'checkoutrevesionone':checkoutrevesionone,
        	'checkoutrevesiontwo':checkoutrevesiontwo
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/checkoutajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				//alert('success ajax');
				var returnvalue = retVal.checkoutinfo.retval;
				var retmessage = retVal.checkoutinfo.retmsg;
				var PrintHTML = '';
				
				if(returnvalue == '0'){
					PrintHTML += "<br>";
					PrintHTML += "<div class='alert alert-danger alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Checkoit Fail...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				} else if(returnvalue == '1'){
					PrintHTML += "<br>";
					PrintHTML += "<div class='alert alert-success alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Checkout Success...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				}
				
				$('#checkoutresult').empty();
				$('#checkoutresult').append(PrintHTML);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_commit').click(function(){
		var defaultfilepath = $('#originalrepourl').val();
		var relativefilepath = $('#filepath').val();
		var commitmessage = $('#commitlog').val();
		var commitpath = '';
		
		commitpath = defaultfilepath.substring(7) + relativefilepath;
		
		console.log('commit path: ' + commitpath);
		
		var trans_objeect = 
    	{
        	'commitrepo':commitpath,
        	'commitmessage':commitmessage
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/commitajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				//alert('success ajax');
				var returnvalue = retVal.commitinfo.retval;
				var retmessage = retVal.commitinfo.retmsg;
				var PrintHTML = '';
				
				if(returnvalue == '0'){
					PrintHTML += "<br>";
					PrintHTML += "<div class='alert alert-danger alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Commit Fail...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				} else if(returnvalue == '1'){
					PrintHTML += "<br>";
					PrintHTML += "<div class='alert alert-success alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Commit Success...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				}
				
				$('#resultwellcommit').empty();
				$('#resultwellcommit').append(PrintHTML);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_update').click(function(){
		var repourl = $('#repourl').val();
		var defaultfilepath = $('#originalrepourl').val();
		var relativefilepath = $('#filepath').val();
		var update_revesion_number = $('#update_revesion').val();
		var updatepath = '';
		
		console.log('repo url: ' + repourl);
		//file:// 잘라내기//
		updatepath = defaultfilepath.substring(7) + relativefilepath;
		
		if(update_revesion_number == 0){
			console.log('update path: ' + updatepath + ' / update revesion number: latest revesion');
		} else{
			console.log('update path: ' + updatepath + ' / update revesion number: ' + update_revesion_number);	
		}
		
		var trans_objeect = 
    	{
			'repourl':repourl,
        	'updaterepo':updatepath,
        	'updaterevesion':update_revesion_number
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/updateajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				var returnvalue = retVal.updateinfo.retval;
				var retmessage = retVal.updateinfo.retmsg;
				var PrintHTML = '';
				
				if(returnvalue == '0'){
					PrintHTML += "<div class='alert alert-danger alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Update Fail...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				} else if(returnvalue == '1'){
					PrintHTML += "<div class='alert alert-success alert-dismissable fade in'>";
					PrintHTML += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
					PrintHTML += "<strong>Update Success...</strong> ["+retmessage+']';
					PrintHTML += "</div>";
				}
				
				$('#resultwell').empty();
				$('#resultwell').append(PrintHTML);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_blame_button').click(function(){
		var filerepourl = $('#blamerepofilepath').val();
		var startrevesion = $('#start_revesion').val();
		var endrevesion = $('#end_revesion').val();
		
		console.log('file path: ' + filerepourl + '/ start rev: ' + startrevesion + '/ end rev: ' + endrevesion);
		
		var trans_objeect = 
    	{
        	'filerepourl':filerepourl,
        	'startrevesion':startrevesion,
        	'endrevesion':endrevesion
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/blameajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				//alert('ajax success');
				var count = retVal.blameinfo.resultval.count;
				var content = [];
				var printcontent = '';
				
				content = retVal.blameinfo.resultval.blamelist;
				
				console.log('count: ' + count);
				
				for(var i=0; i<=count; i++){
					printcontent += content[i] + '<br>';
				}
				
				$('#codeblame').empty();
				$('#codeblame').append(printcontent);
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	})
	$('#btn_status').click(function(){
		var defaultfilepath = $('#originalrepourl').val();
		var repourl = $('#repourl').val();
		var relativefilepath = $('#filepath').val();
		var statuspath;
		
		statuspath = defaultfilepath.substring(7) + relativefilepath;
		
		var trans_objeect = 
    	{
        	'repourl':repourl,
        	'statuspath':statuspath
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/statusajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				var count = retVal.statusinfo.resultval.count;
				var content = [];
				var printcontent = '';
				
				content = retVal.statusinfo.resultval.statusinfolist;
				
				for(var i=0; i<=count; i++){
					printcontent += content[i] + '<br>';
				}
				
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>'+printcontent+'</p>',{
					title: 'SVN Test Dialog',
					type: 'confirmation',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			},
			error: function(retVal, status, er){
				alert("error: "+retVal+" status: "+status+" er:"+er);
			}
		});
	});
	$('#btn_diff_button').click(function(){
		var repourl = $('#diffrepopath').val();
		var revesionone = $('#compare_revesion_one').val();
		var revesiontwo = $('#compare_revesion_two').val();
		
		var trans_objeect = 
    	{
        	'repourl':repourl,
        	'revesionone':revesionone,
        	'revesiontwo':revesiontwo
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/diffajax",
			type: 'POST',
			dataType: 'json',
			data: trans_json,
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(retVal){
				if(retVal.diffinfo.resultval == '0'){
					//alert("success ajax and function fail..." + retVal.diffinfo.resultval);
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>해당 저장소의 [Revesion'+revesionone+'] 과 [Revesion'+revesiontwo+'] 의 차이 결과를 찾을 수 없습니다.</p>',{
						title: 'SVN Test Dialog',
						type: 'warning',
						print: false,
						width: 760,
						position: ['right - 20', 'top + 20'],
						buttons: ['닫기'],
						onClose: function(caption){
							if(caption == '닫기'){
								//alert('yes click');
							}
						}
					});
				} else{
					$('#code').empty();
					$('#code').append(retVal.diffinfo.resultval);
					
					SyntaxHighlighter.highlight(); //동적으로 한번 더 로드해준다.//
					
					var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>해당 저장소의 [Revesion'+revesionone+'] 과 [Revesion'+revesiontwo+'] 의 차이 결과를 출력합니다.</p>',{
						title: 'SVN Test Dialog',
						type: 'confirmation',
						print: false,
						width: 760,
						position: ['right - 20', 'top + 20'],
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
	});
	$('#btn_test').click(function(){
		var trans_objeect = 
    	{
        	'url': 'C:\\Users\\seochangwook\\Desktop\\testrepo' //파일선택하는 걸로 나중엔 설정. 현재는 디폴트//
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
		
		console.log('ip address: ' + serverip);
		
		var trans_objeect = 
    	{
        	'url': repourl,
        	'userid':repouserid,
        	'userpassword':repouserpassword
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/repoinfoajax",
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
	        	printStr += "</thead>"; "src/main/webapp/WEB-INF/views/chat/chattingview.jsp"
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
			url: "http://"+serverip+":8080/controller/repohistoryajax",
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
			url: "http://"+serverip+":8080/controller/repotreeajax",
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
		            	console.log('lock condition: [' + repotreelistname[i] + '] is [' + repotreelistlock[i] + ']');
		            	if(repotreelistlock[i] == 'lock' && repokind[i] == 'file'){
		            		printStr += "<td><img alt='"+repotreelistname[i]+"' src='./resources/images/lockimage.png' width='40' height='40' onclick='unlock(this.alt)'></td>";	
		            	} else if(repotreelistlock[i] == 'unlock' && repokind[i] == 'file'){
		            		printStr += "<td><img alt='"+repotreelistname[i]+"' src='./resources/images/unlockimage.png' width='40' height='40' onclick='lock(this.alt)'></td>";	
		            	} else if(repokind[i] == 'dir') {
		            		printStr += "<td><img src='./resources/images/notimage.png' width='40' height='40'></td>";
		            	}
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
				
				$('#repotree').append(printStr); //다시 테이블을 보여주기 위해서 HTML코드 적용//
				$('#repourl').val(repourl); 
				
				$('#originalrepourl').val($('#repourl').val()+'/svnserverone'); //추후 이 부분은 하드코딩이 아닌 저장소의 이름을 받아온다.//
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
		var repouserid = $('#repouserid').val();
		var repouserpassword = $('#repouserpassword').val();
		
		//alert('path: ' + commitpath + ', name: ' + commitfilename + ', content: ' + commitfilecontent);
		var trans_objeect = 
    	{
			'repourl':repourl,
        	'commitpath': commitpath,
        	'commitlog':commitlog,
        	'commitfilename':commitfilename,
        	'commitfilecontent':commitfilecontent,
        	'userid':repouserid,
        	'userpassword':repouserpassword
	    }
		var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
		
		$.ajax({
			url: "http://"+serverip+":8080/controller/addajax",
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
			url: "http://"+serverip+":8080/controller/commitmodifyajax",
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
			url: "http://"+serverip+":8080/controller/adddirajax",
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
		url: "http://"+serverip+":8080/controller/filecontentajax",
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
					url: "http://"+serverip+":8080/controller/commitdeleteajax",
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
		url: "http://"+serverip+":8080/controller/repotreeajax",
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
	            	console.log('lock condition: [' + repotreelistname[i] + '] is [' + repotreelistlock[i] + ']');
	            	if(repotreelistlock[i] == 'lock' && repokind[i] == 'file'){
	            		printStr += "<td><img alt='"+repotreelistname[i]+"' src='./resources/images/lockimage.png' width='40' height='40' onclick='unlock(this.alt)'></td>";	
	            	} else if(repotreelistlock[i] == 'unlock' && repokind[i] == 'file'){
	            		printStr += "<td><img alt='"+repotreelistname[i]+"' src='./resources/images/unlockimage.png' width='40' height='40' onclick='lock(this.alt)'></td>";	
	            	} else if(repokind[i] == 'dir') {
	            		printStr += "<td><img src='./resources/images/notimage.png' width='40' height='40'></td>";
	            	}
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
//////////////////////////
function unlock(filename){
	var defaultfilepath = $('#originalrepourl').val();
	var repourl = $('#repourl').val();
	var relativefilepath = $('#filepath').val();
	var unlockfilepath;
	
	unlockfilepath = defaultfilepath.substring(7) + relativefilepath + '/' +filename;
	
	//앞의 file:// 을 제거//
	console.log(unlockfilepath +' -> unlock' + ' / repourl: ' + repourl);
	
	var trans_objeect = 
	{
    	'url': repourl,
    	'unlockfilepath':lockfilepath
    }
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: "http://"+serverip+":8080/controller/unlockajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			if(retVal.lockinfo.resultval == '1'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>파일잠금 해제가 정상적으로 이루어졌습니다. 새로고침하여 확인하세요</p>',{
					title: 'SVN Test Dialog',
					type: 'confirmation',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			}
			
			else if(retVal.lockinfo.resultval == '0'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>파일잠금 해제를 실패했습니다. 파일정보를 다시한번 확인하세요</p>',{
					title: 'SVN Test Dialog',
					type: 'error',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
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
//////////////////////////
function lock(filename){
	var defaultfilepath = $('#originalrepourl').val();
	var repourl = $('#repourl').val();
	var relativefilepath = $('#filepath').val();
	var lockfilepath;
	
	lockfilepath = defaultfilepath.substring(7) + relativefilepath + '/' +filename;
	
	//앞의 file:// 을 제거//
	console.log(lockfilepath +' -> lock' + ' / repourl: ' + repourl);
	
	var trans_objeect = 
	{
    	'url': repourl,
    	'lockfilepath':lockfilepath
    }
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: "http://"+serverip+":8080/controller/lockajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			if(retVal.lockinfo.resultval == '1'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>파일잠금이 정상적으로 이루어졌습니다. 새로고침하여 확인하세요</p>',{
					title: 'SVN Test Dialog',
					type: 'confirmation',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
					buttons: ['닫기'],
					onClose: function(caption){
						if(caption == '닫기'){
							//alert('yes click');
						}
					}
				});
			}
			
			else if(retVal.lockinfo.resultval == '0'){
				var infodialog = new $.Zebra_Dialog('<strong>Message:</strong><br><br><p>파일잠금이 실패했습니다. 파일정보를 다시한번 확인하세요</p>',{
					title: 'SVN Test Dialog',
					type: 'error',
					print: false,
					width: 760,
					position: ['right - 20', 'top + 20'],
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
