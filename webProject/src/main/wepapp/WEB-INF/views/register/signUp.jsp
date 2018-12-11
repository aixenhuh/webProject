<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
</html>