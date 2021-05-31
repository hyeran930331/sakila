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

<title>Film modify VIEW(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>Film modify VIEW</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
     
     <table class="table">
        <tr>
          <td >filmId :</td>
          <td><input class="form-control type="text" readonly="readonly" value="${filmList.filmId}"></td>
        </tr>
        
        <tr>
          <td> title :</td>
          <td><input class="form-control type="text" value="${filmList.title}"></td>
        </tr>
        
        <tr>
          <td>rating</td>
          <td>
             <select name="rating" id ="rating" class="form-control">
             	<option selected value="${filmList.rating}"> ${filmList.rating} (default)</option>
                <option value="G">G</option>
                <option value="PG">PG</option>
                <option value="PG-13">PG-13</option>
                <option value="R">R</option>
                <option value="NC-17">NC-17</option>
             </select>
          </td>
        </tr>
        
        <tr>
          <td> length :</td>
          <td><input class="form-control type="text" readonly="readonly" value="${filmList.length}"></td>
        </tr>
        
      	<tr>
      		<td>rentalRate</td>
      		<td>
      			<select id="price" name="price" class="form-control">
                  	<option selected value="${filmList.price}">${filmList.price} (default)</option>
					<option value="0.99">0.99</option>
					<option value="2.99">2.99</option>
					<option value="4.99">4.99</option>
      			</select>
			</td>
      	</tr>
        
        <tr>
          <td> category :</td>
          <td>
	          <select id="category" name="category" class="form-control">
	          <c:forEach var="c" items="${categoryList}">
	          		<c:if test="${c.name == filmList.category}">
	          			<option selected value="${filmList.category}">${filmList.category} (default)</option>
	          		</c:if>
	          		<c:if test="${c.name != filmList.category}">
	          			<option value="${c.name}">${c.name}</option>
	          		</c:if>
	          </c:forEach>
	          </select>
          </td>
        </tr>

        <tr>
          <td>설명</td>
          <td><textarea class="form-control rounded-0"> ${filmList.description} </textarea></td>
        </tr>
        
        <tr>
          <td>배우
          <br>
          <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmActorListByFilm?filmId=${filmList.filmId}">배우수정하기</a> 
          </td>
          
          <td class="text-left">
          	<!-- 배우마다 한줄띄기 하고싶었습니다. 와 이게 한번에 되다니...-->
			<c:forTokens var="temp" items="${filmList.actors } " delims="," varStatus="status">
				<a href="${pageContext.request.contextPath}/admin/getActorOne?Actor=${temp}">${status.count} ${temp }</a><br>
			</c:forTokens>
          </td>
        </tr>
        
      
    </table>
    
    
    <!-- 버튼들 -->
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록으로</a>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${filmList.filmId}">상세페이지로</a>

</div>
</body>
</html>