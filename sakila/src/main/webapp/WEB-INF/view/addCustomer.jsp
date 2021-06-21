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

</head>
<title>add Customer</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	console.log('country 레디');
	$.ajax({
		type:'get',
		url:'/country',
		success: function(jsonData) {
			$('#countryId').empty();
			$(jsonData).each(function(index, item) {
				$('#countryId').append(
					'<option value="'+item.countryId+'">'+item.country+'</option>'
				);
			});
		}
	}); // courntry ëª©ë¡ì ë°ììì country select íê·¸ìì optioníê·¸ë¥¼ ì¶ê°
	
	$('#countryId').change(function(){
		console.log('city 레디');
		$.ajax({
			type:'get',
			url:'/city',
			data:{countryId : $('#countryId').val()},
			success: function(jsonData) {
				$('#cityId').empty();
				$(jsonData).each(function(index, item) {
					$('#cityId').append(
						'<option value="'+item.cityId+'">'+item.city+'</option>'
					);
				});
			}
		}); // city ëª©ë¡ì ë°ììì city select íê·¸ìì optioníê·¸ë¥¼ ì¶ê°
	});
	
	$('#btn').click(function(){
		console.log('btn click');	
		
		if ($('#storeId').val() == "") {
            console.log('storeId을 입력하세요');
            $('#storezone').css("background-color","red");
            
        } else if ($('#email').val() == '') {
        	$('#storezone').css("background-color","");
            console.log('email을 입력하세요');
            $('#emailzone').css("background-color","red");

        } else if ($('#firstName').val() == '') {
            alert('firstName');
            $('#firstName').focus();
            
        } else if ($('#lastName').val() == '') {
            alert('lastName');
            $('#lastName').focus();
            
        } else if ($('#phone').val() == '') {
            alert('phone');
            $('#phone').focus();
            
        } else if ($('#countryId').val() == '') {
            alert('country을 선택하세요');
            $('#countryId').focus();
        } else if ($('#cityId').val() == '') {
            alert('city을 선택하세요');
            $('#cityId').focus();
        } else if ($('#postalCode').val() == '') {
            alert('우편번호를 입력하세요');
            $('#postalCode').focus();    
            
        } else if ($('#district').val() == '') {
            alert('도로명을 입력하세요');
            $('#district').focus();
        } else if ($('#address').val() == '') {
            alert('상세주소를 입력하세요');
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
	<form action="${pageContext.request.contextPath}/admin/addCustomer" id="addForm" name="addForm" method="post">
    <h1>add Customer</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    <table class="table table-striped text-left">
        <thead>
            <tr id="storezone">
                <th>StoreId</th>
                <td>
                	<select class="btn btn-default" name="storeId" id="StoreId">
                		<option value=""> 입력하세요 </option>
                		<option value="1"> store 1 </option>
                		<option value="2"> store 2 </option>
                	</select>
                </td>
             </tr>
			 <tr id = "emailzone">
                <th>email(ID)</th>
                <td><input class="btn btn-default" type="text" name="email" id="email"></td>
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
              	  <select class="btn btn-default" name="countryId" id="countryId" class="select">
              	  	<option value=""> 선택하세요 </option>
              	  </select>
                </td>
            </tr>
			 <tr>    
                <th>city</th>
                <td>
					<select class="btn btn-default" name="cityId" id="cityId">
						<option value=""> 선택하세요 </option>
					</select>
				</td>
			 </tr>
			 <tr>	
				<th>address</th>
                <td>
					<input class="btn btn-default" name="postalCode" id="postalCode" placeholder="postalCode">
					<br>
					<input class="btn btn-default" name="district" id="district" placeholder="district">
					<br>
					<input class="btn btn-default" name="address" id="address" placeholder="address">
					<input class="btn btn-default" name="address2" id="address2" placeholder="address2">
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