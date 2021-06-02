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
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	console.log('country 레디');
	$.ajax({
		type:'get',
		url:'/country',
		success: function(jsonData) {
			$('#country').empty();
			$(jsonData).each(function(index, item) {
				$('#country').append(
					'<option value="'+item.countryId+'">'+item.country+'</option>'
				);
			});
		}
	}); // courntry ëª©ë¡ì ë°ììì country select íê·¸ìì optioníê·¸ë¥¼ ì¶ê°
	
	$('#country').change(function(){
		$.ajax({
			type:'get',
			url:'/city',
			data:{countryId : $('#country').val()},
			success: function(jsonData) {
				$('#city').empty();
				$(jsonData).each(function(index, item) {
					$('#city').append(
						'<option value="'+item.cityId+'">'+item.city+'</option>'
					);
				});
			}
		}); // city ëª©ë¡ì ë°ììì city select íê·¸ìì optioníê·¸ë¥¼ ì¶ê°
	});
	
	$('#btn').click(function({
		console.log('btn click');	
		
		if ($('#storeId').val() == '') {
            alert('storeId을 입력하세요');
            $('#storeId').focus();
            
        } else if ($('#email').val() == '') {
            alert('email을 입력하세요');
            $('#email').focus();
            
        } else if ($('#password').val().size() >= 4) {
            alert('password을 4자 이ㅏㅇ입력하세요');
            $('#password').focus();
            
        } else if ($('#firstName').val() == '') {
            alert('firstName');
            $('#firstName').focus();
            
        } else if ($('#lastName').val() == '') {
            alert('lastName');
            $('#lastName').focus();
            
        } else if ($('#phone').val() == '') {
            alert('phone');
            $('#phone').focus();
            
        } else if ($('#country').val() == '') {
            alert('country을 선택하세요');
            $('#country').focus();
        } else if ($('#city').val() == '') {
            alert('city을 선택하세요');
            $('#city').focus();
        } else if ($('#address').val() == '') {
            alert('address을 입력하세요');
            $('#address').focus();
                    
        } else {
            $('#addForm').submit();
        }
	});

});
</script>
</head>
<body>
	<div class="container">
	<form action="${pageContext.request.contextPath}/admin/addStaff" id="addForm" name="addForm" method="post">
    <h1>add staff</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>StoreId</th>
                <td>
                	<select class="btn btn-default" name="storeId" id="StoreId">
                		<option value="1"> store 1 </option>
                		<option value="2"> store 2 </option>
                	</select>
                </td>
             </tr>
			 <tr>
                <th>email(ID)</th>
                <td><input class="btn btn-default" type="text" name="email" id="email"></td>
             </tr>
             <tr>
                <th>password</th>
                <td><input class="btn btn-default" type="password" name="password" id="password"></td>
             </tr>
			 <tr>
                <th>name</th>
                <td>
                	<input class="btn btn-default" type="text" name="firstName" id="firstName" placeholder="firstName">
                	<input class="btn btn-default" type="text" name="lastName" id="lastName" placeholder="lastName">
                </td>
             </tr>
			 <tr>
                <th>phone</th>
                <td><input class="btn btn-default" type="text" name="phone" id="phone"></td>
            </tr>
			 <tr>  
                <th>country</th>
                <td>
              	  <select class="btn btn-default" name="country" id="country" class="select"></select>
                </td>
            </tr>
			 <tr>    
                <th>city</th>
                <td>
					<select class="btn btn-default" name="city" id="city"></select>
				</td>
			 </tr>
			 <tr>	
				<th>address</th>
                <td>
					<input class="btn btn-default" name="address" id="address">
				</td>
                <td>
            </tr>
        </thead>
        
    </table>
    	<button class="btn btn-default" name="btn" id="btn" type="button">제출</button>
    </form>
	</div>
</body>
</html>