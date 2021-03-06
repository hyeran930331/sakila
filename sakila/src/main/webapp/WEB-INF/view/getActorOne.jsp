<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>getActorList</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
<body>
<div class="container">
    <h1>getActorOne</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    <table class="table table-striped">
        
		<tr>
			<thead>
			<th> 
			    <ul class="pager">
			        <c:if test="${currentPage > 1}">
			            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
			        </c:if>
			        
			        actorID
			        
			        <c:if test="${currentPage < lastPage}">
			            <li class="next"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
			        </c:if>
    			</ul>
			</th>
			<th width="200"> name</th>
			<th> film info</th>
			</thead>
		</tr>
		
		<c:forEach var="a" items="${actorList}">
		<tr>
			<td>
			  <ul class="pager">
		        <c:if test="${currentPage > 1}">
		            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
		        </c:if>
		        ${a.actorId}
		        <c:if test="${currentPage < lastPage}">
		            <li class="next"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
		        </c:if>
  			  </ul>
			</td>
			<td>${a.name}</td>

			<td>
			<c:forTokens var="temp0" items="${a.filmInfo} " delims=";" varStatus="status">
				<c:set var="temp1" value="${fn:split(temp0,':')}"/>
					<c:forEach var="temp2" items="${temp1 }" varStatus="g">
						<c:if test="${g.count==1}">
						${temp2} : 
						</c:if>
						<c:if test="${g.count==2}">
							<c:forTokens var="temp3" items="${temp2} " delims="," varStatus="status">
							<a href="${pageContext.request.contextPath}/admin/getFilmOne?title=${temp3}">${temp3}</a>,
							</c:forTokens>
						</c:if>
					</c:forEach>
					<br>
			</c:forTokens>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div>
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${lastPage}">목록으로</a>
	</div>
  
</div>
</body>
</html>