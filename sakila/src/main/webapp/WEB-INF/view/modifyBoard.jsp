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
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
</script>
 
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous">
</script>
<script>
    $(document).ready(function() {
    	console.log("document ready!");
    	
    	$('#btn').click(function() {
        	console.log("btn clikc!");
        	
            if ($('#boardPw').val().length < 4) {
                alert('boardPw는 4자이상 이어야 합니다');
                $('#boardPw').focus();
                
            } else if ($('#boardTitle').val() == '') {
                alert('boardTitle을 입력하세요');
                $('#boardTitle').focus();
                
            } else if ($('#boardTitle').val() == '') {
                alert('boardTitle을 입력하세요');
                $('#boardUser').focus();
                
            } else if ($('#boardContent').val() == '') {
                alert('boardContent을 입력하세요');
                $('#boardContent').focus();
                
            } else {
                $('#modifyForm').submit();
            }
        });
    });
</script>
<title>Modify BOARD</title>
</head>
<body>
    <div class="container">
        <h1>modify BOARD(spring mvc 방식)</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
        <form id="modifyForm" action="${pageContext.request.contextPath}/admin/modifyBoard" method="post">
            <div class="form-group">
                <label for="boardId">boardId :</label> <input
                    class="form-control" readonly=readonly name="boardId" id="boardId" type="text" value="${boardMap.boardId}"/>
            </div>             
            <div class="form-group">
                <label for="boardPw">boardPw :</label> <input class="form-control"
                    name="boardPw" id="boardPw" type="password"/>
            </div>
            
            <div class="form-group">
                <label for="boardPw">boardTitle :</label> <input
                    class="form-control" name="boardTitle" id="boardTitle" type="text" value="${boardMap.boardTitle}" />
            </div>
            <div class="form-group">
                <label for="boardContent">boardContent :</label>
                <textarea class="form-control" name="boardContent" id="boardContent"
                    rows="5" cols="50">${boardMap.boardContent}</textarea>
            </div>
            <div>
                <button class="btn btn-default" id="btn" name="btn" type="button">제출</button>
                <input class="btn btn-default" type="reset" value="초기화" />
                <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList">글목록</a>
            </div>
        </form>
    </div>
</body>
</html>