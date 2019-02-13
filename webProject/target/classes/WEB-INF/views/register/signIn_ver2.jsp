<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/signin.css" rel="stylesheet">
  </head>
  <body>
  <!-- 순서에 유의 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/rsa.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/jsbn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/prng4.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/rng.js"></script>
  <script>
	$(document).ready(function(){
		$("#signInBtn").on("click", function(evt){
			var id = $("#email");
			var password = $("#current_password");
			
			//rsa encrypt
			var rsa = new RSAKey();

			rsa.setPublic($('#RSAModulus').val(), $('#RSAExponent').val())
			
			$("#userEmail").val(rsa.encrypt(id.val()));
			$("#userPassword").val(rsa.encrypt(password.val()));
			
			$("#form1").submit();
		});
	});
	</script>
    <div class="container">
      <form class="form-signin" id="form1" name="form1" method="POST" action="/loginController.do">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="email" id="email" name="email" class="form-control" placeholder="Email address" required autofocus>
        <input type="password" id="current_password" name="current_password" class="form-control" placeholder="Password" required>
        <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
        <input type="hidden" id="RSAExponent" value="${RSAExponent}"/>   
        <input type="hidden" id="userEmail" name="userEmail">
        <input type="hidden" id="userPassword" name="userPassword">
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button id="signInBtn" class="btn btn-lg btn-primary btn-block">Sign in</button>
      </form>
    </div> <!-- /container -->
  </body>
</html>