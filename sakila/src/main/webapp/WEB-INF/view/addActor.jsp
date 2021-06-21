<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>addActor</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
 
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>
 
<script>
    $(document).ready(function() {
        $('#addButton').click(function() { 
        	console.log('addButton 클릭');
            
        	if ($('#firstName').val() == '') {
                alert('firstName을 입력하세요');
                $('#firstName').focus();
            } else if ($('#lastName').val() == '') {
                alert('lastName을 입력하세요');
                $('#lastName').focus();
            } else {
                $('#addForm').submit();
            }
        });
        
        // #inputFile에 input type="file" 마지막에 추가
        $('#addFilmBtn').click(function(){
        	console.log('#addFilmBtn click!');
        	$('#inputFilm').append('<input type="text" name="filmLine" class="filmLine" placeholder="film"> <br>');
        	//카테고리랑 한줄로 만들어서 넣고 싶은데... 힘드려나요.
        });
        
     	// #inputFile에 input type="file" 마지막 태그를 삭제
		$('#delFilmBtn').click(function(){
			console.log('#delFilmBtn click!');	
			$('#inputFile').children().last().remove();
        });	
    });
</script>
<title>ADD Actor</title>
</head>
<body>
    <div class="container">
        <h1>Actor ADD</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
        <form id="addForm" 
        		action="${pageContext.request.contextPath}/admin/addActor" 
        		method="post"
        		enctype="multipart/form-data">
            <div>
            	<div>
            		<button id="addFilmBtn" type="button">영화추가</button>
            		<button id="delFilmBtn" type="button">영화삭제</button>
            	</div>
            	<div id="inputFilm">
            	</div>
            </div>
            
            <div class="form-group">
                <label for="firstName">firstName :</label> <input class="form-control" name="firstName" id="firstName" type="text" />
            </div>
            <div class="form-group">
                <label for="lastName">lastName :</label> <input class="form-control" name="lastName" id="lastName" type="text" />
            </div>
          
            <div>
                <input class="btn btn-default" id="addButton" type="button" value="배우입력" /> 
                <input class="btn btn-default" type="reset" value="초기화" /> 
                <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList">글목록</a>
            </div>
        </form>
    </div>
</body>
</html>