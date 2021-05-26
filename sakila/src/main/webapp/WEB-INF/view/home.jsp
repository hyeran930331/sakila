<!--  http://localhost/home -->
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
<script>
    $(document).ready(function() {
        $('#btn').click(function() {
        	console.log ("home btn 클릭");
        	
        	if ($('#email').val() == '') {
                alert('email을 입력하세요');
                $('#email').focus();
            } else if ($('#password').val().length < 4) {
                alert('password는 4자 이상입니다.');
                $('#password').focus();
            } else {
                $('#loginForm').submit();
            }
        });
        
    });
</script>
<title>Insert title here</title>
</head>
<body>
	<h1> Home</h1>
	<!-- 로그오프시 -->
	<c:if test="${loginStaff == null}">
		<form id ="loginForm" action="${pageContext.request.contextPath}/login" method="post">
			<div> mail :
				<input type="text" id="email" name="email">
			</div>
			<div> password :
				<input type="password" id="password" name="password">
			</div>
			<input type="button" id="btn" name="btn" type="button" value="로그인">
			<!-- button type="submit"이 아니고 input type="button" <script>활용 -->
		</form>
	</c:if>
	<div>
		<a href="${pageContext.request.contextPath}/admin/getBoardList">게시판 보기</a>
	</div>
	<div>
		<a href="${pageContext.request.contextPath}/admin/getStaffList">직원 보기</a>
	</div>
	<div>
		<a href="${pageContext.request.contextPath}/admin/getFilmList">영화 보기</a>
	</div>
	<div>
		<a href="${pageContext.request.contextPath}/admin/getActorList">배우 보기</a>
	</div>
	<!-- 로그온시 -->
	<c:if test="${loginStaff!= null}">
		<a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a>
	</c:if>
</body>
</html>