<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String userEmail = session.getAttribute("userEmail").toString();
%>
<html>
<head>
</head>
    
<body>

<div class="container">
    <form id="writeForm" name="writeForm" method="post">
    <div class="form-group">
        <label for="writer">작성자</label>
        <input type="text" class="form-control" id="writer" name="writer" style="width:20%;">
    </div>
    <div class="form-group">
        <label for="subject">제목</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요.">
      </div>
      <div class="form-group">
        <label for=content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요."></textarea>
      </div>
      <button type="button" class="btn btn-primary" onClick='fn_addtoBoard()'>게시판 글 작성</button>
      <button type="button" class="btn btn-primary" onClick='fn_cancel()'>취소</button>
    </form>
</div>
<script>
//글쓰기
function fn_addtoBoard(){
    var form = $("#writeForm");
    form.attr("action", '/notice/notice_write.do');
    form.submit();
}
 
//목록
function fn_cancel(){
    var form = document.getElementById("writeForm");
    form.action = "<c:url value='/notice/notice.do'/>";
    form.submit();
}

$(document).ready(function(){
	$("#writer").val('${userEmail}');
})
</script>
</div>
</body>
</html>