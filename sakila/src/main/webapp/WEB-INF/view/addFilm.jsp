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
        $('#btn').click(function() { 
        	console.log('btn 클릭');
 
        
        	if ($('#title').val() == '') {
                alert('title을 입력하세요');
                $('#title').focus();
                
            } else if ($('#film.description').val() == '') {
                alert('description을 입력하세요');
                $('#film.description').focus();
                
            } else if ($('#film.releaseYear').val() == '') {
                alert('releaseYear을 입력하세요');
                $('#film.releaseYear').focus();
                
            } else if ($('#film.rentalDuration').val() == '') {
                alert('rentalDuration을 입력하세요');
                $('#film.rentalDuration').focus();
                
            } else if ($('film.rentalRate').val() == '') {
                alert('rentalRate을 입력하세요');
                $('#film.rentalRate').focus();
                
            } else if ($('#film.length').val() == '') {
                alert('length을 입력하세요');
                $('#film.length').focus();
                
            } else if ($('#film.replacementCost').val() == '') {
                alert('replacementCost을 입력하세요');
                $('#film.replacementCost').focus();
                
            } else {
                $('#addForm').submit();
            }
        });
</script>

<title>addFilm</title>
</head>
<body>
   <div class="container">
      <h1>add Film</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
      
      <form method="post" name="addForm" action="${pageContext.request.contextPath}/admin/addFilm">
         <table class="table table-hover">
            <tr>
               <td>title</td>
               <td>
                  <input type="text" name="film.title" id="title" class="form-control">
               </td>
            </tr>
            <tr>
               <td>category</td>
               <td>
                  <select name="category.categoryId" id ="categoryId" class="form-control">
                     <c:forEach var="c" items="${categoryList}">
                        <option value="${c.categoryId}">${c.name}</option>
                     </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td>description</td>
               <td>
                  <textarea rows="5" cols="100" name="film.description" id="description" class="form-control"></textarea>
               </td>
            </tr>
            <tr>
               <td>releaseYear</td>
               <td>
                  <input type="text" name="film.releaseYear" id="releaseYear" class="form-control">
               </td>
            </tr>
            <tr>
               <td>language</td>
               <td>
                  <select name="film.languageId" id ="language" class="form-control">
                     <c:forEach var="lang" items="${languageList}">
                        <option value="${lang.languageId}">${lang.name}</option>
                     </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td>originalLanguage</td>
               <td>
                  <select name="film.originalLanguageId" id ="originalLanguage" class="form-control">
                     <option>======</option>
                     <c:forEach var="lang" items="${languageList}">
                        <option value="${lang.languageId}">${lang.name}</option>
                     </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td>rentalDuration</td>
               <td>
                  <input type="text" name="film.rentalDuration" id="rentalDuration" class="form-control">               
               </td>
            </tr>
            <tr>
               <td>rentalRate</td>
               <td>
                  <select id="rentalRate" name="film.rentalRate" class="form-control">
					<option value="">모두보기</option>
					<option value="0.99">0.99</option>
					<option value="2.99">2.99</option>
					<option value="4.99">4.99</option>
				</select>
               </td>
            </tr>
            <tr>
               <td>length</td>
               <td>
                  <input type="text" name="film.length" id="length" class="form-control">
               </td>
            </tr>
            <tr>
               <td>replacementCost</td>
               <td>
                  <input type="text" name="film.replacementCost" id="replacementCost" class="form-control">
               </td>
            </tr>
            <tr>
               <td>rating</td>
               <td>
                  <select name="film.rating" id ="rating" class="form-control">
                     <option value="G">G</option>
                     <option value="PG">PG</option>
                     <option value="PG-13">PG-13</option>
                     <option value="R">R</option>
                     <option value="NC-17">NC-17</option>
                  </select>
               </td>
            </tr>
            <tr>
               <td>specialFeatures</td>
               <td>
                  <input type="checkbox" name="ck" value="Trailers">Trailers&nbsp;
                  <input type="checkbox" name="ck" value="Commentaries">Commentaries&nbsp;
                  <input type="checkbox" name="ck" value="Deleted Scenes">Deleted Scenes&nbsp;
                  <input type="checkbox" name="ck" value="Behind the Scenes">Behind the Scenes
               </td>
            </tr>
         </table>
         
         <button id="btn" class="btn btn-secondary">등록</button>
      </form>
      
   </div>
</body>
</html>