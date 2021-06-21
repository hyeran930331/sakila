<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
    crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
    integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
    crossorigin="anonymous">
 
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>
 
<script>
$(document).ready(function() {
    $('#btn').click(function() { 
    	console.log('btn 클릭');
    	// 파일들중 하나라도 첨부되지 않으면 empty = true;
    	
    	//let empty = false;

		//if($('multipartFile').val() == '') {
		//	empty = true;
		//	console.log('empty');
		//}
        
    	//if(empty) { // if(empty == true)
    	//	alert('첨부되지 않은 파일이 있습니다.');
    	//} else if (empty != true) {
            $('#addForm').submit();
       // }
    });
});
</script>
<title>add Boardfile</title>
</head>
<body>
	<h1>파일추가</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	<form id="addForm"
			method="post"
			enctype="multipart/form-data"
			action="${pageContext.request.contextPath}/admin/addBoardfile">
		<div>
			boardId:
		</div>
		<div>
			<input type="text" id="boardId" name="boardId" value="${boardId}" readonly="readonly">
		</div>
		<div>
			<input type="file" id="multipartFile" name="multipartFile">
		</div>
		<div>
			<button type="button" id="btn" >게시글에 추가</button>
		</div>
	</form>
</body>
</html>