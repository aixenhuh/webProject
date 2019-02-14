<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Register</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">
<script>
	$(document).ready(function(){
		$("#signUpBtn").on("click", function(){
			$("#fullname").val($("input[name=firstname]").val() + " " + $("input[name=lastname]").val());
			if(true===invalidSignCheck()){
				$("#signForm").submit();
				alert("가입 완료하였습니다.");
			}

		});
	});
	
	function invalidSignCheck(){
		if(($("#fullname").val())===" ") { alert("이름을 입력해주세요."); $("#firstname").focus(); return false;}
		if(($("#email").val())==="") { alert("이메일을 입력해주세요."); $("#email").focus(); return false;}
		if(($("#password").val())==="") { alert("패스워드를 입력해주세요."); $("#password").focus(); return false;}
		if(($("#confirm_password").val())==="") { alert("패스워드를 입력해주세요."); $("#confirm_password").focus(); return false;}
		if($("#confirm_password").val() != $("#password").val()){
			alert("패스워드와 재 패스워드 입력이 다릅니다.");
			return false;
		}
		return true;
	}
</script>
<form id="signForm" name="signForm" action="/signInsert.do">
<input type="hidden" id="fullname" name="fullname"> 
  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
              </div>
              <form class="user">
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" name="firstname" id="firstname" placeholder="First Name">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" name="lastname" id="lastname" placeholder="Last Name">
                  </div>
                </div>
                <div class="form-group">
                  <input type="email" class="form-control form-control-user" name="email" id="email" placeholder="Email Address">
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user" name="password" id="password" placeholder="Password">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" name="confirm_password" id="confirm_password" placeholder="Repeat Password">
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                  	<input type="text" name="age" id="age" class="form-control input-lg" class="form-control form-control-user" placeholder="age"/>
                  </div>
                  <div class="col-sm-6">
                  	<input type="radio" name="gender" value="M">남자
	  				<input type="radio" name="gender" value="F" checked="checked">여자
                  </div>
                </div>                
                <a href="#" id="signUpBtn" class="btn btn-primary btn-user btn-block">
                  Register Account
                </a>
                <hr>
                <a href="index.html" class="btn btn-google btn-user btn-block">
                  <i class="fab fa-google fa-fw"></i> Register with Google
                </a>
                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                  <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                </a>
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div>
              <div class="text-center">
                <a class="small" href="/loginForm.do">Already have an account? Login!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</form>
  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

</body>

</html>
<!-- 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script>
	$(document).ready(function(){
		$("#signUpBtn").on("click", function(){
			$("#fullname").val($("input[name=firstname]").val() + " " + $("input[name=lastname]").val());
			if(true===invalidSignCheck()){
				$("#signForm").submit();
			}
		});
	});
	
	function invalidSignCheck(){
		if(($("#fullname").val())===" ") { alert("이름을 입력해주세요."); $("#firstname").focus(); return false;}
		if(($("#email").val())==="") { alert("이메일을 입력해주세요."); $("#email").focus(); return false;}
		if(($("#password").val())==="") { alert("패스워드를 입력해주세요."); $("#password").focus(); return false;}
		if(($("#confirm_password").val())==="") { alert("패스워드를 입력해주세요."); $("#confirm_password").focus(); return false;}
		if($("#confirm_password").val() != $("#password").val()){
			alert("패스워드와 재 패스워드 입력이 다릅니다.");
			return false;
		}
		return true;
	}
</script>
<form id="signForm" name="signForm" action="/signInsert.do">
<input type="hidden" id="fullname" name="fullname">
  <div style="padding:10px 0px 10px 0px; align : center">
	  <h4>AngularJS 폼 데모</h4>
	  <div class="row">
	    <div class="col-xs-6 col-md-6">
	      <input type="text" name="firstname" id="firstname" class="form-control input-lg" placeholder="성" />
	    </div>
	    <div class="col-xs-6 col-md-6">
	      <input type="text" name="lastname" id="lastname" class="form-control input-lg" placeholder="이름" />
	    </div>
	  </div>
	  <br>
	  <input type="text" name="email" id="email" class="form-control input-lg" placeholder="Email" />
	  <br>
	  <input type="password" name="password" id="password" class="form-control input-lg" placeholder="패스워드" />
	  <br>
	  <input type="password" name="confirm_password" id="confirm_password" class="form-control input-lg" placeholder="패스워드 재입력" />
	  <br>
	  <input type="text" name="age" id="age" class="form-control input-lg" />
	  <br>
	  <label>성별 : </label>
	  <input type="radio" name="gender" value="M">남자
	  <input type="radio" name="gender" value="F" checked="checked">여자
	  <br>
	  <button id="signUpBtn" type="button" class="btn btn-lg btn-primary btn-block signup-btn">회원가입</button>
  </div>
</form>
</body>
</html> -->