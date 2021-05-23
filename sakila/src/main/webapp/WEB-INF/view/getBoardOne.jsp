<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
    $(document).ready(function() {
        $('#addButton').click(function() {
        	console.log ("addButton 클릭");
            if ($('#staffId').val() == '') {
                alert('staffId를 입력하세요');
                $('#staffId').focus();
            } else if ($('#content').val() == '') {
                alert('content을 입력하세요');
                $('#content').focus();
            } else {
                $('#addComment').submit();
            }
        }); //오오
        
	    $('#removeButton').click(function() {
	    	console.log ("removeButton 클릭");
	        $('#removeComment').submit();
	    });
	});
</script>
<title>BOARD VIEW(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>BOARD VIEW</h1>
     <table class="table table-dark">
         <tbody>
             <tr>
                <td>board_id :</td>
                <td>${boardMap.boardId}</td>
               </tr>
            <tr>
                   <td>board_title :</td>
                   <td>${boardMap.boardTitle}</td>
            </tr>
            <tr>
                   <td>board_content :</td>
                   <td>${boardMap.boardContent}</td>
            </tr>
            <tr>
                   <td>username :</td>
                   <td>${boardMap.username} (${boardMap.staffId})</td>
            </tr>
            <tr>
                   <td>insert_date :</td>
                   <td>${boardMap.insertDate}</td>
            </tr>
            
            <tr>
                   <td>boardfile :</td>
                   <td>
                   <div>
                  		<a href="${pageContext.request.contextPath}/admin/addBoardfile?boardId=${boardMap.boardId}"><button type="button">파일추가</button></a>
                   </div>
                   <c:forEach var="i" items="${boardfileList}">
                   <div>
                   		<a href="${pageContext.request.contextPath}/resource/${f.boardfileName}">${f.boardfileName}</a>
                   		<a href="${pageContext.request.contextPath}/admin/admin/removeBoardfile?boardId=${boardMap.boardId}&boardfileId=${f.boardfileId}">파일삭제</a>
                   </div>
                   </c:forEach>
                   </td>
            </tr>
        </tbody>
    </table>
    
    <!-- 버튼들 -->
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyBoard?boardId=${boardMap.boardId}">수정</a>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/removeBoard?boardId=${boardMap.boardId}">삭제</a>
    <br>
    <c:if test="${((boardMap.boardId)-1)>0}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardOne?boardId=${(boardMap.boardId)-1}">이전글</a>
    </c:if>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList?currentPage=${1}">처음으로</a>
    <!-- ${((boardMap.boardId)/10)} 소수점 버림처리 어떻게 한담? -->
    <c:if test="${((boardMap.boardId)+1)<boardTotal}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardOne?boardId=${(boardMap.boardId)+1}">다음글</a>
    </c:if>
</div>

	<!-- 댓글목록 -->
	<div class="container">
		<div class="container">
			<p>
			<!-- 콘트롤러에 addComment가 실행조차 안하는데요 5:02 -->
			<!-- controller를 따로 안만들어서? -->
			<table >
				<tr>
					<td class="center">
						<form id="removeComment" action="${pageContext.request.contextPath}/admin/removeComment" method="post">
						<table class="table">
							<thead class="table-dark">
							<tr>
								<th>staff_id</th>
								<th>content</th>
								<th>insert_update</th>
								<th></th>
							</tr>
							</thead>
							
							<c:forEach var="c" items="${commentList}"> <!-- map.commentList -->
							<tbody>								
							<tr>
								<td>
									<input type="hidden" id="boardId" name="boardId" value="${c.boardId}">
									<input type="hidden" id="commentId" name="commentId" value="${c.commentId}">
									${c.staffId} 
								</td>
								<td>${c.content} </td>
								<td>${c.insertDate}</td>
								<td> <input class="btn btn-danger" id="removeButton" type="button" value="삭제" />  </td>
							</tr>
							</tbody>
							</c:forEach>							
						</table>
						</form>
					</td>
				</tr>
			
				<tr>
					<td>
						<form id="addComment" action="${pageContext.request.contextPath}/admin/addComment" method="post">
						<table class="table">
							<thead class="thead-light">
							<tr >
								<th>session.staffId 댓글추가</th>
								<th></th>
								<th></th>
								<th></th>
							</tr>
							</thead>
							
							<tbody>
							<tr>
								<td> 
									<input type="hidden" id="boardId" name="boardId" value="${boardMap.boardId}">
									<input type="text" id="staffId" name="staffId">
									<!-- select 로 하고 싶은데~~ 그럼 테이블 또 받아야 겠죠?-->
								</td>
								<td> <textarea id="content" id="content" name="content"></textarea></td>
								<td> 수정불가</td>
								<td> <input class="btn btn-default" id="addButton" type="button" value="댓글입력" /> </td>
							</tr>
							</tbody>
						</table>
						</form>
					</td>
				</tr>
				
			</table>
			<!-- Invalid location of tag (form) 태그의 부적절한 위치 form은 table이나 td를 감싸고 있어야한다 -->
		</div>
	</div>
</body>
</html>