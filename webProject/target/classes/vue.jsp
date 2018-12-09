<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
</head>
<body>

<div id="app-6">
	<p>{{ message }}</p>
	<input v-model="message">메시지 뒤집기
</div>

<script>
	new Vue({
		data : { a: 1 },
		created : function() {
			console.log('a is : ' + this.a)
		}
	})
</script>
</body>
</html>