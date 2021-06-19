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
    <h1>getActorList</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    <table class="table table-striped">
        
		<tr>
			<thead>
			<th> actorID</th>
			<th width="200"> name</th>
			<th> film count</th>
			<th> gerne count</th>
			<th> gerne</th>
			</thead>
		</tr>
		
		<c:forEach var="a" items="${actorList}">
		<tr>
			<td>${a.actorId}</td>
			<td>
			<c:set var="temp1" value=""/>
				<c:forTokens var="temp2" items="${a.name} " delims=" " varStatus="g">
					<c:if test="${g.count==1}">
						<c:set var="temp1" value="firstName=${temp2}"/>
					</c:if>
					<c:if test="${g.count==2}">
						<c:set var="temp1" value="${temp1}&lastName=${temp2}"/>
					</c:if>
				</c:forTokens>
			<a href="${pageContext.request.contextPath}/admin/getActorOne?${temp1}">${a.name}</a>
			</td>
			<td>
			${a.filmNum }
			</td>
			<td>
			${a.gerneNum }
			</td>

			<td>
			<c:forTokens var="temp0" items="${a.filmInfo} " delims=";" varStatus="status">
				<c:set var="temp1" value="${fn:split(temp0,':')}"/>
					<c:forEach var="temp2" items="${temp1 }" varStatus="g">
						<c:if test="${g.count==1}">
						${temp2},
						</c:if>
					</c:forEach>
			</c:forTokens>
			</td>
		</tr>
		</c:forEach>
	</table>
	
	<!-- 검색어 입력창 admin을 빠뜨리다니... -->
    <form action="admin/getActorList" method="get">
        <label for="searchWord">검색어(이름) :</label> 
        <input id="searchWord" name="searchWord" type="text">
        <button type="submit">검색</button>
    </form>

    <ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=1">첫페이지로</a>
        
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
        </c:if>

        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${lastPage}">마지막 페이지로</a>

    </ul>
    <div>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addActor">배우 입력</a>
    </div>
</div>
</body>
</html>