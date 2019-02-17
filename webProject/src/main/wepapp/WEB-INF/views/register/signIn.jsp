<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<body class="bg-gradient-primary">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/rsa.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/jsbn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/prng4.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/rsa/rng.js"></script>
  
    <script>
    var message = "<%= request.getAttribute("message") %>";
	$(document).ready(function(){
		if(message.length > 5){
			alert("<%= request.getAttribute("message") %>");
			location.href = "loginForm.do";
		}

		$("#email").val(getCookie("userCookieId"));
		if($("#email").val() != ""){
			$("#customCheck").attr("checked", true);
		}
		
		$("#signInBtn").on("click", function(evt){
			var id = $("#email").val();
			var password = $("#current_password").val();

			if(isEmpty(id)){
				alert("아이디를 입력해주세요.");
				return;
			}
			
			if(isEmpty(password)){
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			//rsa encrypt
			var rsa = new RSAKey();

			rsa.setPublic($('#RSAModulus').val(), $('#RSAExponent').val())
			
			$("#userEmail").val(rsa.encrypt(id));
			$("#userPassword").val(rsa.encrypt(password));
			
			$("#form1").submit();
		});
		
		$("#customCheck").change(function() {
			if($("#customCheck").is(":checked")){
				setCookie("userCookieId", $("#email").val(),7);
			} else {
				deleteCookie("userCookieId");
			}
		})
		
		var isEmpty = function(value){ if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ return true }else{ return false } };
	
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		 
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName);
		    var cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue);
		}
	});
	
	</script>
  <div class="container">
	<form class="form-signin" id="form1" name="form1" method="POST" action="/loginController.do">
	    <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
        <input type="hidden" id="RSAExponent" value="${RSAExponent}"/>   
        <input type="hidden" id="userEmail" name="userEmail">
        <input type="hidden" id="userPassword" name="userPassword">
	    <!-- Outer Row -->
	    <div class="row justify-content-center">
	
	      <div class="col-xl-10 col-lg-12 col-md-9">
	
	        <div class="card o-hidden border-0 shadow-lg my-5">
	          <div class="card-body p-0">
	            <!-- Nested Row within Card Body -->
	            <div class="row">
	              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
	              <div class="col-lg-6">
	                <div class="p-5">
	                  <div class="text-center">
	                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
	                  </div>
	                  <form class="user">
	                    <div class="form-group">
	                      <input type="email" class="form-control form-control-user" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter Email Address...">
	                    </div>
	                    <div class="form-group">
	                      <input type="password" class="form-control form-control-user" id="current_password" name="current_password" placeholder="Password">
	                    </div>
	                    <div class="form-group">
	                      <div class="custom-control custom-checkbox small">
	                        <input type="checkbox" class="custom-control-input" id="customCheck">
	                        <label class="custom-control-label" for="customCheck">Remember Me</label>
	                      </div>
	                    </div>
	                    <a href="#" id="signInBtn" class="btn btn-primary btn-user btn-block">
	                      Login
	                    </a>
	                    <hr>
	                    <a href="index.html" class="btn btn-google btn-user btn-block">
	                      <i class="fab fa-google fa-fw"></i> Login with Google
	                    </a>
	                    <a href="index.html" class="btn btn-facebook btn-user btn-block">
	                      <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
	                    </a>
	                  </form>
	                  <hr>
	                  <div class="text-center">
	                    <a class="small" href="/forgotPassword.do">Forgot Password?</a>
	                  </div>
	                  <div class="text-center">
	                    <a class="small" href="/signUp.do">Create an Account!</a>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	
	      </div>
	
	    </div>
	</form>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

</body>

</html>
<%-- <html>
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
</html> --%>