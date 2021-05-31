<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


<script>
	$(document).ready(function() {
		function checkboxArr() {
		    var actorId = new Array();     // 배열 초기화
		 	// 체크된 체크박스의 value 값을 가지고 온다.
		    $("input[name='actorId']:checked").each(function(i) { 
		        actorId.push(this.value);     // 체크된 것만 값을  배열에 push
		    });
		    $('#hiddenValue').val(actorId);
	        
	        alert($('#hiddenValue').val()); // 팝업창으로 띄운다
		}
		
	    $('#btn').click(function() { 
	    	console.log('btn 클릭');
	        $('#modifyFilmActor').submit();
	    });
	});
</script> 
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>getFilmActorListByFilm(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>영화 출연진 수정</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    
     <form id="modifyFilmActor" name="modifyFilmActor" action="${pageContext.request.contextPath}/admin/modifyFilmActor" method="post">
	<table class="table">
        <tr>
          <td>${filmId}번 film 출연배우 수정 	<button id="btn" name="btn"> 제출</button>
          <input type = "hidden" name = "filmId" value = "${filmId}">
          </td>
        </tr> 
         
        <tr>
          <td>
          
          	<table class="text-left table-striped">
          		<tr>
				<c:forEach var="c" items="${castingListByFilm}" varStatus="status">
					<c:if test="${((status.count) %5)==1}">
						<tr>
					</c:if>
					
						<td>
						<!-- checkbox 의 name을 동일하게 일치시켜주면 동일한 name의 value를 배열로 묶어서 넘길 수 있다. 
							출처: https://beanice.tistory.com/152 [잡다세상] -->
							<c:if test="${c.cast !=null}">
								<input name="actorId" type="checkbox" checked="checked" value="${c.actorId}">
							</c:if>
							
							<c:if test="${c.cast ==null}">
								<input name="actorId" type="checkbox" value="${c.actorId}">
							</c:if>
							${status.count}. ${c.name}
						</td>
						
					<c:if test="${((status.count) %5)==0}">
						<tr>
					</c:if>
					
				</c:forEach>
				</tr>
			</table>
          </td>
        </tr>
    </table>
    </form>

    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${filmId}">뒤로가기</a>
 
</div>
</body>
</html>